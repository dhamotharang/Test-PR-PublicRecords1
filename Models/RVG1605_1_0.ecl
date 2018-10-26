IMPORT ut, RiskWise, RiskView, RiskWiseFCRA, Risk_Indicators, riskview;

export RVG1605_1_0 (grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION
										
	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			INTEGER seq;
			BOOLEAN truedid;
			STRING out_addr_status;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER rc_ssndod;
			BOOLEAN rc_input_addr_not_most_recent;
			STRING rc_decsflag;
			STRING ver_sources;
			BOOLEAN addrpop;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			INTEGER add_curr_naprop;
			BOOLEAN add_curr_pop;
			INTEGER add_prev_naprop;
			INTEGER addrs_10yr;
			INTEGER adls_per_addr_c6;
			INTEGER inq_count;
			INTEGER inq_count01;
			INTEGER inq_count03;
			INTEGER inq_count06;
			INTEGER inq_count12;
			INTEGER inq_count24;
			INTEGER inq_highriskcredit_count12;
			STRING pb_total_orders;
			INTEGER infutor_nap;
			INTEGER attr_total_number_derogs;
			INTEGER bk_dismissed_historical_count;
			INTEGER criminal_count;
			INTEGER felony_count;
			
			/* Model Intermediate Variables */
			INTEGER sysdate;
			STRING add_ec1;
			STRING add_ec3;
			STRING add_ec4;
			STRING rv_l70_add_standardized;
			INTEGER rv_f03_input_add_not_most_rec;
			INTEGER rv_d30_derog_count;
			STRING rv_d32_criminal_x_felony;
			INTEGER rv_d31_bk_dism_hist_count;
			INTEGER rv_l80_inp_avm_autoval;
			INTEGER rv_c14_addrs_10yr;
			STRING rv_a41_prop_owner;
			INTEGER rv_i60_inq_recency;
			INTEGER rv_i60_inq_hiriskcred_count12;
			INTEGER rv_l79_adls_per_addr_c6;
			INTEGER rv_a50_pb_total_orders;
			REAL a_subscore0;
			REAL a_subscore1;
			REAL a_subscore2;
			REAL a_subscore3;
			REAL a_subscore4;
			REAL a_subscore5;
			REAL a_subscore6;
			REAL a_subscore7;
			REAL a_subscore8;
			REAL a_subscore9;
			REAL a_subscore10;
			REAL a_subscore11;
			REAL a_rawscore;
			REAL a_lnoddsscore;
			REAL a_probscore;
			STRING a_aacd_0;
			REAL a_dist_0;
			STRING a_aacd_1;
			REAL a_dist_1;
			STRING a_aacd_2;
			REAL a_dist_2;
			STRING a_aacd_3;
			REAL a_dist_3;
			STRING a_aacd_4;
			REAL a_dist_4;
			STRING a_aacd_5;
			REAL a_dist_5;
			STRING a_aacd_6;
			REAL a_dist_6;
			STRING a_aacd_7;
			REAL a_dist_7;
			STRING a_aacd_8;
			REAL a_dist_8;
			STRING a_aacd_9;
			REAL a_dist_9;
			STRING a_aacd_10;
			REAL a_dist_10;
			STRING a_aacd_11;
			REAL a_dist_11;
			REAL a_rcvaluel79;
			REAL a_rcvaluel80;
			REAL a_rcvaluel70;
			REAL a_rcvalued32;
			REAL a_rcvalued30;
			REAL a_rcvalued31;
			REAL a_rcvaluea51;
			REAL a_rcvaluea50;
			REAL a_rcvaluei60;
			REAL a_rcvaluef03;
			REAL a_rcvaluea41;
			REAL a_rcvaluec13;
			REAL a_rcvaluec14;
			INTEGER base;
			REAL odds;
			INTEGER point;
			BOOLEAN iv_rv5_deceased;
			BOOLEAN iv_rv5_unscorable;
			INTEGER rvg1605_1_0_score;
			STRING a_rc1;
			STRING a_rc2;
			STRING a_rc3;
			STRING a_rc4;
			STRING a_rc5;
			STRING a_rc6;
			STRING a_rc7;
			STRING a_rc8;
			STRING a_rc9;
			STRING a_rc10;
			STRING a_rc11;
			REAL a_vl1;
			REAL a_vl2;
			REAL a_vl3;
			REAL a_vl4;
			REAL a_vl5;
			REAL a_vl6;
			REAL a_vl7;
			REAL a_vl8;
			REAL a_vl9;
			REAL a_vl10;
			REAL a_vl11;
			STRING rc1_2;
			STRING rc2_2;
			STRING rc3_2;
			STRING rc4_2;
			STRING _rc_inq;
			STRING rc3_c41;
			STRING rc1_c41;
			STRING rc4_c41;
			STRING rc5_c41;
			STRING rc2_c41;
			STRING rc1_1;
			STRING rc3_1;
			STRING rc2_1;
			STRING rc5_1;
			STRING rc4_1;
			STRING rc1;
			STRING rc3;
			STRING rc2;
			STRING rc4;
			STRING rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 
	seq															 := le.seq;
	truedid                          := le.truedid;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := (integer)le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_total_number_derogs         := le.total_number_derogs;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;

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
	
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
	
	add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];
	
	add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];
	
	rv_l70_add_standardized := map(
	    not(addrpop)                                         => '                           ',
	    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => '2 Standardization Error    ',
	    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '1 Address was Standardized ',
	                                                            '0 Address is Standard      ');
	
	rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), NULL, rc_input_addr_not_most_recent);
	
	rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(criminal_count, 3), ALL) + '-' + trim((string)min(felony_count, 3), ALL));
	
	rv_d31_bk_dism_hist_count := if(not(truedid), NULL, min(if(bk_dismissed_historical_count = NULL, -NULL, bk_dismissed_historical_count), 999));
	
	rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	rv_c14_addrs_10yr := map(
	    not(truedid)      => NULL,
	    not(add_curr_pop) => -1,
	                         min(addrs_10yr, 999));
	
	rv_a41_prop_owner := map(
	    not(truedid)                                                                                   => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
	                                                                                                      '0');
	
	rv_i60_inq_recency := map(
	    not(truedid) 					=> NULL,
	    (boolean)inq_count01  => 1,
	    (boolean)inq_count03  => 3,
	    (boolean)inq_count06  => 6,
	    (boolean)inq_count12  => 12,
	    (boolean)inq_count24  => 24,
	    (boolean)inq_count    => 99,
															 0);
	
	rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));
	
	rv_a50_pb_total_orders := map(
	    not(truedid)           => NULL,
	    pb_total_orders = ''   => -1,
	                              (integer)pb_total_orders);
	
	a_subscore0 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.223696,
	    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => -0.05421,
	    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => -0.361,
	    3 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 4   => -0.527831,
	    4 <= rv_i60_inq_hiriskcred_count12                                         => -0.759938,
	                                                                                  0);
	
	a_subscore1 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 0.113888,
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => -0.368682,
	    3 <= rv_i60_inq_recency AND rv_i60_inq_recency < 6   => -0.325734,
	    6 <= rv_i60_inq_recency                              => -0.125066,
	                                                            0);
	
	a_subscore2 := map(
	    (rv_a41_prop_owner in [' ']) => 0,
	    (rv_a41_prop_owner in ['0']) => -0.104503,
	    (rv_a41_prop_owner in ['1']) => 0.177188,
	                                    0);
	
	a_subscore3 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.06706,
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 0.052884,
	    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => -0.061548,
	    3 <= rv_d30_derog_count AND rv_d30_derog_count < 4   => -0.205176,
	    4 <= rv_d30_derog_count                              => -0.273308,
	                                                            0);
	
	a_subscore4 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.149579,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => -0.011623,
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 8   => 0.077831,
	    8 <= rv_a50_pb_total_orders                                  => 0.160974,
	                                                                    0);
	
	a_subscore5 := map(
	    (rv_d32_criminal_x_felony in [' '])                                                                                => 0,
	    (rv_d32_criminal_x_felony in ['0-0'])                                                                              => 0.020675,
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                                                                => -0.336813,
	    (rv_d32_criminal_x_felony in ['0-1', '0-2', '0-3', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => -0.887791,
	                                                                                                                          0);
	
	a_subscore6 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1        => 0,
	    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 52940      => -0.218842,
	    52940 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 91644  => -0.109717,
	    91644 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 170790 => -0.00298,
	    170790 <= rv_l80_inp_avm_autoval                                    => 0.164553,
	                                                                           0);
	
	a_subscore7 := map(
	    (rv_f03_input_add_not_most_rec = NULL) => 0,
	    (rv_f03_input_add_not_most_rec in [0]) => 0.030522,
	    (rv_f03_input_add_not_most_rec in [1]) => -0.259463,
	                                              0);
	
	a_subscore8 := map(
	    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 1 => 0.017303,
	    1 <= rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 2   => -0.384089,
	    2 <= rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 3   => -0.416936,
	    3 <= rv_d31_bk_dism_hist_count                                     => -0.582689,
	                                                                          0);
	
	a_subscore9 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 0.137894,
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 0.026326,
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 4   => 0.005954,
	    4 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => -0.010784,
	    5 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => -0.034755,
	    6 <= rv_c14_addrs_10yr                             => -0.147539,
	                                                          0);
	
	a_subscore10 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.056102,
	    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => -0.056161,
	    2 <= rv_l79_adls_per_addr_c6                                   => -0.15647,
	                                                                      0);
	
	a_subscore11 := map(
	    (rv_l70_add_standardized in [' '])                          => 0,
	    (rv_l70_add_standardized in ['0 Address is Standard'])      => 0.038185,
	    (rv_l70_add_standardized in ['1 Address was Standardized']) => -0.051814,
	    (rv_l70_add_standardized in ['2 Standardization Error'])    => -0.350485,
	                                                                   0);
		
	a_rawscore := a_subscore0 +
	    a_subscore1 +
	    a_subscore2 +
	    a_subscore3 +
	    a_subscore4 +
	    a_subscore5 +
	    a_subscore6 +
	    a_subscore7 +
	    a_subscore8 +
	    a_subscore9 +
	    a_subscore10 +
	    a_subscore11;
	
	a_lnoddsscore := a_rawscore + 0.554823;
	
	a_probscore := exp(a_lnoddsscore) / (1 + exp(a_lnoddsscore));
	
	a_aacd_0 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => 'I60',
	    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 3   => 'I60',
	    3 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 4   => 'I60',
	    4 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	a_dist_0 := a_subscore0 - 0.223696;
	
	a_aacd_1 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 'I60',
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => 'I60',
	    3 <= rv_i60_inq_recency AND rv_i60_inq_recency < 6   => 'I60',
	    6 <= rv_i60_inq_recency                              => 'I60',
	                                                            '');
	
	a_dist_1 := a_subscore1 - 0.113888;
	
	a_aacd_2 := map(
	    (rv_a41_prop_owner in [' ']) => 'A41',
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	a_dist_2 := a_subscore2 - 0.177188;
	
	a_aacd_3 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
	    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => 'D30',
	    3 <= rv_d30_derog_count AND rv_d30_derog_count < 4   => 'D30',
	    4 <= rv_d30_derog_count                              => 'D30',
	                                                            '');
	
	a_dist_3 := a_subscore3 - 0.06706;
	
	a_aacd_4 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 'A50',
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 8   => 'A50',
	    8 <= rv_a50_pb_total_orders                                  => 'A50',
	                                                                    '');
	
	// a_dist_4 := a_subscore4 - 0.160974;
	a_dist_4 := 0;  // reason code edit for ibehavior removal
	
	a_aacd_5 := map(
	    (rv_d32_criminal_x_felony in [' '])                                                                                => '',
	    (rv_d32_criminal_x_felony in ['0-0'])                                                                              => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                                                                => 'D32',
	    (rv_d32_criminal_x_felony in ['0-1', '0-2', '0-3', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                                                          '');
	
	a_dist_5 := a_subscore5 - 0.020675;
	
	a_aacd_6 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1        => 'A51',
	    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 52940      => 'L80',
	    52940 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 91644  => 'L80',
	    91644 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 170790 => 'L80',
	    170790 <= rv_l80_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	a_dist_6 := a_subscore6 - 0.164553;
	
	a_aacd_7 := map(
	    (rv_f03_input_add_not_most_rec = NULL) => '',
	    (rv_f03_input_add_not_most_rec in [0]) => 'F03',
	    (rv_f03_input_add_not_most_rec in [1]) => 'F03',
	                                              '');
	
	a_dist_7 := a_subscore7 - 0.030522;
	
	a_aacd_8 := map(
	    NULL < rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 1 => 'D31',
	    1 <= rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 2   => 'D31',
	    2 <= rv_d31_bk_dism_hist_count AND rv_d31_bk_dism_hist_count < 3   => 'D31',
	    3 <= rv_d31_bk_dism_hist_count                                     => 'D31',
	                                                                          '');
	
	a_dist_8 := a_subscore8 - 0.017303;
	
	a_aacd_9 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 'C13',
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 4   => 'C14',
	    4 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 'C14',
	    5 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => 'C14',
	    6 <= rv_c14_addrs_10yr                             => 'C14',
	                                                          'C13');
	
	a_dist_9 := a_subscore9 - 0.137894;
	
	a_aacd_10 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
	    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => 'L79',
	    2 <= rv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	a_dist_10 := a_subscore10 - 0.056102;
	
	a_aacd_11 := map(
	    (rv_l70_add_standardized in [' '])                          => 'L70',
	    (rv_l70_add_standardized in ['0 Address is Standard'])      => 'L70',
	    (rv_l70_add_standardized in ['1 Address was Standardized']) => 'L70',
	    (rv_l70_add_standardized in ['2 Standardization Error'])    => 'L70',
	                                                                   '');
	
	a_dist_11 := a_subscore11 - 0.038185;
	
	a_rcvaluel79 := (integer)(a_aacd_0 = 'L79') * a_dist_0 +
	    (integer)(a_aacd_1 = 'L79') * a_dist_1 +
	    (integer)(a_aacd_2 = 'L79') * a_dist_2 +
	    (integer)(a_aacd_3 = 'L79') * a_dist_3 +
	    (integer)(a_aacd_4 = 'L79') * a_dist_4 +
	    (integer)(a_aacd_5 = 'L79') * a_dist_5 +
	    (integer)(a_aacd_6 = 'L79') * a_dist_6 +
	    (integer)(a_aacd_7 = 'L79') * a_dist_7 +
	    (integer)(a_aacd_8 = 'L79') * a_dist_8 +
	    (integer)(a_aacd_9 = 'L79') * a_dist_9 +
	    (integer)(a_aacd_10 = 'L79') * a_dist_10 +
	    (integer)(a_aacd_11 = 'L79') * a_dist_11;
	
	a_rcvaluel80 := (integer)(a_aacd_0 = 'L80') * a_dist_0 +
	    (integer)(a_aacd_1 = 'L80') * a_dist_1 +
	    (integer)(a_aacd_2 = 'L80') * a_dist_2 +
	    (integer)(a_aacd_3 = 'L80') * a_dist_3 +
	    (integer)(a_aacd_4 = 'L80') * a_dist_4 +
	    (integer)(a_aacd_5 = 'L80') * a_dist_5 +
	    (integer)(a_aacd_6 = 'L80') * a_dist_6 +
	    (integer)(a_aacd_7 = 'L80') * a_dist_7 +
	    (integer)(a_aacd_8 = 'L80') * a_dist_8 +
	    (integer)(a_aacd_9 = 'L80') * a_dist_9 +
	    (integer)(a_aacd_10 = 'L80') * a_dist_10 +
	    (integer)(a_aacd_11 = 'L80') * a_dist_11;
	
	a_rcvaluel70 := (integer)(a_aacd_0 = 'L70') * a_dist_0 +
	    (integer)(a_aacd_1 = 'L70') * a_dist_1 +
	    (integer)(a_aacd_2 = 'L70') * a_dist_2 +
	    (integer)(a_aacd_3 = 'L70') * a_dist_3 +
	    (integer)(a_aacd_4 = 'L70') * a_dist_4 +
	    (integer)(a_aacd_5 = 'L70') * a_dist_5 +
	    (integer)(a_aacd_6 = 'L70') * a_dist_6 +
	    (integer)(a_aacd_7 = 'L70') * a_dist_7 +
	    (integer)(a_aacd_8 = 'L70') * a_dist_8 +
	    (integer)(a_aacd_9 = 'L70') * a_dist_9 +
	    (integer)(a_aacd_10 = 'L70') * a_dist_10 +
	    (integer)(a_aacd_11 = 'L70') * a_dist_11;
	
	a_rcvalued32 := (integer)(a_aacd_0 = 'D32') * a_dist_0 +
	    (integer)(a_aacd_1 = 'D32') * a_dist_1 +
	    (integer)(a_aacd_2 = 'D32') * a_dist_2 +
	    (integer)(a_aacd_3 = 'D32') * a_dist_3 +
	    (integer)(a_aacd_4 = 'D32') * a_dist_4 +
	    (integer)(a_aacd_5 = 'D32') * a_dist_5 +
	    (integer)(a_aacd_6 = 'D32') * a_dist_6 +
	    (integer)(a_aacd_7 = 'D32') * a_dist_7 +
	    (integer)(a_aacd_8 = 'D32') * a_dist_8 +
	    (integer)(a_aacd_9 = 'D32') * a_dist_9 +
	    (integer)(a_aacd_10 = 'D32') * a_dist_10 +
	    (integer)(a_aacd_11 = 'D32') * a_dist_11;
	
	a_rcvalued30 := (integer)(a_aacd_0 = 'D30') * a_dist_0 +
	    (integer)(a_aacd_1 = 'D30') * a_dist_1 +
	    (integer)(a_aacd_2 = 'D30') * a_dist_2 +
	    (integer)(a_aacd_3 = 'D30') * a_dist_3 +
	    (integer)(a_aacd_4 = 'D30') * a_dist_4 +
	    (integer)(a_aacd_5 = 'D30') * a_dist_5 +
	    (integer)(a_aacd_6 = 'D30') * a_dist_6 +
	    (integer)(a_aacd_7 = 'D30') * a_dist_7 +
	    (integer)(a_aacd_8 = 'D30') * a_dist_8 +
	    (integer)(a_aacd_9 = 'D30') * a_dist_9 +
	    (integer)(a_aacd_10 = 'D30') * a_dist_10 +
	    (integer)(a_aacd_11 = 'D30') * a_dist_11;
	
	a_rcvalued31 := (integer)(a_aacd_0 = 'D31') * a_dist_0 +
	    (integer)(a_aacd_1 = 'D31') * a_dist_1 +
	    (integer)(a_aacd_2 = 'D31') * a_dist_2 +
	    (integer)(a_aacd_3 = 'D31') * a_dist_3 +
	    (integer)(a_aacd_4 = 'D31') * a_dist_4 +
	    (integer)(a_aacd_5 = 'D31') * a_dist_5 +
	    (integer)(a_aacd_6 = 'D31') * a_dist_6 +
	    (integer)(a_aacd_7 = 'D31') * a_dist_7 +
	    (integer)(a_aacd_8 = 'D31') * a_dist_8 +
	    (integer)(a_aacd_9 = 'D31') * a_dist_9 +
	    (integer)(a_aacd_10 = 'D31') * a_dist_10 +
	    (integer)(a_aacd_11 = 'D31') * a_dist_11;
	
	a_rcvaluea51 := (integer)(a_aacd_0 = 'A51') * a_dist_0 +
	    (integer)(a_aacd_1 = 'A51') * a_dist_1 +
	    (integer)(a_aacd_2 = 'A51') * a_dist_2 +
	    (integer)(a_aacd_3 = 'A51') * a_dist_3 +
	    (integer)(a_aacd_4 = 'A51') * a_dist_4 +
	    (integer)(a_aacd_5 = 'A51') * a_dist_5 +
	    (integer)(a_aacd_6 = 'A51') * a_dist_6 +
	    (integer)(a_aacd_7 = 'A51') * a_dist_7 +
	    (integer)(a_aacd_8 = 'A51') * a_dist_8 +
	    (integer)(a_aacd_9 = 'A51') * a_dist_9 +
	    (integer)(a_aacd_10 = 'A51') * a_dist_10 +
	    (integer)(a_aacd_11 = 'A51') * a_dist_11;
	
	a_rcvaluea50 := (integer)(a_aacd_0 = 'A50') * a_dist_0 +
	    (integer)(a_aacd_1 = 'A50') * a_dist_1 +
	    (integer)(a_aacd_2 = 'A50') * a_dist_2 +
	    (integer)(a_aacd_3 = 'A50') * a_dist_3 +
	    (integer)(a_aacd_4 = 'A50') * a_dist_4 +
	    (integer)(a_aacd_5 = 'A50') * a_dist_5 +
	    (integer)(a_aacd_6 = 'A50') * a_dist_6 +
	    (integer)(a_aacd_7 = 'A50') * a_dist_7 +
	    (integer)(a_aacd_8 = 'A50') * a_dist_8 +
	    (integer)(a_aacd_9 = 'A50') * a_dist_9 +
	    (integer)(a_aacd_10 = 'A50') * a_dist_10 +
	    (integer)(a_aacd_11 = 'A50') * a_dist_11;
	
	a_rcvaluei60 := (integer)(a_aacd_0 = 'I60') * a_dist_0 +
	    (integer)(a_aacd_1 = 'I60') * a_dist_1 +
	    (integer)(a_aacd_2 = 'I60') * a_dist_2 +
	    (integer)(a_aacd_3 = 'I60') * a_dist_3 +
	    (integer)(a_aacd_4 = 'I60') * a_dist_4 +
	    (integer)(a_aacd_5 = 'I60') * a_dist_5 +
	    (integer)(a_aacd_6 = 'I60') * a_dist_6 +
	    (integer)(a_aacd_7 = 'I60') * a_dist_7 +
	    (integer)(a_aacd_8 = 'I60') * a_dist_8 +
	    (integer)(a_aacd_9 = 'I60') * a_dist_9 +
	    (integer)(a_aacd_10 = 'I60') * a_dist_10 +
	    (integer)(a_aacd_11 = 'I60') * a_dist_11;
	
	a_rcvaluef03 := (integer)(a_aacd_0 = 'F03') * a_dist_0 +
	    (integer)(a_aacd_1 = 'F03') * a_dist_1 +
	    (integer)(a_aacd_2 = 'F03') * a_dist_2 +
	    (integer)(a_aacd_3 = 'F03') * a_dist_3 +
	    (integer)(a_aacd_4 = 'F03') * a_dist_4 +
	    (integer)(a_aacd_5 = 'F03') * a_dist_5 +
	    (integer)(a_aacd_6 = 'F03') * a_dist_6 +
	    (integer)(a_aacd_7 = 'F03') * a_dist_7 +
	    (integer)(a_aacd_8 = 'F03') * a_dist_8 +
	    (integer)(a_aacd_9 = 'F03') * a_dist_9 +
	    (integer)(a_aacd_10 = 'F03') * a_dist_10 +
	    (integer)(a_aacd_11 = 'F03') * a_dist_11;
	
	a_rcvaluea41 := (integer)(a_aacd_0 = 'A41') * a_dist_0 +
	    (integer)(a_aacd_1 = 'A41') * a_dist_1 +
	    (integer)(a_aacd_2 = 'A41') * a_dist_2 +
	    (integer)(a_aacd_3 = 'A41') * a_dist_3 +
	    (integer)(a_aacd_4 = 'A41') * a_dist_4 +
	    (integer)(a_aacd_5 = 'A41') * a_dist_5 +
	    (integer)(a_aacd_6 = 'A41') * a_dist_6 +
	    (integer)(a_aacd_7 = 'A41') * a_dist_7 +
	    (integer)(a_aacd_8 = 'A41') * a_dist_8 +
	    (integer)(a_aacd_9 = 'A41') * a_dist_9 +
	    (integer)(a_aacd_10 = 'A41') * a_dist_10 +
	    (integer)(a_aacd_11 = 'A41') * a_dist_11;
	
	a_rcvaluec13 := (integer)(a_aacd_0 = 'C13') * a_dist_0 +
	    (integer)(a_aacd_1 = 'C13') * a_dist_1 +
	    (integer)(a_aacd_2 = 'C13') * a_dist_2 +
	    (integer)(a_aacd_3 = 'C13') * a_dist_3 +
	    (integer)(a_aacd_4 = 'C13') * a_dist_4 +
	    (integer)(a_aacd_5 = 'C13') * a_dist_5 +
	    (integer)(a_aacd_6 = 'C13') * a_dist_6 +
	    (integer)(a_aacd_7 = 'C13') * a_dist_7 +
	    (integer)(a_aacd_8 = 'C13') * a_dist_8 +
	    (integer)(a_aacd_9 = 'C13') * a_dist_9 +
	    (integer)(a_aacd_10 = 'C13') * a_dist_10 +
	    (integer)(a_aacd_11 = 'C13') * a_dist_11;
	
	a_rcvaluec14 := (integer)(a_aacd_0 = 'C14') * a_dist_0 +
	    (integer)(a_aacd_1 = 'C14') * a_dist_1 +
	    (integer)(a_aacd_2 = 'C14') * a_dist_2 +
	    (integer)(a_aacd_3 = 'C14') * a_dist_3 +
	    (integer)(a_aacd_4 = 'C14') * a_dist_4 +
	    (integer)(a_aacd_5 = 'C14') * a_dist_5 +
	    (integer)(a_aacd_6 = 'C14') * a_dist_6 +
	    (integer)(a_aacd_7 = 'C14') * a_dist_7 +
	    (integer)(a_aacd_8 = 'C14') * a_dist_8 +
	    (integer)(a_aacd_9 = 'C14') * a_dist_9 +
	    (integer)(a_aacd_10 = 'C14') * a_dist_10 +
	    (integer)(a_aacd_11 = 'C14') * a_dist_11;
	
	base := 700;
	
	odds := (1 - 0.3266) / 0.3266;
	
	point := 50;
	
	iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), true, false);
	
	rvg1605_1_0_score := map(
	    iv_rv5_deceased   => 200,
	    iv_rv5_unscorable => 222,
	                         min(if(max(round(point * (a_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (a_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));
	
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	 
	//*************************************************************************************//
	rc_dataset_a := DATASET([
	    {'L79', a_rcvalueL79},
	    {'L80', a_rcvalueL80},
	    {'L70', a_rcvalueL70},
	    {'D32', a_rcvalueD32},
	    {'D30', a_rcvalueD30},
	    {'D31', a_rcvalueD31},
	    {'A51', a_rcvalueA51},
	    {'A50', a_rcvalueA50},
	    {'I60', a_rcvalueI60},
	    {'F03', a_rcvalueF03},
	    {'A41', a_rcvalueA41},
	    {'C13', a_rcvalueC13},
	    {'C14', a_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_a_sorted := sort(rc_dataset_a, rc_dataset_a.value);
	
	a_rc1 := rc_dataset_a_sorted[1].rc;
	a_rc2 := rc_dataset_a_sorted[2].rc;
	a_rc3 := rc_dataset_a_sorted[3].rc;
	a_rc4 := rc_dataset_a_sorted[4].rc;
	a_rc5 := rc_dataset_a_sorted[5].rc;
	a_rc6 := rc_dataset_a_sorted[6].rc;
	a_rc7 := rc_dataset_a_sorted[7].rc;
	a_rc8 := rc_dataset_a_sorted[8].rc;
	a_rc9 := rc_dataset_a_sorted[9].rc;
	a_rc10 := rc_dataset_a_sorted[10].rc;
	a_rc11 := rc_dataset_a_sorted[11].rc;
	
	a_vl1 := rc_dataset_a_sorted[1].value;
	a_vl2 := rc_dataset_a_sorted[2].value;
	a_vl3 := rc_dataset_a_sorted[3].value;
	a_vl4 := rc_dataset_a_sorted[4].value;
	a_vl5 := rc_dataset_a_sorted[5].value;
	a_vl6 := rc_dataset_a_sorted[6].value;
	a_vl7 := rc_dataset_a_sorted[7].value;
	a_vl8 := rc_dataset_a_sorted[8].value;
	a_vl9 := rc_dataset_a_sorted[9].value;
	a_vl10 := rc_dataset_a_sorted[10].value;
	a_vl11 := rc_dataset_a_sorted[11].value;
	
	//*************************************************************************************//
	rc1_2 := a_rc1;
	rc2_2 := a_rc2;
	rc3_2 := a_rc3;
	rc4_2 := a_rc4;
	
	_rc_inq := map(
	    rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
	    rv_i60_inq_recency > 0            => 'I60',
	                                         '');
	
	rc3_c41 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
	                                             ' ');
	
	rc1_c41 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
	                                             ' ');
	
	rc4_c41 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
	                                             ' ');
	
	rc5_c41 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
	                                             _rc_inq);
	
	rc2_c41 := map(
	    trim((string)rc1_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
	    trim((string)rc3_2, LEFT, RIGHT) = '' => ' ',
	    trim((string)rc4_2, LEFT, RIGHT) = '' => ' ',
	                                             ' ');
	
	rc4_1 := if(rc4_c41 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c41, rc4_2);
	
	rc5_1 := if(rc5_c41 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c41, '');
	
	rc3_1 := if(rc3_c41 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c41, rc3_2);
	
	rc2_1 := if(rc2_c41 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c41, rc2_2);
	
	rc1_1 := if(rc1_c41 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c41, rc1_2);
	

	rc1 := if((rvg1605_1_0_score in [200, 222]), ' ', rc1_1);
	
	rc3 := if((rvg1605_1_0_score in [200, 222]), ' ', rc3_1);
	
	rc2 := if((rvg1605_1_0_score in [200, 222]), ' ', rc2_1);
	
	rc4 := if((rvg1605_1_0_score in [200, 222]), ' ', rc4_1);
	
	rc5 := if((rvg1605_1_0_score in [200, 222]), ' ', rc5_1);
	
	//*************************************************************************************//
	//                      RiskView Version 5 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
	//*************************************************************************************//
	
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	
	// In Version 5 200 and 222 scores will not return reason codes, they will instead return alert codes
	reasonsOverrides := MAP(
		rvg1605_1_0_score = 200 => DATASET([{'00'}], HRILayout),
		rvg1605_1_0_score = 222 => DATASET([{'00'}], HRILayout),
		rvg1605_1_0_score = 900 => DATASET([{'00'}], HRILayout),
															 DATASET([], HRILayout));
																											 
	reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
	
	// If we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
											reasonsOverrides, 
											reasons) (HRI NOT IN ['', '00']);
											
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	
	//*************************************************************************************//
	//                       End RiskView Version 5 Reason Code Logic
	//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_decsflag := rc_decsflag;
		SELF.ver_sources := ver_sources;
		SELF.addrpop := addrpop;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.addrs_10yr := addrs_10yr;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.inq_count := inq_count;
		SELF.inq_count01 := inq_count01;
		SELF.inq_count03 := inq_count03;
		SELF.inq_count06 := inq_count06;
		SELF.inq_count12 := inq_count12;
		SELF.inq_count24 := inq_count24;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.pb_total_orders := pb_total_orders;
		SELF.infutor_nap := infutor_nap;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.bk_dismissed_historical_count := bk_dismissed_historical_count;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.add_ec1 := add_ec1;
		SELF.add_ec3 := add_ec3;
		SELF.add_ec4 := add_ec4;
		SELF.rv_l70_add_standardized := rv_l70_add_standardized;
		SELF.rv_f03_input_add_not_most_rec := rv_f03_input_add_not_most_rec;
		SELF.rv_d30_derog_count := rv_d30_derog_count;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_d31_bk_dism_hist_count := rv_d31_bk_dism_hist_count;
		SELF.rv_l80_inp_avm_autoval := rv_l80_inp_avm_autoval;
		SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
		SELF.rv_a41_prop_owner := rv_a41_prop_owner;
		SELF.rv_i60_inq_recency := rv_i60_inq_recency;
		SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
		SELF.rv_l79_adls_per_addr_c6 := rv_l79_adls_per_addr_c6;
		SELF.rv_a50_pb_total_orders := rv_a50_pb_total_orders;
		SELF.a_subscore0 := a_subscore0;
		SELF.a_subscore1 := a_subscore1;
		SELF.a_subscore2 := a_subscore2;
		SELF.a_subscore3 := a_subscore3;
		SELF.a_subscore4 := a_subscore4;
		SELF.a_subscore5 := a_subscore5;
		SELF.a_subscore6 := a_subscore6;
		SELF.a_subscore7 := a_subscore7;
		SELF.a_subscore8 := a_subscore8;
		SELF.a_subscore9 := a_subscore9;
		SELF.a_subscore10 := a_subscore10;
		SELF.a_subscore11 := a_subscore11;
		SELF.a_rawscore := a_rawscore;
		SELF.a_lnoddsscore := a_lnoddsscore;
		SELF.a_probscore := a_probscore;
		SELF.a_aacd_0 := a_aacd_0;
		SELF.a_dist_0 := a_dist_0;
		SELF.a_aacd_1 := a_aacd_1;
		SELF.a_dist_1 := a_dist_1;
		SELF.a_aacd_2 := a_aacd_2;
		SELF.a_dist_2 := a_dist_2;
		SELF.a_aacd_3 := a_aacd_3;
		SELF.a_dist_3 := a_dist_3;
		SELF.a_aacd_4 := a_aacd_4;
		SELF.a_dist_4 := a_dist_4;
		SELF.a_aacd_5 := a_aacd_5;
		SELF.a_dist_5 := a_dist_5;
		SELF.a_aacd_6 := a_aacd_6;
		SELF.a_dist_6 := a_dist_6;
		SELF.a_aacd_7 := a_aacd_7;
		SELF.a_dist_7 := a_dist_7;
		SELF.a_aacd_8 := a_aacd_8;
		SELF.a_dist_8 := a_dist_8;
		SELF.a_aacd_9 := a_aacd_9;
		SELF.a_dist_9 := a_dist_9;
		SELF.a_aacd_10 := a_aacd_10;
		SELF.a_dist_10 := a_dist_10;
		SELF.a_aacd_11 := a_aacd_11;
		SELF.a_dist_11 := a_dist_11;
		SELF.a_rcvaluel79 := a_rcvaluel79;
		SELF.a_rcvaluel80 := a_rcvaluel80;
		SELF.a_rcvaluel70 := a_rcvaluel70;
		SELF.a_rcvalued32 := a_rcvalued32;
		SELF.a_rcvalued30 := a_rcvalued30;
		SELF.a_rcvalued31 := a_rcvalued31;
		SELF.a_rcvaluea51 := a_rcvaluea51;
		SELF.a_rcvaluea50 := a_rcvaluea50;
		SELF.a_rcvaluei60 := a_rcvaluei60;
		SELF.a_rcvaluef03 := a_rcvaluef03;
		SELF.a_rcvaluea41 := a_rcvaluea41;
		SELF.a_rcvaluec13 := a_rcvaluec13;
		SELF.a_rcvaluec14 := a_rcvaluec14;
		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.iv_rv5_deceased := iv_rv5_deceased;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rvg1605_1_0_score := rvg1605_1_0_score;
		SELF.a_rc1 := a_rc1;
		SELF.a_rc2 := a_rc2;
		SELF.a_rc3 := a_rc3;
		SELF.a_rc4 := a_rc4;
		SELF.a_rc5 := a_rc5;
		SELF.a_rc6 := a_rc6;
		SELF.a_rc7 := a_rc7;
		SELF.a_rc8 := a_rc8;
		SELF.a_rc9 := a_rc9;
		SELF.a_rc10 := a_rc10;
		SELF.a_rc11 := a_rc11;
		SELF.a_vl1 := a_vl1;
		SELF.a_vl2 := a_vl2;
		SELF.a_vl3 := a_vl3;
		SELF.a_vl4 := a_vl4;
		SELF.a_vl5 := a_vl5;
		SELF.a_vl6 := a_vl6;
		SELF.a_vl7 := a_vl7;
		SELF.a_vl8 := a_vl8;
		SELF.a_vl9 := a_vl9;
		SELF.a_vl10 := a_vl10;
		SELF.a_vl11 := a_vl11;
		SELF.rc1_2 := rc1_2;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF._rc_inq := _rc_inq;
		SELF.rc3_c41 := rc3_c41;
		SELF.rc1_c41 := rc1_c41;
		SELF.rc4_c41 := rc4_c41;
		SELF.rc5_c41 := rc5_c41;
		SELF.rc2_c41 := rc2_c41;
		SELF.rc1_1 := rc1_1;
		SELF.rc3_1 := rc3_1;
		SELF.rc2_1 := rc2_1;
		SELF.rc5_1 := rc5_1;
		SELF.rc4_1 := rc4_1;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;
		SELF.rc5 := reasons[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1605_1_0_score;
	#end
		SELF.seq := le.seq;
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

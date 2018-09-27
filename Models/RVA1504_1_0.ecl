IMPORT Models, UT, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVA1504_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			       // integer     seq                              ;
						 // string     score                             ;
			       real       sysdate                          ;
             string       rv_d32_criminal_x_felony         ;
             real       rv_c21_stl_inq_count             ;
             real       rv_d33_eviction_count            ;
             real       rv_d34_unrel_liens_ct            ;
             real       _header_first_seen               ;
             real       rv_c10_m_hdr_fs                  ;
             real       rv_s66_adlperssn_count           ;
             string     rv_f03_address_match             ;
             real       rv_l80_inp_avm_autoval           ;
             real       rv_c14_addrs_10yr                ;
             string     rv_a41_prop_owner                ;
             real       rv_i60_inq_hiriskcred_recency    ;
             real       rv_a50_pb_total_orders           ;
             real       tx_subscore0                     ;
             real       tx_subscore1                     ;
             real       tx_subscore2                     ;
             real       tx_subscore3                     ;
             real       tx_subscore4                     ;
             real       tx_subscore5                     ;
             real       tx_subscore6                     ;
             real       tx_subscore7                     ;
             real       tx_subscore8                     ;
             real       tx_subscore9                     ;
             real       tx_subscore10                    ;
             real       tx_subscore11                    ;
             real       tx_rawscore                      ;
             real       tx_lnoddsscore                   ;
             real       tx_probscore                     ;
             string     tx_aacd_0                        ;
             real       tx_dist_0                        ;
             string     tx_aacd_1                        ;
             real       tx_dist_1                        ;
             string     tx_aacd_2                        ;
             real       tx_dist_2                        ;
             string     tx_aacd_3                        ;
             real       tx_dist_3                        ;
             string     tx_aacd_4                        ;
             real       tx_dist_4                        ;
             string     tx_aacd_5                        ;
             real       tx_dist_5                        ;
             string     tx_aacd_6                        ;
             real       tx_dist_6                        ;
             string     tx_aacd_7                        ;
             real       tx_dist_7                        ;
             string     tx_aacd_8                        ;
             real       tx_dist_8                        ;
             string     tx_aacd_9                        ;
             real       tx_dist_9                        ;
             string     tx_aacd_10                       ;
             real       tx_dist_10                       ;
             string     tx_aacd_11                       ;
             real       tx_dist_11                       ;
             real       tx_rcvaluec21                    ;
             real       tx_rcvaluel80                    ;
             real       tx_rcvalued34                    ;
             real       tx_rcvalued32                    ;
             real       tx_rcvalued33                    ;
             real       tx_rcvaluea51                    ;
             real       tx_rcvaluea50                    ;
             real       tx_rcvaluei60                    ;
             real       tx_rcvaluef03                    ;
             real       tx_rcvaluea41                    ;
             real       tx_rcvalues66                    ;
             real       tx_rcvaluec10                    ;
             real       tx_rcvaluec14                    ;
             real       deceased                         ;
             string     iv_rv5_unscorable                ;
             real       base                             ;
             real       pts                              ;
             real       odds                             ;
             real       rva1504_1_0                      ;
             string     _rc_inq                          ;
             string     tx_rc1                           ;
             string     tx_rc2                           ;
             string     tx_rc3                           ;
             string     tx_rc4                           ;
             string     rc1                              ;
             string     rc4                              ;
             string     rc2                              ;
             string     rc3                              ;
             string     rc5                              ;
      	models.layout_modelout;      
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_eviction_count              := le.bjl.eviction_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */



NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

rv_d34_unrel_liens_ct := if(not(truedid), NULL, min(if(liens_recent_unreleased_count + liens_historical_unreleased_ct = NULL, -NULL, liens_recent_unreleased_count + liens_historical_unreleased_ct), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_s66_adlperssn_count := map(
    not((integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_f03_address_match := map(
    not(truedid)                                => '                          ',
    add_input_isbestmatch                       => '4 INPUT=CURR              ',
    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
    add_curr_pop                                => '1 CURR ONHDRONLY          ',
    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
                                                   '');

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_c14_addrs_10yr := map(
    not(truedid)     => NULL,
    (integer)add_curr_pop = 0 => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

rv_a41_prop_owner := map(
    not(truedid)                                                                                   => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
                                                                                                      '0');

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 >0 => 1,
    inq_highRiskCredit_count03 >0=> 3,
    inq_highRiskCredit_count06 >0=> 6,
    inq_highRiskCredit_count12 >0=> 12,
    inq_highRiskCredit_count24 >0=> 24,
    inq_highRiskCredit_count   >0=> 99,
                                  0);

rv_a50_pb_total_orders := map(
    not(truedid)           => NULL,
    pb_total_orders = '' => -1,
                              (integer)pb_total_orders);

tx_subscore0 := map(
    (rv_d32_criminal_x_felony in [' '])                                      => 0,
    (rv_d32_criminal_x_felony in ['0-0'])                                    => 0.077948,
    (rv_d32_criminal_x_felony in ['1-0'])                                    => -0.269405,
    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => -0.381905,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.521546,
                                                                                0);

tx_subscore1 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 0.061702,
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => -0.007977,
    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => -0.190485,
    3 <= rv_d33_eviction_count                                 => -0.657434,
                                                                  0);

tx_subscore2 := map(
    (rv_f03_address_match in [' '])                                                                          => 0,
    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => -0.173127,
    (rv_f03_address_match in ['4 INPUT=CURR'])                                                               => 0.16128,
                                                                                                                0);

tx_subscore3 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 0.331303,
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 0.09778,
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 0.034655,
    5 <= rv_c14_addrs_10yr                             => -0.179272,
                                                          0);

tx_subscore4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 0.066398,
    3 <= rv_s66_adlperssn_count                                  => -0.310984,
                                                                    0);

tx_subscore5 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.036347,
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.565796,
    6 <= rv_i60_inq_hiriskcred_recency                                         => -0.083252,
                                                                                  0);

tx_subscore6 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 0,
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 285   => -0.051436,
    285 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 336 => 0.236135,
    336 <= rv_c10_m_hdr_fs                           => 0.410087,
                                                        0);

tx_subscore7 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1        => 0.03601,
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 31944      => -0.394864,
    31944 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 120868 => -0.072839,
    120868 <= rv_l80_inp_avm_autoval                                    => 0.293129,
                                                                           0);

tx_subscore8 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.049207,
    1 <= rv_c21_stl_inq_count                                => -0.245523,
                                                                0);

tx_subscore9 := map(
    NULL < (integer)rv_a50_pb_total_orders AND (integer)rv_a50_pb_total_orders < 1 => -0.077166,
    1 <= (integer)rv_a50_pb_total_orders                                  => 0.127716,
                                                                    0);

tx_subscore10 := map(
    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1 => 0.032843,
    1 <= rv_d34_unrel_liens_ct                                 => -0.253939,
                                                                  0);

tx_subscore11 := map(
    (rv_a41_prop_owner in [' ']) => 0,
    (rv_a41_prop_owner in ['0']) => -0.047526,
    (rv_a41_prop_owner in ['1']) => 0.131213,
                                    0);

tx_rawscore := tx_subscore0 +
    tx_subscore1 +
    tx_subscore2 +
    tx_subscore3 +
    tx_subscore4 +
    tx_subscore5 +
    tx_subscore6 +
    tx_subscore7 +
    tx_subscore8 +
    tx_subscore9 +
    tx_subscore10 +
    tx_subscore11;

tx_lnoddsscore := tx_rawscore + 0.454412;

tx_probscore := exp(tx_lnoddsscore) / (1 + exp(tx_lnoddsscore));

tx_aacd_0 := map(
    (rv_d32_criminal_x_felony in [' '])                                      => '',
    (rv_d32_criminal_x_felony in ['0-0'])                                    => 'D32',
    (rv_d32_criminal_x_felony in ['1-0'])                                    => 'D32',
    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
                                                                                '');

tx_dist_0 := tx_subscore0 - 0.077948;

tx_aacd_1 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => 'D33',
    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => 'D33',
    3 <= rv_d33_eviction_count                                 => 'D33',
                                                                  '');

tx_dist_1 := tx_subscore1 - 0.061702;

tx_aacd_2 := map(
    (rv_f03_address_match in [' '])                                                                          => '',
    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => 'F03',
    (rv_f03_address_match in ['4 INPUT=CURR'])                                                               => 'F03',
                                                                                                                '');

tx_dist_2 := tx_subscore2 - 0.16128;

tx_aacd_3 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1 => 'C14',
    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 'C14',
    5 <= rv_c14_addrs_10yr                             => 'C14',
                                                          '');

tx_dist_3 := tx_subscore3 - 0.331303;

tx_aacd_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 'S66',
    3 <= rv_s66_adlperssn_count                                  => 'S66',
                                                                    '');

tx_dist_4 := tx_subscore4 - 0.066398;

tx_aacd_5 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
    6 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
                                                                                  '');

tx_dist_5 := tx_subscore5 - 0.036347;

tx_aacd_6 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 'C10',
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 285   => 'C10',
    285 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 336 => 'C10',
    336 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        'C10');

tx_dist_6 := tx_subscore6 - 0.410087;

tx_aacd_7 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1        => 'A51',
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 31944      => 'L80',
    31944 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 120868 => 'L80',
    120868 <= rv_l80_inp_avm_autoval                                    => 'L80',
                                                                           '');

tx_dist_7 := tx_subscore7 - 0.293129;

tx_aacd_8 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

tx_dist_8 := tx_subscore8 - 0.049207;

tx_aacd_9 := map(
    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
    1 <= rv_a50_pb_total_orders                                  => 'A50',
                                                                    '');

// tx_dist_9 := tx_subscore9 - 0.127716;
tx_dist_9 := 0;  // hard code to 0 to remove iBehavior reason codes

tx_aacd_10 := map(
    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1 => 'D34',
    1 <= rv_d34_unrel_liens_ct                                 => 'D34',
                                                                  '');

tx_dist_10 := tx_subscore10 - 0.032843;

tx_aacd_11 := map(
    (rv_a41_prop_owner in [' ']) => '',
    (rv_a41_prop_owner in ['0']) => 'A41',
    (rv_a41_prop_owner in ['1']) => 'A41',
                                    '');

tx_dist_11 := tx_subscore11 - 0.131213;

tx_rcvaluec21 := (integer)(tx_aacd_0 = 'C21') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'C21') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'C21') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'C21') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'C21') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'C21') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'C21') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'C21') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'C21') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'C21') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'C21') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'C21') * tx_dist_11;

tx_rcvaluel80 := (integer)(tx_aacd_0 = 'L80') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'L80') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'L80') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'L80') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'L80') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'L80') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'L80') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'L80') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'L80') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'L80') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'L80') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'L80') * tx_dist_11;

tx_rcvalued34 := (integer)(tx_aacd_0 = 'D34') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'D34') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'D34') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'D34') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'D34') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'D34') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'D34') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'D34') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'D34') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'D34') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'D34') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'D34') * tx_dist_11;

tx_rcvalued32 := (integer)(tx_aacd_0 = 'D32') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'D32') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'D32') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'D32') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'D32') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'D32') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'D32') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'D32') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'D32') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'D32') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'D32') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'D32') * tx_dist_11;

tx_rcvalued33 := (integer)(tx_aacd_0 = 'D33') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'D33') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'D33') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'D33') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'D33') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'D33') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'D33') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'D33') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'D33') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'D33') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'D33') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'D33') * tx_dist_11;

tx_rcvaluea51 := (integer)(tx_aacd_0 = 'A51') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'A51') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'A51') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'A51') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'A51') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'A51') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'A51') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'A51') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'A51') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'A51') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'A51') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'A51') * tx_dist_11;

tx_rcvaluea50 := (integer)(tx_aacd_0 = 'A50') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'A50') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'A50') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'A50') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'A50') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'A50') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'A50') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'A50') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'A50') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'A50') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'A50') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'A50') * tx_dist_11;

tx_rcvaluei60 := (integer)(tx_aacd_0 = 'I60') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'I60') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'I60') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'I60') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'I60') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'I60') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'I60') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'I60') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'I60') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'I60') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'I60') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'I60') * tx_dist_11;

tx_rcvaluef03 := (integer)(tx_aacd_0 = 'F03') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'F03') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'F03') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'F03') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'F03') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'F03') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'F03') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'F03') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'F03') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'F03') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'F03') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'F03') * tx_dist_11;

tx_rcvaluea41 := (integer)(tx_aacd_0 = 'A41') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'A41') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'A41') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'A41') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'A41') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'A41') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'A41') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'A41') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'A41') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'A41') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'A41') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'A41') * tx_dist_11;

tx_rcvalues66 := (integer)(tx_aacd_0 = 'S66') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'S66') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'S66') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'S66') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'S66') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'S66') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'S66') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'S66') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'S66') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'S66') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'S66') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'S66') * tx_dist_11;

tx_rcvaluec10 := (integer)(tx_aacd_0 = 'C10') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'C10') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'C10') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'C10') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'C10') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'C10') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'C10') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'C10') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'C10') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'C10') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'C10') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'C10') * tx_dist_11;

tx_rcvaluec14 := (integer)(tx_aacd_0 = 'C14') * tx_dist_0 +
    (integer)(tx_aacd_1 = 'C14') * tx_dist_1 +
    (integer)(tx_aacd_2 = 'C14') * tx_dist_2 +
    (integer)(tx_aacd_3 = 'C14') * tx_dist_3 +
    (integer)(tx_aacd_4 = 'C14') * tx_dist_4 +
    (integer)(tx_aacd_5 = 'C14') * tx_dist_5 +
    (integer)(tx_aacd_6 = 'C14') * tx_dist_6 +
    (integer)(tx_aacd_7 = 'C14') * tx_dist_7 +
    (integer)(tx_aacd_8 = 'C14') * tx_dist_8 +
    (integer)(tx_aacd_9 = 'C14') * tx_dist_9 +
    (integer)(tx_aacd_10 = 'C14') * tx_dist_10 +
    (integer)(tx_aacd_11 = 'C14') * tx_dist_11;

deceased := map(
    (integer)rc_decsflag = 1                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

base := 700;

pts := 40;

odds := (1 - .3871) / .3871;

rva1504_1_0 := map(
    deceased > 0            => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(pts * (ln(tx_probscore / (1 - tx_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(tx_probscore / (1 - tx_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

_rc_inq := if(rv_i60_inq_hiriskcred_recency > 0, 'I60', '');


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_tx := DATASET([
    {'C21', tx_rcvalueC21},
    {'L80', tx_rcvalueL80},
    {'D34', tx_rcvalueD34},
    {'D32', tx_rcvalueD32},
    {'D33', tx_rcvalueD33},
    {'A51', tx_rcvalueA51},
    {'A50', tx_rcvalueA50},
    {'I60', tx_rcvalueI60},
    {'F03', tx_rcvalueF03},
    {'A41', tx_rcvalueA41},
    {'S66', tx_rcvalueS66},
    {'C10', tx_rcvalueC10},
    {'C14', tx_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_tx_sorted := sort(rc_dataset_tx, rc_dataset_tx.value);

tx_rc1 := rc_dataset_tx_sorted[1].rc;
tx_rc2 := rc_dataset_tx_sorted[2].rc;
tx_rc3 := rc_dataset_tx_sorted[3].rc;
tx_rc4 := rc_dataset_tx_sorted[4].rc;
//*************************************************************************************//

rc1_2 := tx_rc1;

rc2_2 := tx_rc2;

rc3_2 := tx_rc3;

rc4_2 := tx_rc4;

rc1_c42 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc1_2);

rc4_c42 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc4_2);

rc2_c42 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc2_2);

rc3_c42 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc3_2);

rc5_c42 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         _rc_inq);

rc1_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc1_c42, rc1_2);

rc4_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc4_c42, rc4_2);

rc2_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc2_c42, rc2_2);

rc3_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc3_c42, rc3_2);

rc5_1 := if(rc1_1 != 'I60' and rc2_1 != 'I60' and rc3_1 != 'I60' and rc4_1 != 'I60', rc5_c42, '');

rc1 := if((rva1504_1_0 in [200, 222]), '', rc1_1);

rc4 := if((rva1504_1_0 in [200, 222]), '', rc4_1);

rc2 := if((rva1504_1_0 in [200, 222]), '', rc2_1);

rc3 := if((rva1504_1_0 in [200, 222]), '', rc3_1);

rc5 := if((rva1504_1_0 in [200, 222]), '', rc5_1);


	//*************************************************************************************//
	//                      RiskView Version 5 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
	//*************************************************************************************//
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1504_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1504_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1504_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							DATASET([], HRILayout)
													);
	reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
	// If we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
											reasonsOverrides, 
											reasons) (HRI NOT IN ['', '00']);
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

	//*************************************************************************************//
	//                   End RiskView Version 5 Reason Code Overrides
	//*************************************************************************************//
#if(MODEL_DEBUG)
                    self.clam                             := le ;
                    self.sysdate                          := sysdate;
                    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
                    self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
                    self.rv_d33_eviction_count            := rv_d33_eviction_count;
                    self.rv_d34_unrel_liens_ct            := rv_d34_unrel_liens_ct;
                    self._header_first_seen               := _header_first_seen;
                    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
                    self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
                    self.rv_f03_address_match             := rv_f03_address_match;
                    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
                    self.rv_c14_addrs_10yr                := rv_c14_addrs_10yr;
                    self.rv_a41_prop_owner                := rv_a41_prop_owner;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_a50_pb_total_orders           := rv_a50_pb_total_orders;
                    self.tx_subscore0                     := tx_subscore0;
                    self.tx_subscore1                     := tx_subscore1;
                    self.tx_subscore2                     := tx_subscore2;
                    self.tx_subscore3                     := tx_subscore3;
                    self.tx_subscore4                     := tx_subscore4;
                    self.tx_subscore5                     := tx_subscore5;
                    self.tx_subscore6                     := tx_subscore6;
                    self.tx_subscore7                     := tx_subscore7;
                    self.tx_subscore8                     := tx_subscore8;
                    self.tx_subscore9                     := tx_subscore9;
                    self.tx_subscore10                    := tx_subscore10;
                    self.tx_subscore11                    := tx_subscore11;
                    self.tx_rawscore                      := tx_rawscore;
                    self.tx_lnoddsscore                   := tx_lnoddsscore;
                    self.tx_probscore                     := tx_probscore;
                    self.tx_aacd_0                        := tx_aacd_0;
                    self.tx_dist_0                        := tx_dist_0;
                    self.tx_aacd_1                        := tx_aacd_1;
                    self.tx_dist_1                        := tx_dist_1;
                    self.tx_aacd_2                        := tx_aacd_2;
                    self.tx_dist_2                        := tx_dist_2;
                    self.tx_aacd_3                        := tx_aacd_3;
                    self.tx_dist_3                        := tx_dist_3;
                    self.tx_aacd_4                        := tx_aacd_4;
                    self.tx_dist_4                        := tx_dist_4;
                    self.tx_aacd_5                        := tx_aacd_5;
                    self.tx_dist_5                        := tx_dist_5;
                    self.tx_aacd_6                        := tx_aacd_6;
                    self.tx_dist_6                        := tx_dist_6;
                    self.tx_aacd_7                        := tx_aacd_7;
                    self.tx_dist_7                        := tx_dist_7;
                    self.tx_aacd_8                        := tx_aacd_8;
                    self.tx_dist_8                        := tx_dist_8;
                    self.tx_aacd_9                        := tx_aacd_9;
                    self.tx_dist_9                        := tx_dist_9;
                    self.tx_aacd_10                       := tx_aacd_10;
                    self.tx_dist_10                       := tx_dist_10;
                    self.tx_aacd_11                       := tx_aacd_11;
                    self.tx_dist_11                       := tx_dist_11;
                    self.tx_rcvaluec21                    := tx_rcvaluec21;
                    self.tx_rcvaluel80                    := tx_rcvaluel80;
                    self.tx_rcvalued34                    := tx_rcvalued34;
                    self.tx_rcvalued32                    := tx_rcvalued32;
                    self.tx_rcvalued33                    := tx_rcvalued33;
                    self.tx_rcvaluea51                    := tx_rcvaluea51;
                    self.tx_rcvaluea50                    := tx_rcvaluea50;
                    self.tx_rcvaluei60                    := tx_rcvaluei60;
                    self.tx_rcvaluef03                    := tx_rcvaluef03;
                    self.tx_rcvaluea41                    := tx_rcvaluea41;
                    self.tx_rcvalues66                    := tx_rcvalues66;
                    self.tx_rcvaluec10                    := tx_rcvaluec10;
                    self.tx_rcvaluec14                    := tx_rcvaluec14;
                    self.deceased                         := deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rva1504_1_0                      := rva1504_1_0;
                    self._rc_inq                          := _rc_inq;
                    self.tx_rc1                           := tx_rc1;
                    self.tx_rc2                           := tx_rc2;
                    self.tx_rc3                           := tx_rc3;
                    self.tx_rc4                           := tx_rc4;
                    self.rc1                              := rc1;
                    self.rc4                              := rc4;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc5                              := rc5;
										// self.score := (string3)rva1504_1_0;
  #end

		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																								SELF.hri := if(LEFT.hri='', '00', left.hri),
																								SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																						));
			
		self.score := MAP(
												reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
												reasons[1].hri='35' => '100',
												(string3)rva1504_1_0
											);
											
		self.seq := le.seq;
			
    // #end
		
		
		END;

		model := project( clam, doModel(left) );

		return model;
	END;

IMPORT Models, UT, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVA1504_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			      // integer     seq;
						// string      score;
			      real        sysdate;
            string      rv_f03_input_add_not_most_rec;
            real        rv_f01_inp_addr_address_score;
            string      rv_d32_criminal_x_felony;
            real        rv_c21_stl_inq_count;
            string      rv_d33_eviction_recency;
            real        rv_d34_unrel_lien60_count;
            integer     bureau_adl_eq_fseen_pos;
            string      bureau_adl_fseen_eq;
            real        _bureau_adl_fseen_eq;
            real        _src_bureau_adl_fseen;
            real        rv_c20_m_bureau_adl_fs;
            real        rv_c14_addrs_5yr;
            string      rv_prop_owner_history;
            real        rv_i60_inq_hiriskcred_count12;
            real        az_ca_subscore0;
            real        az_ca_subscore1;
            real        az_ca_subscore2;
            real        az_ca_subscore3;
            real        az_ca_subscore4;
            real        az_ca_subscore5;
            real        az_ca_subscore6;
            real        az_ca_subscore7;
            real        az_ca_subscore8;
            real        az_ca_subscore9;
            real        az_ca_rawscore;
            real        az_ca_lnoddsscore;
            real        az_ca_probscore;
            string      az_ca_aacd_0;
            real        az_ca_dist_0;
            string      az_ca_aacd_1;
            real        az_ca_dist_1;
            string      az_ca_aacd_2;
            real        az_ca_dist_2;
            string      az_ca_aacd_3;
            real        az_ca_dist_3;
            string      az_ca_aacd_4;
            real        az_ca_dist_4;
            string      az_ca_aacd_5;
            real        az_ca_dist_5;
            string      az_ca_aacd_6;
            real        az_ca_dist_6;
            string      az_ca_aacd_7;
            real        az_ca_dist_7;
            string      az_ca_aacd_8;
            real        az_ca_dist_8;
            string      az_ca_aacd_9;
            real        az_ca_dist_9;
            real        az_ca_rcvaluef01;
            real        az_ca_rcvaluec21;
            real        az_ca_rcvaluec20;
            real        az_ca_rcvalued34;
            real        az_ca_rcvalued32;
            real        az_ca_rcvalued33;
            real        az_ca_rcvaluea42;
            real        az_ca_rcvaluef03;
            real        az_ca_rcvaluea41;
            real        az_ca_rcvaluei60;
            real        az_ca_rcvaluec14;
            real        deceased;
            string      iv_rv5_unscorable;
            real        base;
            real        pts;
            real        odds;
            real        rva1504_2_0;
            string      _rc_inq;
            string      az_ca_rc1;
            string      az_ca_rc2;
            string      az_ca_rc3;
            string      az_ca_rc4;
            string      rc1;
            string      rc4;
            string      rc2;
            string      rc3;
            string      rc5;
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
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), '', (string)(integer)rc_input_addr_not_most_recent);

rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_recency := map(
    not(truedid)                                                  => '  ',
    attr_eviction_count90  >0                                     => '03',
    attr_eviction_count180 >0                                     => '06',
    attr_eviction_count12  >0                                     => '12',
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2   => '24',
    attr_eviction_count24  >0                                     => '25',
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2   => '36',
    attr_eviction_count36  >0                                     => '37',
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
    attr_eviction_count60  >0                                     => '61',
    attr_eviction_count >= 2                                    => '98',
    attr_eviction_count >= 1                                    => '99',
                                                                   '00');

rv_d34_unrel_lien60_count := if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

rv_c20_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

rv_c14_addrs_5yr := map(
    not(truedid)     => NULL,
    (integer)add_curr_pop = 0 => -1,
                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

rv_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

az_ca_subscore0 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 20  => -0.411359,
    20 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => -0.013781,
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 0.159754,
    255 <= rv_f01_inp_addr_address_score                                         => 0,
                                                                                    0);

az_ca_subscore1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.065395,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.88171,
                                                                                  0);

az_ca_subscore2 := map(
    (rv_d33_eviction_recency in [' '])                          => 0,
    (rv_d33_eviction_recency in ['00'])                         => 0.067126,
    (rv_d33_eviction_recency in ['03', '06', '12', '24', '25']) => -0.77401,
    (rv_d33_eviction_recency in ['36', '37', '60', '61', '98']) => -0.413806,
    (rv_d33_eviction_recency in ['99'])                         => -0.205836,
                                                                   0);

az_ca_subscore3 := map(
    (rv_prop_owner_history in [' '])          => 0,
    (rv_prop_owner_history in ['CURRENT'])    => 0.422652,
    (rv_prop_owner_history in ['HISTORICAL']) => 0.186118,
    (rv_prop_owner_history in ['NEVER'])      => -0.099331,
                                                 0);

az_ca_subscore4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.048458,
    1 <= rv_c21_stl_inq_count                                => -0.51398,
                                                                0);

az_ca_subscore5 := map(
    (rv_d32_criminal_x_felony in [' '])                               => 0,
    (rv_d32_criminal_x_felony in ['0-0'])                             => 0.021159,
    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])               => -0.147898,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-2', '3-3']) => -1.132035,
                                                                         0);

az_ca_subscore6 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0 => 0,
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310 => -0.04678,
    310 <= rv_c20_m_bureau_adl_fs                                => 0.378489,
                                                                    0);

az_ca_subscore7 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.084466,
    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => -0.010487,
    3 <= rv_c14_addrs_5yr                            => -0.234182,
                                                        0);

az_ca_subscore8 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => 0,
    (rv_f03_input_add_not_most_rec in ['0']) => 0.042125,
    (rv_f03_input_add_not_most_rec in ['1']) => -0.304407,
                                                0);

az_ca_subscore9 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 1 => 0.045711,
    1 <= rv_d34_unrel_lien60_count                                     => -0.260858,
                                                                          0);

az_ca_rawscore := az_ca_subscore0 +
    az_ca_subscore1 +
    az_ca_subscore2 +
    az_ca_subscore3 +
    az_ca_subscore4 +
    az_ca_subscore5 +
    az_ca_subscore6 +
    az_ca_subscore7 +
    az_ca_subscore8 +
    az_ca_subscore9;

az_ca_lnoddsscore := az_ca_rawscore + 1.355299;

az_ca_probscore := exp(az_ca_lnoddsscore) / (1 + exp(az_ca_lnoddsscore));

az_ca_aacd_0 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 20  => 'F01',
    20 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => 'F01',
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 'F01',
    255 <= rv_f01_inp_addr_address_score                                         => '',
                                                                                    '');

az_ca_dist_0 := az_ca_subscore0 - 0.159754;

az_ca_aacd_1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

az_ca_dist_1 := az_ca_subscore1 - 0.065395;

az_ca_aacd_2 := map(
    (rv_d33_eviction_recency in [' '])                          => '',
    (rv_d33_eviction_recency in ['00'])                         => 'D33',
    (rv_d33_eviction_recency in ['03', '06', '12', '24', '25']) => 'D33',
    (rv_d33_eviction_recency in ['36', '37', '60', '61', '98']) => 'D33',
    (rv_d33_eviction_recency in ['99'])                         => 'D33',
                                                                   '');

az_ca_dist_2 := az_ca_subscore2 - 0.067126;

az_ca_aacd_3 := map(
    (rv_prop_owner_history in [' '])          => '',
    (rv_prop_owner_history in ['CURRENT'])    => '',
    (rv_prop_owner_history in ['HISTORICAL']) => 'A42',
    (rv_prop_owner_history in ['NEVER'])      => 'A41',
                                                 '');

az_ca_dist_3 := az_ca_subscore3 - 0.422652;

az_ca_aacd_4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count                                => 'C21',
                                                                '');

az_ca_dist_4 := az_ca_subscore4 - 0.048458;

az_ca_aacd_5 := map(
    (rv_d32_criminal_x_felony in [' '])                               => '',
    (rv_d32_criminal_x_felony in ['0-0'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])               => 'D32',
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-2', '3-3']) => 'D32',
                                                                         '');

az_ca_dist_5 := az_ca_subscore5 - 0.021159;

az_ca_aacd_6 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0 => 'C20',
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310 => 'C20',
    310 <= rv_c20_m_bureau_adl_fs                                => 'C20',
                                                                    'C20');

az_ca_dist_6 := az_ca_subscore6 - 0.378489;

az_ca_aacd_7 := map(
    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 'C14',
    3 <= rv_c14_addrs_5yr                            => 'C14',
                                                        '');

az_ca_dist_7 := az_ca_subscore7 - 0.084466;

az_ca_aacd_8 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => '',
    (rv_f03_input_add_not_most_rec in ['0']) => 'F03',
    (rv_f03_input_add_not_most_rec in ['1']) => 'F03',
                                                '');

az_ca_dist_8 := az_ca_subscore8 - 0.042125;

az_ca_aacd_9 := map(
    NULL < rv_d34_unrel_lien60_count AND rv_d34_unrel_lien60_count < 1 => 'D34',
    1 <= rv_d34_unrel_lien60_count                                     => 'D34',
                                                                          '');

az_ca_dist_9 := az_ca_subscore9 - 0.045711;

az_ca_rcvaluef01 := (integer)(az_ca_aacd_0 = 'F01') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'F01') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'F01') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'F01') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'F01') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'F01') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'F01') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'F01') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'F01') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'F01') * az_ca_dist_9;

az_ca_rcvaluec21 := (integer)(az_ca_aacd_0 = 'C21') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'C21') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'C21') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'C21') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'C21') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'C21') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'C21') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'C21') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'C21') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'C21') * az_ca_dist_9;

az_ca_rcvaluec20 := (integer)(az_ca_aacd_0 = 'C20') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'C20') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'C20') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'C20') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'C20') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'C20') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'C20') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'C20') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'C20') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'C20') * az_ca_dist_9;

az_ca_rcvalued34 := (integer)(az_ca_aacd_0 = 'D34') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'D34') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'D34') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'D34') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'D34') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'D34') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'D34') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'D34') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'D34') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'D34') * az_ca_dist_9;

az_ca_rcvalued32 := (integer)(az_ca_aacd_0 = 'D32') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'D32') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'D32') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'D32') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'D32') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'D32') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'D32') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'D32') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'D32') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'D32') * az_ca_dist_9;

az_ca_rcvalued33 := (integer)(az_ca_aacd_0 = 'D33') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'D33') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'D33') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'D33') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'D33') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'D33') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'D33') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'D33') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'D33') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'D33') * az_ca_dist_9;

az_ca_rcvaluea42 := (integer)(az_ca_aacd_0 = 'A42') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'A42') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'A42') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'A42') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'A42') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'A42') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'A42') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'A42') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'A42') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'A42') * az_ca_dist_9;

az_ca_rcvaluef03 := (integer)(az_ca_aacd_0 = 'F03') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'F03') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'F03') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'F03') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'F03') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'F03') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'F03') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'F03') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'F03') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'F03') * az_ca_dist_9;

az_ca_rcvaluea41 := (integer)(az_ca_aacd_0 = 'A41') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'A41') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'A41') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'A41') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'A41') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'A41') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'A41') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'A41') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'A41') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'A41') * az_ca_dist_9;

az_ca_rcvaluei60 := (integer)(az_ca_aacd_0 = 'I60') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'I60') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'I60') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'I60') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'I60') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'I60') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'I60') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'I60') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'I60') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'I60') * az_ca_dist_9;

az_ca_rcvaluec14 := (integer)(az_ca_aacd_0 = 'C14') * az_ca_dist_0 +
    (integer)(az_ca_aacd_1 = 'C14') * az_ca_dist_1 +
    (integer)(az_ca_aacd_2 = 'C14') * az_ca_dist_2 +
    (integer)(az_ca_aacd_3 = 'C14') * az_ca_dist_3 +
    (integer)(az_ca_aacd_4 = 'C14') * az_ca_dist_4 +
    (integer)(az_ca_aacd_5 = 'C14') * az_ca_dist_5 +
    (integer)(az_ca_aacd_6 = 'C14') * az_ca_dist_6 +
    (integer)(az_ca_aacd_7 = 'C14') * az_ca_dist_7 +
    (integer)(az_ca_aacd_8 = 'C14') * az_ca_dist_8 +
    (integer)(az_ca_aacd_9 = 'C14') * az_ca_dist_9;

deceased := map(
    (integer)rc_decsflag = 1                                                        => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

base := 700;

pts := 40;

odds := (1 - .2032) / .2032;

rva1504_2_0 := map(
    deceased > 0            => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(pts * (ln(az_ca_probscore / (1 - az_ca_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(az_ca_probscore / (1 - az_ca_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

_rc_inq := if(rv_i60_inq_hiriskcred_count12 > 0, 'I60', '');

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_az_ca := DATASET([
    {'F01', az_ca_rcvalueF01},
    {'C21', az_ca_rcvalueC21},
    {'C20', az_ca_rcvalueC20},
    {'D34', az_ca_rcvalueD34},
    {'D32', az_ca_rcvalueD32},
    {'D33', az_ca_rcvalueD33},
    {'A42', az_ca_rcvalueA42},
    {'F03', az_ca_rcvalueF03},
    {'A41', az_ca_rcvalueA41},
    {'I60', az_ca_rcvalueI60},
    {'C14', az_ca_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_az_ca_sorted := sort(rc_dataset_az_ca, rc_dataset_az_ca.value);

az_ca_rc1 := rc_dataset_az_ca_sorted[1].rc;
az_ca_rc2 := rc_dataset_az_ca_sorted[2].rc;
az_ca_rc3 := rc_dataset_az_ca_sorted[3].rc;
az_ca_rc4 := rc_dataset_az_ca_sorted[4].rc;
//*************************************************************************************//

az_ca_rc5 := NULL;

rc1_2 := az_ca_rc1;

rc2_2 := az_ca_rc2;

rc3_2 := az_ca_rc3;

rc4_2 := az_ca_rc4;

rc1_c37 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
  
                                                         rc1_2);

rc4_c37 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc4_2);

rc2_c37 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
   
                                                         rc2_2);

rc3_c37 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
                                                         rc3_2);

rc5_c37 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         _rc_inq);

rc1_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc1_c37, rc1_2);

rc4_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc4_c37, rc4_2);

rc2_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc2_c37, rc2_2);

rc3_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc3_c37, rc3_2);

rc5_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc5_c37, '');

rc1 := if((rva1504_2_0 in [200, 222]), '', rc1_1);

rc4 := if((rva1504_2_0 in [200, 222]), '', rc4_1);

rc2 := if((rva1504_2_0 in [200, 222]), '', rc2_1);

rc3 := if((rva1504_2_0 in [200, 222]), '', rc3_1);

rc5 := if((rva1504_2_0 in [200, 222]), '', rc5_1);


	//*************************************************************************************//
	//                      RiskView Version 5 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
	//*************************************************************************************//
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1504_2_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1504_2_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1504_2_0 = 900 => DATASET([{'00'}], HRILayout),
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
                    self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
                    self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
                    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
                    self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.rv_d34_unrel_lien60_count        := rv_d34_unrel_lien60_count;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.rv_c14_addrs_5yr                 := rv_c14_addrs_5yr;
                    self.rv_prop_owner_history            := rv_prop_owner_history;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.az_ca_subscore0                  := az_ca_subscore0;
                    self.az_ca_subscore1                  := az_ca_subscore1;
                    self.az_ca_subscore2                  := az_ca_subscore2;
                    self.az_ca_subscore3                  := az_ca_subscore3;
                    self.az_ca_subscore4                  := az_ca_subscore4;
                    self.az_ca_subscore5                  := az_ca_subscore5;
                    self.az_ca_subscore6                  := az_ca_subscore6;
                    self.az_ca_subscore7                  := az_ca_subscore7;
                    self.az_ca_subscore8                  := az_ca_subscore8;
                    self.az_ca_subscore9                  := az_ca_subscore9;
                    self.az_ca_rawscore                   := az_ca_rawscore;
                    self.az_ca_lnoddsscore                := az_ca_lnoddsscore;
                    self.az_ca_probscore                  := az_ca_probscore;
                    self.az_ca_aacd_0                     := az_ca_aacd_0;
                    self.az_ca_dist_0                     := az_ca_dist_0;
                    self.az_ca_aacd_1                     := az_ca_aacd_1;
                    self.az_ca_dist_1                     := az_ca_dist_1;
                    self.az_ca_aacd_2                     := az_ca_aacd_2;
                    self.az_ca_dist_2                     := az_ca_dist_2;
                    self.az_ca_aacd_3                     := az_ca_aacd_3;
                    self.az_ca_dist_3                     := az_ca_dist_3;
                    self.az_ca_aacd_4                     := az_ca_aacd_4;
                    self.az_ca_dist_4                     := az_ca_dist_4;
                    self.az_ca_aacd_5                     := az_ca_aacd_5;
                    self.az_ca_dist_5                     := az_ca_dist_5;
                    self.az_ca_aacd_6                     := az_ca_aacd_6;
                    self.az_ca_dist_6                     := az_ca_dist_6;
                    self.az_ca_aacd_7                     := az_ca_aacd_7;
                    self.az_ca_dist_7                     := az_ca_dist_7;
                    self.az_ca_aacd_8                     := az_ca_aacd_8;
                    self.az_ca_dist_8                     := az_ca_dist_8;
                    self.az_ca_aacd_9                     := az_ca_aacd_9;
                    self.az_ca_dist_9                     := az_ca_dist_9;
                    self.az_ca_rcvaluef01                 := az_ca_rcvaluef01;
                    self.az_ca_rcvaluec21                 := az_ca_rcvaluec21;
                    self.az_ca_rcvaluec20                 := az_ca_rcvaluec20;
                    self.az_ca_rcvalued34                 := az_ca_rcvalued34;
                    self.az_ca_rcvalued32                 := az_ca_rcvalued32;
                    self.az_ca_rcvalued33                 := az_ca_rcvalued33;
                    self.az_ca_rcvaluea42                 := az_ca_rcvaluea42;
                    self.az_ca_rcvaluef03                 := az_ca_rcvaluef03;
                    self.az_ca_rcvaluea41                 := az_ca_rcvaluea41;
                    self.az_ca_rcvaluei60                 := az_ca_rcvaluei60;
                    self.az_ca_rcvaluec14                 := az_ca_rcvaluec14;
                    self.deceased                         := deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rva1504_2_0                      := rva1504_2_0;
                    self._rc_inq                          := _rc_inq;
                    self.az_ca_rc1                        := az_ca_rc1;
                    self.az_ca_rc2                        := az_ca_rc2;
                    self.az_ca_rc3                        := az_ca_rc3;
                    self.az_ca_rc4                        := az_ca_rc4;
                    self.rc1                              := rc1;
                    self.rc4                              := rc4;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc5                              := rc5;
										// self.score := (string3)rva1504_2_0;

  #end

		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																								SELF.hri := if(LEFT.hri='', '00', left.hri),
																								SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																						));
			
			
			self.score := MAP(
												reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
												reasons[1].hri='35' => '100',
												(string3)RVA1504_2_0
											);
											
			self.seq := le.seq;
    // #end	
		
		END;

		model := project( clam, doModel(left) );

		return model;
	END;

IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVA1607_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Input Variables */
		unsigned	seq;
		integer4	sysdate;
		string1		add_ec1;
		string1		add_ec3;
		string1		add_ec4;
		string30	rv_l70_add_standardized;
		string1		rv_f03_input_add_not_most_rec;
		string1		rv_c19_add_prison_hist;
		string3		rv_d32_criminal_x_felony;
		string2		rv_d33_eviction_recency;
		integer4	bureau_adl_eq_fseen_pos;
		string		bureau_adl_fseen_eq;
		integer4	_bureau_adl_fseen_eq;
		integer4	_src_bureau_adl_fseen;
		integer		rv_c20_m_bureau_adl_fs;
		integer		rv_a46_curr_avm_autoval;
		integer		rv_c13_max_lres;
		string1		rv_ever_asset_owner;
		integer		rv_i61_inq_collection_count12;
		integer		rv_i60_inq_banking_count12;
		integer		rv_c13_inp_addr_lres;
		integer		rv_i62_inq_phones_per_adl;
		integer		rv_i62_inq_dobs_per_adl;
		real			s0_subscore0;
		real			s0_subscore1;
		real			s0_subscore2;
		real			s0_subscore3;
		real			s0_subscore4;
		real			s0_subscore5;
		real			s0_subscore6;
		real			s0_subscore7;
		real			s0_subscore8;
		real			s0_subscore9;
		real			s0_subscore10;
		real			s0_subscore11;
		real			s0_subscore12;
		real			s0_subscore13;
		real			s0_rawscore;
		real			s0_lnoddsscore;
		real			s0_probscore;
		string3		s0_aacd_0;
		real 			s0_dist_0;
		string3		s0_aacd_1;
		real 			s0_dist_1;
		string3		s0_aacd_2;
		real 			s0_dist_2;
		string3		s0_aacd_3;
		real 			s0_dist_3;
		string3		s0_aacd_4;
		real 			s0_dist_4;
		string3		s0_aacd_5;
		real 			s0_dist_5;
		string3		s0_aacd_6;
		real 			s0_dist_6;
		string3		s0_aacd_7;
		real 			s0_dist_7;
		string3		s0_aacd_8;
		real 			s0_dist_8;
		string3		s0_aacd_9;
		real 			s0_dist_9;
		string3		s0_aacd_10;
		real 			s0_dist_10;
		string3		s0_aacd_11;
		real 			s0_dist_11;
		string3		s0_aacd_12;
		real 			s0_dist_12;
		string3		s0_aacd_13;
		real 			s0_dist_13;
		real 			s0_rcvaluea40;
		real 			s0_rcvaluec20;
		real 			s0_rcvaluef03;
		real 			s0_rcvaluel70;
		real 			s0_rcvalued32;
		real 			s0_rcvalued33;
		real 			s0_rcvaluea46;
		real 			s0_rcvaluec19;
		real 			s0_rcvaluei60;
		real 			s0_rcvaluei61;
		real 			s0_rcvaluei62;
		real 			s0_rcvaluec13;
		real 			s0_rcvaluec12;
		boolean		iv_rv5_deceased;
		string1		iv_rv5_unscorable;
		integer		base;
		integer		pts;
		real			odds;
		integer		rva1607_1_0;
		string3		_rc_inq;
		string3		rc5;
		string3		rc2;
		string3		rc1;
		string3		rc3;
		string3		rc4;
		//temp fields to debug reason codes
		string3		s0_rc1;
		string3		s0_rc2;
		string3		s0_rc3;
		string3		s0_rc4;
		string3		rc1_2;
		string3		rc2_2;
		string3		rc3_2;
		string3		rc4_2;
		string3		rc1_c48;
		string3		rc2_c48;
		string3		rc3_c48;
		string3		rc4_c48;
		string3		rc5_c48;
		string3		rc1_1;
		string3		rc2_1;
		string3		rc3_1;
		string3		rc4_1;
		string3		rc5_1;

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
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	add_input_lres                   := le.lres;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_prison_history             := le.other_address_info.isprison;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

rv_l70_add_standardized := map(
    not(addrpop)                                         => '                           ',
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => '2 Standardization Error    ',
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '1 Address was Standardized ',
                                                            '0 Address is Standard      ');

rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), ' ', (string1)(integer)rc_input_addr_not_most_recent);

rv_c19_add_prison_hist := if(not(truedid), ' ', (string1)(integer)addrs_prison_history);

rv_d32_criminal_x_felony := if(not(truedid), ' ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

rv_d33_eviction_recency := map(
    not(truedid)                                           => '  ',
    attr_eviction_count90 > 0                              => '03',
    attr_eviction_count180 > 0                             => '06',
    attr_eviction_count12 > 0                              => '12',
    attr_eviction_count24 > 0 and attr_eviction_count >= 2 => '24',
    attr_eviction_count24 > 0                              => '25',
    attr_eviction_count36 > 0 and attr_eviction_count >= 2 => '36',
    attr_eviction_count36 > 0                              => '37',
    attr_eviction_count60 > 0 and attr_eviction_count >= 2 => '60',
    attr_eviction_count60 > 0                              => '61',
    attr_eviction_count >= 2                               => '98',
    attr_eviction_count >= 1                               => '99',
                                                              '00');

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

rv_c20_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);

rv_c13_max_lres := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

rv_ever_asset_owner := map(
    not(truedid)                                                                                                                                                                                                 => ' ',
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => '1',
                                                                                                                                                                                                                    '0');

rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

rv_i60_inq_banking_count12 := if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999));

rv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

rv_i62_inq_dobs_per_adl := if(not(truedid), NULL, min(if(inq_dobsperadl = NULL, -NULL, inq_dobsperadl), 999));

s0_subscore0 := map(
    (rv_d33_eviction_recency in [' '])                    => 0,
    (rv_d33_eviction_recency in ['00'])                   => 0.079892,
    (rv_d33_eviction_recency in ['03', '06'])             => -0.959512,
    (rv_d33_eviction_recency in ['12', '24'])             => -0.722177,
    (rv_d33_eviction_recency in ['25', '36', '37'])       => -0.60909,
    (rv_d33_eviction_recency in ['60', '61', '98', '99']) => 0.013542,
                                                             0);

s0_subscore1 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.201654,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.077881,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.373925,
    3 <= rv_i62_inq_phones_per_adl                                     => -0.573451,
                                                                          0);

s0_subscore2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 1  => -0.300875,
    1 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7    => -0.052179,
    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 19   => 0.024929,
    19 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 49  => 0.146004,
    49 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 136 => 0.16255,
    136 <= rv_c13_inp_addr_lres                               => 0.319819,
                                                                 0);

s0_subscore3 := map(
    (rv_d32_criminal_x_felony in [' '])                                      => 0,
    (rv_d32_criminal_x_felony in ['0-0'])                                    => 0.027681,
    (rv_d32_criminal_x_felony in ['1-0'])                                    => -0.058127,
    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => -0.465132,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -1.091369,
                                                                                0);

s0_subscore4 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => -0.031169,
    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81343       => -0.22265,
    81343 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 193631  => -0.035414,
    193631 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 271538 => 0.118036,
    271538 <= rv_a46_curr_avm_autoval                                      => 0.31801,
                                                                              0);

s0_subscore5 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 20 => -0.332213,
    20 <= rv_c13_max_lres AND rv_c13_max_lres < 27  => -0.272524,
    27 <= rv_c13_max_lres AND rv_c13_max_lres < 40  => -0.182505,
    40 <= rv_c13_max_lres AND rv_c13_max_lres < 58  => -0.054932,
    58 <= rv_c13_max_lres AND rv_c13_max_lres < 127 => 0.056555,
    127 <= rv_c13_max_lres                          => 0.119881,
                                                       0);

s0_subscore6 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0   => 0.00915,
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 74    => -0.281499,
    74 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 106  => -0.056809,
    106 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 234 => 0.049628,
    234 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310 => 0.052144,
    310 <= rv_c20_m_bureau_adl_fs                                  => 0.079173,
                                                                      0);

s0_subscore7 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 0.029604,
    1 <= rv_i61_inq_collection_count12                                         => -0.441564,
                                                                                  0);

s0_subscore8 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => 0,
    (rv_f03_input_add_not_most_rec in ['0']) => 0.043435,
    (rv_f03_input_add_not_most_rec in ['1']) => -0.285511,
                                                0);

s0_subscore9 := map(
    NULL < rv_i62_inq_dobs_per_adl AND rv_i62_inq_dobs_per_adl < 2 => 0.019926,
    2 <= rv_i62_inq_dobs_per_adl                                   => -0.560398,
                                                                      0);

s0_subscore10 := map(
    (rv_c19_add_prison_hist in [' ']) => 0,
    (rv_c19_add_prison_hist in ['0']) => 0.00748,
    (rv_c19_add_prison_hist in ['1']) => -1.207923,
                                         0);

s0_subscore11 := map(
    (rv_ever_asset_owner in [' ']) => 0,
    (rv_ever_asset_owner in ['0']) => -0.062393,
    (rv_ever_asset_owner in ['1']) => 0.128213,
                                      0);

s0_subscore12 := map(
    (rv_l70_add_standardized in [' '])                          => 0,
    (rv_l70_add_standardized in ['0 Address is Standard'])      => 0.0408,
    (rv_l70_add_standardized in ['1 Address was Standardized']) => -0.14097,
    (rv_l70_add_standardized in ['2 Standardization Error'])    => -0.191675,
                                                                   0);

s0_subscore13 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 1 => 0.015826,
    1 <= rv_i60_inq_banking_count12                                      => -0.345036,
                                                                            0);

s0_rawscore := s0_subscore0 +
    s0_subscore1 +
    s0_subscore2 +
    s0_subscore3 +
    s0_subscore4 +
    s0_subscore5 +
    s0_subscore6 +
    s0_subscore7 +
    s0_subscore8 +
    s0_subscore9 +
    s0_subscore10 +
    s0_subscore11 +
    s0_subscore12 +
    s0_subscore13;

s0_lnoddsscore := s0_rawscore + 2.245860;

s0_probscore := exp(s0_lnoddsscore) / (1 + exp(s0_lnoddsscore));

s0_aacd_0 := map(
    (rv_d33_eviction_recency in [' '])                    => '',
    (rv_d33_eviction_recency in ['00'])                   => 'D33',
    (rv_d33_eviction_recency in ['03', '06'])             => 'D33',
    (rv_d33_eviction_recency in ['12', '24'])             => 'D33',
    (rv_d33_eviction_recency in ['25', '36', '37'])       => 'D33',
    (rv_d33_eviction_recency in ['60', '61', '98', '99']) => 'D33',
                                                             '');

s0_dist_0 := s0_subscore0 - 0.079892;

s0_aacd_1 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

s0_dist_1 := s0_subscore1 - 0.201654;

s0_aacd_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 1  => 'C13',
    1 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7    => 'C13',
    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 19   => 'C13',
    19 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 49  => 'C13',
    49 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 136 => 'C13',
    136 <= rv_c13_inp_addr_lres                               => 'C13',
                                                                 '');

s0_dist_2 := s0_subscore2 - 0.319819;

s0_aacd_3 := map(
    (rv_d32_criminal_x_felony in [' '])                                      => '',
    (rv_d32_criminal_x_felony in ['0-0'])                                    => 'D32',
    (rv_d32_criminal_x_felony in ['1-0'])                                    => 'D32',
    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => 'D32',
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
                                                                                '');

s0_dist_3 := s0_subscore3 - 0.027681;

s0_aacd_4 := map(
    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1         => 'A46',
    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81343       => 'A46',
    81343 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 193631  => 'A46',
    193631 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 271538 => 'A46',
    271538 <= rv_a46_curr_avm_autoval                                      => 'A46',
                                                                              '');

s0_dist_4 := s0_subscore4 - 0.31801;

s0_aacd_5 := map(
    NULL < rv_c13_max_lres AND rv_c13_max_lres < 20 => 'C13',
    20 <= rv_c13_max_lres AND rv_c13_max_lres < 27  => 'C13',
    27 <= rv_c13_max_lres AND rv_c13_max_lres < 40  => 'C13',
    40 <= rv_c13_max_lres AND rv_c13_max_lres < 58  => 'C13',
    58 <= rv_c13_max_lres AND rv_c13_max_lres < 127 => 'C13',
    127 <= rv_c13_max_lres                          => 'C13',
                                                       '');

s0_dist_5 := s0_subscore5 - 0.119881;

s0_aacd_6 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0   => 'C12',
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 74    => 'C20',
    74 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 106  => 'C20',
    106 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 234 => 'C20',
    234 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 310 => 'C20',
    310 <= rv_c20_m_bureau_adl_fs                                  => 'C20',
                                                                      'C12');

s0_dist_6 := s0_subscore6 - 0.079173;

s0_aacd_7 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 'I61',
    1 <= rv_i61_inq_collection_count12                                         => 'I61',
                                                                                  '');

s0_dist_7 := s0_subscore7 - 0.029604;

s0_aacd_8 := map(
    (rv_f03_input_add_not_most_rec in [' ']) => '',
    (rv_f03_input_add_not_most_rec in ['0']) => 'F03',
    (rv_f03_input_add_not_most_rec in ['1']) => 'F03',
                                                '');

s0_dist_8 := s0_subscore8 - 0.043435;

s0_aacd_9 := map(
    NULL < rv_i62_inq_dobs_per_adl AND rv_i62_inq_dobs_per_adl < 2 => 'I62',
    2 <= rv_i62_inq_dobs_per_adl                                   => 'I62',
                                                                      '');

s0_dist_9 := s0_subscore9 - 0.019926;

s0_aacd_10 := map(
    (rv_c19_add_prison_hist in [' ']) => '',
    (rv_c19_add_prison_hist in ['0']) => 'C19',
    (rv_c19_add_prison_hist in ['1']) => 'C19',
                                         '');

s0_dist_10 := s0_subscore10 - 0.00748;

s0_aacd_11 := map(
    (rv_ever_asset_owner in [' ']) => '',
    (rv_ever_asset_owner in ['0']) => 'A40',
    (rv_ever_asset_owner in ['1']) => 'A40',
                                      '');

s0_dist_11 := s0_subscore11 - 0.128213;

s0_aacd_12 := map(
    (rv_l70_add_standardized in [' '])                          => 'L70',
    (rv_l70_add_standardized in ['0 Address is Standard'])      => 'L70',
    (rv_l70_add_standardized in ['1 Address was Standardized']) => 'L70',
    (rv_l70_add_standardized in ['2 Standardization Error'])    => 'L70',
                                                                   '');

s0_dist_12 := s0_subscore12 - 0.0408;

s0_aacd_13 := map(
    NULL < rv_i60_inq_banking_count12 AND rv_i60_inq_banking_count12 < 1 => 'I60',
    1 <= rv_i60_inq_banking_count12                                      => 'I60',
                                                                            '');

s0_dist_13 := s0_subscore13 - 0.015826;

s0_rcvaluea40 := (integer)(s0_aacd_0 = 'A40') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'A40') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'A40') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'A40') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'A40') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'A40') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'A40') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'A40') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'A40') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'A40') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'A40') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'A40') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'A40') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'A40') * s0_dist_13;

s0_rcvaluec20 := (integer)(s0_aacd_0 = 'C20') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'C20') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'C20') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'C20') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'C20') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'C20') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'C20') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'C20') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'C20') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'C20') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'C20') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'C20') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'C20') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'C20') * s0_dist_13;

s0_rcvaluef03 := (integer)(s0_aacd_0 = 'F03') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'F03') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'F03') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'F03') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'F03') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'F03') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'F03') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'F03') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'F03') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'F03') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'F03') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'F03') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'F03') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'F03') * s0_dist_13;

s0_rcvaluel70 := (integer)(s0_aacd_0 = 'L70') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'L70') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'L70') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'L70') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'L70') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'L70') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'L70') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'L70') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'L70') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'L70') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'L70') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'L70') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'L70') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'L70') * s0_dist_13;

s0_rcvalued32 := (integer)(s0_aacd_0 = 'D32') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'D32') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'D32') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'D32') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'D32') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'D32') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'D32') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'D32') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'D32') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'D32') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'D32') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'D32') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'D32') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'D32') * s0_dist_13;

s0_rcvalued33 := (integer)(s0_aacd_0 = 'D33') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'D33') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'D33') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'D33') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'D33') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'D33') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'D33') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'D33') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'D33') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'D33') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'D33') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'D33') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'D33') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'D33') * s0_dist_13;

s0_rcvaluea46 := (integer)(s0_aacd_0 = 'A46') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'A46') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'A46') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'A46') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'A46') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'A46') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'A46') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'A46') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'A46') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'A46') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'A46') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'A46') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'A46') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'A46') * s0_dist_13;

s0_rcvaluec19 := (integer)(s0_aacd_0 = 'C19') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'C19') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'C19') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'C19') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'C19') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'C19') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'C19') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'C19') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'C19') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'C19') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'C19') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'C19') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'C19') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'C19') * s0_dist_13;

s0_rcvaluei60 := (integer)(s0_aacd_0 = 'I60') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'I60') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'I60') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'I60') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'I60') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'I60') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'I60') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'I60') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'I60') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'I60') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'I60') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'I60') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'I60') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'I60') * s0_dist_13;

s0_rcvaluei61 := (integer)(s0_aacd_0 = 'I61') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'I61') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'I61') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'I61') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'I61') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'I61') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'I61') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'I61') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'I61') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'I61') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'I61') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'I61') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'I61') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'I61') * s0_dist_13;

s0_rcvaluei62 := (integer)(s0_aacd_0 = 'I62') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'I62') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'I62') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'I62') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'I62') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'I62') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'I62') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'I62') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'I62') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'I62') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'I62') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'I62') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'I62') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'I62') * s0_dist_13;

s0_rcvaluec13 := (integer)(s0_aacd_0 = 'C13') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'C13') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'C13') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'C13') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'C13') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'C13') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'C13') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'C13') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'C13') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'C13') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'C13') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'C13') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'C13') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'C13') * s0_dist_13;

s0_rcvaluec12 := (integer)(s0_aacd_0 = 'C12') * s0_dist_0 +
    (integer)(s0_aacd_1 = 'C12') * s0_dist_1 +
    (integer)(s0_aacd_2 = 'C12') * s0_dist_2 +
    (integer)(s0_aacd_3 = 'C12') * s0_dist_3 +
    (integer)(s0_aacd_4 = 'C12') * s0_dist_4 +
    (integer)(s0_aacd_5 = 'C12') * s0_dist_5 +
    (integer)(s0_aacd_6 = 'C12') * s0_dist_6 +
    (integer)(s0_aacd_7 = 'C12') * s0_dist_7 +
    (integer)(s0_aacd_8 = 'C12') * s0_dist_8 +
    (integer)(s0_aacd_9 = 'C12') * s0_dist_9 +
    (integer)(s0_aacd_10 = 'C12') * s0_dist_10 +
    (integer)(s0_aacd_11 = 'C12') * s0_dist_11 +
    (integer)(s0_aacd_12 = 'C12') * s0_dist_12 +
    (integer)(s0_aacd_13 = 'C12') * s0_dist_13;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

base := 700;

pts := 40;

odds := (1 - .0789) / .0789;

rva1607_1_0 := map(
    // iv_rv5_deceased > 0     => 200,
    iv_rv5_deceased = true  => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(pts * (ln(s0_probscore / (1 - s0_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(s0_probscore / (1 - s0_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_s0 := DATASET([
    {'A40', s0_rcvalueA40},
    {'C20', s0_rcvalueC20},
    {'F03', s0_rcvalueF03},
    {'L70', s0_rcvalueL70},
    {'D32', s0_rcvalueD32},
    {'D33', s0_rcvalueD33},
    {'A46', s0_rcvalueA46},
    {'C19', s0_rcvalueC19},
    {'I60', s0_rcvalueI60},
    {'I61', s0_rcvalueI61},
    {'I62', s0_rcvalueI62},
    {'C13', s0_rcvalueC13},
    {'C12', s0_rcvalueC12}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_s0_sorted := sort(rc_dataset_s0, rc_dataset_s0.value);

s0_rc1 := rc_dataset_s0_sorted[1].rc;
s0_rc2 := rc_dataset_s0_sorted[2].rc;
s0_rc3 := rc_dataset_s0_sorted[3].rc;
s0_rc4 := rc_dataset_s0_sorted[4].rc;

s0_vl1 := rc_dataset_s0_sorted[1].value;
s0_vl2 := rc_dataset_s0_sorted[2].value;
s0_vl3 := rc_dataset_s0_sorted[3].value;
s0_vl4 := rc_dataset_s0_sorted[4].value;
//*************************************************************************************//


rc1_2 := s0_rc1;

rc2_2 := s0_rc2;

rc3_2 := s0_rc3;

rc4_2 := s0_rc4;

_rc_inq := map(
    rv_i62_inq_phones_per_adl > 0     => 'I62',
    rv_i61_inq_collection_count12 > 0 => 'I61',
    rv_i62_inq_dobs_per_adl > 0       => 'I62',
    rv_i60_inq_banking_count12 > 0    => 'I60',
                                         '');

rc5_c48 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);

rc2_c48 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc1_c48 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc3_c48 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc4_c48 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     '');

rc5_1 := if(rc5_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c48, '');

rc2_1 := if(rc2_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c48, rc2_2);

rc3_1 := if(rc3_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c48, rc3_2);

rc1_1 := if(rc1_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c48, rc1_2);

rc4_1 := if(rc4_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c48, rc4_2);

rc4 := if((rva1607_1_0 in [200, 222]), '', rc4_1);

rc1 := if((rva1607_1_0 in [200, 222]), '', rc1_1);

rc3 := if((rva1607_1_0 in [200, 222]), '', rc3_1);

rc2 := if((rva1607_1_0 in [200, 222]), '', rc2_1);

rc5 := if((rva1607_1_0 in [200, 222]), '', rc5_1);

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1607_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1607_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1607_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		/* Model Input Variables */
		SELF.seq 															:= le.seq;
		self.sysdate                          := sysdate;
		self.add_ec1                          := add_ec1;
		self.add_ec3                          := add_ec3;
		self.add_ec4                          := add_ec4;
		self.rv_l70_add_standardized          := rv_l70_add_standardized;
		self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
		self.rv_c19_add_prison_hist           := rv_c19_add_prison_hist;
		self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
		self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
		self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
		self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
		self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
		self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
		self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
		self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
		self.rv_c13_max_lres                  := rv_c13_max_lres;
		self.rv_ever_asset_owner              := rv_ever_asset_owner;
		self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
		self.rv_i60_inq_banking_count12       := rv_i60_inq_banking_count12;
		self.rv_c13_inp_addr_lres             := rv_c13_inp_addr_lres;
		self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
		self.rv_i62_inq_dobs_per_adl          := rv_i62_inq_dobs_per_adl;
		self.s0_subscore0                     := s0_subscore0;
		self.s0_subscore1                     := s0_subscore1;
		self.s0_subscore2                     := s0_subscore2;
		self.s0_subscore3                     := s0_subscore3;
		self.s0_subscore4                     := s0_subscore4;
		self.s0_subscore5                     := s0_subscore5;
		self.s0_subscore6                     := s0_subscore6;
		self.s0_subscore7                     := s0_subscore7;
		self.s0_subscore8                     := s0_subscore8;
		self.s0_subscore9                     := s0_subscore9;
		self.s0_subscore10                    := s0_subscore10;
		self.s0_subscore11                    := s0_subscore11;
		self.s0_subscore12                    := s0_subscore12;
		self.s0_subscore13                    := s0_subscore13;
		self.s0_rawscore                      := s0_rawscore;
		self.s0_lnoddsscore                   := s0_lnoddsscore;
		self.s0_probscore                     := s0_probscore;
		self.s0_aacd_0                        := s0_aacd_0;
		self.s0_dist_0                        := s0_dist_0;
		self.s0_aacd_1                        := s0_aacd_1;
		self.s0_dist_1                        := s0_dist_1;
		self.s0_aacd_2                        := s0_aacd_2;
		self.s0_dist_2                        := s0_dist_2;
		self.s0_aacd_3                        := s0_aacd_3;
		self.s0_dist_3                        := s0_dist_3;
		self.s0_aacd_4                        := s0_aacd_4;
		self.s0_dist_4                        := s0_dist_4;
		self.s0_aacd_5                        := s0_aacd_5;
		self.s0_dist_5                        := s0_dist_5;
		self.s0_aacd_6                        := s0_aacd_6;
		self.s0_dist_6                        := s0_dist_6;
		self.s0_aacd_7                        := s0_aacd_7;
		self.s0_dist_7                        := s0_dist_7;
		self.s0_aacd_8                        := s0_aacd_8;
		self.s0_dist_8                        := s0_dist_8;
		self.s0_aacd_9                        := s0_aacd_9;
		self.s0_dist_9                        := s0_dist_9;
		self.s0_aacd_10                       := s0_aacd_10;
		self.s0_dist_10                       := s0_dist_10;
		self.s0_aacd_11                       := s0_aacd_11;
		self.s0_dist_11                       := s0_dist_11;
		self.s0_aacd_12                       := s0_aacd_12;
		self.s0_dist_12                       := s0_dist_12;
		self.s0_aacd_13                       := s0_aacd_13;
		self.s0_dist_13                       := s0_dist_13;
		self.s0_rcvaluea40                    := s0_rcvaluea40;
		self.s0_rcvaluec20                    := s0_rcvaluec20;
		self.s0_rcvaluef03                    := s0_rcvaluef03;
		self.s0_rcvaluel70                    := s0_rcvaluel70;
		self.s0_rcvalued32                    := s0_rcvalued32;
		self.s0_rcvalued33                    := s0_rcvalued33;
		self.s0_rcvaluea46                    := s0_rcvaluea46;
		self.s0_rcvaluec19                    := s0_rcvaluec19;
		self.s0_rcvaluei60                    := s0_rcvaluei60;
		self.s0_rcvaluei61                    := s0_rcvaluei61;
		self.s0_rcvaluei62                    := s0_rcvaluei62;
		self.s0_rcvaluec13                    := s0_rcvaluec13;
		self.s0_rcvaluec12                    := s0_rcvaluec12;
		self.iv_rv5_deceased                  := iv_rv5_deceased;
		self.iv_rv5_unscorable                := iv_rv5_unscorable;
		self.base                             := base;
		self.pts                              := pts;
		self.odds                             := odds;
		self.rva1607_1_0                      := rva1607_1_0;
		self._rc_inq                          := _rc_inq;
		self.rc5                              := rc5;
		self.rc2                              := rc2;
		self.rc1                              := rc1;
		self.rc3                              := rc3;
		self.rc4                              := rc4;
		self.s0_rc1 			:= s0_rc1;
		self.s0_rc2 			:= s0_rc2;
		self.s0_rc3 			:= s0_rc3;
		self.s0_rc4 			:= s0_rc4;
		self.rc1_2 				:= rc1_2;
		self.rc2_2 				:= rc2_2;
		self.rc3_2 				:= rc3_2;
		self.rc4_2 				:= rc4_2;
		self.rc1_c48			:= rc1_c48;
		self.rc2_c48			:= rc2_c48;
		self.rc3_c48			:= rc3_c48;
		self.rc4_c48			:= rc4_c48;
		self.rc5_c48			:= rc5_c48;
		self.rc1_1				:= rc1_1;
		self.rc2_1				:= rc2_1;
		self.rc3_1				:= rc3_1;
		self.rc4_1				:= rc4_1;
		self.rc5_1				:= rc5_1;
		self.clam 														:= le;
	#else
		self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.score 	:= (STRING3)rva1607_1_0;
		self.seq 		:= le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

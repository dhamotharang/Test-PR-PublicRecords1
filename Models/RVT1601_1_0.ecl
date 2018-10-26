/* !! Second Build !! */
IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, STD, riskview;


EXPORT RVT1601_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
INTEGER seq;
STRING sysdate; STRING iv_add_apt; STRING rv_D32_Mos_Since_Crim_LS; STRING rv_C12_NonDerog_Recency; 
STRING rv_S66_adlperssn_count; STRING rv_F01_inp_addr_not_verified; STRING rv_A44_curr_add_naprop; 
STRING rv_L80_Inp_AVM_AutoVal; STRING rv_C14_addrs_15yr; STRING rv_A41_A42_Prop_Owner_History; 
STRING rv_E55_College_Ind; STRING rv_E57_prof_license_br_flag; STRING rv_I60_inq_hiRiskCred_count12; 
STRING rv_L79_adls_per_apt_addr; STRING rv_L79_adls_per_sfd_addr; STRING rv_I62_inq_phones_per_adl; 
STRING m_subScore0; STRING m_subScore1; STRING m_subScore2; STRING m_subScore3; STRING m_subScore4; 
STRING m_subScore5; STRING m_subScore6; STRING m_subScore7; STRING m_subScore8; STRING m_subScore9; 
STRING m_subScore10; STRING m_subScore11; STRING m_subScore12; STRING m_subScore13; STRING m_scaledScore; 
STRING m_rawScore; STRING m_lnOddsScore; STRING m_probScore; STRING m_AACD_0; STRING m_DIST_0; 
STRING m_AACD_1; STRING m_DIST_1; STRING m_AACD_2; STRING m_DIST_2; STRING m_AACD_3; STRING m_DIST_3; 
STRING m_AACD_4; STRING m_DIST_4; STRING m_AACD_5; STRING m_DIST_5; STRING m_AACD_6; STRING m_DIST_6; 
STRING m_AACD_7; STRING m_DIST_7; STRING m_AACD_8; STRING m_DIST_8; STRING m_AACD_9; STRING m_DIST_9; 
STRING m_AACD_10; STRING m_DIST_10; STRING m_AACD_11; STRING m_DIST_11; STRING m_AACD_12; STRING m_DIST_12; 
STRING m_AACD_13; STRING m_DIST_13; 
STRING i; STRING _rc; STRING rc; STRING tmp_dist; STRING _dst; 
STRING m_RC1; STRING m_RC2; STRING m_RC3; STRING m_RC4; STRING m_RC5; STRING m_RC6; STRING m_RC7; 
STRING m_RC8; STRING m_RC9; STRING m_RC10; STRING m_RC11; STRING m_RC12; STRING m_RC13; 
STRING m_VL1; STRING m_VL2; STRING m_VL3; STRING m_VL4; STRING m_VL5; STRING m_VL6; STRING m_VL7; 
STRING m_VL8; STRING m_VL9; STRING m_VL10; STRING m_VL11; STRING m_VL12; STRING m_VL13; 
STRING _NUM_RCS; STRING iv_rv5_deceased; STRING iv_rv5_unscorable; STRING ov_rc19; 
STRING _201; STRING _203; STRING _210; STRING base; STRING pts; STRING odds; 
STRING RVT1601_1_2; STRING rc1; STRING rc2; STRING rc3; STRING rc4; STRING rc5; STRING _rc_inq;

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
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_hrisksic                      := le.iid.hrisksic;
	combo_lnamecount                 := le.iid.combo_lastcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_hphonecount                := le.iid.combo_hphonecount;
	combo_ssncount                   := le.iid.combo_ssncount;
	ver_sources                      := le.header_summary.ver_sources;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
	attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
	attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
	attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
	attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
	criminal_last_date               := le.bjl.last_criminal_date;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
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

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d32_mos_since_crim_ls := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

rv_c12_nonderog_recency := map(
    not(truedid)                => NULL,
    attr_num_nonderogs90 > 0    => 3,
    attr_num_nonderogs180 > 0   => 6,
    attr_num_nonderogs12 > 0    => 12,
    attr_num_nonderogs24 > 0    => 24,
    attr_num_nonderogs36 > 0    => 36,
    attr_num_nonderogs60 > 0    => 60,
    attr_num_nonderogs >= 1     => 99,
                               0);

rv_s66_adlperssn_count := map(
    not((integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_f01_inp_addr_not_verified := if(not(add_input_pop and truedid), NULL, (integer)add_input_addr_not_verified);

rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_e55_college_ind := map(
    not(truedid)                           => ' ',
    (college_file_type in ['H', 'C', 'A']) => '1',
    college_attendance                     => '1',
                                              '0');

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

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_l79_adls_per_apt_addr := map(
    not(addrpop)     => NULL,
    iv_add_apt = '0' => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

m_subscore0 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.098523,
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.543941,
    2 <= rv_i62_inq_phones_per_adl                                     => -1.055537,
                                                                          0);

m_subscore1 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => -0.057623,
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 23217       => -0.845436,
    23217 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 68618   => -0.30959,
    68618 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 176027  => -0.028836,
    176027 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 355200 => 0.29369,
    355200 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 729253 => 0.592887,
    729253 <= rv_l80_inp_avm_autoval                                     => 1.086026,
                                                                            0);

m_subscore2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.09642,
    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.188562,
    3 <= rv_s66_adlperssn_count                                  => -0.330384,
                                                                    0);

m_subscore3 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 0.019188,
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 16  => -1.090053,
    16 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 39 => -0.945793,
    39 <= rv_d32_mos_since_crim_ls                                   => -0.349659,
                                                                        0);

m_subscore4 := map(
    (rv_a44_curr_add_naprop in [NULL])   => 0,
    (rv_a44_curr_add_naprop in [0])      => -0.128087,
    (rv_a44_curr_add_naprop in [1])      => -0.005631,
    (rv_a44_curr_add_naprop in [2, 3])   => 0.236783,
    (rv_a44_curr_add_naprop in [4])      => 0.238211,
                                        0);

m_subscore5 := map(
    (rv_e55_college_ind in [' ']) => 0,
    (rv_e55_college_ind in ['0']) => -0.02774,
    (rv_e55_college_ind in ['1']) => 0.602939,
                                     0);

m_subscore6 := map(
    (rv_f01_inp_addr_not_verified in [NULL]) => 0,
    (rv_f01_inp_addr_not_verified in [0]) => 0.067886,
    (rv_f01_inp_addr_not_verified in [1]) => -0.222736,
                                               0);

m_subscore7 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0 => -0.057138,
    0 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 1   => 0.334803,
    1 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 2   => 0.167676,
    2 <= rv_l79_adls_per_apt_addr                                    => 0.035252,
                                                                        0);

m_subscore8 := map(
    (rv_a41_a42_prop_owner_history in [' '])                     => 0,
    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 0.489725,
    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => -0.029068,
                                                                    0);

m_subscore9 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 0 => 0.036944,
    0 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1   => 0.133668,
    1 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4   => 0.033666,
    4 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5   => -0.107659,
    5 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6   => -0.190143,
    6 <= rv_l79_adls_per_sfd_addr                                    => -0.33363,
                                                                        0);

m_subscore10 := map(
    (rv_e57_prof_license_br_flag in [NULL]) => 0,
    (rv_e57_prof_license_br_flag in [0]) => -0.016107,
    (rv_e57_prof_license_br_flag in [1]) => 0.810308,
                                              0);

m_subscore11 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.012954,
    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.867802,
                                                                                  0);

m_subscore12 := map(
    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => -0.036066,
    6 <= rv_c12_nonderog_recency                                   => 0.198522,
                                                                      0);

m_subscore13 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => -0.027543,
    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => 0.052038,
    2 <= rv_c14_addrs_15yr                             => -0.144256,
                                                          0);

m_rawscore := m_subscore0 +
    m_subscore1 +
    m_subscore2 +
    m_subscore3 +
    m_subscore4 +
    m_subscore5 +
    m_subscore6 +
    m_subscore7 +
    m_subscore8 +
    m_subscore9 +
    m_subscore10 +
    m_subscore11 +
    m_subscore12 +
    m_subscore13;

m_lnoddsscore := m_rawscore + 0.857391;

m_probscore := exp(m_lnoddsscore) / (1 + exp(m_lnoddsscore));

m_aacd_0 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          '');

m_dist_0 := m_subscore0 - 0.098523;

m_aacd_1 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => 'L80',
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 23217       => 'L80',
    23217 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 68618   => 'L80',
    68618 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 176027  => 'L80',
    176027 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 355200 => 'L80',
    355200 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 729253 => 'L80',
    729253 <= rv_l80_inp_avm_autoval                                     => 'L80',
                                                                            '');

m_dist_1 := m_subscore1 - 1.086026;

m_aacd_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
    3 <= rv_s66_adlperssn_count                                  => 'S66',
                                                                    '');

m_dist_2 := m_subscore2 - 0.09642;

m_aacd_3 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D32',
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 16  => 'D32',
    16 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 39 => 'D32',
    39 <= rv_d32_mos_since_crim_ls                                   => 'D32',
                                                                        '');

m_dist_3 := m_subscore3 - 0.019188;

m_aacd_4 := map(
    (rv_a44_curr_add_naprop in [NULL])   => '',
    (rv_a44_curr_add_naprop in [0])      => 'A44',
    (rv_a44_curr_add_naprop in [1])      => 'A44',
    (rv_a44_curr_add_naprop in [2, 3])   => 'A44',
    (rv_a44_curr_add_naprop in [4])      => 'A44',
                                            '');

m_dist_4 := m_subscore4 - 0.238211;

m_aacd_5 := map(
    (rv_e55_college_ind in [' ']) => 'C12',
    (rv_e55_college_ind in ['0']) => 'E55',
    (rv_e55_college_ind in ['1']) => 'E55',
                                     '');

m_dist_5 := m_subscore5 - 0.602939;

m_aacd_6 := map(
    (rv_f01_inp_addr_not_verified in [NULL]) => '',
    (rv_f01_inp_addr_not_verified in [0])    => 'F01',
    (rv_f01_inp_addr_not_verified in [1])    => 'F01',
                                                '');

m_dist_6 := m_subscore6 - 0.067886;

m_aacd_7 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0 => '',
    0 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 1   => 'L79',
    1 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 2   => 'L79',
    2 <= rv_l79_adls_per_apt_addr                                    => 'L79',
                                                                        '');

m_dist_7 := m_subscore7 - 0.334803;

m_aacd_8 := map(
    (rv_a41_a42_prop_owner_history in [' '])                     => 'C12',
    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 'A44',
    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => 'A44',
                                                                    '');

m_dist_8 := m_subscore8 - 0.489725;

m_aacd_9 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 0 => '',
    0 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1   => 'L79',
    1 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4   => 'L79',
    4 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5   => 'L79',
    5 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6   => 'L79',
    6 <= rv_l79_adls_per_sfd_addr                                    => 'L79',
                                                                        '');

m_dist_9 := m_subscore9 - 0.133668;

m_aacd_10 := map(
    (rv_e57_prof_license_br_flag in [NULL]) => 'C12',
    (rv_e57_prof_license_br_flag in [0])    => 'E57',
    (rv_e57_prof_license_br_flag in [1])    => 'E57',
                                               '');

m_dist_10 := m_subscore10 - 0.810308;

m_aacd_11 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

m_dist_11 := m_subscore11 - 0.012954;

m_aacd_12 := map(
    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => 'C12',
    6 <= rv_c12_nonderog_recency                                   => 'C12',
                                                                      '');

m_dist_12 := m_subscore12 - 0.198522;

m_aacd_13 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => '',
    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => 'C14',
    2 <= rv_c14_addrs_15yr                             => 'C14',
                                                          '');

m_dist_13 := m_subscore13 - 0.052038;

m_rcvaluel79 := (integer)(m_aacd_0 = 'L79') * m_dist_0 +
    (integer)(m_aacd_1 = 'L79') * m_dist_1 +
    (integer)(m_aacd_2 = 'L79') * m_dist_2 +
    (integer)(m_aacd_3 = 'L79') * m_dist_3 +
    (integer)(m_aacd_4 = 'L79') * m_dist_4 +
    (integer)(m_aacd_5 = 'L79') * m_dist_5 +
    (integer)(m_aacd_6 = 'L79') * m_dist_6 +
    (integer)(m_aacd_7 = 'L79') * m_dist_7 +
    (integer)(m_aacd_8 = 'L79') * m_dist_8 +
    (integer)(m_aacd_9 = 'L79') * m_dist_9 +
    (integer)(m_aacd_10 = 'L79') * m_dist_10 +
    (integer)(m_aacd_11 = 'L79') * m_dist_11 +
    (integer)(m_aacd_12 = 'L79') * m_dist_12 +
    (integer)(m_aacd_13 = 'L79') * m_dist_13;

m_rcvaluel80 := (integer)(m_aacd_0 = 'L80') * m_dist_0 +
    (integer)(m_aacd_1 = 'L80') * m_dist_1 +
    (integer)(m_aacd_2 = 'L80') * m_dist_2 +
    (integer)(m_aacd_3 = 'L80') * m_dist_3 +
    (integer)(m_aacd_4 = 'L80') * m_dist_4 +
    (integer)(m_aacd_5 = 'L80') * m_dist_5 +
    (integer)(m_aacd_6 = 'L80') * m_dist_6 +
    (integer)(m_aacd_7 = 'L80') * m_dist_7 +
    (integer)(m_aacd_8 = 'L80') * m_dist_8 +
    (integer)(m_aacd_9 = 'L80') * m_dist_9 +
    (integer)(m_aacd_10 = 'L80') * m_dist_10 +
    (integer)(m_aacd_11 = 'L80') * m_dist_11 +
    (integer)(m_aacd_12 = 'L80') * m_dist_12 +
    (integer)(m_aacd_13 = 'L80') * m_dist_13;

m_rcvaluei60 := (integer)(m_aacd_0 = 'I60') * m_dist_0 +
    (integer)(m_aacd_1 = 'I60') * m_dist_1 +
    (integer)(m_aacd_2 = 'I60') * m_dist_2 +
    (integer)(m_aacd_3 = 'I60') * m_dist_3 +
    (integer)(m_aacd_4 = 'I60') * m_dist_4 +
    (integer)(m_aacd_5 = 'I60') * m_dist_5 +
    (integer)(m_aacd_6 = 'I60') * m_dist_6 +
    (integer)(m_aacd_7 = 'I60') * m_dist_7 +
    (integer)(m_aacd_8 = 'I60') * m_dist_8 +
    (integer)(m_aacd_9 = 'I60') * m_dist_9 +
    (integer)(m_aacd_10 = 'I60') * m_dist_10 +
    (integer)(m_aacd_11 = 'I60') * m_dist_11 +
    (integer)(m_aacd_12 = 'I60') * m_dist_12 +
    (integer)(m_aacd_13 = 'I60') * m_dist_13;

m_rcvalued32 := (integer)(m_aacd_0 = 'D32') * m_dist_0 +
    (integer)(m_aacd_1 = 'D32') * m_dist_1 +
    (integer)(m_aacd_2 = 'D32') * m_dist_2 +
    (integer)(m_aacd_3 = 'D32') * m_dist_3 +
    (integer)(m_aacd_4 = 'D32') * m_dist_4 +
    (integer)(m_aacd_5 = 'D32') * m_dist_5 +
    (integer)(m_aacd_6 = 'D32') * m_dist_6 +
    (integer)(m_aacd_7 = 'D32') * m_dist_7 +
    (integer)(m_aacd_8 = 'D32') * m_dist_8 +
    (integer)(m_aacd_9 = 'D32') * m_dist_9 +
    (integer)(m_aacd_10 = 'D32') * m_dist_10 +
    (integer)(m_aacd_11 = 'D32') * m_dist_11 +
    (integer)(m_aacd_12 = 'D32') * m_dist_12 +
    (integer)(m_aacd_13 = 'D32') * m_dist_13;

m_rcvaluee55 := (integer)(m_aacd_0 = 'E55') * m_dist_0 +
    (integer)(m_aacd_1 = 'E55') * m_dist_1 +
    (integer)(m_aacd_2 = 'E55') * m_dist_2 +
    (integer)(m_aacd_3 = 'E55') * m_dist_3 +
    (integer)(m_aacd_4 = 'E55') * m_dist_4 +
    (integer)(m_aacd_5 = 'E55') * m_dist_5 +
    (integer)(m_aacd_6 = 'E55') * m_dist_6 +
    (integer)(m_aacd_7 = 'E55') * m_dist_7 +
    (integer)(m_aacd_8 = 'E55') * m_dist_8 +
    (integer)(m_aacd_9 = 'E55') * m_dist_9 +
    (integer)(m_aacd_10 = 'E55') * m_dist_10 +
    (integer)(m_aacd_11 = 'E55') * m_dist_11 +
    (integer)(m_aacd_12 = 'E55') * m_dist_12 +
    (integer)(m_aacd_13 = 'E55') * m_dist_13;

m_rcvaluea44 := (integer)(m_aacd_0 = 'A44') * m_dist_0 +
    (integer)(m_aacd_1 = 'A44') * m_dist_1 +
    (integer)(m_aacd_2 = 'A44') * m_dist_2 +
    (integer)(m_aacd_3 = 'A44') * m_dist_3 +
    (integer)(m_aacd_4 = 'A44') * m_dist_4 +
    (integer)(m_aacd_5 = 'A44') * m_dist_5 +
    (integer)(m_aacd_6 = 'A44') * m_dist_6 +
    (integer)(m_aacd_7 = 'A44') * m_dist_7 +
    (integer)(m_aacd_8 = 'A44') * m_dist_8 +
    (integer)(m_aacd_9 = 'A44') * m_dist_9 +
    (integer)(m_aacd_10 = 'A44') * m_dist_10 +
    (integer)(m_aacd_11 = 'A44') * m_dist_11 +
    (integer)(m_aacd_12 = 'A44') * m_dist_12 +
    (integer)(m_aacd_13 = 'A44') * m_dist_13;

m_rcvaluef01 := (integer)(m_aacd_0 = 'F01') * m_dist_0 +
    (integer)(m_aacd_1 = 'F01') * m_dist_1 +
    (integer)(m_aacd_2 = 'F01') * m_dist_2 +
    (integer)(m_aacd_3 = 'F01') * m_dist_3 +
    (integer)(m_aacd_4 = 'F01') * m_dist_4 +
    (integer)(m_aacd_5 = 'F01') * m_dist_5 +
    (integer)(m_aacd_6 = 'F01') * m_dist_6 +
    (integer)(m_aacd_7 = 'F01') * m_dist_7 +
    (integer)(m_aacd_8 = 'F01') * m_dist_8 +
    (integer)(m_aacd_9 = 'F01') * m_dist_9 +
    (integer)(m_aacd_10 = 'F01') * m_dist_10 +
    (integer)(m_aacd_11 = 'F01') * m_dist_11 +
    (integer)(m_aacd_12 = 'F01') * m_dist_12 +
    (integer)(m_aacd_13 = 'F01') * m_dist_13;

m_rcvaluei62 := (integer)(m_aacd_0 = 'I62') * m_dist_0 +
    (integer)(m_aacd_1 = 'I62') * m_dist_1 +
    (integer)(m_aacd_2 = 'I62') * m_dist_2 +
    (integer)(m_aacd_3 = 'I62') * m_dist_3 +
    (integer)(m_aacd_4 = 'I62') * m_dist_4 +
    (integer)(m_aacd_5 = 'I62') * m_dist_5 +
    (integer)(m_aacd_6 = 'I62') * m_dist_6 +
    (integer)(m_aacd_7 = 'I62') * m_dist_7 +
    (integer)(m_aacd_8 = 'I62') * m_dist_8 +
    (integer)(m_aacd_9 = 'I62') * m_dist_9 +
    (integer)(m_aacd_10 = 'I62') * m_dist_10 +
    (integer)(m_aacd_11 = 'I62') * m_dist_11 +
    (integer)(m_aacd_12 = 'I62') * m_dist_12 +
    (integer)(m_aacd_13 = 'I62') * m_dist_13;

m_rcvalues66 := (integer)(m_aacd_0 = 'S66') * m_dist_0 +
    (integer)(m_aacd_1 = 'S66') * m_dist_1 +
    (integer)(m_aacd_2 = 'S66') * m_dist_2 +
    (integer)(m_aacd_3 = 'S66') * m_dist_3 +
    (integer)(m_aacd_4 = 'S66') * m_dist_4 +
    (integer)(m_aacd_5 = 'S66') * m_dist_5 +
    (integer)(m_aacd_6 = 'S66') * m_dist_6 +
    (integer)(m_aacd_7 = 'S66') * m_dist_7 +
    (integer)(m_aacd_8 = 'S66') * m_dist_8 +
    (integer)(m_aacd_9 = 'S66') * m_dist_9 +
    (integer)(m_aacd_10 = 'S66') * m_dist_10 +
    (integer)(m_aacd_11 = 'S66') * m_dist_11 +
    (integer)(m_aacd_12 = 'S66') * m_dist_12 +
    (integer)(m_aacd_13 = 'S66') * m_dist_13;

m_rcvaluec12 := (integer)(m_aacd_0 = 'C12') * m_dist_0 +
    (integer)(m_aacd_1 = 'C12') * m_dist_1 +
    (integer)(m_aacd_2 = 'C12') * m_dist_2 +
    (integer)(m_aacd_3 = 'C12') * m_dist_3 +
    (integer)(m_aacd_4 = 'C12') * m_dist_4 +
    (integer)(m_aacd_5 = 'C12') * m_dist_5 +
    (integer)(m_aacd_6 = 'C12') * m_dist_6 +
    (integer)(m_aacd_7 = 'C12') * m_dist_7 +
    (integer)(m_aacd_8 = 'C12') * m_dist_8 +
    (integer)(m_aacd_9 = 'C12') * m_dist_9 +
    (integer)(m_aacd_10 = 'C12') * m_dist_10 +
    (integer)(m_aacd_11 = 'C12') * m_dist_11 +
    (integer)(m_aacd_12 = 'C12') * m_dist_12 +
    (integer)(m_aacd_13 = 'C12') * m_dist_13;

m_rcvaluee57 := (integer)(m_aacd_0 = 'E57') * m_dist_0 +
    (integer)(m_aacd_1 = 'E57') * m_dist_1 +
    (integer)(m_aacd_2 = 'E57') * m_dist_2 +
    (integer)(m_aacd_3 = 'E57') * m_dist_3 +
    (integer)(m_aacd_4 = 'E57') * m_dist_4 +
    (integer)(m_aacd_5 = 'E57') * m_dist_5 +
    (integer)(m_aacd_6 = 'E57') * m_dist_6 +
    (integer)(m_aacd_7 = 'E57') * m_dist_7 +
    (integer)(m_aacd_8 = 'E57') * m_dist_8 +
    (integer)(m_aacd_9 = 'E57') * m_dist_9 +
    (integer)(m_aacd_10 = 'E57') * m_dist_10 +
    (integer)(m_aacd_11 = 'E57') * m_dist_11 +
    (integer)(m_aacd_12 = 'E57') * m_dist_12 +
    (integer)(m_aacd_13 = 'E57') * m_dist_13;

m_rcvaluec14 := (integer)(m_aacd_0 = 'C14') * m_dist_0 +
    (integer)(m_aacd_1 = 'C14') * m_dist_1 +
    (integer)(m_aacd_2 = 'C14') * m_dist_2 +
    (integer)(m_aacd_3 = 'C14') * m_dist_3 +
    (integer)(m_aacd_4 = 'C14') * m_dist_4 +
    (integer)(m_aacd_5 = 'C14') * m_dist_5 +
    (integer)(m_aacd_6 = 'C14') * m_dist_6 +
    (integer)(m_aacd_7 = 'C14') * m_dist_7 +
    (integer)(m_aacd_8 = 'C14') * m_dist_8 +
    (integer)(m_aacd_9 = 'C14') * m_dist_9 +
    (integer)(m_aacd_10 = 'C14') * m_dist_10 +
    (integer)(m_aacd_11 = 'C14') * m_dist_11 +
    (integer)(m_aacd_12 = 'C14') * m_dist_12 +
    (integer)(m_aacd_13 = 'C14') * m_dist_13;

iv_rv5_deceased := rc_decsflag = '1' 
                or rc_ssndod != 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

ov_rc19 := combo_lnamecount = 0 and combo_addrcount = 0 and combo_hphonecount = 0 and combo_ssncount = 0;

_201 := rc_hrisksic = '2225';

_203 := nas_summary <= 4 and nap_summary <= 4 or ov_rc19;

_210 := not(fnamepop) and not(lnamepop) and not(addrpop) and (integer)ssnlength = 0 and not(hphnpop);

base := 700;

pts := 40;

odds := (1 - .2970) / .2970;

rvt1601_1_2 := map(
    iv_rv5_deceased     => 200,
    _201                => 201,
    _210                => 210,
    _203                => 203,
    iv_rv5_unscorable = '1' => 222,
          min(if(max(round(pts * (ln(m_probscore / (1 - m_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, 
					       -NULL, 
								 max(round(pts * (ln(m_probscore / (1 - m_probscore)) - ln(odds)) / ln(2) + base), 501)
								), 900)
								  );


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_m := DATASET([
    {'L79', m_rcvalueL79},
    {'L80', m_rcvalueL80},
    {'I60', m_rcvalueI60},
    {'D32', m_rcvalueD32},
    {'E55', m_rcvalueE55},
    {'A44', m_rcvalueA44},
    {'F01', m_rcvalueF01},
    {'I62', m_rcvalueI62},
    {'S66', m_rcvalueS66},
    {'C12', m_rcvalueC12},
    {'E57', m_rcvalueE57},
    {'C14', m_rcvalueC14}
    ], ds_layout)(value<0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_m_sorted := sort(rc_dataset_m, rc_dataset_m.value);

m_rc1 := rc_dataset_m_sorted[1].rc;
m_rc2 := rc_dataset_m_sorted[2].rc;
m_rc3 := rc_dataset_m_sorted[3].rc;
m_rc4 := rc_dataset_m_sorted[4].rc;

m_vl1 := rc_dataset_m_sorted[1].value;
m_vl2 := rc_dataset_m_sorted[2].value;
m_vl3 := rc_dataset_m_sorted[3].value;
m_vl4 := rc_dataset_m_sorted[4].value;
//*************************************************************************************//

	rc1_2 := m_rc1;
	
	rc2_2 := m_rc2;
	
	rc3_2 := m_rc3;
	
	rc4_2 := m_rc4;

_rc_inq := map(
    rv_i62_inq_phones_per_adl > 0     => 'I62',
    rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
                                         '');

rc1_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             m_rc1);

rc2_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             m_rc2);

rc5_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc3_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             m_rc3);

rc4_c48 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             m_rc4);

rc3_1 := if(rc3_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c48, rc3_2);

rc4_1 := if(rc4_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c48, rc4_2);

rc1_1 := if(rc1_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c48, rc1_2);

rc5_1 := if(rc5_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c48, '');

rc2_1 := if(rc2_c48 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c48, rc2_2);

rc5 := if((rvt1601_1_2 in [200, 201, 203, 210, 222, 900]), '', rc5_1);

rc2 := if((rvt1601_1_2 in [200, 201, 203, 210, 222, 900]), '', rc2_1);

rc1 := if((rvt1601_1_2 in [200, 201, 203, 210, 222, 900]), '', rc1_1);

rc4 := if((rvt1601_1_2 in [200, 201, 203, 210, 222, 900]), '', rc4_1);

rc3 := if((rvt1601_1_2 in [200, 201, 203, 210, 222, 900]), '', rc3_1);
	

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													rvt1601_1_2 = 200 => DATASET([{'00'}], HRILayout),
													rvt1601_1_2 = 222 => DATASET([{'00'}], HRILayout),
													rvt1601_1_2 = 900 => DATASET([{'00'}], HRILayout),
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
SELF.seq := le.seq;

	self.sysdate                          := (string) sysdate;
	self.iv_add_apt                       := (string) iv_add_apt;

	self.rv_d32_mos_since_crim_ls         := (string) rv_d32_mos_since_crim_ls;
	self.rv_c12_nonderog_recency          := (string) rv_c12_nonderog_recency;
	self.rv_s66_adlperssn_count           := (string) rv_s66_adlperssn_count;
	self.rv_f01_inp_addr_not_verified     := (string) rv_f01_inp_addr_not_verified;
	self.rv_a44_curr_add_naprop           := (string) rv_a44_curr_add_naprop;
	self.rv_l80_inp_avm_autoval           := (string) rv_l80_inp_avm_autoval;
	self.rv_c14_addrs_15yr                := (string) rv_c14_addrs_15yr;
	self.rv_a41_a42_prop_owner_history    := (string) rv_a41_a42_prop_owner_history;
	self.rv_e55_college_ind               := (string) rv_e55_college_ind;
	self.rv_e57_prof_license_br_flag      := (string) rv_e57_prof_license_br_flag;
	self.rv_i60_inq_hiriskcred_count12    := (string) rv_i60_inq_hiriskcred_count12;
	self.rv_l79_adls_per_apt_addr         := (string) rv_l79_adls_per_apt_addr;
	self.rv_l79_adls_per_sfd_addr         := (string) rv_l79_adls_per_sfd_addr;
	self.rv_i62_inq_phones_per_adl        := (string) rv_i62_inq_phones_per_adl;
	self.m_subscore0                      := (string) m_subscore0;
	self.m_subscore1                      := (string) m_subscore1;
	self.m_subscore2                      := (string) m_subscore2;
	self.m_subscore3                      := (string) m_subscore3;
	self.m_subscore4                      := (string) m_subscore4;
	self.m_subscore5                      := (string) m_subscore5;
	self.m_subscore6                      := (string) m_subscore6;
	self.m_subscore7                      := (string) m_subscore7;
	self.m_subscore8                      := (string) m_subscore8;
	self.m_subscore9                      := (string) m_subscore9;
	self.m_subscore10                     := (string) m_subscore10;
	self.m_subscore11                     := (string) m_subscore11;
	self.m_subscore12                     := (string) m_subscore12;
	self.m_subscore13                     := (string) m_subscore13;
	self.m_rawscore                       := (string) m_rawscore;
	self.m_lnoddsscore                    := (string) m_lnoddsscore;
	self.m_probscore                      := (string) m_probscore;
	self.m_aacd_0                         := (string) m_aacd_0;
	self.m_dist_0                         := (string) m_dist_0;
	self.m_aacd_1                         := (string) m_aacd_1;
	self.m_dist_1                         := (string) m_dist_1;
	self.m_aacd_2                         := (string) m_aacd_2;
	self.m_dist_2                         := (string) m_dist_2;
	self.m_aacd_3                         := (string) m_aacd_3;
	self.m_dist_3                         := (string) m_dist_3;
	self.m_aacd_4                         := (string) m_aacd_4;
	self.m_dist_4                         := (string) m_dist_4;
	self.m_aacd_5                         := (string) m_aacd_5;
	self.m_dist_5                         := (string) m_dist_5;
	self.m_aacd_6                         := (string) m_aacd_6;
	self.m_dist_6                         := (string) m_dist_6;
	self.m_aacd_7                         := (string) m_aacd_7;
	self.m_dist_7                         := (string) m_dist_7;
	self.m_aacd_8                         := (string) m_aacd_8;
	self.m_dist_8                         := (string) m_dist_8;
	self.m_aacd_9                         := (string) m_aacd_9;
	self.m_dist_9                         := (string) m_dist_9;
	self.m_aacd_10                        := (string) m_aacd_10;
	self.m_dist_10                        := (string) m_dist_10;
	self.m_aacd_11                        := (string) m_aacd_11;
	self.m_dist_11                        := (string) m_dist_11;
	self.m_aacd_12                        := (string) m_aacd_12;
	self.m_dist_12                        := (string) m_dist_12;
	self.m_aacd_13                        := (string) m_aacd_13;
	self.m_dist_13                        := (string) m_dist_13;
	/*self.m_rcvaluel79                     := (string) m_rcvaluel79;
	self.m_rcvaluel80                     := (string) m_rcvaluel80;
	self.m_rcvaluei60                     := (string) m_rcvaluei60;
	self.m_rcvalued32                     := (string) m_rcvalued32;
	self.m_rcvaluee55                     := (string) m_rcvaluee55;
	self.m_rcvaluea44                     := (string) m_rcvaluea44;
	self.m_rcvaluef01                     := (string) m_rcvaluef01;
	self.m_rcvaluei62                     := (string) m_rcvaluei62;
	self.m_rcvalues66                     := (string) m_rcvalues66;
	self.m_rcvaluec12                     := (string) m_rcvaluec12;
	self.m_rcvaluee57                     := (string) m_rcvaluee57;
	self.m_rcvaluec14                     := (string) m_rcvaluec14;*/
	/*self.m_scaledscore := (string) m_scaledscore;
	self.i := (string) i;
	self._rc := (string) _rc;
	self.rc := (string) rc;
	self tmp_dist := (string) tmp_dist;
	self.dst := (string) dst;*/
	self.iv_rv5_deceased                  := (string) iv_rv5_deceased;
	self.iv_rv5_unscorable                := (string) iv_rv5_unscorable;
	self.ov_rc19                          := (string) ov_rc19;
	self._201                             := (string) _201;
	self._203                             := (string) _203;
	self._210                             := (string) _210;
	self.base                             := (string) base;
	self.pts                              := (string) pts;
	self.odds                             := (string) odds;
	self.rvt1601_1_2                      := (string) rvt1601_1_2;
	self.m_rc1                            := (string) m_rc1;
	self.m_rc2                            := (string) m_rc2;
	self.m_rc3                            := (string) m_rc3;
	self.m_rc4                            := (string) m_rc4;
	self.m_vl1                            := (string) m_vl1;
	self.m_vl2                            := (string) m_vl2;
	self.m_vl3                            := (string) m_vl3;
	self.m_vl4                            := (string) m_vl4;
	self._rc_inq                          := (string) _rc_inq;
	self.rc5                              := (string) rc5;
	self.rc2                              := (string) rc2;
	self.rc1                              := (string) rc1;
	self.rc3                              := (string) rc3;
	self.rc4                              := (string) rc4;

		SELF.clam := le;
		self := [];
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)));
		SELF.score := (STRING3)rvt1601_1_2;
	  SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

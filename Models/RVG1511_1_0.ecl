IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVG1511_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			/* Model Input Variables */
			Integer seq;
			Integer sysdate;
			Integer rv_f00_dob_score;
			Integer _criminal_last_date;
			Integer rv_d32_mos_since_crim_ls;
			Integer _header_first_seen;
			Integer rv_c10_m_hdr_fs;
			String rv_e55_college_ind;
			Integer rv_i60_inq_hiriskcred_count12;
			Integer rv_i60_inq_comm_recency;
			Integer rv_l79_adls_per_addr_c6;
			String rv_f01_inp_add_house_num_match;
			Integer iv_c14_addrs_per_adl;
			Integer rv_i60_inq_other_recency;
			Integer rv_i62_inq_addrs_per_adl;
			String EMAIL;
			String iv_f00_email_verification;
			Real p__subscore0;
			Real p__subscore1;
			Real p__subscore2;
			Real p__subscore3;
			Real p__subscore4;
			Real p__subscore5;
			Real p__subscore6;
			Real p__subscore7;
			Real p__subscore8;
			Real p__subscore9;
			Real p__subscore10;
			Real p__subscore11;
			Real p__rawscore;
			Real p__lnoddsscore;
			Real p__probscore;
			String p__aacd_0;
			Real p__dist_0;
			String p__aacd_1;
			Real p__dist_1;
			String p__aacd_2;
			Real p__dist_2;
			String p__aacd_3;
			Real p__dist_3;
			String p__aacd_4;
			Real p__dist_4;
			String p__aacd_5;
			Real p__dist_5;
			String p__aacd_6;
			Real p__dist_6;
			String p__aacd_7;
			Real p__dist_7;
			String p__aacd_8;
			Real p__dist_8;
			String p__aacd_9;
			Real p__dist_9;
			String p__aacd_10;
			Real p__dist_10;
			String p__aacd_11;
			Real p__dist_11;
			Real p__rcvaluel79;
			Real p__rcvalued32;
			Real p__rcvaluei60;
			Real p__rcvaluef00;
			Real p__rcvaluei62;
			Real p__rcvaluee55;
			Real p__rcvaluef01;
			Real p__rcvaluec10;
			Real p__rcvaluec14;
			Boolean iv_rv5_deceased;
			String iv_rv5_unscorable;
			Integer base;
			Integer pts;
			Integer odds;
			Integer rvg1511_1_0;
			String p__rc1;
			Real p__vl1;
			String p__rc2;
			Real p__vl2;
			String p__rc3;
			Real p__vl3;
			String p__rc4;
			Real p__vl4;
			Real vl1;
			Real vl2;
			Real vl3;
			Real vl4;
			String _rc_inq;
			String rc1;
			String rc2;
			String rc3;
			String rc4;
			String rc5;
			
      // Models.Layout_ModelOut;  
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
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	header_first_seen                := le.ssn_verification.header_first_seen;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	EMAIL														 := le.Shell_Input.email_address;
	email_verification               := le.email_summary.identity_email_verification_level;
	criminal_last_date               := le.bjl.last_criminal_date;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_rv5_unscorable_1 := if(riskview.constants.noscore(nas_summary,nap_summary, Add_Input_NAProp, le.truedid), '1', '0');

rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d32_mos_since_crim_ls := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_e55_college_ind := map(
    not(truedid)                           => ' ',
    (college_file_type in ['H', 'C', 'A']) => '1',
    college_attendance                     => '1',
                                              '0');

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_i60_inq_comm_recency := map(
    not(truedid)               					=> NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                           0);

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_f01_inp_add_house_num_match := if(not(add_input_pop and truedid), '', (String)((Integer)add_input_house_number_match));

iv_c14_addrs_per_adl := if(not(truedid), NULL, min(if(addrs_per_adl = NULL, -NULL, addrs_per_adl), 999));

rv_i60_inq_other_recency := map(
    not(truedid)      				 => NULL,
    (Boolean)inq_other_count01 => 1,
    (Boolean)inq_other_count03 => 3,
    (Boolean)inq_other_count06 => 6,
    (Boolean)inq_other_count12 => 12,
    (Boolean)inq_other_count24 => 24,
    (Boolean)inq_other_count   => 99,
																  0);

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

iv_f00_email_verification := if(not(truedid), '', trim(email_verification, LEFT));

p__subscore0 := map(
    (iv_f00_email_verification in [' '])           => 0,
    (iv_f00_email_verification in ['0'])           => -0.207638,
    (iv_f00_email_verification in ['1', '2', '3']) => -0.128347,
    (iv_f00_email_verification in ['4'])           => 0.028487,
    (iv_f00_email_verification in ['5'])           => 0.112718,
                                                      0);

p__subscore1 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 0.141978,
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => 0.05457,
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => -0.125215,
    3 <= rv_i62_inq_addrs_per_adl                                    => -0.229214,
                                                                        0);

p__subscore2 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6 => 0.058129,
    6 <= iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 10  => 0.000962,
    10 <= iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 16 => -0.137388,
    16 <= iv_c14_addrs_per_adl                               => -0.688658,
                                                                0);

p__subscore3 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 0,
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 123   => -0.237624,
    123 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 161 => -0.141063,
    161 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 203 => -0.060952,
    203 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 253 => -0.057192,
    253 <= rv_c10_m_hdr_fs                           => 0.071783,
                                                        0);

p__subscore4 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 0.017682,
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 27  => -0.500613,
    27 <= rv_d32_mos_since_crim_ls                                   => -0.385526,
                                                                        0);

p__subscore5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.085916,
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => -0.02259,
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 4   => -0.067319,
    4 <= rv_i60_inq_hiriskcred_count12                                         => -0.115651,
                                                                                  0);

p__subscore6 := map(
    (rv_f01_inp_add_house_num_match = '')  => 0,
    (rv_f01_inp_add_house_num_match = '0') => -0.208629,
    (rv_f01_inp_add_house_num_match = '1') => 0.025426,
                                              0);

p__subscore7 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100 => -0.293709,
    100 <= rv_f00_dob_score AND rv_f00_dob_score < 255 => 0.018276,
    255 <= rv_f00_dob_score                            => 0,
                                                          0);

p__subscore8 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.040653,
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => -0.044505,
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 6   => -0.147459,
    6 <= rv_l79_adls_per_addr_c6                                   => -0.347028,
                                                                      0);

p__subscore9 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 0.01528,
    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => -0.41586,
    6 <= rv_i60_inq_comm_recency                                   => -0.181462,
                                                                      0);

p__subscore10 := map(
    NULL < rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 1 => 0.009539,
    1 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 6   => -0.356803,
    6 <= rv_i60_inq_other_recency                                    => 0.007558,
                                                                        0);

p__subscore11 := map(
    (rv_e55_college_ind in [' ']) => 0,
    (rv_e55_college_ind in ['0']) => -0.025874,
    (rv_e55_college_ind in ['1']) => 0.125667,
                                     0);

p__rawscore := p__subscore0 +
    p__subscore1 +
    p__subscore2 +
    p__subscore3 +
    p__subscore4 +
    p__subscore5 +
    p__subscore6 +
    p__subscore7 +
    p__subscore8 +
    p__subscore9 +
    p__subscore10 +
    p__subscore11;

p__lnoddsscore := p__rawscore + 1.504095;

p__probscore := exp(p__lnoddsscore) / (1 + exp(p__lnoddsscore));

p__aacd_0 := map(
    (iv_f00_email_verification in [' '])           => '',
    (iv_f00_email_verification in ['0'])           => 'F00',
    (iv_f00_email_verification in ['1', '2', '3']) => 'F00',
    (iv_f00_email_verification in ['4'])           => 'F00',
    (iv_f00_email_verification in ['5'])           => 'F00',
                                                      '');

p__dist_0 := p__subscore0 - 0.112718;

p__aacd_1 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => 'I60',
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_addrs_per_adl                                    => 'I62',
                                                                        '');

p__dist_1 := p__subscore1 - 0.141978;

p__aacd_2 := map(
    NULL < iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 6 => 'C14',
    6 <= iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 10  => 'C14',
    10 <= iv_c14_addrs_per_adl AND iv_c14_addrs_per_adl < 16 => 'C14',
    16 <= iv_c14_addrs_per_adl                               => 'C14',
                                                                '');

p__dist_2 := p__subscore2 - 0.058129;

p__aacd_3 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 0   => 'C10',
    0 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 123   => 'C10',
    123 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 161 => 'C10',
    161 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 203 => 'C10',
    203 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 253 => 'C10',
    253 <= rv_c10_m_hdr_fs                           => 'C10',
                                                        'C10');

p__dist_3 := p__subscore3 - 0.071783;

p__aacd_4 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D32',
    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 27  => 'D32',
    27 <= rv_d32_mos_since_crim_ls                                   => 'D32',
                                                                        '');

p__dist_4 := p__subscore4 - 0.017682;

p__aacd_5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 2   => 'I60',
    2 <= rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 4   => 'I60',
    4 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
                                                                                  '');

p__dist_5 := p__subscore5 - 0.085916;

p__aacd_6 := map(
    (rv_f01_inp_add_house_num_match = '')  => 'F00',
    (rv_f01_inp_add_house_num_match = '0') => 'F01',
    (rv_f01_inp_add_house_num_match = '1') => 'F01',
                                              'F00');

p__dist_6 := p__subscore6 - 0.025426;

p__aacd_7 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100 => 'F00',
    100 <= rv_f00_dob_score AND rv_f00_dob_score < 255 => 'F00',
    255 <= rv_f00_dob_score                            => 'F00',
                                                          'F00');

p__dist_7 := p__subscore7 - 0.018276;

p__aacd_8 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => 'L79',
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 6   => 'L79',
    6 <= rv_l79_adls_per_addr_c6                                   => 'L79',
                                                                      '');

p__dist_8 := p__subscore8 - 0.040653;

p__aacd_9 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 'I60',
    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => 'I60',
    6 <= rv_i60_inq_comm_recency                                   => 'I60',
                                                                      '');

p__dist_9 := p__subscore9 - 0.01528;

p__aacd_10 := map(
    NULL < rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 1 => 'I60',
    1 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 6   => 'I60',
    6 <= rv_i60_inq_other_recency                                    => 'I60',
                                                                        '');

p__dist_10 := p__subscore10 - 0.009539;

p__aacd_11 := map(
    (rv_e55_college_ind in [' ']) => '',
    (rv_e55_college_ind in ['0']) => 'E55',
    (rv_e55_college_ind in ['1']) => 'E55',
                                     '');

p__dist_11 := p__subscore11 - 0.125667;

p__rcvaluel79 := (integer)(p__aacd_0 = 'L79') * p__dist_0 +
    (integer)(p__aacd_1 = 'L79') * p__dist_1 +
    (integer)(p__aacd_2 = 'L79') * p__dist_2 +
    (integer)(p__aacd_3 = 'L79') * p__dist_3 +
    (integer)(p__aacd_4 = 'L79') * p__dist_4 +
    (integer)(p__aacd_5 = 'L79') * p__dist_5 +
    (integer)(p__aacd_6 = 'L79') * p__dist_6 +
    (integer)(p__aacd_7 = 'L79') * p__dist_7 +
    (integer)(p__aacd_8 = 'L79') * p__dist_8 +
    (integer)(p__aacd_9 = 'L79') * p__dist_9 +
    (integer)(p__aacd_10 = 'L79') * p__dist_10 +
    (integer)(p__aacd_11 = 'L79') * p__dist_11;

p__rcvalued32 := (integer)(p__aacd_0 = 'D32') * p__dist_0 +
    (integer)(p__aacd_1 = 'D32') * p__dist_1 +
    (integer)(p__aacd_2 = 'D32') * p__dist_2 +
    (integer)(p__aacd_3 = 'D32') * p__dist_3 +
    (integer)(p__aacd_4 = 'D32') * p__dist_4 +
    (integer)(p__aacd_5 = 'D32') * p__dist_5 +
    (integer)(p__aacd_6 = 'D32') * p__dist_6 +
    (integer)(p__aacd_7 = 'D32') * p__dist_7 +
    (integer)(p__aacd_8 = 'D32') * p__dist_8 +
    (integer)(p__aacd_9 = 'D32') * p__dist_9 +
    (integer)(p__aacd_10 = 'D32') * p__dist_10 +
    (integer)(p__aacd_11 = 'D32') * p__dist_11;

p__rcvaluei60 := (integer)(p__aacd_0 = 'I60') * p__dist_0 +
    (integer)(p__aacd_1 = 'I60') * p__dist_1 +
    (integer)(p__aacd_2 = 'I60') * p__dist_2 +
    (integer)(p__aacd_3 = 'I60') * p__dist_3 +
    (integer)(p__aacd_4 = 'I60') * p__dist_4 +
    (integer)(p__aacd_5 = 'I60') * p__dist_5 +
    (integer)(p__aacd_6 = 'I60') * p__dist_6 +
    (integer)(p__aacd_7 = 'I60') * p__dist_7 +
    (integer)(p__aacd_8 = 'I60') * p__dist_8 +
    (integer)(p__aacd_9 = 'I60') * p__dist_9 +
    (integer)(p__aacd_10 = 'I60') * p__dist_10 +
    (integer)(p__aacd_11 = 'I60') * p__dist_11;

p__rcvaluef00 := (integer)(p__aacd_0 = 'F00') * p__dist_0 +
    (integer)(p__aacd_1 = 'F00') * p__dist_1 +
    (integer)(p__aacd_2 = 'F00') * p__dist_2 +
    (integer)(p__aacd_3 = 'F00') * p__dist_3 +
    (integer)(p__aacd_4 = 'F00') * p__dist_4 +
    (integer)(p__aacd_5 = 'F00') * p__dist_5 +
    (integer)(p__aacd_6 = 'F00') * p__dist_6 +
    (integer)(p__aacd_7 = 'F00') * p__dist_7 +
    (integer)(p__aacd_8 = 'F00') * p__dist_8 +
    (integer)(p__aacd_9 = 'F00') * p__dist_9 +
    (integer)(p__aacd_10 = 'F00') * p__dist_10 +
    (integer)(p__aacd_11 = 'F00') * p__dist_11;

p__rcvaluei62 := (integer)(p__aacd_0 = 'I62') * p__dist_0 +
    (integer)(p__aacd_1 = 'I62') * p__dist_1 +
    (integer)(p__aacd_2 = 'I62') * p__dist_2 +
    (integer)(p__aacd_3 = 'I62') * p__dist_3 +
    (integer)(p__aacd_4 = 'I62') * p__dist_4 +
    (integer)(p__aacd_5 = 'I62') * p__dist_5 +
    (integer)(p__aacd_6 = 'I62') * p__dist_6 +
    (integer)(p__aacd_7 = 'I62') * p__dist_7 +
    (integer)(p__aacd_8 = 'I62') * p__dist_8 +
    (integer)(p__aacd_9 = 'I62') * p__dist_9 +
    (integer)(p__aacd_10 = 'I62') * p__dist_10 +
    (integer)(p__aacd_11 = 'I62') * p__dist_11;

p__rcvaluee55 := (integer)(p__aacd_0 = 'E55') * p__dist_0 +
    (integer)(p__aacd_1 = 'E55') * p__dist_1 +
    (integer)(p__aacd_2 = 'E55') * p__dist_2 +
    (integer)(p__aacd_3 = 'E55') * p__dist_3 +
    (integer)(p__aacd_4 = 'E55') * p__dist_4 +
    (integer)(p__aacd_5 = 'E55') * p__dist_5 +
    (integer)(p__aacd_6 = 'E55') * p__dist_6 +
    (integer)(p__aacd_7 = 'E55') * p__dist_7 +
    (integer)(p__aacd_8 = 'E55') * p__dist_8 +
    (integer)(p__aacd_9 = 'E55') * p__dist_9 +
    (integer)(p__aacd_10 = 'E55') * p__dist_10 +
    (integer)(p__aacd_11 = 'E55') * p__dist_11;

p__rcvaluef01 := (integer)(p__aacd_0 = 'F01') * p__dist_0 +
    (integer)(p__aacd_1 = 'F01') * p__dist_1 +
    (integer)(p__aacd_2 = 'F01') * p__dist_2 +
    (integer)(p__aacd_3 = 'F01') * p__dist_3 +
    (integer)(p__aacd_4 = 'F01') * p__dist_4 +
    (integer)(p__aacd_5 = 'F01') * p__dist_5 +
    (integer)(p__aacd_6 = 'F01') * p__dist_6 +
    (integer)(p__aacd_7 = 'F01') * p__dist_7 +
    (integer)(p__aacd_8 = 'F01') * p__dist_8 +
    (integer)(p__aacd_9 = 'F01') * p__dist_9 +
    (integer)(p__aacd_10 = 'F01') * p__dist_10 +
    (integer)(p__aacd_11 = 'F01') * p__dist_11;

p__rcvaluec10 := (integer)(p__aacd_0 = 'C10') * p__dist_0 +
    (integer)(p__aacd_1 = 'C10') * p__dist_1 +
    (integer)(p__aacd_2 = 'C10') * p__dist_2 +
    (integer)(p__aacd_3 = 'C10') * p__dist_3 +
    (integer)(p__aacd_4 = 'C10') * p__dist_4 +
    (integer)(p__aacd_5 = 'C10') * p__dist_5 +
    (integer)(p__aacd_6 = 'C10') * p__dist_6 +
    (integer)(p__aacd_7 = 'C10') * p__dist_7 +
    (integer)(p__aacd_8 = 'C10') * p__dist_8 +
    (integer)(p__aacd_9 = 'C10') * p__dist_9 +
    (integer)(p__aacd_10 = 'C10') * p__dist_10 +
    (integer)(p__aacd_11 = 'C10') * p__dist_11;

p__rcvaluec14 := (integer)(p__aacd_0 = 'C14') * p__dist_0 +
    (integer)(p__aacd_1 = 'C14') * p__dist_1 +
    (integer)(p__aacd_2 = 'C14') * p__dist_2 +
    (integer)(p__aacd_3 = 'C14') * p__dist_3 +
    (integer)(p__aacd_4 = 'C14') * p__dist_4 +
    (integer)(p__aacd_5 = 'C14') * p__dist_5 +
    (integer)(p__aacd_6 = 'C14') * p__dist_6 +
    (integer)(p__aacd_7 = 'C14') * p__dist_7 +
    (integer)(p__aacd_8 = 'C14') * p__dist_8 +
    (integer)(p__aacd_9 = 'C14') * p__dist_9 +
    (integer)(p__aacd_10 = 'C14') * p__dist_10 +
    (integer)(p__aacd_11 = 'C14') * p__dist_11;

iv_rv5_deceased := (Integer)rc_decsflag = 1 or rc_ssndod != 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

base := 700;

pts := 60;

odds := (1 - .184) / .184;

rvg1511_1_0 := map(
    (Integer)iv_rv5_deceased > 0     => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(pts * (ln(p__probscore / (1 - p__probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(p__probscore / (1 - p__probscore)) - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_p_ := DATASET([
    {'L79', p__rcvalueL79},
    {'D32', p__rcvalueD32},
    {'I60', p__rcvalueI60},
    {'F00', p__rcvalueF00},
    {'I62', p__rcvalueI62},
    {'E55', p__rcvalueE55},
    {'F01', p__rcvalueF01},
    {'C10', p__rcvalueC10},
    {'C14', p__rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_p__sorted := sort(rc_dataset_p_, rc_dataset_p_.value);

p__rc1 := rc_dataset_p__sorted[1].rc;
p__rc2 := rc_dataset_p__sorted[2].rc;
p__rc3 := rc_dataset_p__sorted[3].rc;
p__rc4 := rc_dataset_p__sorted[4].rc;

p__vl1 := rc_dataset_p__sorted[1].value;
p__vl2 := rc_dataset_p__sorted[2].value;
p__vl3 := rc_dataset_p__sorted[3].value;
p__vl4 := rc_dataset_p__sorted[4].value;
//*************************************************************************************//

rc1_2 := p__rc1;
rc2_2 := p__rc2;
rc3_2 := p__rc3;
rc4_2 := p__rc4;

vl1 := p__vl1;
vl2 := p__vl2;
vl3 := p__vl3;
vl4 := p__vl4;

_rc_inq := map(
    rv_i62_inq_addrs_per_adl = 1      => 'I60',
    rv_i62_inq_addrs_per_adl > 1      => 'I62',
    rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
    rv_i60_inq_comm_recency > 0       => 'I60',
    rv_i60_inq_other_recency > 0      => 'I60',
                                         '');
																				 
rc5_c43 := map(
    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc2_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc3_2, LEFT), LEFT, RIGHT) = '' => '',
    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
                                                         _rc_inq);

rc5_1 := if(not((rc1_2 in ['I60', 'I62'])) and not((rc2_2 in ['I60', 'I62'])) and not((rc3_2 in ['I60', 'I62'])) and not((rc4_2 in ['I60', 'I62'])), rc5_c43, '');

rc1 := if((rvg1511_1_0 in [200, 222]), '', rc1_2);

rc2 := if((rvg1511_1_0 in [200, 222]), '', rc2_2);

rc3 := if((rvg1511_1_0 in [200, 222]), '', rc3_2);

rc4 := if((rvg1511_1_0 in [200, 222]), '', rc4_2);

rc5 := if((rvg1511_1_0 in [200, 222]), '', rc5_1);


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVG1511_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1511_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1511_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		SELF.seq 															:= le.seq;
		self.sysdate                          := sysdate;
		self.rv_f00_dob_score                 := rv_f00_dob_score;
		self._criminal_last_date              := _criminal_last_date;
		self.rv_d32_mos_since_crim_ls         := rv_d32_mos_since_crim_ls;
		self._header_first_seen               := _header_first_seen;
		self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
		self.rv_e55_college_ind               := rv_e55_college_ind;
		self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
		self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
		self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
		self.rv_f01_inp_add_house_num_match   := rv_f01_inp_add_house_num_match;
		self.iv_c14_addrs_per_adl             := iv_c14_addrs_per_adl;
		self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
		self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
		self.EMAIL														:= EMAIL;
		self.iv_f00_email_verification        := iv_f00_email_verification;
		self.p__subscore0                     := p__subscore0;
		self.p__subscore1                     := p__subscore1;
		self.p__subscore2                     := p__subscore2;
		self.p__subscore3                     := p__subscore3;
		self.p__subscore4                     := p__subscore4;
		self.p__subscore5                     := p__subscore5;
		self.p__subscore6                     := p__subscore6;
		self.p__subscore7                     := p__subscore7;
		self.p__subscore8                     := p__subscore8;
		self.p__subscore9                     := p__subscore9;
		self.p__subscore10                    := p__subscore10;
		self.p__subscore11                    := p__subscore11;
		self.p__rawscore                      := p__rawscore;
		self.p__lnoddsscore                   := p__lnoddsscore;
		self.p__probscore                     := p__probscore;
		self.p__aacd_0                        := p__aacd_0;
		self.p__dist_0                        := p__dist_0;
		self.p__aacd_1                        := p__aacd_1;
		self.p__dist_1                        := p__dist_1;
		self.p__aacd_2                        := p__aacd_2;
		self.p__dist_2                        := p__dist_2;
		self.p__aacd_3                        := p__aacd_3;
		self.p__dist_3                        := p__dist_3;
		self.p__aacd_4                        := p__aacd_4;
		self.p__dist_4                        := p__dist_4;
		self.p__aacd_5                        := p__aacd_5;
		self.p__dist_5                        := p__dist_5;
		self.p__aacd_6                        := p__aacd_6;
		self.p__dist_6                        := p__dist_6;
		self.p__aacd_7                        := p__aacd_7;
		self.p__dist_7                        := p__dist_7;
		self.p__aacd_8                        := p__aacd_8;
		self.p__dist_8                        := p__dist_8;
		self.p__aacd_9                        := p__aacd_9;
		self.p__dist_9                        := p__dist_9;
		self.p__aacd_10                       := p__aacd_10;
		self.p__dist_10                       := p__dist_10;
		self.p__aacd_11                       := p__aacd_11;
		self.p__dist_11                       := p__dist_11;
		self.p__rcvaluel79                    := p__rcvaluel79;
		self.p__rcvalued32                    := p__rcvalued32;
		self.p__rcvaluei60                    := p__rcvaluei60;
		self.p__rcvaluef00                    := p__rcvaluef00;
		self.p__rcvaluei62                    := p__rcvaluei62;
		self.p__rcvaluee55                    := p__rcvaluee55;
		self.p__rcvaluef01                    := p__rcvaluef01;
		self.p__rcvaluec10                    := p__rcvaluec10;
		self.p__rcvaluec14                    := p__rcvaluec14;
		self.iv_rv5_deceased                  := iv_rv5_deceased;
		self.iv_rv5_unscorable                := iv_rv5_unscorable;
		self.base                             := base;
		self.pts                              := pts;
		self.odds                             := odds;
		self.rvg1511_1_0                      := rvg1511_1_0;
		self.p__rc1                           := p__rc1;
		self.p__vl1                           := p__vl1;
		self.p__rc2                           := p__rc2;
		self.p__vl2                           := p__vl2;
		self.p__rc3                           := p__rc3;
		self.p__vl3                           := p__vl3;
		self.p__rc4                           := p__rc4;
		self.p__vl4                           := p__vl4;
		self.vl1                              := vl1;
		self.vl2                              := vl2;
		self.vl3                              := vl3;
		self.vl4                              := vl4;
		self._rc_inq                          := _rc_inq;
		
		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1511_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

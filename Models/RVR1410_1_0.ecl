// RVR1410_1_0 - Blue Stem - 4.1. shell - FCRA 

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVR1410_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION

  RVR_DEBUG := false;
	
	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;
	
	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));	
	

  #if(RVR_DEBUG)
    layout_debug := record
	integer             seq;	
	 real               sysdate;
   boolean            iv_pots_phone;
   boolean            iv_add_apt;
   boolean            iv_riskview_222s;
   string             iv_db001_bankruptcy;
   real               iv_de001_eviction_recency;
   real               iv_pl002_addrs_15yr;
   real               prop_adl_p_count_pos;
   real               prop_adl_count_p;
   real               _src_prop_adl_count;
   real               iv_src_property_adl_count;
   real               vote_adl_vo_lseen_pos;
   string             vote_adl_lseen_vo;
   real               _vote_adl_lseen_vo;
   real               _src_vote_adl_lseen;
   real               iv_mos_src_voter_adl_lseen;
   string             iv_best_match_address;
   real               _gong_did_first_seen;
   real               iv_mos_since_gong_did_fst_seen;
   real               iv_max_ids_per_sfd_addr_c6;
   real               iv_inq_highriskcredit_recency;
   boolean            ver_phn_inf;
   boolean            ver_phn_nap;
   real               inf_phn_ver_lvl;
   real               nap_phn_ver_lvl;
   string             iv_nap_phn_ver_x_inf_phn_ver;
   real               _impulse_last_seen;
   real               iv_mos_since_impulse_last_seen;
   string             iv_criminal_x_felony;
   real               _reported_dob;
   real               reported_age;
   real               _combined_age;
   boolean            evidence_of_college;
   string             iv_college_attendance_x_age;
   real               iv_pb_total_orders;
   string             iv_msa_name;
   string             iv_ed001_college_ind;
   real               _header_first_seen;
   real               iv_sr001_m_hdr_fs;
   real               all_subscore0;
   real               all_subscore1;
   real               all_subscore2;
   real               all_subscore3;
   real               all_subscore4;
   real               all_subscore5;
   real               all_subscore6;
   real               all_subscore7;
   real               all_subscore8;
   real               all_subscore9;
   real               all_subscore10;
   real               all_subscore11;
   real               all_subscore12;
   real               all_subscore13;
   real               all_subscore14;
   real               all_rawscore;
   real               all_lnoddsscore;
   real               all_probscore;
   real               base;
   real               point;
   real               odds;
   real               rvr1410_1_0;
   boolean            glrc9i;
   boolean            glrc9y;
   boolean            glrc36;
   boolean            glrc97;
   boolean            glrcev;
   boolean            glrc99;
   boolean            glrc9h;
   boolean            glrc9w;
   boolean            glrc9p;
   boolean            glrc9f;
   boolean            glrc9r;
   boolean            glrc9d;
   boolean            glrc9a;
   boolean            glrcbl;
   boolean            glrc9j;
   real               rcvalue9i_1;
   real               rcvalue9i;
   real               rcvalue9y_1;
   real               rcvalue9y;
   real               rcvalue36_1;
   real               rcvalue36;
   real               rcvalue97_1;
   real               rcvalue97;
   real               rcvalueev_1;
   real               rcvalueev;
   real               rcvalue99_1;
   real               rcvalue99;
   real               rcvalue9h_1;
   real               rcvalue9h;
   real               rcvalue9w_1;
   real               rcvalue9w;
   real               rcvalue9p_1;
   real               rcvalue9p;
   real               rcvalue9f_1;
   real               rcvalue9f;
   real               rcvalue9r_1;
   real               rcvalue9r;
   real               rcvalue9d_1;
   real               rcvalue9d;
   real               rcvalue9a_1;
   real               rcvalue9a;
   real               rcvaluebl_1;
   real               rcvaluebl_2;
   real               rcvaluebl;
   string             rc5;
   string             rc4;
   string             rc3;
   string             rc2;
   string             rc1;
                                        
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	
		msa_name                         := le.msa;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	voter_avail                      := le.available_sources.voter;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	impulse_last_seen                := le.impulse.last_seen_date;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;

	
NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_de001_eviction_recency := map(
    not(truedid)                                                   => NULL,
    attr_eviction_count90  >=1                                     => 3,
    attr_eviction_count180 >=1                                     => 6,
    attr_eviction_count12  >=1                                     => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    attr_eviction_count24  >=1                                     => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    attr_eviction_count36  >=1                                     => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    attr_eviction_count60  >=1                                     => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

_src_prop_adl_count := max(prop_adl_count_p, (real)0);

iv_src_property_adl_count := map(
    not(truedid)               => NULL,
    _src_prop_adl_count = NULL => -1,
                                  _src_prop_adl_count);

vote_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

vote_adl_lseen_vo := if(vote_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, vote_adl_vo_lseen_pos, ','));

_vote_adl_lseen_vo := common.sas_date((string)(vote_adl_lseen_vo));

_src_vote_adl_lseen := _vote_adl_lseen_vo;

iv_mos_src_voter_adl_lseen := map(
    not(truedid)               => NULL,
    not(voter_avail)           => -1,
    _src_vote_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_vote_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vote_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_vote_adl_lseen) / (365.25 / 12))));

iv_best_match_address := map(
    add1_isbestmatch => 'ADD1',
    add2_isbestmatch => 'ADD2',
    add3_isbestmatch => 'ADD3',
                        'NONE');

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_max_ids_per_sfd_addr_c6 := map(
    not(add1_pop)    => NULL,
    (integer)iv_add_apt = 1 => -1,
                        max(adls_per_addr_c6, ssns_per_addr_c6));

iv_inq_highriskcredit_recency := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 >=1 => 1,
    inq_highRiskCredit_count03 >=1=> 3,
    inq_highRiskCredit_count06 >=1=> 6,
    inq_highRiskCredit_count12 >=1=> 12,
    inq_highRiskCredit_count24 >=1=> 24,
    inq_highRiskCredit_count   >=1=> 99,
                                  0);

ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl := map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2);

nap_phn_ver_lvl := map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2);

iv_nap_phn_ver_x_inf_phn_ver := map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));

_impulse_last_seen := common.sas_date((string)(impulse_last_seen));

iv_mos_since_impulse_last_seen := map(
    not(truedid)                   => NULL,
    not(_impulse_last_seen = NULL) => if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12))),
                                      -1);

iv_criminal_x_felony := if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

_combined_age := map(
    age > 0           => age,
    (integer)input_dob_age > 0 => (integer)input_dob_age,
    inferred_age > 0           => inferred_age,
    reported_age > 0           => reported_age,
    (integer)ams_age > 0       => (integer)ams_age,
                                   -1);

evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');

iv_college_attendance_x_age := map(
    not(truedid or dobpop) => '',
    _combined_age = -1     => '',
    evidence_of_college    => 'Y' + (string)(if (min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10 >= 0, truncate(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10), roundup(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10)) * 10),
                              'N' + (string)(if (min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10 >= 0, truncate(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10), roundup(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10)) * 10));

iv_pb_total_orders := map(
    not(truedid)           => NULL,
    pb_total_orders = ''   => -1,
                              (integer)pb_total_orders);

iv_msa_name := StringLib.StringFilterOut((string)msa_name, '');

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                          => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or (integer)ams_college_tier >= 0 and ams_college_tier <>'' or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                                   => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
                                                                                                                                                                             '0');

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

all_subscore0 := map(
    (iv_college_attendance_x_age in ['N10', 'N20', 'N30']) => -0.247367,
    (iv_college_attendance_x_age in ['N40'])               => -0.042930,
    (iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30']) => 0.100314,
    (iv_college_attendance_x_age in ['Y40'])               => 0.199750,
    (iv_college_attendance_x_age in ['N50', 'Y50'])        => 0.419193,
    (iv_college_attendance_x_age in ['N60', 'Y60'])        => 0.716002,
                                                              0.000000);

all_subscore1 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.162250,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => 0.043447,
    2 <= iv_pb_total_orders AND iv_pb_total_orders < 3   => 0.136361,
    3 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.225738,
    4 <= iv_pb_total_orders AND iv_pb_total_orders < 6   => 0.317509,
    6 <= iv_pb_total_orders AND iv_pb_total_orders < 12  => 0.407520,
    12 <= iv_pb_total_orders AND iv_pb_total_orders < 14 => 0.577529,
    14 <= iv_pb_total_orders AND iv_pb_total_orders < 32 => 0.855951,
    32 <= iv_pb_total_orders                             => 1.129586,
                                                            0.000000);

all_subscore2 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-1'])                      => -0.401694,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0', '0-1', '1-0'])  => -0.118985,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1'])               => -0.117951,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '2-3', '3-1', '3-3']) => 0.100903,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                      => 0.248997,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                      => 0.271781,
                                                                      -0.000000);

all_subscore3 := map(
    (iv_criminal_x_felony in [' '])                        => 0.000000,
    (iv_criminal_x_felony in ['0-0'])                      => 0.035215,
    (iv_criminal_x_felony in ['1-0'])                      => -0.313029,
    (iv_criminal_x_felony in ['1-1', '2-0', '2-1', '2-2']) => -0.450741,
    (iv_criminal_x_felony in ['3-0', '3-1', '3-2', '3-3']) => -0.627232,
                                                              0.000000);

all_subscore4 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.035118,
    3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => -0.706852,
    25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 98 => -0.389572,
    98 <= iv_de001_eviction_recency                                    => -0.143387,
                                                                          -0.000000);

all_subscore5 := map(
    (iv_best_match_address in ['ADD1'])         => 0.105806,
    (iv_best_match_address in ['NONE'])         => -0.074540,
    (iv_best_match_address in ['ADD2', 'ADD3']) => -0.140115,
                                                   0.000000);

all_subscore6 := map(
    NULL < iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 0 => 0.033362,
    0 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 22  => -0.631783,
    22 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 56 => -0.436552,
    56 <= iv_mos_since_impulse_last_seen                                         => -0.324453,
                                                                                    -0.000000);

all_subscore7 := map(
    (iv_db001_bankruptcy in [' '])                 => -0.000000,
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.025827,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.005205,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => 0.364087,
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.544161,
                                                      -0.000000);

all_subscore8 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.019082,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -0.581306,
    3 <= iv_inq_highriskcredit_recency                                         => -0.427818,
                                                                                  -0.000000);

all_subscore9 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 0 => -0.033876,
    0 <= iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 18  => 0.255547,
    18 <= iv_mos_src_voter_adl_lseen                                     => -0.028690,
                                                                            -0.000000);

all_subscore10 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0  => 0.062156,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 54   => -0.154342,
    54 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 80  => -0.111249,
    80 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 109 => 0.012098,
    109 <= iv_mos_since_gong_did_fst_seen                                         => 0.076165,
                                                                                     0.000000);
// StringLib.StringFilterOut(mystring, '\'') 
all_subscore11 := map(
    (iv_msa_name in [' '])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    => -0.000000,
    (iv_msa_name in ['AL NONMETROPOLITAN AREA', 'ALBANY, GA', 'ALBUQUERQUE, NM', 'ALEXANDRIA, LA', 'ANNISTON-OXFORD, AL', 'AR NONMETROPOLITAN AREA', 'ATHENS-CLARK COUNTY, GA', 'ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'AUBURN-OPELIKA, AL', 'AUGUSTA-RICHMOND COUNTY,GA-SC', 'AZ NONMETROPOLITAN AREA', 'BAKERSFIELD, CA', 'BATON ROUGE, LA', 'BIRMINGHAM-HOOVER, AL', 'BRUNSWICK, GA', 'CA NONMETROPOLITAN AREA', 'CHATTANOOGA, TN-GA', 'CHICO, CA', 'CLEVELAND, TN', 'COLUMBUS, GA-AL', 'DALTON, GA'])                      => -0.105621,
    (iv_msa_name in ['DECATUR, AL', 'DOTHAN, AL', 'EL CENTRO, CA', 'FARMINGTON, NM', 'FAYETTEVILLE-SPRINGDALE-ROGERS, AR-MO', 'FLAGSTAFF, AZ', 'FLORENCE-MUSCLE SHOALS, AL', 'FORT SMITH, AR-OK', 'FRESNO, CA', 'GA NONMETROPOLITAN AREA', 'GADSDEN, AL', 'GAINESVILLE, GA', 'GULFPORT-BILOXI, MS', 'HANFORD-CORCORAN, CA', 'HATTIESBURG, MS', 'HINESVILLE-FORT STEWART,GA', 'HOT SPRINGS, AR', 'HOUMA-BAYOU CANE-THIBODAUX,LA', 'HUNTSVILLE, AL', 'JACKSON, MS', 'JACKSON, TN', 'JOHNSON CITY, TN'])                         => -0.105621,
    (iv_msa_name in ['JONESBORO, AR', 'KNOXVILLE, TN', 'LA NONMETROPOLITAN AREA', 'LAFAYETTE, LA', 'LAKE CHARLES, LA', 'LAKE HAVASU CITY-KINGMAN,AZ', 'LAS CRUCES, NM', 'LAWTON, OK', 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MACON, GA', 'MADERA, CA', 'MEMPHIS, TN-AR-MS', 'MERCED, CA', 'MOBILE, AL', 'MODESTO, CA', 'MONROE, LA', 'MONTGOMERY, AL', 'MORRISTOWN, TN', 'MS NONMETROPOLITAN AREA', 'NAPA, CA', 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN'])                  => -0.105621,
    (iv_msa_name in ['NEW ORLEANS-METAIRIE-KENNER,LA', 'NM NONMETROPOLITAN AREA', 'OK NONMETROPOLITAN AREA', 'OKLAHOMA CITY, OK', 'OXNARD-THOUSAND OAKS-VENTURA, CA', 'PASCAGOULA, MS', 'PHOENIX-MESA-SCOTTSDALE,AZ', 'PINE BLUFF, AR', 'PRESCOTT, AZ', 'REDDING, CA', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'ROME, GA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SALINAS, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA'])                            => -0.105621,
    (iv_msa_name in ['SAN LUIS OBISPO-PASO ROBLES,CA', 'SANTA BARBARA-SANTA MARIA LETA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'SANTA FE, NM', 'SANTA ROSA-PETALUMA, CA', 'SAVANNAH, GA', 'SHREVEPORT-BOSSIER CITY,LA', 'STOCKTON, CA', 'TN NONMETROPOLITAN AREA', 'TUCSON, AZ', 'TULSA, OK', 'TUSCALOOSA, AL', 'VALDOSTA, GA', 'VALLEJO-FAIRFIELD, CA', 'VISALIA-PORTERVILLE, CA', 'WARNER ROBINS, GA', 'YUBA CITY, CA', 'YUMA, AZ'])                                                                                            => -0.105621,
    (iv_msa_name in ['ANDERSON, SC', 'ASHEVILLE, NC', 'BLACKSBURG-CHRISTIANSBURG DFORD, VA', 'BOWLING GREEN, KY', 'BURLINGTON, NC', 'CHARLESTON, WV', 'CHARLESTON-NORTH CHARLESTON,SC', 'CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'CHARLOTTESVILLE, VA', 'CLARKSVILLE, TN-KY', 'COLUMBIA, SC', 'DANVILLE, VA', 'DE NONMETROPOLITAN AREA', 'DOVER, DE', 'DURHAM, NC', 'ELIZABETHTOWN, KY', 'FAYETTEVILLE, NC', 'FLORENCE, SC', 'GOLDSBORO, NC', 'GREENSBORO-HIGH POINT, NC', 'GREENVILLE, NC', 'GREENVILLE-MAULDIN-EASLEY, SC'])     => -0.098502,
    (iv_msa_name in ['HARRISONBURG, VA', 'HICKORY-LENOIR-MORGANTON,NC', 'HUNTINGTON-ASHLAND, WV-KY', 'JACKSONVILLE, NC', 'KINGSPORT-BRISTOL-BRISTOL, TN-VA', 'KY NONMETROPOLITAN AREA', 'LEXINGTON-FAYETTE, KY', 'LYNCHBURG, VA', 'MORGANTOWN, WV', 'MYRTLE BEACH-CONWAY-NORTHMYRTLE BEACH, SC', 'NC NONMETROPOLITAN AREA', 'OWENSBORO, KY', 'RALEIGH-CARY, NC', 'RICHMOND, VA', 'ROANOKE, VA', 'ROCKY MOUNT, NC', 'SC NONMETROPOLITAN AREA', 'SPARTANBURG, SC', 'SUMTER, SC', 'VA NONMETROPOLITAN AREA'])                    => -0.098502,
    (iv_msa_name in ['VIRGINIA BEACH-NORFOLK-NEWPORT NEWS, VA-NC', 'WILMINGTON, NC', 'WINCHESTER, VA-WV', 'WINSTON-SALEM, NC', 'WV NONMETROPOLITAN AREA'])                                                                                                                                                                                                                                                                                                                                                                    => -0.098502,
    (iv_msa_name in ['ABILENE, TX', 'AGUADILLA-ISABELA-SAN SEBASTIAN, PR', 'AK NONMETROPOLITAN AREA', 'AKRON, OH', 'ALL OTHER TERRITORIES ANDFOREIGN COUNTRIES', 'AMARILLO, TX', 'AMES, IA', 'ANCHORAGE, AK', 'ANDERSON, IN', 'ANN ARBOR, MI', 'APPLETON, WI', 'AUSTIN-ROUND ROCK, TX', 'BATTLE CREEK, MI', 'BAY CITY, MI', 'BEAUMONT-PORT ARTHUR, TX', 'BELLINGHAM, WA', 'BEND, OR', 'BILLINGS, MT', 'BISMARCK, ND', 'BLOOMINGTON, IN', 'BLOOMINGTON-NORMAL, IL', 'BOISE CITY-NAMPA, ID', 'BOULDER, CO'])                    => 0.028654,
    (StringLib.StringFilterOut(iv_msa_name,'\'') in ['BREMERTON-SILVERDALE, WA', 'BROWNSVILLE-HARLINGEN, TX', 'CANTON-MASSILLON, OH', 'CAPE CORAL-FORT MYERS, FL', 'CAPE GIRARDEAU-JACKSON, MO-IL', 'CARSON CITY, NV', 'CASPER, WY', 'CEDAR RAPIDS, IA', 'CHAMPAIGN-URBANA, IL', 'CHEYENNE, WY', 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI', 'CINCINNATI-MIDDLETOWN, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'CO NONMETROPOLITAN AREA', 'COEUR DALENE, ID', 'COLLEGE STATION-BRYAN, TX', 'COLORADO SPRINGS, CO', 'COLUMBIA, MO', 'COLUMBUS, IN'])                       => 0.028654,
    (iv_msa_name in ['COLUMBUS, OH', 'CORPUS CHRISTI, TX', 'CORVALIS, OR', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'DANVILLE, IL', 'DAVENPORT-MOLINE-ROCK ISLAND, IA-IL', 'DAYTON, OH', 'DECATUR, IL', 'DELTONA-DAYTONA BEACH-ORMONDBEACH, FL', 'DENVER-AURORA, CO', 'DES MOINES-WEST DES MOINES,IA', 'DETROIT-WARREN-LIVONIA, MI', 'DUBUQUE, IA', 'DULUTH, MN-WI', 'EAU CLAIRE, WI', 'EL PASO, TX', 'ELKHART-GOSHEN, IN', 'EUGENE-SPRINGFIELD, OR', 'EVANSVILLE, IN-KY', 'FAIRBANKS, AK', 'FAJARDO, PR'])                          => 0.028654,
    (iv_msa_name in ['FARGO, ND-MN', 'FL NONMETROPOLITAN AREA', 'FLINT, MI', 'FOND DU LAC, WI', 'FORT COLLINS-LOVELAND, CO', 'FORT WALTON BEACH-CRESTVIEW-DESTIN, FL', 'FORT WAYNE, IN', 'GAINESVILLE, FL', 'GRAND FORKS, ND-MN', 'GRAND JUNCTION, CO', 'GRAND RAPIDS-WYOMING, MI', 'GREAT FALLS, MT', 'GREELEY, CO', 'GREEN BAY, WI', 'GU NONMETROPOLITAN AREA', 'GUAYAMA, PR', 'HI NONMETROPOLITAN AREA', 'HOLLAND-GRAND HAVEN, MI', 'HONOLULU, HI', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'IA NONMETROPOLITAN AREA'])           => 0.028654,
    (iv_msa_name in ['ID NONMETROPOLITAN AREA', 'IDAHO FALLS, ID', 'IL NONMETROPOLITAN AREA', 'IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'IOWA CITY, IA', 'JACKSON, MI', 'JACKSONVILLE, FL', 'JANESVILLE, WI', 'JEFFERSON CITY, MO', 'JOPLIN, MO', 'KALAMAZOO-PORTAGE, MI', 'KANKAKEE-BRADLEY, IL', 'KANSAS CITY, MO-KS', 'KENNEWICK-RICHLAND-PASCO,WA', 'KILLEEN-TEMPLE-FORT HOOD,TX', 'KOKOMO, IN', 'KS NONMETROPOLITAN AREA', 'LA CROSSE, WI-MN', 'LAFAYETTE, IN', 'LAKELAND, FL', 'LANSING-EAST LANSING, MI']) => 0.028654,
    (iv_msa_name in ['LAREDO, TX', 'LAS VEGAS-PARADISE, NV', 'LAWRENCE, KS', 'LEWISTON, ID-WA', 'LIMA, OH', 'LINCOLN, NE', 'LOGAN, UT-ID', 'LONGVIEW, TX', 'LONGVIEW, WA', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'LUBBOCK, TX', 'MADISON, WI', 'MANHATTAN, KS', 'MANKATO-NORTH MANKATO, MN', 'MANSFIELD, OH', 'MAYAGUEZ, PR', 'MCALLEN-EDINBURG-MISSION,TX', 'MEDFORD, OR', 'MI NONMETROPOLITAN AREA', 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL', 'MICHIGAN CITY-LA PORTE, IN', 'MIDLAND, TX'])                                => 0.028654,
    (iv_msa_name in ['MILWAUKEE-WAUKESHA-WEST ALLIS, WI', 'MINNEAPOLIS-ST. PAUL-BLOOMINGTON, MN-WI', 'MISSOULA, MT', 'MN NONMETROPOLITAN AREA', 'MO NONMETROPOLITAN AREA', 'MONROE, MI', 'MOUNT VERNON-ANACORTES, WA', 'MT NONMETROPOLITAN AREA', 'MUNCIE, IN', 'MUSKEGON-NORTON SHORES, MI', 'NAPLES-MARCO ISLAND, FL', 'ND NONMETROPOLITAN AREA', 'NE NONMETROPOLITAN AREA', 'NILES-BENTON HARBOR, MI', 'NV NONMETROPOLITAN AREA', 'OCALA, FL', 'ODESSA, TX', 'OGDEN-CLEARFIELD, UT', 'OH NONMETROPOLITAN AREA'])           => 0.028654,
    (iv_msa_name in ['OLYMPIA, WA', 'OMAHA-COUNCIL BLUFFS, NE-IA', 'OR NONMETROPOLITAN AREA', 'ORLANDO-KISSIMMEE, FL', 'OSHKOSH-NEENAH, WI', 'PALM BAY-MELBOURNE-TITUSVILLE, FL', 'PALM COAST, FL', 'PANAMA CITY-LYNN HAVEN, FL', 'PARKERSBURG-MARIETTA-VIENNA,WV-OH', 'PENSACOLA-FERRY PASS-BRENT,FL', 'PEORIA, IL', 'POCATELLO, ID', 'PONCE, PR', 'PORT ST. LUCIE, FL', 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'PR NONMETROPOLITAN AREA', 'PROVO-OREM, UT', 'PUEBLO, CO', 'PUNTA GORDA, FL', 'RACINE, WI'])                 => 0.028654,
    (iv_msa_name in ['RAPID CITY, SD', 'RENO-SPARKS, NV', 'ROCHESTER, MN', 'ROCKFORD, IL', 'SAGINAW-SAGINAW TOWNSHIPNORTH, MI', 'SALEM, OR', 'SALT LAKE CITY, UT', 'SAN ANGELO, TX', 'SAN ANTONIO, TX', 'SAN GERMAN-CABO ROJO, PR', 'SAN JUAN-CAGUAS-GUAYNABO,PR', 'SANDUSKY, OH', 'SARASOTA-BRADENTON-VENICE, FL', 'SD NONMETROPOLITAN AREA', 'SEATTLE-TACOMA-BELLEVUE,WA', 'SEBASTIAN-VERO BEACH, FL', 'SHEBOYGAN, WI', 'SHERMAN-DENISON, TX', 'SIOUX CITY, IA-NE-SD', 'SIOUX FALLS, SD', 'SOUTH BEND-MISHAWAKA, IN-MI'])   => 0.028654,
    (iv_msa_name in ['SPOKANE, WA', 'SPRINGFIELD, IL', 'SPRINGFIELD, MO', 'SPRINGFIELD, OH', 'ST. CLOUD, MN', 'ST. GEORGE, UT', 'ST. JOSEPH, MO-KS', 'ST. LOUIS, MO-IL', 'TALLAHASSEE, FL', 'TAMPA-ST. PETERSBURG-CLEARWATER, FL', 'TERRE HAUTE, IN', 'TEXARKANA, TX-TEXARKANA,AR', 'TOLEDO, OH', 'TOPEKA, KS', 'TX NONMETROPOLITAN AREA', 'TYLER, TX', 'UT NONMETROPOLITAN AREA', 'VI NONMETROPOLITAN AREA', 'VICTORIA, TX', 'WA NONMETROPOLITAN AREA', 'WACO, TX', 'WATERLOO-CEDAR FALLS, IA', 'WAUSAU, WI'])               => 0.028654,
    (iv_msa_name in ['WEIRTON-STEUBENVILLE, WV-OH', 'WENATCHEE, WA', 'WHEELING, WV-OH', 'WI NONMETROPOLITAN AREA', 'WICHITA FALLS, TX', 'WICHITA, KS', 'WY NONMETROPOLITAN AREA', 'YAKIMA, WA', 'YAUCO, PR', 'YOUNGSTOWN-WARREN-BOARDMAN,OH-PA'])                                                                                                                                                                                                                                                                             => 0.028654,
    (iv_msa_name in ['ALBANY-SCHENECTADY-TROY,NY', 'ALLENTOWN-BETHLEHEM-EASTON,PA-NJ', 'ALTOONA, PA', 'ATLANTIC CITY, NJ', 'BALTIMORE-TOWSON, MD', 'BANGOR, ME', 'BARNSTABLE TOWN, MA', 'BINGHAMTON, NY', 'BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'BRIDGEPORT-STAMFORD-NORWALK,CT', 'BUFFALO-NIAGARA FALLS, NY', 'BURLINGTON-SOUTH BURLINGTON,VT', 'CT NONMETROPOLITAN AREA', 'CUMBERLAND, MD-WV', 'ELMIRA, NY', 'ERIE, PA', 'GLENS FALLS, NY', 'HAGERSTOWN-MARTINSBURG, MD-WV', 'HARRISBURG-CARLISLE, PA'])                         => 0.105475,
    (iv_msa_name in ['HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'ITHACA, NY', 'JOHNSTOWN, PA', 'KINGSTON, NY', 'LANCASTER, PA', 'LEBANON, PA', 'LEWISTON-AUBURN, ME', 'MANCHESTER-NASHUA, NH', 'MD NONMETROPOLITAN AREA', 'ME NONMETROPOLITAN AREA', 'NEW HAVEN-MILFORD, CT', 'NEW YORK-NORTHERN NEW JERSEY', 'NH NONMETROPOLITAN AREA', 'NORWICH-NEW LONDON, CT', 'NY NONMETROPOLITAN AREA', 'OCEAN CITY, NJ', 'PA NONMETROPOLITAN AREA', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'PITTSBURGH, PA'])                  => 0.105475,
    (iv_msa_name in ['PITTSFIELD, MA', 'PORTLAND-SOUTH PORTLAND-BIDDEFORD, ME', 'POUGHKEEPSIE-NEWBURGH-MIDDLETOWN, NY', 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'READING, PA', 'ROCHESTER, NY', 'SALISBURY, MD', 'SCRANTON--WILKES-BARRE, PA', 'SPRINGFIELD, MA', 'STATE COLLEGE, PA', 'SYRACUSE, NY', 'TRENTON-EWING, NJ', 'UTICA-ROME, NY', 'VINELAND-MILLVILLE-BRIDGETON, NJ', 'VT NONMETROPOLITAN AREA', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV', 'WILLIAMSPORT, PA', 'WORCESTER, MA'])                         => 0.105475,
    (iv_msa_name in ['YORK-HANOVER, PA', 'YORK-NORTHERN NEW JERSEY-LONG ISLAND, NY-NJ-PA'])                                                                                                                                                                                                                                                                                                                                                                                                                                   => 0.105475,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 -0.000000);

all_subscore12 := map(
    NULL < iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 0 => 0.088569,
    0 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 1   => 0.014195,
    1 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 2   => -0.033354,
    2 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 4   => -0.181645,
    4 <= iv_max_ids_per_sfd_addr_c6                                      => -0.301277,
                                                                            0.000000);

all_subscore13 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.153148,
    2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => -0.028287,
    6 <= iv_pl002_addrs_15yr                               => -0.056893,
                                                              -0.000000);

all_subscore14 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.031688,
    1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => 0.135129,
    2 <= iv_src_property_adl_count                                     => 0.204369,
                                                                          -0.000000);

all_rawscore := all_subscore0 +
    all_subscore1 +
    all_subscore2 +
    all_subscore3 +
    all_subscore4 +
    all_subscore5 +
    all_subscore6 +
    all_subscore7 +
    all_subscore8 +
    all_subscore9 +
    all_subscore10 +
    all_subscore11 +
    all_subscore12 +
    all_subscore13 +
    all_subscore14;

all_lnoddsscore := all_rawscore + -0.262517;

all_probscore := exp(all_lnoddsscore) / (1 + exp(all_lnoddsscore));

base := 700;

point := 40;

odds := (1 - 0.568) / 0.568;

rvr1410_1_0 := map(
    (integer)rc_decsflag = 1  => 200,
    iv_riskview_222s => 222,
                        max(min(if(round(point * (ln(all_probscore / (1 - all_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(all_probscore / (1 - all_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));


glrc9i :=  iv_ed001_college_ind <> '' and (integer)iv_ed001_college_ind = 0 and age < 30;

glrc9y := (integer)truedid = 1 and pb_total_dollars = '' ;

glrc36 := 1;

glrc97 := (integer)truedid = 1 and criminal_count > 0;

glrcev := (integer)truedid = 1 and attr_eviction_count > 0;

glrc99 := (integer)truedid = 1;

glrc9h := (integer)truedid = 1 and impulse_count > 0;

glrc9w := (integer)truedid = 1 and filing_count > 0;

glrc9p := (integer)truedid = 1 and inq_HighRiskCredit_count12 > 0;

glrc9f := (integer)truedid = 1;

glrc9r := (integer)truedid = 1;

glrc9d := (integer)truedid = 1 and unique_addr_count > 1;

glrc9a := (integer)truedid = 1 and iv_src_property_adl_count < 1;

glrcbl := 0;

glrc9j := -1 < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 360;

rcvalue9i_1 := (integer)glrc9i * (0.716002 - all_subscore0);

rcvalue9i := if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9y_1 := (integer)glrc9y * (1.129586 - all_subscore1);

// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));
rcvalue9y := 0;

rcvalue36_1 := glrc36 * (0.271781 - all_subscore2);

rcvalue36 := if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

rcvalue97_1 := (integer)glrc97 * (0.035215 - all_subscore3);

rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalueev_1 := (integer)glrcev * (0.035118 - all_subscore4);

rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvalue99_1 := (integer)glrc99 * (0.105806 - all_subscore5);

rcvalue99 := if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

rcvalue9h_1 := (integer)glrc9h * (0.033362 - all_subscore6);

rcvalue9h := if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9w_1 := (integer)glrc9w * (0.544161 - all_subscore7);

rcvalue9w := if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvalue9p_1 := (integer)glrc9p * (0.019082 - all_subscore8);

rcvalue9p := if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9f_1 := (integer)glrc9f * (0.255547 - all_subscore9);

rcvalue9f := if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

rcvalue9r_1 := (integer)glrc9r * (0.076165 - all_subscore10);

rcvalue9r := if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

rcvalue9d_1 := (integer)glrc9d * (0.153148 - all_subscore13);

rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9a_1 := (integer)glrc9a * (0.204369 - all_subscore14);

rcvalue9a := if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvaluebl_1 := glrcbl * (0.105475 - all_subscore11);

rcvaluebl_2 := glrcbl * (0.088569 - all_subscore12);

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'9I', RCValue9I},
    {'9Y', RCValue9Y},
    {'36', RCValue36},
    {'97', RCValue97},
    {'EV', RCValueEV},
    {'99', RCValue99},
    {'9H', RCValue9H},
    {'9W', RCValue9W},
    {'9P', RCValue9P},
    {'9F', RCValue9F},
    {'9R', RCValue9R},
    {'9D', RCValue9D},
    {'9A', RCValue9A},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
// I'll leave the implementation details to the Engineers.
//*************************************************************************************//

rc_dataset_sorted := sort(rc_dataset, -rc_dataset.value);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top 4 reason codes

rcs_9p5 := IF(glrc9p and RCValue9P > 0  AND NOT EXISTS(rcs_top4 (rc in ['9P'])),  	// Check to see if RC 9P is a part of the score, but not in the first 4 RC's
								ROW({'9P', NULL}, ds_layout), ROW({' ', NULL}, ds_layout)); 																				// If so - make it the 5th reason code.
	
rcs_9p := rcs_top4 & rcs_9p5;	


rcs_override := MAP(
											rvr1410_1_0 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvr1410_1_0 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvr1410_1_0 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
																											 rcs_9p
										 );

rcs_1:= if(rcs_override[1].rc = ' ', ROW({'36', NULL}, ds_layout), rcs_override[1]);

rcs_2 := map(
           rcs_override[2].rc= ' '  and not(rcs_1.rc in ['02', '9X', '35', '36', '91', '92', '93', '94'])   =>ROW({'36', NULL}, ds_layout), 

            rcs_override[2].rc = ' ' and not(rcs_1.rc in ['02', '9X', '35', '91', '92', '93', '94']) and (integer)glrc9j = 1 => ROW({'9J', NULL}, ds_layout),
						              
													                                                                               rcs_override[2]);
rcs_3 := if(rcs_override[3].rc = ' ' and  not(rcs_2.rc in [' ', '9J']) and (integer)glrc9j = 1, ROW({'9J', NULL}, ds_layout), rcs_override[3]);

rcs:= rcs_1 & rcs_2 & rcs_3 & rcs_override[4] &rcs_override[5];

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		
		rcs_final := PROJECT(rcs, TRANSFORM(Risk_Indicators.Layout_Desc,
					SELF.hri := LEFT.rc,
					SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
				));

		inCalif := isCalifornia AND (
					(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
					+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
					+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
				
		ri := MAP(
							riTemp[1].hri <> '00' => riTemp,
							inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
							rcs_final
							);
						
		zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
		
		reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes


	//Intermediate variables
		#if(RVR_DEBUG)
			              self.clam														 := le;
	                     self.sysdate                          := sysdate;
                    self.iv_pots_phone                    := iv_pots_phone;
                    self.iv_add_apt                       := iv_add_apt;
                    self.iv_riskview_222s                 := iv_riskview_222s;
                    self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
                    self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
                    self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
                    self.prop_adl_p_count_pos             := prop_adl_p_count_pos;
                    self.prop_adl_count_p                 := prop_adl_count_p;
                    self._src_prop_adl_count              := _src_prop_adl_count;
                    self.iv_src_property_adl_count        := iv_src_property_adl_count;
                    self.vote_adl_vo_lseen_pos            := vote_adl_vo_lseen_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self._src_vote_adl_lseen              := _src_vote_adl_lseen;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.iv_best_match_address            := iv_best_match_address;
                    self._gong_did_first_seen             := _gong_did_first_seen;
                    self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
                    self.iv_max_ids_per_sfd_addr_c6       := iv_max_ids_per_sfd_addr_c6;
                    self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
                    self.ver_phn_inf                      := ver_phn_inf;
                    self.ver_phn_nap                      := ver_phn_nap;
                    self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
                    self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
                    self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
                    self._impulse_last_seen               := _impulse_last_seen;
                    self.iv_mos_since_impulse_last_seen   := iv_mos_since_impulse_last_seen;
                    self.iv_criminal_x_felony             := iv_criminal_x_felony;
                    self._reported_dob                    := _reported_dob;
                    self.reported_age                     := reported_age;
                    self._combined_age                    := _combined_age;
                    self.evidence_of_college              := evidence_of_college;
                    self.iv_college_attendance_x_age      := iv_college_attendance_x_age;
                    self.iv_pb_total_orders               := iv_pb_total_orders;
                    self.iv_msa_name                      := iv_msa_name;
                    self.iv_ed001_college_ind             := iv_ed001_college_ind;
                    self._header_first_seen               := _header_first_seen;
                    self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
                    self.all_subscore0                    := all_subscore0;
                    self.all_subscore1                    := all_subscore1;
                    self.all_subscore2                    := all_subscore2;
                    self.all_subscore3                    := all_subscore3;
                    self.all_subscore4                    := all_subscore4;
                    self.all_subscore5                    := all_subscore5;
                    self.all_subscore6                    := all_subscore6;
                    self.all_subscore7                    := all_subscore7;
                    self.all_subscore8                    := all_subscore8;
                    self.all_subscore9                    := all_subscore9;
                    self.all_subscore10                   := all_subscore10;
                    self.all_subscore11                   := all_subscore11;
                    self.all_subscore12                   := all_subscore12;
                    self.all_subscore13                   := all_subscore13;
                    self.all_subscore14                   := all_subscore14;
                    self.all_rawscore                     := all_rawscore;
                    self.all_lnoddsscore                  := all_lnoddsscore;
                    self.all_probscore                    := all_probscore;
                    self.base                             := base;
                    self.point                            := point;
                    self.odds                             := odds;
                    self.rvr1410_1_0                      := rvr1410_1_0;
                    self.glrc9i                           := glrc9i;
                    self.glrc9y                           := glrc9y;
                    self.glrc36                           := glrc36;
                    self.glrc97                           := glrc97;
                    self.glrcev                           := glrcev;
                    self.glrc99                           := glrc99;
                    self.glrc9h                           := glrc9h;
                    self.glrc9w                           := glrc9w;
                    self.glrc9p                           := glrc9p;
                    self.glrc9f                           := glrc9f;
                    self.glrc9r                           := glrc9r;
                    self.glrc9d                           := glrc9d;
                    self.glrc9a                           := glrc9a;
                    self.glrcbl                           := glrcbl;
                    self.glrc9j                           := glrc9j;
                    self.rcvalue9i_1                      := rcvalue9i_1;
                    self.rcvalue9i                        := rcvalue9i;
                    self.rcvalue9y_1                      := rcvalue9y_1;
                    self.rcvalue9y                        := rcvalue9y;
                    self.rcvalue36_1                      := rcvalue36_1;
                    self.rcvalue36                        := rcvalue36;
                    self.rcvalue97_1                      := rcvalue97_1;
                    self.rcvalue97                        := rcvalue97;
                    self.rcvalueev_1                      := rcvalueev_1;
                    self.rcvalueev                        := rcvalueev;
                    self.rcvalue99_1                      := rcvalue99_1;
                    self.rcvalue99                        := rcvalue99;
                    self.rcvalue9h_1                      := rcvalue9h_1;
                    self.rcvalue9h                        := rcvalue9h;
                    self.rcvalue9w_1                      := rcvalue9w_1;
                    self.rcvalue9w                        := rcvalue9w;
                    self.rcvalue9p_1                      := rcvalue9p_1;
                    self.rcvalue9p                        := rcvalue9p;
                    self.rcvalue9f_1                      := rcvalue9f_1;
                    self.rcvalue9f                        := rcvalue9f;
                    self.rcvalue9r_1                      := rcvalue9r_1;
                    self.rcvalue9r                        := rcvalue9r;
                    self.rcvalue9d_1                      := rcvalue9d_1;
                    self.rcvalue9d                        := rcvalue9d;
                    self.rcvalue9a_1                      := rcvalue9a_1;
                    self.rcvalue9a                        := rcvalue9a;
                    self.rcvaluebl_1                      := rcvaluebl_1;
                    self.rcvaluebl_2                      := rcvaluebl_2;
                    self.rcvaluebl                        := rcvaluebl;
                    self.rc5                              := rcs[5].rc;
                    self.rc4                              := rcs[4].rc;
                    self.rc3                              := rcs[3].rc;
                    self.rc2                              := rcs[2].rc;
                    self.rc1                              := rcs[1].rc;
                                      

		#end
			SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																								SELF.hri := if(LEFT.hri='', '00', left.hri),
																								SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																						));
			self.seq := le.seq;
			
			self.score := MAP(
												reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
												reasons[1].hri='35' => '100',
												(string3) RVR1410_1_0
											);
		END;

		model := project( clam, doModel(left) );

		return model;
	END;

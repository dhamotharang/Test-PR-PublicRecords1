//Strategic Link Consulting Score - VIP customers

import risk_indicators, riskwise, riskwisefcra, ut, riskview;

export RVG1304_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := false;

  #if(RVG_DEBUG)
    layout_debug := record
			boolean email_src_im                     ; //email_src_im;
			integer iv_ds001_impulse_count           ; //iv_ds001_impulse_count;
			integer iv_ms001_ssns_per_adl            ; //iv_ms001_ssns_per_adl;
			integer iv_pl002_addrs_per_ssn_c6        ; //iv_pl002_addrs_per_ssn_c6;
			integer iv_in001_estimated_income        ; //iv_in001_estimated_income;
			integer iv_iq001_inq_count12             ; //iv_iq001_inq_count12;
			integer iv_dob_score                     ; //iv_dob_score;
			integer iv_inp_addr_mortgage_amount      ; //iv_inp_addr_mortgage_amount;
			integer iv_prop_owned_assessed_total     ; //iv_prop_owned_assessed_total;
			integer iv_addrs_10yr                    ; //iv_addrs_10yr;
			integer iv_recent_disconnects            ; //iv_recent_disconnects;
			integer iv_gong_did_phone_ct             ; //iv_gong_did_phone_ct;
			integer iv_adls_per_addr                 ; //iv_adls_per_addr;
			integer iv_inq_highriskcredit_recency    ; //iv_inq_highriskcredit_recency;
			boolean ver_phn_inf                      ; //ver_phn_inf;
			boolean ver_phn_nap                      ; //ver_phn_nap;
			string  inf_phn_ver_lvl                  ; //inf_phn_ver_lvl;
			string  nap_phn_ver_lvl                  ; //nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; //iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_email_domain_free_count       ; //iv_email_domain_free_count;
			integer iv_derog_diff                    ; //iv_derog_diff;
			string  iv_ams_college_code              ; //iv_ams_college_code;
			integer iv_pb_total_orders               ; //iv_pb_total_orders;
			real    subscore0                        ; //subscore0;
			real    subscore1                        ; //subscore1;
			real    subscore2                        ; //subscore2;
			real    subscore3                        ; //subscore3;
			real    subscore4                        ; //subscore4;
			real    subscore5                        ; //subscore5;
			real    subscore6                        ; //subscore6;
			real    subscore7                        ; //subscore7;
			real    subscore8                        ; //subscore8;
			real    subscore9                        ; //subscore9;
			real    subscore10                       ; //subscore10;
			real    subscore11                       ; //subscore11;
			real    subscore12                       ; //subscore12;
			real    subscore13                       ; //subscore13;
			real    subscore14                       ; //subscore14;
			real    subscore15                       ; //subscore15;
			real    subscore16                       ; //subscore16;
			real    subscore17                       ; //subscore17;
			real    rawscore                         ; //rawscore;
			real    lnoddsscore                      ; //lnoddsscore;
			real    probscore                        ; //probscore;
			integer base                             ; //base;
			integer point                            ; //point;
			real    odds                             ; //odds;
			boolean iv_riskview_222s                 ; //iv_riskview_222s;
			boolean iv_ssn_deceased                  ; //iv_ssn_deceased;
			integer rvg1304_1                        ; //rvg1304_1;
			integer iv_combined_age                  ; //iv_combined_age;
			boolean bk_flag                          ; //bk_flag;
			boolean crim_flag                        ; //crim_flag;
			boolean lien_flag                        ; //lien_flag;
			integer iv_pots_phone                    ; //iv_pots_phone;
			boolean glrc9h                           ; //glrc9h;
			boolean glrc9p                           ; //glrc9p;
			boolean glrc9m                           ; //glrc9m;
			boolean glrc9o                           ; //glrc9o;
			boolean glrcms                           ; //glrcms;
			boolean glrc9q                           ; //glrc9q;
			boolean glrc9d                           ; //glrc9d;
			boolean glrc9i                           ; //glrc9i;
			boolean glrc07                           ; //glrc07;
			boolean glrcpv                           ; //glrcpv;
			boolean glrc28                           ; //glrc28;
			boolean glrc9a                           ; //glrc9a;
			boolean glrc9w                           ; //glrc9w;
			boolean glrc97                           ; //glrc97;
			boolean glrc98                           ; //glrc98;
			boolean glrc9e                           ; //glrc9e;
			boolean glrcbl                           ; //glrcbl;
			real    rcvalue9h_1                      ; //rcvalue9h_1;
			real    rcvalue9h                        ; //rcvalue9h;
			real    rcvalue9p_1                      ; //rcvalue9p_1;
			real    rcvalue9p                        ; //rcvalue9p;
			real    rcvalue9m_1                      ; //rcvalue9m_1;
			real    rcvalue9m                        ; //rcvalue9m;
			real    rcvalue9o_1                      ; //rcvalue9o_1;
			real    rcvalue9o_2                      ; //rcvalue9o_2;
			real    rcvalue9o                        ; //rcvalue9o;
			real    rcvaluems_1                      ; //rcvaluems_1;
			real    rcvaluems                        ; //rcvaluems;
			real    rcvalue9q_1                      ; //rcvalue9q_1;
			real    rcvalue9q                        ; //rcvalue9q;
			real    rcvalue9d_1                      ; //rcvalue9d_1;
			real    rcvalue9d_2                      ; //rcvalue9d_2;
			real    rcvalue9d                        ; //rcvalue9d;
			real    rcvalue9i_1                      ; //rcvalue9i_1;
			real    rcvalue9i                        ; //rcvalue9i;
			real    rcvalue07_1                      ; //rcvalue07_1;
			real    rcvalue07                        ; //rcvalue07;
			real    rcvaluepv_1                      ; //rcvaluepv_1;
			real    rcvaluepv                        ; //rcvaluepv;
			real    rcvalue9a_1                      ; //rcvalue9a_1;
			real    rcvalue9a                        ; //rcvalue9a;
			real    rcvalue28_1                      ; //rcvalue28_1;
			real    rcvalue28                        ; //rcvalue28;
			real    rcvalue9e_1                      ; //rcvalue9e_1;
			real    rcvalue9e                        ; //rcvalue9e;
			real    rcvalue98_1                      ; //rcvalue98_1;
			real    rcvalue98                        ; //rcvalue98;
			real    rcvalue9w_1                      ; //rcvalue9w_1;
			real    rcvalue9w                        ; //rcvalue9w;
			real    rcvalue97_1                      ; //rcvalue97_1;
			real    rcvalue97                        ; //rcvalue97;
			real    rcvaluebl_1                      ; //rcvaluebl_1;
			real    rcvaluebl_2                      ; //rcvaluebl_2;
			real    rcvaluebl_3                      ; //rcvaluebl_3;
			real    rcvaluebl_4                      ; //rcvaluebl_4;
			real    rcvaluebl                        ; //rcvaluebl;
			string  rc1                              ; //rc1;
			string  rc2                              ; //rc2;
			string  rc3                              ; //rc3;
			string  rc4                              ; //rc4;
			string  rc5                              ; //rc5;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end

	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	telcordia_type                   := le.phone_verification.telcordia_type;
	recent_disconnects               := le.phone_verification.recent_disconnects;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im 		 => 1,
                                              impulse_count);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_pl002_addrs_per_ssn_c6 := if(not((integer)ssnlength > 0), NULL, addrs_per_ssn_c6);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

iv_dob_score := if(not(truedid and dobpop), NULL, combo_dobscore);

iv_inp_addr_mortgage_amount := if(not(add1_pop), NULL, add1_mortgage_amount);

iv_prop_owned_assessed_total := if(not(truedid or add1_pop), NULL, property_owned_assessed_total);

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_recent_disconnects := if(not(hphnpop), NULL, recent_disconnects);

iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

iv_adls_per_addr := if(not(add1_pop), NULL, adls_per_addr);

iv_inq_highriskcredit_recency := map(
    not(truedid)               		=> NULL,
    inq_highRiskCredit_count01 >0 => 1,
    inq_highRiskCredit_count03 >0 => 3,
    inq_highRiskCredit_count06 >0 => 6,
    inq_highRiskCredit_count12 >0 => 12,
    inq_highRiskCredit_count24 >0 => 24,
    inq_highRiskCredit_count   >0 => 99,
																		 0);

ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl := map(
    ver_phn_inf     => '3',
    infutor_nap = 1 => '1',
    infutor_nap = 0 => '0',
                       '2');

nap_phn_ver_lvl := map(
    ver_phn_nap     => '3',
    nap_summary = 1 => '1',
    nap_summary = 0 => '0',
                       '2');

iv_nap_phn_ver_x_inf_phn_ver := map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim(nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(inf_phn_ver_lvl, LEFT, RIGHT));

iv_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_ams_college_code := map(
    not(truedid)            => '  ',
    ams_college_code = ''	 	=> '-1',
                               trim(ams_college_code, LEFT));

iv_pb_total_orders := map(
    not(truedid)           				=> NULL,
    (integer)pb_total_orders = 0 	=> -1,
																		 (integer)pb_total_orders);

subscore0 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.179793,
    1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.248530,
    2 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 3   => -0.509684,
    3 <= iv_ds001_impulse_count                                  => -0.728212,
                                                                    -0.000000);

subscore1 := map(
    NULL < iv_derog_diff AND iv_derog_diff < -2 => -0.347831,
    -2 <= iv_derog_diff AND iv_derog_diff < 1   => -0.136677,
    1 <= iv_derog_diff AND iv_derog_diff < 2    => -0.041820,
    2 <= iv_derog_diff AND iv_derog_diff < 4    => 0.000306,
    4 <= iv_derog_diff AND iv_derog_diff < 5    => 0.205580,
    5 <= iv_derog_diff                          => 0.456769,
                                                   0.000000);

subscore2 := map(
    (iv_inq_highriskcredit_recency in [1, 3]) => -0.354123,
    (iv_inq_highriskcredit_recency in [6])    => -0.243342,
    (iv_inq_highriskcredit_recency in [12])   => -0.052401,
    (iv_inq_highriskcredit_recency in [0])    => 0.070115,
                                                 0.000000);

subscore3 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 1       => 0.000000,
    1 <= iv_in001_estimated_income AND iv_in001_estimated_income < 22000     => -0.275502,
    22000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 33000 => -0.101844,
    33000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 39000 => 0.121269,
    39000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 68000 => 0.148813,
    68000 <= iv_in001_estimated_income                                       => 0.212346,
                                                                                0.000000);

subscore4 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                                                 => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-1', '3-3']) => -0.086527,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3'])                                                                => 0.175079,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                                => 0.241809,
                                                                                                                0.000000);

subscore5 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.148754,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => -0.034726,
    4 <= iv_pb_total_orders AND iv_pb_total_orders < 5   => 0.033955,
    5 <= iv_pb_total_orders AND iv_pb_total_orders < 11  => 0.137740,
    11 <= iv_pb_total_orders                             => 0.213969,
                                                            0.000000);

subscore6 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.043096,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.015754,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.130677,
    4 <= iv_ms001_ssns_per_adl                                 => -0.710083,
                                                                  0.000000);

subscore7 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.040003,
    1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => 0.019650,
    2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 5   => -0.002376,
    5 <= iv_iq001_inq_count12                                => -0.472125,
                                                                0.000000);

subscore8 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => -0.000000,
    0 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => 0.110338,
    3 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => 0.061593,
    4 <= iv_addrs_10yr AND iv_addrs_10yr < 7   => -0.005401,
    7 <= iv_addrs_10yr AND iv_addrs_10yr < 10  => -0.161006,
    10 <= iv_addrs_10yr                        => -0.298428,
                                                  -0.000000);

subscore9 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr < 1 => 0.026668,
    1 <= iv_adls_per_addr AND iv_adls_per_addr < 2   => -0.048537,
    2 <= iv_adls_per_addr AND iv_adls_per_addr < 3   => 0.395656,
    3 <= iv_adls_per_addr AND iv_adls_per_addr < 6   => 0.079469,
    6 <= iv_adls_per_addr AND iv_adls_per_addr < 10  => 0.061051,
    10 <= iv_adls_per_addr AND iv_adls_per_addr < 15 => 0.047305,
    15 <= iv_adls_per_addr AND iv_adls_per_addr < 22 => -0.041544,
    22 <= iv_adls_per_addr AND iv_adls_per_addr < 35 => -0.097202,
    35 <= iv_adls_per_addr                           => -0.282572,
                                                        -0.000000);

subscore10 := map(
    (iv_ams_college_code in ['Other'])  => -0.000000,
    (iv_ams_college_code in ['-1'])     => -0.033931,
    (iv_ams_college_code in ['2'])      => 0.138233,
    (iv_ams_college_code in ['1', '4']) => 0.351233,
                                           -0.000000);

subscore11 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.112163,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => 0.015839,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 4   => -0.034776,
    4 <= iv_email_domain_free_count AND iv_email_domain_free_count < 5   => -0.168273,
    5 <= iv_email_domain_free_count                                      => -0.220316,
                                                                            0.000000);

subscore12 := map(
    NULL < iv_recent_disconnects AND iv_recent_disconnects < 1 => 0.024710,
    1 <= iv_recent_disconnects                                 => -0.324230,
                                                                  0.000000);

subscore13 := map(
    NULL < iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount < 1         => -0.003547,
    1 <= iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount < 68960       => -0.213937,
    68960 <= iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount < 101533  => -0.006075,
    101533 <= iv_inp_addr_mortgage_amount AND iv_inp_addr_mortgage_amount < 151525 => 0.015509,
    151525 <= iv_inp_addr_mortgage_amount                                          => 0.141912,
                                                                                      0.000000);

subscore14 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 1 => 0.064536,
    1 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 2   => 0.021864,
    2 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3   => -0.104275,
    3 <= iv_gong_did_phone_ct                                => -0.150942,
                                                                -0.000000);

subscore15 := map(
    NULL < iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total < 1        => -0.007549,
    1 <= iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total < 90930      => -0.183151,
    90930 <= iv_prop_owned_assessed_total AND iv_prop_owned_assessed_total < 154865 => 0.026833,
    154865 <= iv_prop_owned_assessed_total                                          => 0.179475,
                                                                                       0.000000);

subscore16 := map(
    NULL < iv_dob_score AND iv_dob_score < 100 => -0.271957,
    100 <= iv_dob_score AND iv_dob_score < 255 => 0.014017,
    255 <= iv_dob_score                        => 0.000000,
                                                  0.000000);

subscore17 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 < 1 => 0.014862,
    1 <= iv_pl002_addrs_per_ssn_c6                                     => -0.238391,
                                                                          0.000000);

rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6 +
    subscore7 +
    subscore8 +
    subscore9 +
    subscore10 +
    subscore11 +
    subscore12 +
    subscore13 +
    subscore14 +
    subscore15 +
    subscore16 +
    subscore17;

lnoddsscore := rawscore + 0.238227;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

point := 40;

odds := (1 - 0.437) / 0.437;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_ssn_deceased := rc_decsflag = '1' or contains_i(ver_sources, 'DS') > 0;

rvg1304_1 := map(
    iv_ssn_deceased     => 200,
    iv_riskview_222s    => 222,
                           min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

iv_combined_age := map(
    not(truedid or dobpop) 					=> NULL,
    age > 0                					=> age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       					=> inferred_age,
    (integer)ams_age > 0            => (integer)ams_age,
																			 -1);

bk_flag := filing_count > 0;

crim_flag := criminal_count > 0;

lien_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

iv_pots_phone := if((telcordia_type in ['00', '50', '51', '52', '54']), 1, 0);

glrc9h := truedid and impulse_count > 0;

glrc9p := truedid and inq_highriskcredit_count12 > 0;

glrc9m := truedid and 0 < estimated_income AND estimated_income < 26000;

glrc9o := hphnpop and addrpop and (nap_summary in [0, 1, 2, 3, 4]) and iv_pots_phone = 1;

glrcms := truedid and ssns_per_adl > 2;

glrc9q := truedid and inq_count12 > 0;

glrc9d := truedid and (addrs_10yr > 4 or addrs_per_ssn_c6 > 0);

glrc9i := truedid and 0 < iv_combined_age AND iv_combined_age < 30 and not((ams_college_code in ['1', '2', '4']));

glrc07 := hphnpop and (rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D');

glrcpv := truedid and property_owned_assessed_count > 0;

glrc28 := truedid and dobpop and combo_dobscore != 255;

glrc9a := truedid and property_owned_total = 0 and (add1_naprop in [0, 1, 2]);

glrc9w := truedid and bankrupt;

glrc97 := truedid and criminal_count > 0;

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc9e := truedid and addrpop and attr_total_number_derogs = 0 and attr_num_nonderogs < 4;

glrcbl := 0;

rcvalue9h_1 := 0.179793 - subscore0;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9p_1 := 0.070115 - subscore2;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9m_1 := 0.212346 - subscore3;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9o_1 := 0.241809 - subscore4;

rcvalue9o_2 := 0.064536 - subscore14;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1, rcvalue9o_2) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1), if(rcvalue9o_2 = NULL, 0, rcvalue9o_2)));

rcvaluems_1 := 0.043096 - subscore6;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalue9q_1 := 0.040003 - subscore7;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9d_1 := 0.110338 - subscore8;

rcvalue9d_2 := 0.014862 - subscore17;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

rcvalue9i_1 := 0.351233 - subscore10;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue07_1 := 0.02471 - subscore12;

rcvalue07 := (integer)glrc07 * if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));

rcvaluepv_1 := 0.179475 - subscore15;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvalue9a_1 := 0.179475 - subscore15;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue28_1 := 0.014017 - subscore16;

rcvalue28 := (integer)glrc28 * if(max(rcvalue28_1) = NULL, NULL, sum(if(rcvalue28_1 = NULL, 0, rcvalue28_1)));

rcvalue9e_1 := 0.456769 - subscore1;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue98_1 := if(lien_flag, (integer)lien_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.456769 - subscore1), 0);

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9w_1 := if(bk_flag, (integer)bk_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.456769 - subscore1), 0);

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvalue97_1 := if(crim_flag, (integer)crim_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.456769 - subscore1), 0);

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvaluebl_1 := 0.213969 - subscore5;

rcvaluebl_2 := 0.395656 - subscore9;

rcvaluebl_3 := 0.112163 - subscore11;

rcvaluebl_4 := 0.141912 - subscore13;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
    {'9H', RCValue9H},
    {'9P', RCValue9P},
    {'9M', RCValue9M},
    {'9O', RCValue9O},
    {'MS', RCValueMS},
    {'9Q', RCValue9Q},
    {'9D', RCValue9D},
    {'9I', RCValue9I},
    {'07', RCValue07},
    {'PV', RCValuePV},
    {'9A', RCValue9A},
    {'28', RCValue28},
    {'9E', RCValue9E},
    {'98', RCValue98},
    {'9W', RCValue9W},
    {'97', RCValue97},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9q1 := rcs_top4[1];
	rcs_9q2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'], 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9q3 := rcs_top4[3];
	rcs_9q4 := rcs_top4[4];
	rcs_9q5 := IF(glrc9q and inq_count12 > 0 AND NOT EXISTS(rcs_top4 (rc in ['9P', '9Q'])),  	// Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								ROW({'9Q', NULL}, ds_layout)); 																										// If so - make it the 5th reason code.
	
	
	rcs_9q := rcs_9q1 & rcs_9q2 & rcs_9q3 & rcs_9q4 & rcs_9q5;

	rcs_override := MAP(
											rvg1304_1 = 200 							=> DATASET([{'02', NULL}], ds_layout),
											rvg1304_1 = 222 							=> DATASET([{'9X', NULL}], ds_layout),
											rvg1304_1 = 900 							=> DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9q(rc != '')) 	=> DATASET([{'36', NULL}], ds_layout),
																											 rcs_9q
										 );

	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVG_DEBUG)
	  self.clam															:= le;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_pl002_addrs_per_ssn_c6        := iv_pl002_addrs_per_ssn_c6;
		self.iv_in001_estimated_income        := iv_in001_estimated_income;
		self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
		self.iv_dob_score                     := iv_dob_score;
		self.iv_inp_addr_mortgage_amount      := iv_inp_addr_mortgage_amount;
		self.iv_prop_owned_assessed_total     := iv_prop_owned_assessed_total;
		self.iv_addrs_10yr                    := iv_addrs_10yr;
		self.iv_recent_disconnects            := iv_recent_disconnects;
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
		self.iv_adls_per_addr                 := iv_adls_per_addr;
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_email_domain_free_count       := iv_email_domain_free_count;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_ams_college_code              := iv_ams_college_code;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.subscore0                        := subscore0;
		self.subscore1                        := subscore1;
		self.subscore2                        := subscore2;
		self.subscore3                        := subscore3;
		self.subscore4                        := subscore4;
		self.subscore5                        := subscore5;
		self.subscore6                        := subscore6;
		self.subscore7                        := subscore7;
		self.subscore8                        := subscore8;
		self.subscore9                        := subscore9;
		self.subscore10                       := subscore10;
		self.subscore11                       := subscore11;
		self.subscore12                       := subscore12;
		self.subscore13                       := subscore13;
		self.subscore14                       := subscore14;
		self.subscore15                       := subscore15;
		self.subscore16                       := subscore16;
		self.subscore17                       := subscore17;
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_ssn_deceased                  := iv_ssn_deceased;
		self.rvg1304_1                        := rvg1304_1;
		self.iv_combined_age                  := iv_combined_age;
		self.bk_flag                          := bk_flag;
		self.crim_flag                        := crim_flag;
		self.lien_flag                        := lien_flag;
		self.iv_pots_phone                    := iv_pots_phone;
		self.glrc9h                           := glrc9h;
		self.glrc9p                           := glrc9p;
		self.glrc9m                           := glrc9m;
		self.glrc9o                           := glrc9o;
		self.glrcms                           := glrcms;
		self.glrc9q                           := glrc9q;
		self.glrc9d                           := glrc9d;
		self.glrc9i                           := glrc9i;
		self.glrc07                           := glrc07;
		self.glrcpv                           := glrcpv;
		self.glrc28                           := glrc28;
		self.glrc9a                           := glrc9a;
		self.glrc9w                           := glrc9w;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.glrc9e                           := glrc9e;
		self.glrcbl                           := glrcbl;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9p_1                      := rcvalue9p_1;
		self.rcvalue9p                        := rcvalue9p;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o_2                      := rcvalue9o_2;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d_2                      := rcvalue9d_2;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue07_1                      := rcvalue07_1;
		self.rcvalue07                        := rcvalue07;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue28_1                      := rcvalue28_1;
		self.rcvalue28                        := rcvalue28;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := reasons[1].hri;
		self.rc2                              := reasons[2].hri;
		self.rc3                              := reasons[3].hri;
		self.rc4                              := reasons[4].hri;
		self.rc5                              := reasons[5].hri;
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVG1304_1
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;

//DM Services - Custom 4.0 RV Score

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVR1210_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  RVR_DEBUG := false;

  #if(RVR_DEBUG)
    layout_debug := record
			integer sysdate                          ; // sysdate;
			boolean iv_truedid                       ; // iv_truedid;
			integer iv_src_bureau_addr_count         ; // iv_src_bureau_addr_count;
			integer _reported_dob                    ; // _reported_dob;
			integer reported_age                     ; // reported_age;
			integer iv_combined_age                  ; // iv_combined_age;
			integer iv_inp_addr_avm_auto_val         ; // iv_inp_addr_avm_auto_val;
			integer iv_inp_addr_naprop               ; // iv_inp_addr_naprop;
			integer _gong_did_first_seen             ; // _gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen   ; // iv_mos_since_gong_did_fst_seen;
			integer iv_gong_did_phone_ct             ; // iv_gong_did_phone_ct;
			integer _header_first_seen               ; // _header_first_seen;
			integer iv_mos_since_header_fst_seen     ; // iv_mos_since_header_fst_seen;
			integer iv_ssns_per_adl                  ; // iv_ssns_per_adl;
			integer iv_adls_per_addr                 ; // iv_adls_per_addr;
			integer iv_invalid_addrs_per_adl_c6      ; // iv_invalid_addrs_per_adl_c6;
			integer iv_inq_highriskcredit_count12    ; // iv_inq_highriskcredit_count12;
			integer iv_inq_retail_count12            ; // iv_inq_retail_count12;
			integer iv_infutor_nap                   ; // iv_infutor_nap;
			boolean ver_phn_inf                      ; // ver_phn_inf;
			boolean ver_phn_nap                      ; // ver_phn_nap;
			integer inf_phn_ver_lvl                  ; // inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ; // nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; // iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_impulse_recency               ; // iv_impulse_recency;
			integer iv_email_domain_free_count       ; // iv_email_domain_free_count;
			integer iv_derog_diff                    ; // iv_derog_diff;
			string  iv_bk_disposition_lvl            ; // iv_bk_disposition_lvl;
			integer iv_liens_unrel_lt_ct             ; // iv_liens_unrel_lt_ct;
			integer iv_liens_unrel_sc_ct             ; // iv_liens_unrel_sc_ct;
			integer iv_criminal_count                ; // iv_criminal_count;
			integer iv_prof_license_flag             ; // iv_prof_license_flag;
			integer iv_wealth_index                  ; // iv_wealth_index;
			integer iv_pb_total_dollars              ; // iv_pb_total_dollars;
			integer iv_pb_total_orders               ; // iv_pb_total_orders;
			real    subscore0                        ; // subscore0;
			real    subscore1                        ; // subscore1;
			real    subscore2                        ; // subscore2;
			real    subscore3                        ; // subscore3;
			real    subscore4                        ; // subscore4;
			real    subscore5                        ; // subscore5;
			real    subscore6                        ; // subscore6;
			real    subscore7                        ; // subscore7;
			real    subscore8                        ; // subscore8;
			real    subscore9                        ; // subscore9;
			real    subscore10                       ; // subscore10;
			real    subscore11                       ; // subscore11;
			real    subscore12                       ; // subscore12;
			real    subscore13                       ; // subscore13;
			real    subscore14                       ; // subscore14;
			real    subscore15                       ; // subscore15;
			real    subscore16                       ; // subscore16;
			real    subscore17                       ; // subscore17;
			real    subscore18                       ; // subscore18;
			real    subscore19                       ; // subscore19;
			real    subscore20                       ; // subscore20;
			real    subscore21                       ; // subscore21;
			real    subscore22                       ; // subscore22;
			real    subscore23                       ; // subscore23;
			real    subscore24                       ; // subscore24;
			real    subscore25                       ; // subscore25;
			real    rawscore                         ; // rawscore;
			real    lnoddsscore                      ; // lnoddsscore;
			real    probscore                        ; // probscore;
			boolean ssn_deceased                     ; // ssn_deceased;
			boolean riskview_222s                    ; // riskview_222s;
			integer base                             ; // base;
			integer point                            ; // point;
			real    odds                             ; // odds;
			integer rvr1210_1_0                      ; // rvr1210_1_0;
			boolean glrc36_1                         ; // glrc36_1;
			boolean glrc36_2                         ; // glrc36_2;
			boolean glrc97                           ; // glrc97;
			boolean glrc98                           ; // glrc98;
			boolean glrc9a                           ; // glrc9a;
			boolean glrc9g                           ; // glrc9g;
			boolean glrc9h                           ; // glrc9h;
			boolean glrc9m                           ; // glrc9m;
			boolean glrc9o                           ; // glrc9o;
			boolean glrc9q                           ; // glrc9q;
			boolean glrc9r                           ; // glrc9r;
			boolean glrc9w                           ; // glrc9w;
			boolean glrc9y                           ; // glrc9y;
			boolean glrcms                           ; // glrcms;
			boolean glrcpv                           ; // glrcpv;
			boolean glrcbl                           ; // glrcbl;
			boolean criminal_flag                    ; // criminal_flag;
			boolean lien_unrel_flag                  ; // lien_unrel_flag;
			boolean bankruptcy_flag                  ; // bankruptcy_flag;
			real	 	divptslost_iv_derog_diff         ; // divptslost_iv_derog_diff;
			real    rcvalue36_1                      ; // rcvalue36_1;
			real    rcvalue36_2                      ; // rcvalue36_2;
			real    rcvalue36_3                      ; // rcvalue36_3;
			real    rcvalue36                        ; // rcvalue36;
			real    rcvalue97_1                      ; // rcvalue97_1;
			real    rcvalue97_2                      ; // rcvalue97_2;
			real    rcvalue97                        ; // rcvalue97;
			real    rcvalue98_1                      ; // rcvalue98_1;
			real    rcvalue98_2                      ; // rcvalue98_2;
			real    rcvalue98_3                      ; // rcvalue98_3;
			real    rcvalue98                        ; // rcvalue98;
			real    rcvalue9a_1                      ; // rcvalue9a_1;
			real    rcvalue9a                        ; // rcvalue9a;
			real    rcvalue9g_1                      ; // rcvalue9g_1;
			real    rcvalue9g                        ; // rcvalue9g;
			real    rcvalue9h_1                      ; // rcvalue9h_1;
			real    rcvalue9h                        ; // rcvalue9h;
			real    rcvalue9m_1                      ; // rcvalue9m_1;
			real    rcvalue9m                        ; // rcvalue9m;
			real    rcvalue9o_1                      ; // rcvalue9o_1;
			real    rcvalue9o                        ; // rcvalue9o;
			real    rcvalue9q_1                      ; // rcvalue9q_1;
			real    rcvalue9q_2                      ; // rcvalue9q_2;
			real    rcvalue9q                        ; // rcvalue9q;
			real    rcvalue9r_1                      ; // rcvalue9r_1;
			real    rcvalue9r_2                      ; // rcvalue9r_2;
			real    rcvalue9r                        ; // rcvalue9r;
			real    rcvalue9w_1                      ; // rcvalue9w_1;
			real    rcvalue9w_2                      ; // rcvalue9w_2;
			real    rcvalue9w                        ; // rcvalue9w;
			real    rcvalue9y_1                      ; // rcvalue9y_1;
			real    rcvalue9y_2                      ; // rcvalue9y_2;
			real    rcvalue9y                        ; // rcvalue9y;
			real    rcvaluems_1                      ; // rcvaluems_1;
			real    rcvaluems                        ; // rcvaluems;
			real    rcvaluepv_1                      ; // rcvaluepv_1;
			real    rcvaluepv                        ; // rcvaluepv;
			real    rcvaluebl_1                      ; // rcvaluebl_1;
			real    rcvaluebl_2                      ; // rcvaluebl_2;
			real    rcvaluebl_3                      ; // rcvaluebl_3;
			real    rcvaluebl_4                      ; // rcvaluebl_4;
			real    rcvaluebl_5                      ; // rcvaluebl_5;
			real    rcvaluebl                        ; // rcvaluebl;
			string  rc1                              ; // rc1;
			string  rc2                              ; // rc2;
			string  rc3                              ; // rc3;
			string  rc4                              ; // rc4;
			string  rc5                              ; // rc5;
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
			rc_decsflag                      := le.iid.decsflag;
			rc_bansflag                      := le.iid.bansflag;
			combo_dobscore                   := le.iid.combo_dobscore;
			ver_sources                      := le.header_summary.ver_sources;
			ver_addr_sources                 := le.header_summary.ver_addr_sources;
			ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
			addrpop                          := le.input_validation.address;
			ssnlength                        := le.input_validation.ssn_length;
			dobpop                           := le.input_validation.dateofbirth;
			hphnpop                          := le.input_validation.homephone;
			age                              := le.name_verification.age;
			add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
			add1_naprop                      := le.address_verification.input_address_information.naprop;
			add1_pop                         := le.addrpop;
			property_owned_total             := le.address_verification.owned.property_total;
			property_sold_total              := le.address_verification.sold.property_total;
			gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
			gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
			header_first_seen                := le.ssn_verification.header_first_seen;
			ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
			adls_per_addr                    := le.velocity_counters.adls_per_addr;
			invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
			inq_count12                      := le.acc_logs.inquiries.count12;
			inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
			inq_retail_count12               := le.acc_logs.retail.count12;
			pb_total_dollars                 := le.ibehavior.total_dollars;
			pb_total_orders                  := le.ibehavior.total_number_of_orders;
			infutor_nap                      := le.infutor_phone.infutor_nap;
			impulse_count                    := le.impulse.count;
			impulse_count30                  := le.impulse.count30;
			impulse_count90                  := le.impulse.count90;
			impulse_count180                 := le.impulse.count180;
			impulse_count12                  := le.impulse.count12;
			impulse_count24                  := le.impulse.count24;
			impulse_count36                  := le.impulse.count36;
			impulse_count60                  := le.impulse.count60;
			email_domain_free_count          := le.email_summary.email_domain_free_ct;
			email_source_list                := le.email_summary.email_source_list;
			attr_total_number_derogs         := le.total_number_derogs;
			attr_num_nonderogs               := le.source_verification.num_nonderogs;
			bankrupt                         := le.bjl.bankrupt;
			disposition                      := le.bjl.disposition;
			filing_count                     := le.bjl.filing_count;
			bk_recent_count                  := le.bjl.bk_recent_count;
			liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
			liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
			liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
			liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
			criminal_count                   := le.bjl.criminal_count;
			ams_age                          := le.student.age;
			prof_license_flag                := le.professional_license.professional_license_flag;
			wealth_index                     := le.wealth_indicator;
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

// sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

sysdate := map(
    trim((string)le.historydate, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
    length(trim((string)le.historydate, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)le.historydate, LEFT))[1..4], (trim((string)le.historydate, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);
iv_truedid := truedid;

iv_src_bureau_addr_count := if	(not(truedid), 
																		NULL, 
																		max(
																				if(
																						max( 
																								(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ','), 
																								(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ','), 
																								(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ','), 
																								(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ','), 
																								(integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',')
																							 ) = NULL, 
																						NULL, 
																						sum(
																								if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',')), 
																								if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',')), 
																								if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',')), 
																								if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',')), 
																								if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ','))
																							 )
																					), 
																			0)
																);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) 					=> NULL,
    age > 0                					=> age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       					=> inferred_age,
    reported_age > 0       					=> reported_age,
    (integer)ams_age > 0            => (integer)ams_age,
																				-1);

iv_inp_addr_avm_auto_val := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_mos_since_header_fst_seen := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

iv_adls_per_addr := if(not(add1_pop), NULL, adls_per_addr);

iv_invalid_addrs_per_adl_c6 := if(not(truedid), NULL, invalid_addrs_per_adl_c6);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_inq_retail_count12 := if(not(truedid), NULL, inq_retail_count12);

iv_infutor_nap := if(not(hphnpop), NULL, infutor_nap);

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

iv_impulse_recency := map(
    not(truedid)                            		=> NULL,
    impulse_count30  > 0                        => 1,
    impulse_count90  > 0                       	=> 3,
    impulse_count180 > 0                       	=> 6,
    impulse_count12  > 0                       	=> 12,
    impulse_count24  > 0                       	=> 24,
    impulse_count36  > 0                       	=> 36,
    impulse_count60  > 0                       	=> 60,
    impulse_count    > 0                       	=> 99,
    contains_i(email_source_list, 'IM') > 0 		=> 99,
																									 0);

iv_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_bk_disposition_lvl := map(
    not(truedid or (integer)ssnlength > 0)                                                                                  => '          ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                         => 'Discharged',
    (disposition in ['Dismissed'])                                                                                          => 'Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => 'OtherBK  ',
                                                                                                                               'No BK');

iv_liens_unrel_lt_ct := if(not(truedid), NULL, liens_unrel_LT_ct);

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_prof_license_flag := if(not(truedid), NULL, (integer)prof_license_flag);

iv_wealth_index := if(not(truedid), NULL, (integer)wealth_index);

iv_pb_total_dollars := map(
    not(truedid)            => NULL,
    pb_total_dollars = '' 	=> -1,
                               (integer)pb_total_dollars);

iv_pb_total_orders := map(
    not(truedid)           	=> NULL,
    pb_total_orders = '' 		=> -1,
                              (integer)pb_total_orders);

subscore0 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['Other'])                                         => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in [' -1'])                                           => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.160033,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3'])                      => 0.133527,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                           => 0.396465,
                                                                                           0.000000);

subscore1 := map(
    NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 0    => -0.112511,
    0 <= iv_pb_total_dollars AND iv_pb_total_dollars < 27     => -0.173926,
    27 <= iv_pb_total_dollars AND iv_pb_total_dollars < 63    => -0.044376,
    63 <= iv_pb_total_dollars AND iv_pb_total_dollars < 168   => -0.013663,
    168 <= iv_pb_total_dollars AND iv_pb_total_dollars < 464  => 0.087994,
    464 <= iv_pb_total_dollars AND iv_pb_total_dollars < 732  => 0.173322,
    732 <= iv_pb_total_dollars AND iv_pb_total_dollars < 2008 => 0.315729,
    2008 <= iv_pb_total_dollars                               => 0.627189,
                                                                 -0.000000);

subscore2 := map(
    NULL < iv_combined_age AND iv_combined_age < 14 => -0.000000,
    14 <= iv_combined_age AND iv_combined_age < 51  => -0.123107,
    51 <= iv_combined_age AND iv_combined_age < 62  => 0.132392,
    62 <= iv_combined_age                           => 0.255614,
                                                       -0.000000);

subscore3 := map(
    (iv_bk_disposition_lvl in ['Other'])      => -0.000000,
    (iv_bk_disposition_lvl in ['Dismissed'])  => -0.129335,
    (iv_bk_disposition_lvl in ['No BK'])      => -0.046381,
    (iv_bk_disposition_lvl in ['OtherBK'])    => 0.137251,
    (iv_bk_disposition_lvl in ['Discharged']) => 0.301587,
                                                 -0.000000);

subscore4 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 1 => 0.061969,
    1 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 2   => 0.066416,
    2 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3   => -0.128386,
    3 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 4   => -0.183417,
    4 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 5   => -0.260135,
    5 <= iv_gong_did_phone_ct                                => -0.412093,
                                                                0.000000);

subscore5 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr < 5 => 0.177696,
    5 <= iv_adls_per_addr AND iv_adls_per_addr < 10  => 0.014512,
    10 <= iv_adls_per_addr AND iv_adls_per_addr < 16 => -0.050534,
    16 <= iv_adls_per_addr                           => -0.095924,
                                                        -0.000000);

subscore6 := map(
    NULL < iv_mos_since_header_fst_seen AND iv_mos_since_header_fst_seen < 0   => 0.000000,
    0 <= iv_mos_since_header_fst_seen AND iv_mos_since_header_fst_seen < 263   => -0.085715,
    263 <= iv_mos_since_header_fst_seen AND iv_mos_since_header_fst_seen < 289 => 0.009100,
    289 <= iv_mos_since_header_fst_seen AND iv_mos_since_header_fst_seen < 347 => 0.070041,
    347 <= iv_mos_since_header_fst_seen                                        => 0.279814,
                                                                                  0.000000);

subscore7 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.088060,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 6   => 0.005011,
    6 <= iv_pb_total_orders AND iv_pb_total_orders < 18  => 0.110544,
    18 <= iv_pb_total_orders                             => 0.295172,
                                                            -0.000000);

subscore8 := map(
    NULL < iv_impulse_recency AND iv_impulse_recency < 1 => 0.031501,
    1 <= iv_impulse_recency AND iv_impulse_recency < 12  => -0.621133,
    12 <= iv_impulse_recency AND iv_impulse_recency < 36 => -0.281765,
    36 <= iv_impulse_recency                             => -0.186559,
                                                            0.000000);

subscore9 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.126286,
    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 2   => -0.023178,
    2 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 4   => 0.039206,
    4 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 5   => 0.125645,
    5 <= iv_src_bureau_addr_count                                    => 0.530320,
                                                                        0.000000);

subscore10 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0  => 0.000000,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 47   => -0.124486,
    47 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 87  => -0.014284,
    87 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 111 => 0.159930,
    111 <= iv_mos_since_gong_did_fst_seen                                         => 0.275878,
                                                                                     0.000000);

subscore11 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.017042,
    1 <= iv_inq_highriskcredit_count12                                         => -0.435180,
                                                                                  -0.000000);

subscore12 := map(
    NULL < iv_invalid_addrs_per_adl_c6 AND iv_invalid_addrs_per_adl_c6 < 1 => 0.010289,
    1 <= iv_invalid_addrs_per_adl_c6                                       => -0.479459,
                                                                              -0.000000);

subscore13 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 1 => -0.042359,
    1 <= iv_wealth_index AND iv_wealth_index < 2   => -0.037178,
    2 <= iv_wealth_index AND iv_wealth_index < 3   => -0.033601,
    3 <= iv_wealth_index AND iv_wealth_index < 4   => 0.089872,
    4 <= iv_wealth_index AND iv_wealth_index < 5   => 0.107130,
    5 <= iv_wealth_index                           => 0.285184,
                                                      0.000000);

subscore14 := map(
    (iv_inp_addr_naprop in [1])    => -0.045553,
    (iv_inp_addr_naprop in [0])    => -0.020585,
    (iv_inp_addr_naprop in [2, 3]) => -0.018849,
    (iv_inp_addr_naprop in [4])    => 0.156109,
                                      -0.000000);

subscore15 := map(
    NULL < iv_derog_diff AND iv_derog_diff < -3 => -0.304628,
    -3 <= iv_derog_diff AND iv_derog_diff < -1  => -0.089197,
    -1 <= iv_derog_diff AND iv_derog_diff < 3   => -0.021946,
    3 <= iv_derog_diff AND iv_derog_diff < 4    => 0.053325,
    4 <= iv_derog_diff                          => 0.075864,
                                                   0.000000);

subscore16 := map(
    (iv_infutor_nap in [6])                         => -0.362736,
    (iv_infutor_nap in [0, 1, 4, 7, 9, 10, 11, 12]) => 0.011243,
                                                       -0.000000);

subscore17 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 2 => 0.035480,
    2 <= iv_ssns_per_adl AND iv_ssns_per_adl < 3   => -0.046191,
    3 <= iv_ssns_per_adl AND iv_ssns_per_adl < 5   => -0.088300,
    5 <= iv_ssns_per_adl                           => -0.373939,
                                                      -0.000000);

subscore18 := map(
    NULL < iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 34930    => -0.035065,
    34930 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 164900 => 0.051540,
    164900 <= iv_inp_addr_avm_auto_val                                      => 0.171736,
                                                                               0.000000);

subscore19 := map(
    NULL < (integer)iv_truedid AND (integer)iv_truedid < 1 	=> -0.350746,
    1 <= (integer)iv_truedid                      					=> 0.008520,
																															 -0.000000);

subscore20 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.014372,
    1 <= iv_liens_unrel_sc_ct                                => -0.167953,
                                                                0.000000);

subscore21 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.025454,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => 0.002482,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => -0.048934,
    3 <= iv_email_domain_free_count                                      => -0.108547,
                                                                            0.000000);

subscore22 := map(
    NULL < iv_inq_retail_count12 AND iv_inq_retail_count12 < 1 => 0.003850,
    1 <= iv_inq_retail_count12                                 => -0.262905,
                                                                  0.000000);

subscore23 := map(
    NULL < iv_prof_license_flag AND iv_prof_license_flag < 1 => -0.006964,
    1 <= iv_prof_license_flag                                => 0.130629,
                                                                0.000000);

subscore24 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.003708,
    1 <= iv_criminal_count AND iv_criminal_count < 3   => -0.005822,
    3 <= iv_criminal_count                             => -0.241994,
                                                          0.000000);

subscore25 := map(
    NULL < iv_liens_unrel_lt_ct AND iv_liens_unrel_lt_ct < 1 => 0.001368,
    1 <= iv_liens_unrel_lt_ct                                => -0.038230,
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
    subscore17 +
    subscore18 +
    subscore19 +
    subscore20 +
    subscore21 +
    subscore22 +
    subscore23 +
    subscore24 +
    subscore25;

lnoddsscore := rawscore + 0.422955;

probscore := exp(lnoddsscore) / ((real)1 + exp(lnoddsscore));

ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

riskview_222s := 	riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

base := 600;

point := 40;

odds := (1 - .3984) / .3984;

rvr1210_1_0 := map(
    ssn_deceased  => 200,
    riskview_222s => 222,
                     min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

glrc36_1 := iv_src_bureau_addr_count < 1;

glrc36_2 := 1;

glrc97 := criminal_count > 0;

glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrc9g := -1 < iv_combined_age AND iv_combined_age <= 25;

glrc9h := impulse_count > 0;

glrc9m := (integer)wealth_index < 6;

glrc9o := hphnpop and addrpop and (nap_summary in [0, 1, 2, 3, 4]);

glrc9q := inq_count12 > 0;

glrc9r := truedid;

glrc9w := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

glrc9y := (integer)pb_total_dollars < 168;

glrcms := truedid and ssns_per_adl > 2;

glrcpv := iv_inp_addr_avm_auto_val > 0;

glrcbl := 0;

criminal_flag := criminal_count > 0;

lien_unrel_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bankruptcy_flag := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

divptslost_iv_derog_diff := if(if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag) = NULL, NULL, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag)) = 0, 0, (0.075864 - subscore15) / if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag) = NULL, NULL, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag)));

rcvalue36_1 := 0.53032 - subscore9;

rcvalue36_2 := 0.00852 - subscore19;

rcvalue36_3 := 0.130629 - subscore23;

rcvalue36 := (integer)glrc36_1 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1))) + glrc36_2 * if(max(rcvalue36_2, rcvalue36_3) = NULL, NULL, sum(if(rcvalue36_2 = NULL, 0, rcvalue36_2), if(rcvalue36_3 = NULL, 0, rcvalue36_3)));

rcvalue97_1 := (integer)criminal_flag * divptslost_iv_derog_diff;

rcvalue97_2 := 0.003708 - subscore24;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvalue98_1 := (integer)lien_unrel_flag * divptslost_iv_derog_diff;

rcvalue98_2 := 0.014372 - subscore20;

rcvalue98_3 := 0.001368 - subscore25;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3)));

rcvalue9a_1 := 0.156109 - subscore14;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9g_1 := 0.255614 - subscore2;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvalue9h_1 := 0.031501 - subscore8;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9m_1 := 0.285184 - subscore13;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9o_1 := 0.396465 - subscore0;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue9q_1 := 0.017042 - subscore11;

rcvalue9q_2 := 0.00385 - subscore22;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1, rcvalue9q_2) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2)));

rcvalue9r_1 := 0.279814 - subscore6;

rcvalue9r_2 := 0.275878 - subscore10;

rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1, rcvalue9r_2) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2)));

rcvalue9w_1 := 0.301587 - subscore3;

rcvalue9w_2 := (integer)bankruptcy_flag * divptslost_iv_derog_diff;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

// rcvalue9y_1 := 0.627189 - subscore1;
// rcvalue9y_2 := 0.295172 - subscore7;

// hard coding these so 9Y doesn't come back anymore
        RCValue9Y_1 := 0;
        RCValue9Y_2 := 0;

rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1, rcvalue9y_2) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1), if(rcvalue9y_2 = NULL, 0, rcvalue9y_2)));

rcvaluems_1 := 0.03548 - subscore17;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluepv_1 := 0.171736 - subscore18;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvaluebl_1 := 0.066416 - subscore4;

rcvaluebl_2 := 0.177696 - subscore5;

rcvaluebl_3 := 0.010289 - subscore12;

rcvaluebl_4 := 0.011243 - subscore16;

rcvaluebl_5 := 0.025454 - subscore21;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'36',  RCValue36},
	{'97',  RCValue97},
	{'98',  RCValue98},
	{'9A',  RCValue9A},
	{'9G',  RCValue9G},
	{'9H',  RCValue9H},
	{'9M',  RCValue9M},
	{'9O',  RCValue9O},
	{'9Q',  RCValue9Q},
	{'9R',  RCValue9R},
	{'9W',  RCValue9W},
	{'9Y',  RCValue9Y},
	{'MS',  RCValueMS},
	{'PV',  RCValuePV},
	{'BL',  RCValueBL}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9q1 := rcs_top4[1];
rcs_9q2 := rcs_top4[2];
rcs_9q3 := rcs_top4[3];
rcs_9q4 := rcs_top4[4];
rcs_9q5 := IF(GLRC9Q AND NOT EXISTS(rcs_top4 (rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
								(iv_inq_highriskcredit_count12 > 0 or iv_inq_retail_count12 > 0),
									DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.

rcs_9q := rcs_9q1 & rcs_9q2  & rcs_9q3 & rcs_9q4 & rcs_9q5;

rcs_override := MAP(
										rvr1210_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
										rvr1210_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
										rvr1210_1_0 = 900 => DATASET([{'', NULL}], ds_layout),
										NOT EXISTS(rcs_9q(rc != '')) => DATASET([{'36', NULL}], ds_layout),
										rcs_9q
									);

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
			SELF.hri := LEFT.rc,
			SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
		));

ri := MAP(
					riTemp[1].hri <> '00' => riTemp,
					rcs_final
					);
					
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables

	#if(RVR_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_truedid                       := iv_truedid;
		self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_inp_addr_avm_auto_val         := iv_inp_addr_avm_auto_val;
		self.iv_inp_addr_naprop               := iv_inp_addr_naprop;
		self._gong_did_first_seen             := _gong_did_first_seen;
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
		self._header_first_seen               := _header_first_seen;
		self.iv_mos_since_header_fst_seen     := iv_mos_since_header_fst_seen;
		self.iv_ssns_per_adl                  := iv_ssns_per_adl;
		self.iv_adls_per_addr                 := iv_adls_per_addr;
		self.iv_invalid_addrs_per_adl_c6      := iv_invalid_addrs_per_adl_c6;
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
		self.iv_inq_retail_count12            := iv_inq_retail_count12;
		self.iv_infutor_nap                   := iv_infutor_nap;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_impulse_recency               := iv_impulse_recency;
		self.iv_email_domain_free_count       := iv_email_domain_free_count;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_bk_disposition_lvl            := iv_bk_disposition_lvl;
		self.iv_liens_unrel_lt_ct             := iv_liens_unrel_lt_ct;
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
		self.iv_criminal_count                := iv_criminal_count;
		self.iv_prof_license_flag             := iv_prof_license_flag;
		self.iv_wealth_index                  := iv_wealth_index;
		self.iv_pb_total_dollars              := iv_pb_total_dollars;
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
		self.subscore18                       := subscore18;
		self.subscore19                       := subscore19;
		self.subscore20                       := subscore20;
		self.subscore21                       := subscore21;
		self.subscore22                       := subscore22;
		self.subscore23                       := subscore23;
		self.subscore24                       := subscore24;
		self.subscore25                       := subscore25;
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.ssn_deceased                     := ssn_deceased;
		self.riskview_222s                    := riskview_222s;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.rvr1210_1_0                      := rvr1210_1_0;
		self.glrc36_1                         := glrc36_1;
		self.glrc36_2                         := glrc36_2;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.glrc9a                           := glrc9a;
		self.glrc9g                           := glrc9g;
		self.glrc9h                           := glrc9h;
		self.glrc9m                           := glrc9m;
		self.glrc9o                           := glrc9o;
		self.glrc9q                           := glrc9q;
		self.glrc9r                           := glrc9r;
		self.glrc9w                           := glrc9w;
		self.glrc9y                           := glrc9y;
		self.glrcms                           := glrcms;
		self.glrcpv                           := glrcpv;
		self.glrcbl                           := glrcbl;
		self.criminal_flag                    := criminal_flag;
		self.lien_unrel_flag                  := lien_unrel_flag;
		self.bankruptcy_flag                  := bankruptcy_flag;
		self.divptslost_iv_derog_diff         := divptslost_iv_derog_diff;
		self.rcvalue36_1                      := rcvalue36_1;
		self.rcvalue36_2                      := rcvalue36_2;
		self.rcvalue36_3                      := rcvalue36_3;
		self.rcvalue36                        := rcvalue36;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97_2                      := rcvalue97_2;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98_3                      := rcvalue98_3;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9g_1                      := rcvalue9g_1;
		self.rcvalue9g                        := rcvalue9g;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q_2                      := rcvalue9q_2;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9r_1                      := rcvalue9r_1;
		self.rcvalue9r_2                      := rcvalue9r_2;
		self.rcvalue9r                        := rcvalue9r;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w_2                      := rcvalue9w_2;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue9y_1                      := rcvalue9y_1;
		self.rcvalue9y_2                      := rcvalue9y_2;
		self.rcvalue9y                        := rcvalue9y;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1 															:= reasons[1].hri;
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
											reasons[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '000',
											(string3)RVR1210_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;

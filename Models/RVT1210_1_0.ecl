/*2013-02-06T19:50:29Z (Kevin Huls)
Per Lea - tightened code around 9D reason code so it is not returned so often.  Also added check to return score '000' if reason code 35 is returned.
*/
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVT1210_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN xmlPreScreenOptOut = FALSE ) := FUNCTION

  RVT_DEBUG := false;

  #if(RVT_DEBUG)
    layout_debug := record
			integer sysdate                          ; // sysdate;
			integer src_voter_adl_lseen              ; // src_voter_adl_lseen;
			integer _src_voter_adl_lseen             ; // _src_voter_adl_lseen;
			integer iv_mos_src_voter_adl_lseen       ; // iv_mos_src_voter_adl_lseen;
			integer iv_inp_addr_source_count         ; // iv_inp_addr_source_count;
			integer iv_inp_addr_naprop               ; // iv_inp_addr_naprop;
			string  iv_inp_addr_vacant               ; // iv_inp_addr_vacant;
			string  iv_inp_addr_res_or_business      ; // iv_inp_addr_res_or_business;
			integer iv_bst_addr_lres                 ; // iv_bst_addr_lres;
			integer iv_bst_addr_avm_auto_val         ; // iv_bst_addr_avm_auto_val;
			integer iv_prv_addr_avm_auto_val         ; // iv_prv_addr_avm_auto_val;
			integer iv_addrs_5yr                     ; // iv_addrs_5yr;
			integer _gong_did_first_seen             ; // _gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen   ; // iv_mos_since_gong_did_fst_seen;
			integer iv_ssns_per_adl                  ; // iv_ssns_per_adl;
			integer iv_adls_per_addr_c6              ; // iv_adls_per_addr_c6;
			integer iv_adls_per_phone_c6             ; // iv_adls_per_phone_c6;
			integer iv_inq_count12                   ; // iv_inq_count12;
			integer iv_paw_source_count              ; // iv_paw_source_count;
			boolean ver_phn_inf                      ; // ver_phn_inf;
			boolean ver_phn_nap                      ; // ver_phn_nap;
			integer inf_phn_ver_lvl                  ; // inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ; // nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; // iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_impulse_count                 ; // iv_impulse_count;
			integer iv_all_email_domain_free         ; // iv_all_email_domain_free;
			integer iv_eviction_count                ; // iv_eviction_count;
			integer iv_criminal_count                ; // iv_criminal_count;
			integer iv_ams_college_code              ; // iv_ams_college_code;
			integer iv_prof_license_flag             ; // iv_prof_license_flag;
			integer iv_wealth_index                  ; // iv_wealth_index;
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
			real    rawscore                         ; // rawscore;
			real    lnoddsscore                      ; // lnoddsscore;
			real    probscore                        ; // probscore;
			integer base                             ; // base;
			real    odds                             ; // odds;
			integer point                            ; // point;
			boolean ssn_deceased                     ; // ssn_deceased;
			boolean iv_riskview_222s                 ; // iv_riskview_222s;
			integer rvt1210_1                        ; // rvt1210_1;
			boolean glrc97                           ; // glrc97;
			boolean glrc9a                           ; // glrc9a;
			boolean glrc9c                           ; // glrc9c;
			boolean glrc9d                           ; // glrc9d;
			boolean glrc9e                           ; // glrc9e;
			boolean glrc9f                           ; // glrc9f;
			boolean glrc9h                           ; // glrc9h;
			integer _reported_dob                    ; // _reported_dob;
			integer reported_age                     ; // reported_age;
			integer iv_combined_age                  ; // iv_combined_age;
			boolean glrc9i                           ; // glrc9i;
			boolean glrc9m                           ; // glrc9m;
			boolean glrc9o                           ; // glrc9o;
			boolean glrc9q                           ; // glrc9q;
			boolean glrc9u                           ; // glrc9u;
			boolean glrcev                           ; // glrcev;
			boolean glrcms                           ; // glrcms;
			boolean glrcpv                           ; // glrcpv;
			boolean glrcbl                           ; // glrcbl;
			real    rcvalue97_1                      ; // rcvalue97_1;
			real    rcvalue97                        ; // rcvalue97;
			real    rcvalue9a_1                      ; // rcvalue9a_1;
			real    rcvalue9a                        ; // rcvalue9a;
			real    rcvalue9c_1                      ; // rcvalue9c_1;
			real    rcvalue9c                        ; // rcvalue9c;
			real    rcvalue9d_1                      ; // rcvalue9d_1;
			real    rcvalue9d                        ; // rcvalue9d;
			real    rcvalue9e_1                      ; // rcvalue9e_1;
			real    rcvalue9e                        ; // rcvalue9e;
			real    rcvalue9f_1                      ; // rcvalue9f_1;
			real    rcvalue9f_2                      ; // rcvalue9f_2;
			real    rcvalue9f                        ; // rcvalue9f;
			real    rcvalue9h_1                      ; // rcvalue9h_1;
			real    rcvalue9h                        ; // rcvalue9h;
			real    rcvalue9i_1                      ; // rcvalue9i_1;
			real    rcvalue9i                        ; // rcvalue9i;
			real    rcvalue9m_1                      ; // rcvalue9m_1;
			real    rcvalue9m                        ; // rcvalue9m;
			real    rcvalue9o_1                      ; // rcvalue9o_1;
			real    rcvalue9o                        ; // rcvalue9o;
			real    rcvalue9q_1                      ; // rcvalue9q_1;
			real    rcvalue9q                        ; // rcvalue9q;
			real    rcvalue9u_1                      ; // rcvalue9u_1;
			real    rcvalue9u_2                      ; // rcvalue9u_2;
			real    rcvalue9u                        ; // rcvalue9u;
			real    rcvalueev_1                      ; // rcvalueev_1;
			real    rcvalueev                        ; // rcvalueev;
			real    rcvaluems_1                      ; // rcvaluems_1;
			real    rcvaluems                        ; // rcvaluems;
			real    rcvaluepv_1                      ; // rcvaluepv_1;
			real    rcvaluepv                        ; // rcvaluepv;
			real    rcvaluebl_1                      ; // rcvaluebl_1;
			real    rcvaluebl_2                      ; // rcvaluebl_2;
			real    rcvaluebl_3                      ; // rcvaluebl_3;
			real    rcvaluebl_4                      ; // rcvaluebl_4;
			real    rcvaluebl_5                      ; // rcvaluebl_5;
			real    rcvaluebl_6                      ; // rcvaluebl_6;
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
			ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
			voter_avail                      := le.available_sources.voter;
			addrpop                          := le.input_validation.address;
			dobpop                           := le.input_validation.dateofbirth;
			hphnpop                          := le.input_validation.homephone;
			age                              := le.name_verification.age;
			add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
			add1_lres                        := le.lres;
			add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
			add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
			add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
			add1_source_count                := le.address_verification.input_address_information.source_count;
			add1_naprop                      := le.address_verification.input_address_information.naprop;
			add1_pop                         := le.addrpop;
			property_owned_total             := le.address_verification.owned.property_total;
			property_sold_total              := le.address_verification.sold.property_total;
			add2_lres                        := le.lres2;
			add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
			add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
			addrs_5yr                        := le.other_address_info.addrs_last_5years;
			unique_addr_count                := le.address_history_summary.unique_addr_cnt;
			gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
			ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
			adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
			adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
			inq_count12                      := le.acc_logs.inquiries.count12;
			paw_source_count                 := le.employment.source_ct;
			infutor_nap                      := le.infutor_phone.infutor_nap;
			impulse_count                    := le.impulse.count;
			email_count                      := le.email_summary.email_ct;
			email_domain_free_count          := le.email_summary.email_domain_free_ct;
			attr_eviction_count              := le.bjl.eviction_count;
			bankrupt                         := le.bjl.bankrupt;
			filing_count                     := le.bjl.filing_count;
			bk_recent_count                  := le.bjl.bk_recent_count;
			liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
			liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
			criminal_count                   := le.bjl.criminal_count;
			ams_age                          := le.student.age;
			ams_college_code                 := le.student.college_code;
			prof_license_flag                := le.professional_license.professional_license_flag;
			wealth_index                     := le.wealth_indicator;
			input_dob_age                    := le.shell_input.age;
			inferred_age                     := le.inferred_age;
			reported_dob                     := le.reported_dob;
			archive_date                     := le.historydate;

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

// sysdate := common.sas_date((string)(archive_date));	

//It appears the convertor did not map sysdate appropriately.  Replacing the above line with the below standard code. 

sysdate := map(
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);

src_voter_adl_lseen := if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') != '0', (integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') , NULL);

_src_voter_adl_lseen := common.sas_date((string)(src_voter_adl_lseen));

iv_mos_src_voter_adl_lseen := map(
    not(truedid)                => NULL,
    not(voter_avail)            => -1,
    _src_voter_adl_lseen = NULL => -1,
                                   if ((sysdate - _src_voter_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_voter_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_voter_adl_lseen) / (365.25 / 12))));

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

iv_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

iv_inp_addr_vacant := map(
    not(add1_pop)                    => '  ',
    add1_advo_address_vacancy = ''	 => '-1',
                                        add1_advo_address_vacancy);

iv_inp_addr_res_or_business := map(
    not(add1_pop)                    => '  ',
    add1_advo_res_or_business = ''	 => '-1',
                                        add1_advo_res_or_business);

iv_bst_addr_lres := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_lres,
                        add2_lres);

iv_bst_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

iv_adls_per_addr_c6 := if(not(add1_pop), NULL, adls_per_addr_c6);

iv_adls_per_phone_c6 := if(not(hphnpop), NULL, adls_per_phone_c6);

iv_inq_count12 := if(not(truedid), NULL, inq_count12);

iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

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

iv_impulse_count := if(not(truedid), NULL, impulse_count);

iv_all_email_domain_free := if(not(truedid), NULL, (integer)(email_count = email_domain_free_count) * min(if(email_count = NULL, -NULL, email_count), 5));

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_ams_college_code := map(
    not(truedid)            => NULL,
    ams_college_code = ''		=> -1,
                               (integer)ams_college_code);

iv_prof_license_flag := if(not(truedid), NULL, (integer)prof_license_flag);

iv_wealth_index := if(not(truedid), NULL, (integer)wealth_index);

subscore0 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['Other'])                                  => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-0', '1-1', '1-3'])                      => -0.388747,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '2-0', '2-1', '3-1', '3-3']) => -0.088493,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0'])                      => 0.367430,
                                                                                    0.000000);

subscore1 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.165374,
    0 <= iv_addrs_5yr AND iv_addrs_5yr < 1   => 0.008865,
    1 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.154066,
    2 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => -0.030779,
    3 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => -0.146037,
    4 <= iv_addrs_5yr                        => -0.347812,
                                                0.000000);

subscore2 := map(
    (iv_inp_addr_naprop in [0, 1]) => -0.071387,
    (iv_inp_addr_naprop in [2, 3]) => 0.308610,
    (iv_inp_addr_naprop in [4])    => 0.348793,
                                      0.000000);

subscore3 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.043388,
    1 <= iv_criminal_count                             => -0.529931,
                                                          -0.000000);

subscore4 := map(
    NULL < iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 1         => -0.055340,
    1 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 35226       => -0.223089,
    35226 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 52783   => -0.167962,
    52783 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 111175  => -0.023915,
    111175 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 203414 => 0.161681,
    203414 <= iv_bst_addr_avm_auto_val                                       => 0.372337,
                                                                                0.000000);

subscore5 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.052125,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 45  => -0.374839,
    45 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 66 => -0.113869,
    66 <= iv_mos_since_gong_did_fst_seen                                         => 0.119562,
                                                                                    0.000000);

subscore6 := map(
    (iv_ams_college_code in [-1])      => -0.019954,
    (iv_ams_college_code in [1, 2, 4]) => 0.727660,
                                          0.000000);

subscore7 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.090702,
    1 <= iv_inp_addr_source_count                                    => 0.097114,
                                                                        0.000000);

subscore8 := map(
    (iv_wealth_index in [0])       => 0.030188,
    (iv_wealth_index in [1])       => -0.201702,
    (iv_wealth_index in [2])       => -0.151660,
    (iv_wealth_index in [3])       => -0.000024,
    (iv_wealth_index in [4, 5, 6]) => 0.149167,
                                      0.000000);

subscore9 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.016336,
    1 <= iv_paw_source_count                               => 0.438459,
                                                              0.000000);

subscore10 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.024997,
    1 <= iv_eviction_count                             => -0.264743,
                                                          -0.000000);

subscore11 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1        => -0.004813,
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 34500      => -0.311590,
    34500 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 58803  => -0.029318,
    58803 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 138951 => 0.001368,
    138951 <= iv_prv_addr_avm_auto_val                                      => 0.196629,
                                                                               -0.000000);

subscore12 := map(
    NULL < iv_impulse_count AND iv_impulse_count < 1 => 0.014071,
    1 <= iv_impulse_count                            => -0.511312,
                                                        0.000000);

subscore13 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 0 => -0.007428,
    0 <= iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 24  => 0.424425,
    24 <= iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 57 => -0.047742,
    57 <= iv_mos_src_voter_adl_lseen                                     => -0.239988,
                                                                            -0.000000);

subscore14 := map(
    NULL < iv_adls_per_phone_c6 AND iv_adls_per_phone_c6 < 1 => 0.015305,
    1 <= iv_adls_per_phone_c6                                => -0.376560,
                                                                0.000000);

subscore15 := map(
    NULL < iv_bst_addr_lres AND iv_bst_addr_lres < 1 => 0.000000,
    1 <= iv_bst_addr_lres AND iv_bst_addr_lres < 6   => -0.112656,
    6 <= iv_bst_addr_lres AND iv_bst_addr_lres < 11  => -0.066854,
    11 <= iv_bst_addr_lres                           => 0.058490,
                                                        0.000000);

subscore16 := map(
    (iv_inp_addr_res_or_business in ['Other'])       => -0.000000,
    (iv_inp_addr_res_or_business in ['-1'])          => -0.000000,
    (iv_inp_addr_res_or_business in ['A'])           => 0.012827,
    (iv_inp_addr_res_or_business in ['B', 'C', 'D']) => -0.340309,
                                                        -0.000000);

subscore17 := map(
    NULL < iv_inq_count12 AND iv_inq_count12 < 1 => 0.014188,
    1 <= iv_inq_count12                          => -0.283040,
                                                    0.000000);

subscore18 := map(
    (iv_inp_addr_vacant in ['Other']) => -0.000000,
    (iv_inp_addr_vacant in ['-1'])    => -0.000000,
    (iv_inp_addr_vacant in ['N'])     => 0.010483,
    (iv_inp_addr_vacant in ['Y'])     => -0.404733,
                                         -0.000000);

subscore19 := map(
    NULL < iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 < 1 => 0.034724,
    1 <= iv_adls_per_addr_c6                               => -0.087391,
                                                              0.000000);

subscore20 := map(
    NULL < iv_all_email_domain_free AND iv_all_email_domain_free < 1 => 0.023926,
    1 <= iv_all_email_domain_free AND iv_all_email_domain_free < 2   => -0.098353,
    2 <= iv_all_email_domain_free                                    => -0.170296,
                                                                        0.000000);

subscore21 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 1 => 0.000000,
    1 <= iv_ssns_per_adl AND iv_ssns_per_adl < 3   => 0.010476,
    3 <= iv_ssns_per_adl                           => -0.153243,
                                                      0.000000);

subscore22 := map(
    (iv_prof_license_flag in [0]) => -0.003643,
    (iv_prof_license_flag in [1]) => 0.319012,
                                     -0.000000);

rawscore := sum(
	subscore0,
	subscore1,
	subscore2,
	subscore3,
	subscore4,
	subscore5,
	subscore6,
	subscore7,
	subscore8,
	subscore9,
	subscore10,
	subscore11,
	subscore12,
	subscore13,
	subscore14,
	subscore15,
	subscore16,
	subscore17,
	subscore18,
	subscore19,
	subscore20,
	subscore21,
	subscore22
    );

lnoddsscore := rawscore + -0.176719;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

odds := (1 - 0.54) / 0.54;

point := 50;

ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvt1210_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

glrc97 := criminal_count > 0;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrc9c := addrpop;

glrc9d := truedid and iv_addrs_5yr > 0;  //iv_addrs_5yr check added after issue was found in QA testing.  Was not in original SAS or converted ECL code.

glrc9e := addrpop;

glrc9f := truedid;

glrc9h := impulse_count > 0;

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) 			=> NULL,
    age > 0                			=> age,
    (integer)input_dob_age > 0  => (integer)input_dob_age,
    inferred_age > 0       			=> inferred_age,
    reported_age > 0       			=> reported_age,
    (integer)ams_age > 0        => (integer)ams_age,
																	 -1);

glrc9i := 18 <= iv_combined_age AND iv_combined_age <= 25;

glrc9m := (integer)wealth_index < 6;

glrc9o := hphnpop and addrpop and (nap_summary in [0, 1, 2, 3, 4]);

glrc9q := inq_count12 > 0;

glrc9u := add1_pop and add1_advo_address_vacancy != ' ';

glrcev := attr_eviction_count > 0;

glrcms := truedid and ssns_per_adl > 2;

glrcpv := iv_bst_addr_avm_auto_val > 0;

glrcbl := 0;

rcvalue97_1 := 0.043388 - subscore3;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue9a_1 := 0.348793 - subscore2;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9c_1 := 0.05849 - subscore15;

rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

rcvalue9d_1 := 0.154066 - subscore1;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9e_1 := 0.097114 - subscore7;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue9f_1 := 0.119562 - subscore5;

rcvalue9f_2 := 0.424425 - subscore13;

rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2)));

rcvalue9h_1 := 0.014071 - subscore12;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9i_1 := 0.72766 - subscore6;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9m_1 := 0.149167 - subscore8;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9o_1 := 0.36743 - subscore0;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue9q_1 := 0.014188 - subscore17;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9u_1 := 0.010483 - subscore18;

rcvalue9u_2 := 0.012827 - subscore16;

rcvalue9u := (integer)glrc9u * if(max(rcvalue9u_1, rcvalue9u_2) = NULL, NULL, sum(if(rcvalue9u_1 = NULL, 0, rcvalue9u_1), if(rcvalue9u_2 = NULL, 0, rcvalue9u_2)));

rcvalueev_1 := 0.024997 - subscore10;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvaluems_1 := 0.010476 - subscore21;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluepv_1 := 0.372337 - subscore4;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvaluebl_1 := 0.438459 - subscore9;

rcvaluebl_2 := 0.015305 - subscore14;

rcvaluebl_3 := 0.034724 - subscore19;

rcvaluebl_4 := 0.023926 - subscore20;

rcvaluebl_5 := 0.319012 - subscore22;

rcvaluebl_6 := 0.196629 - subscore11;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'97',	RCValue97},
	{'9A',	RCValue9A},
	{'9C',	RCValue9C},
	{'9D',	RCValue9D},
	{'9E',	RCValue9E},
	{'9F',	RCValue9F},
	{'9H',	RCValue9H},
	{'9I',	RCValue9I},
	{'9M',	RCValue9M},
	{'9O',	RCValue9O},
	{'9Q',	RCValue9Q},
	{'9U',	RCValue9U},
	{'EV',	RCValueEV},
	{'MS',	RCValueMS},
	{'PV',	RCValuePV},
	{'BL',	RCValueBL}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	rcs_9q1 := rcs_top4[1];
	rcs_9q2 := rcs_top4[2];
	rcs_9q3 := rcs_top4[3];
	rcs_9q4 := rcs_top4[4];
	rcs_9q5 := IF(GLRC9Q AND NOT EXISTS(rcs_top4 (rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
									inq_count12 > 0,
										DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.
	
	rcs_9q := rcs_9q1 & rcs_9q2  & rcs_9q3 & rcs_9q4 & rcs_9q5;
	rcs_override := MAP(
											rvt1210_1 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvt1210_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvt1210_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9q(rc != '')) => DATASET([{'36', NULL}], ds_layout),
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
			
	PrescreenOptOut := xmlPrescreenOptOut or Risk_Indicators.iid_constants.CheckFlag(Risk_Indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags);
	
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => DATASET([{'95', Risk_Indicators.getHRIDesc('95')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
						
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables

	#if(RVT_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.src_voter_adl_lseen              := src_voter_adl_lseen;
		self._src_voter_adl_lseen             := _src_voter_adl_lseen;
		self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
		self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
		self.iv_inp_addr_naprop               := iv_inp_addr_naprop;
		self.iv_inp_addr_vacant               := iv_inp_addr_vacant;
		self.iv_inp_addr_res_or_business      := iv_inp_addr_res_or_business;
		self.iv_bst_addr_lres                 := iv_bst_addr_lres;
		self.iv_bst_addr_avm_auto_val         := iv_bst_addr_avm_auto_val;
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self._gong_did_first_seen             := _gong_did_first_seen;
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		self.iv_ssns_per_adl                  := iv_ssns_per_adl;
		self.iv_adls_per_addr_c6              := iv_adls_per_addr_c6;
		self.iv_adls_per_phone_c6             := iv_adls_per_phone_c6;
		self.iv_inq_count12                   := iv_inq_count12;
		self.iv_paw_source_count              := iv_paw_source_count;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_impulse_count                 := iv_impulse_count;
		self.iv_all_email_domain_free         := iv_all_email_domain_free;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_criminal_count                := iv_criminal_count;
		self.iv_ams_college_code              := iv_ams_college_code;
		self.iv_prof_license_flag             := iv_prof_license_flag;
		self.iv_wealth_index                  := iv_wealth_index;
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
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.base                             := base;
		self.odds                             := odds;
		self.point                            := point;
		self.ssn_deceased                     := ssn_deceased;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.rvt1210_1                        := rvt1210_1;
		self.glrc97                           := glrc97;
		self.glrc9a                           := glrc9a;
		self.glrc9c                           := glrc9c;
		self.glrc9d                           := glrc9d;
		self.glrc9e                           := glrc9e;
		self.glrc9f                           := glrc9f;
		self.glrc9h                           := glrc9h;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.glrc9i                           := glrc9i;
		self.glrc9m                           := glrc9m;
		self.glrc9o                           := glrc9o;
		self.glrc9q                           := glrc9q;
		self.glrc9u                           := glrc9u;
		self.glrcev                           := glrcev;
		self.glrcms                           := glrcms;
		self.glrcpv                           := glrcpv;
		self.glrcbl                           := glrcbl;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9c_1                      := rcvalue9c_1;
		self.rcvalue9c                        := rcvalue9c;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue9f_1                      := rcvalue9f_1;
		self.rcvalue9f_2                      := rcvalue9f_2;
		self.rcvalue9f                        := rcvalue9f;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9u_1                      := rcvalue9u_1;
		self.rcvalue9u_2                      := rcvalue9u_2;
		self.rcvalue9u                        := rcvalue9u;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl_6                      := rcvaluebl_6;
		self.rcvaluebl                        := rcvaluebl;
		SELF.rc1 															:= rcs_override[1].rc;
		SELF.rc2 															:= rcs_override[2].rc;
		SELF.rc3 															:= rcs_override[3].rc;
		SELF.rc4 															:= rcs_override[4].rc;
		SELF.rc5 															:= rcs_override[5].rc;
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)reasons[1].hri + 10),
											Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => '222',
											reasons[1].hri='35' => '100',
											(string3)RVT1210_1
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;

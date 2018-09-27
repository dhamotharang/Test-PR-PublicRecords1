//Bluestem (Fingerhut) - Custom 4.0 RV Score

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVR1303_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVR_DEBUG := false;

  #if(RVR_DEBUG)
    layout_debug := record
			integer sysdate                          ; //sysdate;
			boolean iv_pots_phone                    ; //iv_pots_phone;
			boolean iv_add_apt                       ; //iv_add_apt;
			boolean iv_riskview_222s                 ; //iv_riskview_222s;
			integer first_seen_tn                    ; //first_seen_tn;
			integer first_seen_ts                    ; //first_seen_ts;
			integer first_seen_tu                    ; //first_seen_tu;
			integer first_seen_en                    ; //first_seen_en;
			integer first_seen_eq                    ; //first_seen_eq;
			integer src_bureau_adl_fseen             ; //src_bureau_adl_fseen;
			integer _src_bureau_adl_fseen            ; //_src_bureau_adl_fseen;
			integer iv_mos_src_bureau_adl_fseen      ; //iv_mos_src_bureau_adl_fseen;
			integer _reported_dob                    ; //_reported_dob;
			integer reported_age                     ; //reported_age;
			integer iv_combined_age                  ; //iv_combined_age;
			integer iv_ssn_miskey                    ; //iv_ssn_miskey;
			integer iv_inp_addr_source_count         ; //iv_inp_addr_source_count;
			integer iv_inp_addr_naprop               ; //iv_inp_addr_naprop;
			integer iv_addrs_5yr                     ; //iv_addrs_5yr;
			integer _gong_did_first_seen             ; //_gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen   ; //iv_mos_since_gong_did_fst_seen;
			integer _gong_did_last_seen              ; //_gong_did_last_seen;
			integer iv_mos_since_gong_did_lst_seen   ; //iv_mos_since_gong_did_lst_seen;
			integer iv_gong_did_phone_ct             ; //iv_gong_did_phone_ct;
			integer iv_max_ids_per_sfd_addr_c6       ; //iv_max_ids_per_sfd_addr_c6;
			integer iv_phones_per_sfd_addr_c6        ; //iv_phones_per_sfd_addr_c6;
			integer iv_inq_highriskcredit_count12    ; //iv_inq_highriskcredit_count12;
			integer iv_paw_source_count              ; //iv_paw_source_count;
			boolean ver_phn_inf                      ; //ver_phn_inf;
			boolean ver_phn_nap                      ; //ver_phn_nap;
			string  inf_phn_ver_lvl                  ; //inf_phn_ver_lvl;
			string  nap_phn_ver_lvl                  ; //nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ; //iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_impulse_recency               ; //iv_impulse_recency;
			integer iv_all_email_domain_isp          ; //iv_all_email_domain_isp;
			integer iv_attr_eviction_recency         ; //iv_attr_eviction_recency;
			string  iv_liens_unrel_x_rel             ; //iv_liens_unrel_x_rel;
			integer iv_criminal_count                ; //iv_criminal_count;
			string  iv_prof_license_category         ; //iv_prof_license_category;
			real    ns_subscore0                     ; //ns_subscore0;
			real    ns_subscore1                     ; //ns_subscore1;
			real    ns_subscore2                     ; //ns_subscore2;
			real    ns_subscore3                     ; //ns_subscore3;
			real    ns_subscore4                     ; //ns_subscore4;
			real    ns_subscore5                     ; //ns_subscore5;
			real    ns_subscore6                     ; //ns_subscore6;
			real    ns_subscore7                     ; //ns_subscore7;
			real    ns_subscore8                     ; //ns_subscore8;
			real    ns_subscore9                     ; //ns_subscore9;
			real    ns_subscore10                    ; //ns_subscore10;
			real    ns_subscore11                    ; //ns_subscore11;
			real    ns_subscore12                    ; //ns_subscore12;
			real    ns_subscore13                    ; //ns_subscore13;
			real    ns_subscore14                    ; //ns_subscore14;
			real    ns_subscore15                    ; //ns_subscore15;
			real    ns_subscore16                    ; //ns_subscore16;
			real    ns_subscore17                    ; //ns_subscore17;
			real    ns_subscore18                    ; //ns_subscore18;
			real    ns_subscore19                    ; //ns_subscore19;
			real    ns_rawscore                      ; //ns_rawscore;
			real    ns_logit                         ; //ns_logit;
			integer base                             ; //base;
			integer pts                              ; //pts;
			real    logit                            ; //logit;
			integer rvr1303_1_0                      ; //rvr1303_1_0;
			boolean glrc9r                           ; //glrc9r;
			boolean glrc9g                           ; //glrc9g;
			boolean glrc29                           ; //glrc29;
			boolean glrc9e                           ; //glrc9e;
			boolean glrc9a                           ; //glrc9a;
			boolean glrc9d                           ; //glrc9d;
			boolean glrc9f                           ; //glrc9f;
			boolean glrc9p                           ; //glrc9p;
			boolean glrc9o                           ; //glrc9o;
			boolean glrc9h                           ; //glrc9h;
			boolean glrcev                           ; //glrcev;
			boolean glrc98                           ; //glrc98;
			boolean glrc97                           ; //glrc97;
			boolean glrcbl                           ; //glrcbl;
			real    rcvalue9r_1                      ; //rcvalue9r_1;
			real    rcvalue9r                        ; //rcvalue9r;
			real    rcvalue9g_1                      ; //rcvalue9g_1;
			real    rcvalue9g                        ; //rcvalue9g;
			real    rcvalue29_1                      ; //rcvalue29_1;
			real    rcvalue29                        ; //rcvalue29;
			real    rcvalue9e_1                      ; //rcvalue9e_1;
			real    rcvalue9e                        ; //rcvalue9e;
			real    rcvalue9a_1                      ; //rcvalue9a_1;
			real    rcvalue9a                        ; //rcvalue9a;
			real    rcvalue9d_1                      ; //rcvalue9d_1;
			real    rcvalue9d                        ; //rcvalue9d;
			real    rcvalue9f_1                      ; //rcvalue9f_1;
			real    rcvalue9f_2                      ; //rcvalue9f_2;
			real    rcvalue9f                        ; //rcvalue9f;
			real    rcvalue9p_1                      ; //rcvalue9p_1;
			real    rcvalue9p                        ; //rcvalue9p;
			real    rcvalue9o_1                      ; //rcvalue9o_1;
			real    rcvalue9o                        ; //rcvalue9o;
			real    rcvalue9h_1                      ; //rcvalue9h_1;
			real    rcvalue9h                        ; //rcvalue9h;
			real    rcvalueev_1                      ; //rcvalueev_1;
			real    rcvalueev                        ; //rcvalueev;
			real    rcvalue98_1                      ; //rcvalue98_1;
			real    rcvalue98                        ; //rcvalue98;
			real    rcvalue97_1                      ; //rcvalue97_1;
			real    rcvalue97                        ; //rcvalue97;
			real    rcvaluebl_1                      ; //rcvaluebl_1;
			real    rcvaluebl_2                      ; //rcvaluebl_2;
			real    rcvaluebl_3                      ; //rcvaluebl_3;
			real    rcvaluebl_4                      ; //rcvaluebl_4;
			real    rcvaluebl_5                      ; //rcvaluebl_5;
			real    rcvaluebl_6                      ; //rcvaluebl_6;
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
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_decsflag                      := le.iid.decsflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		age                              := le.name_verification.age;
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		paw_source_count                 := le.employment.source_ct;
		infutor_nap                      := le.Infutor_Phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		impulse_count30                  := le.impulse.count30;
		impulse_count90                  := le.impulse.count90;
		impulse_count180                 := le.impulse.count180;
		impulse_count12                  := le.impulse.count12;
		impulse_count24                  := le.impulse.count24;
		impulse_count36                  := le.impulse.count36;
		impulse_count60                  := le.impulse.count60;
		email_count                      := le.email_summary.email_ct;
		email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count30            := le.bjl.eviction_count30;
		attr_eviction_count90            := le.bjl.eviction_count90;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		criminal_count                   := le.bjl.criminal_count;
		ams_age                          := le.student.age;
		prof_license_category            := le.professional_license.plcategory;
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

first_seen_tn := if(Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ','), NULL);

first_seen_ts := if(Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ','), NULL);

first_seen_tu := if(Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ','), NULL);

first_seen_en := if(Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ','), NULL);

first_seen_eq := if(Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ','), NULL);

src_bureau_adl_fseen := if(max(first_seen_tn, first_seen_ts, first_seen_tu, first_seen_en, first_seen_eq) = NULL, NULL, min(if(first_seen_tn = NULL, -NULL, first_seen_tn), if(first_seen_ts = NULL, -NULL, first_seen_ts), if(first_seen_tu = NULL, -NULL, first_seen_tu), if(first_seen_en = NULL, -NULL, first_seen_en), if(first_seen_eq = NULL, -NULL, first_seen_eq)));

_src_bureau_adl_fseen := common.sas_date((string)(src_bureau_adl_fseen));

iv_mos_src_bureau_adl_fseen := map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

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

iv_ssn_miskey := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)rc_ssnmiskeyflag);

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

iv_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

iv_mos_since_gong_did_lst_seen_1 := if(not(truedid), NULL, NULL);

iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

iv_max_ids_per_sfd_addr_c6 := map(
    not(add1_pop) => NULL,
    iv_add_apt    => -1,
                     max(adls_per_addr_c6, ssns_per_addr_c6));

iv_phones_per_sfd_addr_c6 := map(
    not(add1_pop) => NULL,
    iv_add_apt    => -1,
                     phones_per_addr_c6);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

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

iv_impulse_recency := map(
    not(truedid)                            		=> NULL,
    impulse_count30  > 0                        => 1,
    impulse_count90  > 0                        => 3,
    impulse_count180 > 0                        => 6,
    impulse_count12  > 0                        => 12,
    impulse_count24  > 0                        => 24,
    impulse_count36  > 0                        => 36,
    impulse_count60  > 0                        => 60,
    impulse_count    > 0                        => 99,
    contains_i(email_source_list, 'IM') > 0 		=> 99,
																									 0);

iv_all_email_domain_isp := if(not(truedid), NULL, (integer)(email_count = email_domain_ISP_count) * min(if(email_count = NULL, -NULL, email_count), 5));

iv_attr_eviction_recency := map(
    not(truedid)           		 		=> NULL,
    attr_eviction_count30  > 0 		=> 1,
    attr_eviction_count90  > 0 		=> 3,
    attr_eviction_count180 > 0 		=> 6,
    attr_eviction_count12  > 0 		=> 12,
    attr_eviction_count24  > 0 		=> 24,
    attr_eviction_count36  > 0 		=> 36,
    attr_eviction_count60  > 0 		=> 60,
    attr_eviction_count    > 0 		=> 99,
																		 0);

iv_liens_unrel_x_rel := if(not(truedid), '   ', trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_prof_license_category := map(
    not(truedid)                 => '  ',
    prof_license_category = ''	 => '-1',
                                    prof_license_category);

ns_subscore0 := map(
    NULL < iv_mos_src_bureau_adl_fseen AND iv_mos_src_bureau_adl_fseen < 188 => -0.174245,
    188 <= iv_mos_src_bureau_adl_fseen AND iv_mos_src_bureau_adl_fseen < 260 => 0.069450,
    260 <= iv_mos_src_bureau_adl_fseen                                       => 0.353188,
                                                                                -0.000000);

ns_subscore1 := map(
    NULL < iv_combined_age AND iv_combined_age < 55 => -0.062684,
    55 <= iv_combined_age                           => 0.465432,
                                                       -0.000000);

ns_subscore2 := map(
    (iv_ssn_miskey in [0]) => 0.019199,
    (iv_ssn_miskey in [1]) => -0.984647,
                              0.000000);

ns_subscore3 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.269393,
    1 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 4   => 0.062166,
    4 <= iv_inp_addr_source_count                                    => 0.379852,
                                                                        0.000000);

ns_subscore4 := map(
    (iv_inp_addr_naprop in [0])    => -0.076413,
    (iv_inp_addr_naprop in [1, 2]) => 0.011897,
    (iv_inp_addr_naprop in [3])    => 0.240650,
    (iv_inp_addr_naprop in [4])    => 0.421876,
                                      0.000000);

ns_subscore5 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 5 => 0.020326,
    5 <= iv_addrs_5yr                        => -0.202731,
                                                -0.000000);

ns_subscore6 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.043167,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 33  => -0.352896,
    33 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 68 => -0.044569,
    68 <= iv_mos_since_gong_did_fst_seen                                         => 0.330411,
                                                                                    -0.000000);

ns_subscore7 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 0 => 0.005483,
    0 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 3   => 0.334732,
    3 <= iv_mos_since_gong_did_lst_seen                                          => -0.218793,
                                                                                    -0.000000);

ns_subscore8 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3 => 0.062788,
    3 <= iv_gong_did_phone_ct                                => -0.646489,
                                                                0.000000);

ns_subscore9 := map(
    NULL < iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 0 => 0.121527,
    0 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 1   => 0.100103,
    1 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 2   => -0.060274,
    2 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 3   => -0.138923,
    3 <= iv_max_ids_per_sfd_addr_c6                                      => -0.440239,
                                                                            0.000000);

ns_subscore10 := map(
    NULL < iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 0 => 0.023858,
    0 <= iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 1   => 0.101202,
    1 <= iv_phones_per_sfd_addr_c6                                     => -0.521727,
                                                                          -0.000000);

ns_subscore11 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.015323,
    1 <= iv_inq_highriskcredit_count12                                         => -0.572350,
                                                                                  -0.000000);

ns_subscore12 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.013405,
    1 <= iv_paw_source_count                               => 0.420189,
                                                              0.000000);

ns_subscore13 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1'])        => -0.148840,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '3-0'])                      => 0.464866,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '2-0', '2-1', '2-3', '3-1']) => 0.045595,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-3'])                             => -0.168044,
                                                                             0.000000);

ns_subscore14 := map(
    NULL < iv_impulse_recency AND iv_impulse_recency < 1 => 0.058716,
    1 <= iv_impulse_recency                              => -0.498879,
                                                            -0.000000);

ns_subscore15 := map(
    NULL < iv_all_email_domain_isp AND iv_all_email_domain_isp < 1 => -0.029379,
    1 <= iv_all_email_domain_isp                                   => 0.336716,
                                                                      0.000000);

ns_subscore16 := map(
    NULL < iv_attr_eviction_recency AND iv_attr_eviction_recency < 1 => 0.040123,
    1 <= iv_attr_eviction_recency                                    => -0.334344,
                                                                        -0.000000);

ns_subscore17 := map(
    (iv_liens_unrel_x_rel in ['Other'])                                                              => -0.000000,
    (iv_liens_unrel_x_rel in ['2-0', '3-0'])                                                         => -0.258431,
    (iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.026787,
                                                                                                        -0.000000);

ns_subscore18 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.020960,
    1 <= iv_criminal_count                             => -0.337638,
                                                          -0.000000);

ns_subscore19 := map(
    (iv_prof_license_category in ['-1'])                         => -0.012622,
    (iv_prof_license_category in ['0', '1', '2', '3', '4', '5']) => 0.679507,
                                                                    0.000000);

ns_rawscore := ns_subscore0 +
    ns_subscore1 +
    ns_subscore2 +
    ns_subscore3 +
    ns_subscore4 +
    ns_subscore5 +
    ns_subscore6 +
    ns_subscore7 +
    ns_subscore8 +
    ns_subscore9 +
    ns_subscore10 +
    ns_subscore11 +
    ns_subscore12 +
    ns_subscore13 +
    ns_subscore14 +
    ns_subscore15 +
    ns_subscore16 +
    ns_subscore17 +
    ns_subscore18 +
    ns_subscore19;

ns_logit := ns_rawscore + -0.343060;

base := 700;

pts := 40;

logit := ln(.57 / (1 - .57));

rvr1303_1_0 := map(
    rc_decsflag = '1'   => 200,
    iv_riskview_222s 		=> 222,
													 round(min(if(max(pts * (ns_logit - logit) / ln(2) + base, (real)501) = NULL, -NULL, max(pts * (ns_logit - logit) / ln(2) + base, (real)501)), 900)));

glrc9r := truedid;

glrc9g := iv_combined_age > 0 and iv_combined_age < 30;

glrc29 := not(iv_ssn_miskey = NULL);

glrc9e := add1_pop and truedid;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrc9d := truedid;

glrc9f := truedid;

glrc9p := truedid;

glrc9o := hphnpop and add1_pop and (nap_summary in [0, 1, 2, 3, 4]);

glrc9h := truedid;

glrcev := truedid;

glrc98 := truedid;

glrc97 := truedid;

glrcbl := 0;

rcvalue9r_1 := 0.353188 - ns_subscore0;

rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

rcvalue9g_1 := 0.465432 - ns_subscore1;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvalue29_1 := 0.019199 - ns_subscore2;

rcvalue29 := (integer)glrc29 * if(max(rcvalue29_1) = NULL, NULL, sum(if(rcvalue29_1 = NULL, 0, rcvalue29_1)));

rcvalue9e_1 := 0.379852 - ns_subscore3;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue9a_1 := 0.421876 - ns_subscore4;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9d_1 := 0.020326 - ns_subscore5;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9f_1 := 0.330411 - ns_subscore6;

rcvalue9f_2 := 0.334732 - ns_subscore7;

rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2)));

rcvalue9p_1 := 0.015323 - ns_subscore11;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9o_1 := 0.464866 - ns_subscore13;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue9h_1 := 0.058716 - ns_subscore14;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalueev_1 := 0.040123 - ns_subscore16;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvalue98_1 := 0.026787 - ns_subscore17;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue97_1 := 0.020960 - ns_subscore18;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvaluebl_1 := 0.062788 - ns_subscore8;

rcvaluebl_2 := (0.100103 - ns_subscore9) * (integer)(iv_max_ids_per_sfd_addr_c6 > -1);

rcvaluebl_3 := (0.101202 - ns_subscore10) * (integer)(iv_phones_per_sfd_addr_c6 > -1);

rcvaluebl_4 := 0.420189 - ns_subscore12;

rcvaluebl_5 := 0.336716 - ns_subscore15;

rcvaluebl_6 := 0.679507 - ns_subscore19;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'9R',    RCValue9R},
	{'9G',    RCValue9G},
	{'29',    RCValue29},
	{'9E',    RCValue9E},
	{'9A',    RCValue9A},
	{'9D',    RCValue9D},
	{'9F',    RCValue9F},
	{'9P',    RCValue9P},
	{'9O',    RCValue9O},
	{'9H',    RCValue9H},
	{'EV',    RCValueEV},
	{'98',    RCValue98},
	{'97',    RCValue97},
	{'BL',    RCValueBL}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := rcs_top4[1];
rcs_9p2 := rcs_top4[2];
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
rcs_9p5 := IF(GLRC9P AND NOT EXISTS(rcs_top4 (rc = '9P')) AND  // Check to see if RC 9P is a part of the score, but not in the first 4 RC's
								(iv_inq_highriskcredit_count12 > 0),
									DATASET([{'9P', NULL}], ds_layout)); // If so - make it the 5th reason code.

rcs_9p := rcs_9p1 & rcs_9p2  & rcs_9p3 & rcs_9p4 & rcs_9p5;

rcs_override := MAP(
										rvr1303_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
										rvr1303_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
										rvr1303_1_0 = 900 => DATASET([{'', NULL}], ds_layout),
										NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
										rcs_9p
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

	#if(RVR_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.first_seen_tn                    := first_seen_tn;
		self.first_seen_ts                    := first_seen_ts;
		self.first_seen_tu                    := first_seen_tu;
		self.first_seen_en                    := first_seen_en;
		self.first_seen_eq                    := first_seen_eq;
		self.src_bureau_adl_fseen             := src_bureau_adl_fseen;
		self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
		self.iv_mos_src_bureau_adl_fseen      := iv_mos_src_bureau_adl_fseen;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_ssn_miskey                    := iv_ssn_miskey;
		self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
		self.iv_inp_addr_naprop               := iv_inp_addr_naprop;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self._gong_did_first_seen             := _gong_did_first_seen;
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		self._gong_did_last_seen              := _gong_did_last_seen;
		self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
		self.iv_max_ids_per_sfd_addr_c6       := iv_max_ids_per_sfd_addr_c6;
		self.iv_phones_per_sfd_addr_c6        := iv_phones_per_sfd_addr_c6;
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
		self.iv_paw_source_count              := iv_paw_source_count;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_impulse_recency               := iv_impulse_recency;
		self.iv_all_email_domain_isp          := iv_all_email_domain_isp;
		self.iv_attr_eviction_recency         := iv_attr_eviction_recency;
		self.iv_liens_unrel_x_rel             := iv_liens_unrel_x_rel;
		self.iv_criminal_count                := iv_criminal_count;
		self.iv_prof_license_category         := iv_prof_license_category;
		self.ns_subscore0                     := ns_subscore0;
		self.ns_subscore1                     := ns_subscore1;
		self.ns_subscore2                     := ns_subscore2;
		self.ns_subscore3                     := ns_subscore3;
		self.ns_subscore4                     := ns_subscore4;
		self.ns_subscore5                     := ns_subscore5;
		self.ns_subscore6                     := ns_subscore6;
		self.ns_subscore7                     := ns_subscore7;
		self.ns_subscore8                     := ns_subscore8;
		self.ns_subscore9                     := ns_subscore9;
		self.ns_subscore10                    := ns_subscore10;
		self.ns_subscore11                    := ns_subscore11;
		self.ns_subscore12                    := ns_subscore12;
		self.ns_subscore13                    := ns_subscore13;
		self.ns_subscore14                    := ns_subscore14;
		self.ns_subscore15                    := ns_subscore15;
		self.ns_subscore16                    := ns_subscore16;
		self.ns_subscore17                    := ns_subscore17;
		self.ns_subscore18                    := ns_subscore18;
		self.ns_subscore19                    := ns_subscore19;
		self.ns_rawscore                      := ns_rawscore;
		self.ns_logit                         := ns_logit;
		self.base                             := base;
		self.pts                              := pts;
		self.logit                            := logit;
		self.rvr1303_1_0                      := rvr1303_1_0;
		self.glrc9r                           := glrc9r;
		self.glrc9g                           := glrc9g;
		self.glrc29                           := glrc29;
		self.glrc9e                           := glrc9e;
		self.glrc9a                           := glrc9a;
		self.glrc9d                           := glrc9d;
		self.glrc9f                           := glrc9f;
		self.glrc9p                           := glrc9p;
		self.glrc9o                           := glrc9o;
		self.glrc9h                           := glrc9h;
		self.glrcev                           := glrcev;
		self.glrc98                           := glrc98;
		self.glrc97                           := glrc97;
		self.glrcbl                           := glrcbl;
		self.rcvalue9r_1                      := rcvalue9r_1;
		self.rcvalue9r                        := rcvalue9r;
		self.rcvalue9g_1                      := rcvalue9g_1;
		self.rcvalue9g                        := rcvalue9g;
		self.rcvalue29_1                      := rcvalue29_1;
		self.rcvalue29                        := rcvalue29;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9f_1                      := rcvalue9f_1;
		self.rcvalue9f_2                      := rcvalue9f_2;
		self.rcvalue9f                        := rcvalue9f;
		self.rcvalue9p_1                      := rcvalue9p_1;
		self.rcvalue9p                        := rcvalue9p;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl_6                      := rcvaluebl_6;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := rcs_override[1].rc;
		self.rc2                              := rcs_override[2].rc;
		self.rc3                              := rcs_override[3].rc;
		self.rc4                              := rcs_override[4].rc;
		self.rc5                              := rcs_override[5].rc;

	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 				=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' 														=> '100',
																																				 (string3)RVR1303_1_0
										 );
END;

		model := project( clam, doModel(left) );

		return model;
END;

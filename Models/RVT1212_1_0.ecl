//T-Mobile (full file) custom score

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVT1212_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVT_DEBUG := false;

  #if(RVT_DEBUG)
    layout_debug := record
			integer  sysdate                          ;  //sysdate;
			integer  iv_input_dob_match_level         ;  //iv_input_dob_match_level;
			integer  _reported_dob                    ;  //_reported_dob;
			integer  reported_age                     ;  //reported_age;
			integer  iv_combined_age                  ;  //iv_combined_age;
			string   iv_best_match_address            ;  //iv_best_match_address;
			integer  iv_inp_addr_avm_auto_val         ;  //iv_inp_addr_avm_auto_val;
			integer  iv_inp_addr_naprop               ;  //iv_inp_addr_naprop;
			string   mortgage_type                    ;  //mortgage_type;
			boolean  mortgage_present                 ;  //mortgage_present;
			string   iv_inp_addr_mortgage_type        ;  //iv_inp_addr_mortgage_type;
			string   iv_inp_addr_vacant               ;  //iv_inp_addr_vacant;
			integer  iv_prv_addr_avm_auto_val         ;  //iv_prv_addr_avm_auto_val;
			integer  _gong_did_first_seen             ;  //_gong_did_first_seen;
			integer  iv_mos_since_gong_did_fst_seen   ;  //iv_mos_since_gong_did_fst_seen;
			integer  iv_ssns_per_adl                  ;  //iv_ssns_per_adl;
			integer  iv_max_ids_per_addr              ;  //iv_max_ids_per_addr;
			integer  iv_max_ids_per_addr_c6           ;  //iv_max_ids_per_addr_c6;
			integer  iv_adls_per_phone_c6             ;  //iv_adls_per_phone_c6;
			integer  iv_inq_count12                   ;  //iv_inq_count12;
			integer  iv_inq_highriskcredit_count12    ;  //iv_inq_highriskcredit_count12;
			integer  iv_paw_source_count              ;  //iv_paw_source_count;
			boolean  ver_phn_inf                      ;  //ver_phn_inf;
			boolean  ver_phn_nap                      ;  //ver_phn_nap;
			integer  inf_phn_ver_lvl                  ;  //inf_phn_ver_lvl;
			integer  nap_phn_ver_lvl                  ;  //nap_phn_ver_lvl;
			string   iv_nap_phn_ver_x_inf_phn_ver     ;  //iv_nap_phn_ver_x_inf_phn_ver;
			integer  iv_impulse_count                 ;  //iv_impulse_count;
			integer  iv_attr_addrs_recency            ;  //iv_attr_addrs_recency;
			integer  iv_attr_purchase_recency         ;  //iv_attr_purchase_recency;
			integer  iv_unreleased_liens_ct           ;  //iv_unreleased_liens_ct;
			integer  iv_criminal_count                ;  //iv_criminal_count;
			integer  iv_felony_count                  ;  //iv_felony_count;
			integer  iv_ams_college_code              ;  //iv_ams_college_code;
			integer  iv_prof_license_flag             ;  //iv_prof_license_flag;
			integer  iv_wealth_index                  ;  //iv_wealth_index;
			integer  sum_dols                         ;  //sum_dols;
			real     pct_offline_dols                 ;  //pct_offline_dols;
			real     pct_retail_dols                  ;  //pct_retail_dols;
			real     pct_online_dols                  ;  //pct_online_dols;
			string   iv_pb_profile                    ;  //iv_pb_profile;
			integer  iv_vs099_addr_not_ver_w_ssn      ;  //iv_vs099_addr_not_ver_w_ssn;
			real     s_subscore0                      ;  //s_subscore0;
			real     s_subscore1                      ;  //s_subscore1;
			real     s_subscore2                      ;  //s_subscore2;
			real     s_subscore3                      ;  //s_subscore3;
			real     s_subscore4                      ;  //s_subscore4;
			real     s_subscore5                      ;  //s_subscore5;
			real     s_subscore6                      ;  //s_subscore6;
			real     s_subscore7                      ;  //s_subscore7;
			real     s_subscore8                      ;  //s_subscore8;
			real     s_subscore9                      ;  //s_subscore9;
			real     s_subscore10                     ;  //s_subscore10;
			real     s_subscore11                     ;  //s_subscore11;
			real     s_subscore12                     ;  //s_subscore12;
			real     s_subscore13                     ;  //s_subscore13;
			real     s_subscore14                     ;  //s_subscore14;
			real     s_subscore15                     ;  //s_subscore15;
			real     s_subscore16                     ;  //s_subscore16;
			real     s_subscore17                     ;  //s_subscore17;
			real     s_subscore18                     ;  //s_subscore18;
			real     s_subscore19                     ;  //s_subscore19;
			real     s_subscore20                     ;  //s_subscore20;
			real     s_subscore21                     ;  //s_subscore21;
			real     s_subscore22                     ;  //s_subscore22;
			real     s_subscore23                     ;  //s_subscore23;
			real     s_subscore24                     ;  //s_subscore24;
			real     s_subscore25                     ;  //s_subscore25;
			real     s_subscore26                     ;  //s_subscore26;
			real     s_subscore27                     ;  //s_subscore27;
			real     s_rawscore                       ;  //s_rawscore;
			real     s_lnoddsscore                    ;  //s_lnoddsscore;
			real     s_probscore                      ;  //s_probscore;
			integer  base                             ;  //base;
			real     odds                             ;  //odds;
			integer  point                            ;  //point;
			boolean  ssn_deceased                     ;  //ssn_deceased;
			boolean  iv_riskview_222s                 ;  //iv_riskview_222s;
			integer  rvt1212_1                        ;  //rvt1212_1;
			boolean  glrc24                           ;  //glrc24;
			boolean  glrc28                           ;  //glrc28;
			boolean  glrc97                           ;  //glrc97;
			boolean  glrc98                           ;  //glrc98;
			boolean  glrc99                           ;  //glrc99;
			boolean  glrc9a                           ;  //glrc9a;
			boolean  glrc9d                           ;  //glrc9d;
			boolean  glrc9f                           ;  //glrc9f;
			boolean  glrc9g                           ;  //glrc9g;
			boolean  glrc9h                           ;  //glrc9h;
			boolean  glrc9i                           ;  //glrc9i;
			boolean  glrc9m                           ;  //glrc9m;
			boolean  glrc9o                           ;  //glrc9o;
			boolean  glrc9p                           ;  //glrc9p;
			boolean  glrc9q                           ;  //glrc9q;
			boolean  glrc9u                           ;  //glrc9u;
			boolean  glrcms                           ;  //glrcms;
			boolean  glrcpv                           ;  //glrcpv;
			boolean  glrcbl                           ;  //glrcbl;
			real     rcvalue24_1                      ;  //rcvalue24_1;
			real     rcvalue24                        ;  //rcvalue24;
			real     rcvalue28_1                      ;  //rcvalue28_1;
			real     rcvalue28                        ;  //rcvalue28;
			real     rcvalue97_1                      ;  //rcvalue97_1;
			real     rcvalue97_2                      ;  //rcvalue97_2;
			real     rcvalue97                        ;  //rcvalue97;
			real     rcvalue98_1                      ;  //rcvalue98_1;
			real     rcvalue98                        ;  //rcvalue98;
			real     rcvalue99_1                      ;  //rcvalue99_1;
			real     rcvalue99                        ;  //rcvalue99;
			real     rcvalue9a_1                      ;  //rcvalue9a_1;
			real     rcvalue9a                        ;  //rcvalue9a;
			real     rcvalue9d_1                      ;  //rcvalue9d_1;
			real     rcvalue9d                        ;  //rcvalue9d;
			real     rcvalue9f_1                      ;  //rcvalue9f_1;
			real     rcvalue9f                        ;  //rcvalue9f;
			real     rcvalue9g_1                      ;  //rcvalue9g_1;
			real     rcvalue9g                        ;  //rcvalue9g;
			real     rcvalue9h_1                      ;  //rcvalue9h_1;
			real     rcvalue9h                        ;  //rcvalue9h;
			real     rcvalue9i_1                      ;  //rcvalue9i_1;
			real     rcvalue9i                        ;  //rcvalue9i;
			real     rcvalue9m_1                      ;  //rcvalue9m_1;
			real     rcvalue9m                        ;  //rcvalue9m;
			real     rcvalue9o_1                      ;  //rcvalue9o_1;
			real     rcvalue9o                        ;  //rcvalue9o;
			real     rcvalue9p_1                      ;  //rcvalue9p_1;
			real     rcvalue9p                        ;  //rcvalue9p;
			real     rcvalue9q_1                      ;  //rcvalue9q_1;
			real     rcvalue9q                        ;  //rcvalue9q;
			real     rcvalue9u_1                      ;  //rcvalue9u_1;
			real     rcvalue9u                        ;  //rcvalue9u;
			real     rcvaluems_1                      ;  //rcvaluems_1;
			real     rcvaluems                        ;  //rcvaluems;
			real     rcvaluepv_1                      ;  //rcvaluepv_1;
			real     rcvaluepv                        ;  //rcvaluepv;
			real     rcvaluebl_1                      ;  //rcvaluebl_1;
			real     rcvaluebl_2                      ;  //rcvaluebl_2;
			real     rcvaluebl_3                      ;  //rcvaluebl_3;
			real     rcvaluebl_4                      ;  //rcvaluebl_4;
			real     rcvaluebl_5                      ;  //rcvaluebl_5;
			real     rcvaluebl_6                      ;  //rcvaluebl_6;
			real     rcvaluebl_7                      ;  //rcvaluebl_7;
			real     rcvaluebl_8                      ;  //rcvaluebl_8;
			real     rcvaluebl_9                      ;  //rcvaluebl_9;
			real     rcvaluebl                        ;  //rcvaluebl;
			string   rc1                              ;  //rc1;
			string   rc2                              ;  //rc2;
			string   rc3                              ;  //rc3;
			string   rc4                              ;  //rc4;
			string   rc5                              ;  //rc5;
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
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_offline_dollars               := (integer)le.ibehavior.offline_dollars;
	pb_online_dollars                := (integer)le.ibehavior.online_dollars;
	pb_retail_dollars                := (integer)le.ibehavior.retail_dollars;
	paw_source_count                 := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_date_first_purchase         := le.other_address_info.date_first_purchase;
	attr_num_purchase30              := le.other_address_info.num_purchase30;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;

NULL := -999999999;

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_input_dob_match_level := if(not(truedid and dobpop), null, (integer)input_dob_match_level);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) 					=> NULL,
    age > 0                					=> age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       					=> inferred_age,
    reported_age > 0       					=> reported_age,
    (integer)ams_age > 0   					=> (integer)ams_age,
																			 -1);

iv_best_match_address := map(
    add1_isbestmatch => 'ADD1',
    add2_isbestmatch => 'ADD2',
    add3_isbestmatch => 'ADD3',
                        'NONE');

iv_inp_addr_avm_auto_val := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

mortgage_type := add1_mortgage_type;

mortgage_present := not((add1_mortgage_date in [0]));

iv_inp_addr_mortgage_type := map(
    not(add1_pop)                                         => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type in ['U'])                              => 'Unknown        ',
    not(mortgage_type = '')                             	=> 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage');

iv_inp_addr_vacant := map(
    not(add1_pop)                    	=> '  ',
    add1_advo_address_vacancy = '' 		=> '-1',
                                        add1_advo_address_vacancy);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

iv_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));

iv_max_ids_per_addr_c6 := if(not(add1_pop), NULL, max(adls_per_addr_c6, ssns_per_addr_c6));

iv_adls_per_phone_c6 := if(not(hphnpop), NULL, adls_per_phone_c6);

iv_inq_count12 := if(not(truedid), NULL, inq_count12);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

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

iv_attr_addrs_recency := map(
    not(truedid)      		=> NULL,
    attr_addrs_last30 >0 	=> 1,
    attr_addrs_last90 >0 	=> 3,
    attr_addrs_last12 >0 	=> 12,
    attr_addrs_last24 >0 	=> 24,
    attr_addrs_last36 >0 	=> 36,
    addrs_5yr         >0 	=> 60,
    addrs_10yr        >0 	=> 120,
    addrs_15yr        >0 	=> 180,
    addrs_per_adl 	  >0 	=> 999,
														 0);

iv_attr_purchase_recency := map(
    not(truedid)                 	 => NULL,
    attr_num_purchase30   >0       => 1,
    attr_num_purchase90   >0       => 3,
    attr_num_purchase180  >0       => 6,
    attr_num_purchase12   >0       => 12,
    attr_num_purchase24   >0       => 24,
    attr_num_purchase36   >0       => 36,
    attr_num_purchase60   >0       => 60,
    attr_date_first_purchase > 0 	 => 99,
																			0);

iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_felony_count := if(not(truedid), NULL, felony_count);

iv_ams_college_code := map(
    not(truedid)            					=> NULL,
    ams_college_code = '' 						=> -1,
																				 (integer)ams_college_code);

iv_prof_license_flag := if(not(truedid), NULL, (integer)prof_license_flag);

iv_wealth_index := if(not(truedid), NULL, (integer)wealth_index);

sum_dols := if(max(pb_offline_dollars, pb_online_dollars, pb_retail_dollars) = NULL, NULL, sum(if(pb_offline_dollars = NULL, 0, pb_offline_dollars), if(pb_online_dollars = NULL, 0, pb_online_dollars), if(pb_retail_dollars = NULL, 0, pb_retail_dollars)));

pct_offline_dols := if(sum_dols > 0, pb_offline_dollars / sum_dols, -1);

pct_retail_dols := if(sum_dols > 0, pb_retail_dollars / sum_dols, -1);

pct_online_dols := if(sum_dols > 0, pb_online_dollars / sum_dols, -1);

iv_pb_profile := map(
    not(truedid)                					=> '                 ',
    pb_number_of_sources = '' 						=> '0 No Purch Data  ',
    pct_offline_dols > .50      					=> '1 Offline Shopper',
    pct_online_dols > .50       					=> '2 Online Shopper ',
    pct_retail_dols > .50       					=> '3 Retail Shopper ',
																						 '4 Other');

iv_vs099_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), null, (integer)(nas_summary in [4, 7, 9]));

s_subscore0 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['Other'])                                         => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                            => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.117756,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-1', '3-3'])                                    => 0.035860,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0'])                             => 0.358148,
                                                                                           0.000000);

s_subscore1 := map(
    NULL < iv_impulse_count AND iv_impulse_count < 1 => 0.062472,
    1 <= iv_impulse_count                            => -0.589106,
                                                        -0.000000);

s_subscore2 := map(
    (iv_vs099_addr_not_ver_w_ssn in [0]) => 0.116787,
    (iv_vs099_addr_not_ver_w_ssn in [1]) => -0.262993,
                                            0.000000);

s_subscore3 := map(
    NULL < iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 1         => -0.106465,
    1 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 29057       => -0.315143,
    29057 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 64718   => -0.062302,
    64718 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 98035   => 0.029233,
    98035 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 124452  => 0.037242,
    124452 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 154285 => 0.110872,
    154285 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 193780 => 0.245053,
    193780 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 250655 => 0.269202,
    250655 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 376572 => 0.289121,
    376572 <= iv_inp_addr_avm_auto_val                                       => 0.529156,
                                                                                -0.000000);

s_subscore4 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.098579,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.256976,
    2 <= iv_unreleased_liens_ct                                  => -0.311363,
                                                                    -0.000000);

s_subscore5 := map(
    17 < iv_combined_age AND iv_combined_age < 22  => -0.321911,
    22 <= iv_combined_age AND iv_combined_age < 25 => -0.188630,
    25 <= iv_combined_age AND iv_combined_age < 30 => -0.006166,
    30 <= iv_combined_age AND iv_combined_age < 36 => 0.063633,
    36 <= iv_combined_age AND iv_combined_age < 42 => 0.095650,
    42 <= iv_combined_age                          => 0.116890,
                                                      -0.000000);

s_subscore6 := map(
    (iv_wealth_index in [0])    => -0.000000,
    (iv_wealth_index in [1])    => -0.313709,
    (iv_wealth_index in [2])    => -0.192609,
    (iv_wealth_index in [3])    => 0.038028,
    (iv_wealth_index in [4])    => 0.169486,
    (iv_wealth_index in [5, 6]) => 0.305735,
                                   -0.000000);

s_subscore7 := map(
    (iv_ams_college_code in [-1])   => -0.035045,
    (iv_ams_college_code in [2])    => 0.177603,
    (iv_ams_college_code in [1, 4]) => 0.648317,
                                       0.000000);

s_subscore8 := map(
    (iv_attr_purchase_recency in [1, 3, 6, 12, 24]) => 0.564281,
    (iv_attr_purchase_recency in [36])              => 0.267089,
    (iv_attr_purchase_recency in [60])              => 0.204452,
    (iv_attr_purchase_recency in [99])              => 0.123088,
    (iv_attr_purchase_recency in [0])               => -0.069625,
                                                       0.000000);

s_subscore9 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => -0.030817,
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 38353       => -0.327334,
    38353 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 61292   => -0.217248,
    61292 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 93256   => -0.009053,
    93256 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 120500  => 0.035918,
    120500 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 143796 => 0.069158,
    143796 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 186147 => 0.191303,
    186147 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 245167 => 0.216017,
    245167 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 380295 => 0.319181,
    380295 <= iv_prv_addr_avm_auto_val                                       => 0.468318,
                                                                                0.000000);

s_subscore10 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.038744,
    1 <= iv_criminal_count AND iv_criminal_count < 3   => -0.327085,
    3 <= iv_criminal_count                             => -0.578114,
                                                          0.000000);

s_subscore11 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 1 => -0.262959,
    1 <= iv_ssns_per_adl AND iv_ssns_per_adl < 2   => 0.063693,
    2 <= iv_ssns_per_adl AND iv_ssns_per_adl < 3   => -0.132339,
    3 <= iv_ssns_per_adl AND iv_ssns_per_adl < 4   => -0.261834,
    4 <= iv_ssns_per_adl AND iv_ssns_per_adl < 5   => -0.333052,
    5 <= iv_ssns_per_adl                           => -0.585385,
                                                      -0.000000);

s_subscore12 := map(
    (iv_best_match_address in ['ADD1'])                 => 0.101063,
    (iv_best_match_address in ['ADD2', 'ADD3', 'NONE']) => -0.107748,
                                                           0.000000);

s_subscore13 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0  => 0.000000,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 45   => -0.163601,
    45 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 62  => -0.033768,
    62 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 81  => 0.033200,
    81 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 97  => 0.141957,
    97 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 122 => 0.280857,
    122 <= iv_mos_since_gong_did_fst_seen                                         => 0.418600,
                                                                                     0.000000);

s_subscore14 := map(
    (iv_inp_addr_naprop in [1])    => -0.105707,
    (iv_inp_addr_naprop in [0])    => 0.006679,
    (iv_inp_addr_naprop in [2, 3]) => 0.032657,
    (iv_inp_addr_naprop in [4])    => 0.189074,
                                      0.000000);

s_subscore15 := map(
    (iv_pb_profile in ['Other'])                       => -0.000000,
    (iv_pb_profile in ['0 No Purch Data'])             => -0.052874,
    (iv_pb_profile in ['1 Offline Shopper'])           => 0.010295,
    (iv_pb_profile in ['2 Online Shopper'])            => 0.197739,
    (iv_pb_profile in ['3 Retail Shopper', '4 Other']) => 0.232068,
                                                          -0.000000);

s_subscore16 := map(
    NULL < iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 1 => 0.062387,
    1 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 2   => -0.085063,
    2 <= iv_max_ids_per_addr_c6                                  => -0.187539,
                                                                    0.000000);

s_subscore17 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.031540,
    1 <= iv_paw_source_count                               => 0.276738,
                                                              -0.000000);

s_subscore18 := map(
    (iv_attr_addrs_recency in [1])                => -0.081455,
    (iv_attr_addrs_recency in [3, 12])            => -0.060655,
    (iv_attr_addrs_recency in [24, 36, 60])       => 0.081904,
    (iv_attr_addrs_recency in [0, 120, 180, 999]) => 0.173137,
                                                     0.000000);

s_subscore19 := map(
    (iv_inp_addr_mortgage_type in ['Other'])                                                                                      => -0.000000,
    (iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government'])                                                  => 0.197352,
    (iv_inp_addr_mortgage_type in ['Commercial', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.033670,
                                                                                                                                     -0.000000);

s_subscore20 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr < 1 => -0.000000,
    1 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 2   => -0.006402,
    2 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 4   => 0.221265,
    4 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 6   => 0.169064,
    6 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 14  => 0.046400,
    14 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 18 => -0.021730,
    18 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 24 => -0.053677,
    24 <= iv_max_ids_per_addr                              => -0.090357,
                                                              -0.000000);

s_subscore21 := map(
    (iv_input_dob_match_level in [0])          => 0.000000,
    (iv_input_dob_match_level in [1, 2, 3, 4]) => -0.372254,
    (iv_input_dob_match_level in [5, 6])       => -0.139288,
    (iv_input_dob_match_level in [7])          => -0.105429,
    (iv_input_dob_match_level in [8])          => 0.029315,
                                                  0.000000);

s_subscore22 := map(
    NULL < iv_inq_count12 AND iv_inq_count12 < 1 => 0.028860,
    1 <= iv_inq_count12                          => -0.182821,
                                                    0.000000);

s_subscore23 := map(
    NULL < iv_adls_per_phone_c6 AND iv_adls_per_phone_c6 < 1 => 0.014951,
    1 <= iv_adls_per_phone_c6                                => -0.345607,
                                                                0.000000);

s_subscore24 := map(
    NULL < iv_felony_count AND iv_felony_count < 1 => 0.011651,
    1 <= iv_felony_count                           => -0.448489,
                                                      0.000000);

s_subscore25 := map(
    (iv_prof_license_flag in [0]) => -0.014574,
    (iv_prof_license_flag in [1]) => 0.306747,
                                     0.000000);

s_subscore26 := map(
    (iv_inp_addr_vacant in ['Other']) => 0.000000,
    (iv_inp_addr_vacant in ['-1'])    => 0.000000,
    (iv_inp_addr_vacant in ['N'])     => 0.007272,
    (iv_inp_addr_vacant in ['Y'])     => -0.291868,
                                         0.000000);

s_subscore27 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.008056,
    1 <= iv_inq_highriskcredit_count12                                         => -0.194484,
                                                                                  -0.000000);

s_rawscore := s_subscore0 +
    s_subscore1 +
    s_subscore2 +
    s_subscore3 +
    s_subscore4 +
    s_subscore5 +
    s_subscore6 +
    s_subscore7 +
    s_subscore8 +
    s_subscore9 +
    s_subscore10 +
    s_subscore11 +
    s_subscore12 +
    s_subscore13 +
    s_subscore14 +
    s_subscore15 +
    s_subscore16 +
    s_subscore17 +
    s_subscore18 +
    s_subscore19 +
    s_subscore20 +
    s_subscore21 +
    s_subscore22 +
    s_subscore23 +
    s_subscore24 +
    s_subscore25 +
    s_subscore26 +
    s_subscore27;

s_lnoddsscore := s_rawscore + 0.922357;

s_probscore := exp(s_lnoddsscore) / (1 + exp(s_lnoddsscore));

base := 700;

odds := (1 - 0.289) / 0.289;

point := 40;

ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvt1212_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(point * (ln(s_probscore / (1 - s_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(s_probscore / (1 - s_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

glrc24 := truedid and addrpop and (integer)ssnlength > 0;

glrc28 := truedid and dobpop;

glrc97 := truedid; 

glrc98 := truedid; 

glrc99 := truedid and addrpop;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrc9d := truedid;

glrc9f := truedid;

glrc9g := (truedid or dobpop) and 18 <= iv_combined_age AND iv_combined_age <= 29;

glrc9h := truedid;

glrc9i := truedid and 18 <= iv_combined_age AND iv_combined_age <= 25 and iv_ams_college_code = -1;

glrc9m := truedid;

glrc9o := hphnpop and addrpop and (nap_summary in [0, 1, 2, 3, 4]);

glrc9p := truedid;

glrc9q := truedid;

glrc9u := addrpop and add1_advo_address_vacancy != ' ';

glrcms := truedid and ssns_per_adl > 1;

glrcpv := truedid and addrpop;

glrcbl := 0;

rcvalue24_1 := 0.116787 - s_subscore2;

rcvalue24 := (integer)glrc24 * if(max(rcvalue24_1) = NULL, NULL, sum(if(rcvalue24_1 = NULL, 0, rcvalue24_1)));

rcvalue28_1 := 0.029315 - s_subscore21;

rcvalue28 := (integer)glrc28 * if(max(rcvalue28_1) = NULL, NULL, sum(if(rcvalue28_1 = NULL, 0, rcvalue28_1)));

rcvalue97_1 := 0.038744 - s_subscore10;

rcvalue97_2 := 0.011651 - s_subscore24;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvalue98_1 := 0.098579 - s_subscore4;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue99_1 := 0.101063 - s_subscore12;

rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

rcvalue9a_1 := 0.189074 - s_subscore14;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9d_1 := 0.173137 - s_subscore18;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9f_1 := 0.4186 - s_subscore13;

rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

rcvalue9g_1 := 0.11689 - s_subscore5;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvalue9h_1 := 0.062472 - s_subscore1;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9i_1 := 0.648317 - s_subscore7;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9m_1 := 0.305735 - s_subscore6;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9o_1 := 0.358148 - s_subscore0;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue9p_1 := 0.008056 - s_subscore27;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvalue9q_1 := 0.02886 - s_subscore22;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9u_1 := 0.007272 - s_subscore26;

rcvalue9u := (integer)glrc9u * if(max(rcvalue9u_1) = NULL, NULL, sum(if(rcvalue9u_1 = NULL, 0, rcvalue9u_1)));

rcvaluems_1 := 0.063693 - s_subscore11;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluepv_1 := 0.529156 - s_subscore3;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvaluebl_1 := 0.468318 - s_subscore9;

rcvaluebl_2 := 0.232068 - s_subscore15;

rcvaluebl_3 := 0.062387 - s_subscore16;

rcvaluebl_4 := 0.276738 - s_subscore17;

rcvaluebl_5 := 0.221265 - s_subscore20;

rcvaluebl_6 := 0.014951 - s_subscore23;

rcvaluebl_7 := 0.306747 - s_subscore25;

rcvaluebl_8 := 0.564281 - s_subscore8;

rcvaluebl_9 := 0.197352 - s_subscore19;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6, rcvaluebl_7, rcvaluebl_8, rcvaluebl_9) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6), if(rcvaluebl_7 = NULL, 0, rcvaluebl_7), if(rcvaluebl_8 = NULL, 0, rcvaluebl_8), if(rcvaluebl_9 = NULL, 0, rcvaluebl_9)));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'24',    RCValue24},
	{'28',    RCValue28},
	{'97',    RCValue97},
	{'98',    RCValue98},
	{'99',    RCValue99},
	{'9A',    RCValue9A},
	{'9D',    RCValue9D},
	{'9F',    RCValue9F},
	{'9G',    RCValue9G},
	{'9H',    RCValue9H},
	{'9I',    RCValue9I},
	{'9M',    RCValue9M},
	{'9O',    RCValue9O},
	{'9P',    RCValue9P},
	{'9Q',    RCValue9Q},
	{'9U',    RCValue9U},
	{'MS',    RCValueMS},
	{'PV',    RCValuePV},
	{'BL',    RCValueBL}
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
										rvt1212_1 = 200 => DATASET([{'02', NULL}], ds_layout),
										rvt1212_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
										rvt1212_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
										NOT EXISTS(rcs_9q(rc != '')) => DATASET([{'36', NULL}], ds_layout),
										rcs_9q
									 );

rc2_36 := DATASET([{'36', NULL}], ds_layout);									 
rc2_9E := DATASET([{'9E', NULL}], ds_layout);	
								 
rcs_override2 := MAP(
										 rcs_override[2].rc = '' AND 500 < rvt1212_1 AND rvt1212_1 < 850 AND rcs_override[1].rc <> '36'   => rcs_override[1] & rc2_9E & rcs_override[3] & rcs_override[4] & rcs_override[5], 
										 rcs_override[2].rc = '' AND 500 < rvt1212_1 AND rvt1212_1 < 850   															  => rcs_override[1] & rc2_36 & rcs_override[3] & rcs_override[4] & rcs_override[5], 
																																																											   rcs_override);								 

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

rcs_final := PROJECT(rcs_override2, TRANSFORM(Risk_Indicators.Layout_Desc,
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

#if(RVT_DEBUG)
	self.clam															:= le;
	self.sysdate                          := sysdate;
	self.iv_input_dob_match_level         := iv_input_dob_match_level;
	self._reported_dob                    := _reported_dob;
	self.reported_age                     := reported_age;
	self.iv_combined_age                  := iv_combined_age;
	self.iv_best_match_address            := iv_best_match_address;
	self.iv_inp_addr_avm_auto_val         := iv_inp_addr_avm_auto_val;
	self.iv_inp_addr_naprop               := iv_inp_addr_naprop;
	self.mortgage_type                    := mortgage_type;
	self.mortgage_present                 := mortgage_present;
	self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
	self.iv_inp_addr_vacant               := iv_inp_addr_vacant;
	self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
	self._gong_did_first_seen             := _gong_did_first_seen;
	self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
	self.iv_ssns_per_adl                  := iv_ssns_per_adl;
	self.iv_max_ids_per_addr              := iv_max_ids_per_addr;
	self.iv_max_ids_per_addr_c6           := iv_max_ids_per_addr_c6;
	self.iv_adls_per_phone_c6             := iv_adls_per_phone_c6;
	self.iv_inq_count12                   := iv_inq_count12;
	self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
	self.iv_paw_source_count              := iv_paw_source_count;
	self.ver_phn_inf                      := ver_phn_inf;
	self.ver_phn_nap                      := ver_phn_nap;
	self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
	self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
	self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
	self.iv_impulse_count                 := iv_impulse_count;
	self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
	self.iv_attr_purchase_recency         := iv_attr_purchase_recency;
	self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
	self.iv_criminal_count                := iv_criminal_count;
	self.iv_felony_count                  := iv_felony_count;
	self.iv_ams_college_code              := iv_ams_college_code;
	self.iv_prof_license_flag             := iv_prof_license_flag;
	self.iv_wealth_index                  := iv_wealth_index;
	self.sum_dols                         := sum_dols;
	self.pct_offline_dols                 := pct_offline_dols;
	self.pct_retail_dols                  := pct_retail_dols;
	self.pct_online_dols                  := pct_online_dols;
	self.iv_pb_profile                    := iv_pb_profile;
	self.iv_vs099_addr_not_ver_w_ssn      := iv_vs099_addr_not_ver_w_ssn;
	self.s_subscore0                      := s_subscore0;
	self.s_subscore1                      := s_subscore1;
	self.s_subscore2                      := s_subscore2;
	self.s_subscore3                      := s_subscore3;
	self.s_subscore4                      := s_subscore4;
	self.s_subscore5                      := s_subscore5;
	self.s_subscore6                      := s_subscore6;
	self.s_subscore7                      := s_subscore7;
	self.s_subscore8                      := s_subscore8;
	self.s_subscore9                      := s_subscore9;
	self.s_subscore10                     := s_subscore10;
	self.s_subscore11                     := s_subscore11;
	self.s_subscore12                     := s_subscore12;
	self.s_subscore13                     := s_subscore13;
	self.s_subscore14                     := s_subscore14;
	self.s_subscore15                     := s_subscore15;
	self.s_subscore16                     := s_subscore16;
	self.s_subscore17                     := s_subscore17;
	self.s_subscore18                     := s_subscore18;
	self.s_subscore19                     := s_subscore19;
	self.s_subscore20                     := s_subscore20;
	self.s_subscore21                     := s_subscore21;
	self.s_subscore22                     := s_subscore22;
	self.s_subscore23                     := s_subscore23;
	self.s_subscore24                     := s_subscore24;
	self.s_subscore25                     := s_subscore25;
	self.s_subscore26                     := s_subscore26;
	self.s_subscore27                     := s_subscore27;
	self.s_rawscore                       := s_rawscore;
	self.s_lnoddsscore                    := s_lnoddsscore;
	self.s_probscore                      := s_probscore;
	self.base                             := base;
	self.odds                             := odds;
	self.point                            := point;
	self.ssn_deceased                     := ssn_deceased;
	self.iv_riskview_222s                 := iv_riskview_222s;
	self.rvt1212_1                        := rvt1212_1;
	self.glrc24                           := glrc24;
	self.glrc28                           := glrc28;
	self.glrc97                           := glrc97;
	self.glrc98                           := glrc98;
	self.glrc99                           := glrc99;
	self.glrc9a                           := glrc9a;
	self.glrc9d                           := glrc9d;
	self.glrc9f                           := glrc9f;
	self.glrc9g                           := glrc9g;
	self.glrc9h                           := glrc9h;
	self.glrc9i                           := glrc9i;
	self.glrc9m                           := glrc9m;
	self.glrc9o                           := glrc9o;
	self.glrc9p                           := glrc9p;
	self.glrc9q                           := glrc9q;
	self.glrc9u                           := glrc9u;
	self.glrcms                           := glrcms;
	self.glrcpv                           := glrcpv;
	self.glrcbl                           := glrcbl;
	self.rcvalue24_1                      := rcvalue24_1;
	self.rcvalue24                        := rcvalue24;
	self.rcvalue28_1                      := rcvalue28_1;
	self.rcvalue28                        := rcvalue28;
	self.rcvalue97_1                      := rcvalue97_1;
	self.rcvalue97_2                      := rcvalue97_2;
	self.rcvalue97                        := rcvalue97;
	self.rcvalue98_1                      := rcvalue98_1;
	self.rcvalue98                        := rcvalue98;
	self.rcvalue99_1                      := rcvalue99_1;
	self.rcvalue99                        := rcvalue99;
	self.rcvalue9a_1                      := rcvalue9a_1;
	self.rcvalue9a                        := rcvalue9a;
	self.rcvalue9d_1                      := rcvalue9d_1;
	self.rcvalue9d                        := rcvalue9d;
	self.rcvalue9f_1                      := rcvalue9f_1;
	self.rcvalue9f                        := rcvalue9f;
	self.rcvalue9g_1                      := rcvalue9g_1;
	self.rcvalue9g                        := rcvalue9g;
	self.rcvalue9h_1                      := rcvalue9h_1;
	self.rcvalue9h                        := rcvalue9h;
	self.rcvalue9i_1                      := rcvalue9i_1;
	self.rcvalue9i                        := rcvalue9i;
	self.rcvalue9m_1                      := rcvalue9m_1;
	self.rcvalue9m                        := rcvalue9m;
	self.rcvalue9o_1                      := rcvalue9o_1;
	self.rcvalue9o                        := rcvalue9o;
	self.rcvalue9p_1                      := rcvalue9p_1;
	self.rcvalue9p                        := rcvalue9p;
	self.rcvalue9q_1                      := rcvalue9q_1;
	self.rcvalue9q                        := rcvalue9q;
	self.rcvalue9u_1                      := rcvalue9u_1;
	self.rcvalue9u                        := rcvalue9u;
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
	self.rcvaluebl_7                      := rcvaluebl_7;
	self.rcvaluebl_8                      := rcvaluebl_8;
	self.rcvaluebl_9                      := rcvaluebl_9;
	self.rcvaluebl                        := rcvaluebl;
	self.rc1                              := rcs_override2[1].rc;
	self.rc2                              := rcs_override2[2].rc;
	self.rc3                              := rcs_override2[3].rc;
	self.rc4                              := rcs_override2[4].rc;
	self.rc5                              := rcs_override2[5].rc;
#end
	SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																						SELF.hri := if(LEFT.hri='', '00', left.hri),
																						SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																				));
	self.seq := le.seq;
	self.score := MAP(
										reasons[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)reasons[1].hri + 10),
										reasons[1].hri='35' => '100',
										(string3)RVT1212_1
									);
END;
		model := project( clam, doModel(left) );
		return model;
END;
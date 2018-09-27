//Santander B-Paper Custom Model Refresh

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVA1304_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
			integer sysdate                          ;  //sysdate;
			boolean iv_pots_phone                    ;  //iv_pots_phone;
			boolean iv_add_apt                       ;  //iv_add_apt;
			boolean iv_riskview_222s                 ;  //iv_riskview_222s;
			integer _in_dob                          ;  //_in_dob;
			real    yr_in_dob                        ;  //yr_in_dob;
			integer yr_in_dob_int                    ;  //yr_in_dob_int;
			integer age_estimate                     ;  //age_estimate;
			integer iv_ag001_age                     ;  //iv_ag001_age;
			string  iv_va007_add_vacant              ;  //iv_va007_add_vacant;
			integer iv_va040_add_prison_hist         ;  //iv_va040_add_prison_hist;
			integer iv_de001_eviction_recency        ;  //iv_de001_eviction_recency;
			boolean email_src_im                     ;  //email_src_im;
			integer iv_ds001_impulse_count           ;  //iv_ds001_impulse_count;
			string  iv_ed001_college_ind_37          ;  //iv_ed001_college_ind_37;
			integer iv_src_property_adl_count        ;  //iv_src_property_adl_count;
			integer iv_addr_non_phn_src_ct           ;  //iv_addr_non_phn_src_ct;
			string  iv_best_match_address            ;  //iv_best_match_address;
			string  iv_inp_addr_house_number_match   ;  //iv_inp_addr_house_number_match;
			string  iv_inp_addr_ownership_lvl        ;  //iv_inp_addr_ownership_lvl;
			string  iv_bst_addr_avm_land_use         ;  //iv_bst_addr_avm_land_use;
			integer iv_avg_prop_assess_purch_amt     ;  //iv_avg_prop_assess_purch_amt;
			integer iv_addrs_5yr                     ;  //iv_addrs_5yr;
			integer iv_credit_seeking                ;  //iv_credit_seeking;
			integer _infutor_first_seen              ;  //_infutor_first_seen;
			integer iv_mos_since_infutor_first_seen  ;  //iv_mos_since_infutor_first_seen;
			boolean ver_phn_inf                      ;  //ver_phn_inf;
			boolean ver_phn_nap                      ;  //ver_phn_nap;
			string  inf_phn_ver_lvl                  ;  //inf_phn_ver_lvl;
			string  nap_phn_ver_lvl                  ;  //nap_phn_ver_lvl;
			string  iv_nap_phn_ver_x_inf_phn_ver     ;  //iv_nap_phn_ver_x_inf_phn_ver;
			integer iv_email_domain_free_count       ;  //iv_email_domain_free_count;
			integer iv_attr_addrs_recency            ;  //iv_attr_addrs_recency;
			integer iv_derog_ratio                   ;  //iv_derog_ratio;
			string  iv_liens_unrel_x_rel             ;  //iv_liens_unrel_x_rel;
			integer iv_liens_unrel_cj_ct             ;  //iv_liens_unrel_cj_ct;
			integer iv_liens_unrel_sc_ct             ;  //iv_liens_unrel_sc_ct;
			string  iv_criminal_x_felony             ;  //iv_criminal_x_felony;
			string  iv_prof_license_category         ;  //iv_prof_license_category;
			integer iv_pb_total_orders               ;  //iv_pb_total_orders;
			real    bri_subscore0                    ;  //bri_subscore0;
			real    bri_subscore1                    ;  //bri_subscore1;
			real    bri_subscore2                    ;  //bri_subscore2;
			real    bri_subscore3                    ;  //bri_subscore3;
			real    bri_subscore4                    ;  //bri_subscore4;
			real    bri_subscore5                    ;  //bri_subscore5;
			real    bri_subscore6                    ;  //bri_subscore6;
			real    bri_subscore7                    ;  //bri_subscore7;
			real    bri_subscore8                    ;  //bri_subscore8;
			real    bri_subscore9                    ;  //bri_subscore9;
			real    bri_subscore10                   ;  //bri_subscore10;
			real    bri_subscore11                   ;  //bri_subscore11;
			real    bri_subscore12                   ;  //bri_subscore12;
			real    bri_subscore13                   ;  //bri_subscore13;
			real    bri_subscore14                   ;  //bri_subscore14;
			real    bri_subscore15                   ;  //bri_subscore15;
			real    bri_subscore16                   ;  //bri_subscore16;
			real    bri_subscore17                   ;  //bri_subscore17;
			real    bri_subscore18                   ;  //bri_subscore18;
			real    bri_subscore19                   ;  //bri_subscore19;
			real    bri_subscore20                   ;  //bri_subscore20;
			real    bri_subscore21                   ;  //bri_subscore21;
			real    bri_subscore22                   ;  //bri_subscore22;
			real    bri_subscore23                   ;  //bri_subscore23;
			real    bri_subscore24                   ;  //bri_subscore24;
			real    bri_rawscore                     ;  //bri_rawscore;
			real    bri_lnoddsscore                  ;  //bri_lnoddsscore;
			real    bri_probscore                    ;  //bri_probscore;
			integer bbase                            ;  //bbase;
			integer bpts                             ;  //bpts;
			real    blogit                           ;  //blogit;
			integer rva1304_1_0                      ;  //rva1304_1_0;
			boolean criminal_flag                    ;  //criminal_flag;
			boolean lien_unrel_flag                  ;  //lien_unrel_flag;
			boolean bankruptcy_flag                  ;  //bankruptcy_flag;
			boolean impulse_flag                     ;  //impulse_flag;
			boolean eviction_flag                    ;  //eviction_flag;
			integer derog_flag_sum                   ;  //derog_flag_sum;
			real    divptslost_iv_derog_ratio        ;  //divptslost_iv_derog_ratio;
			boolean glrc9k                           ;  //glrc9k;
			boolean glrc9n                           ;  //glrc9n;
			boolean glrcev                           ;  //glrcev;
			boolean glrc9h                           ;  //glrc9h;
			boolean glrc9e                           ;  //glrc9e;
			boolean glrc99                           ;  //glrc99;
			boolean glrc30                           ;  //glrc30;
			boolean glrc9a                           ;  //glrc9a;
			boolean glrcpv                           ;  //glrcpv;
			boolean glrc9d                           ;  //glrc9d;
			boolean glrc9o                           ;  //glrc9o;
			boolean glrc98                           ;  //glrc98;
			boolean glrc97                           ;  //glrc97;
			boolean glrc9w                           ;  //glrc9w;
			boolean glrcbl                           ;  //glrcbl;
			real    rcvalue9k_1                      ;  //rcvalue9k_1;
			real    rcvalue9k                        ;  //rcvalue9k;
			real    rcvalue9n_1                      ;  //rcvalue9n_1;
			real    rcvalue9n                        ;  //rcvalue9n;
			real    rcvalueev_1                      ;  //rcvalueev_1;
			real    rcvalueev_2                      ;  //rcvalueev_2;
			real    rcvalueev                        ;  //rcvalueev;
			real    rcvalue9h_1                      ;  //rcvalue9h_1;
			real    rcvalue9h_2                      ;  //rcvalue9h_2;
			real    rcvalue9h                        ;  //rcvalue9h;
			real    rcvalue9e_1                      ;  //rcvalue9e_1;
			real    rcvalue9e                        ;  //rcvalue9e;
			real    rcvalue99_1                      ;  //rcvalue99_1;
			real    rcvalue99                        ;  //rcvalue99;
			real    rcvalue30_1                      ;  //rcvalue30_1;
			real    rcvalue30                        ;  //rcvalue30;
			real    rcvalue9a_1                      ;  //rcvalue9a_1;
			real    rcvalue9a                        ;  //rcvalue9a;
			real    rcvaluepv_1                      ;  //rcvaluepv_1;
			real    rcvaluepv                        ;  //rcvaluepv;
			real    rcvalue9d_1                      ;  //rcvalue9d_1;
			real    rcvalue9d_2                      ;  //rcvalue9d_2;
			real    rcvalue9d                        ;  //rcvalue9d;
			real    rcvalue9o_1                      ;  //rcvalue9o_1;
			real    rcvalue9o                        ;  //rcvalue9o;
			real    rcvalue98_1                      ;  //rcvalue98_1;
			real    rcvalue98_2                      ;  //rcvalue98_2;
			real    rcvalue98_3                      ;  //rcvalue98_3;
			real    rcvalue98_4                      ;  //rcvalue98_4;
			real    rcvalue98                        ;  //rcvalue98;
			real    rcvalue97_1                      ;  //rcvalue97_1;
			real    rcvalue97_2                      ;  //rcvalue97_2;
			real    rcvalue97                        ;  //rcvalue97;
			real    rcvalue9w_1                      ;  //rcvalue9w_1;
			real    rcvalue9w                        ;  //rcvalue9w;
			real    rcvaluebl_1                      ;  //rcvaluebl_1;
			real    rcvaluebl_2                      ;  //rcvaluebl_2;
			real    rcvaluebl_3                      ;  //rcvaluebl_3;
			real    rcvaluebl_4                      ;  //rcvaluebl_4;
			real    rcvaluebl_5                      ;  //rcvaluebl_5;
			real    rcvaluebl_6                      ;  //rcvaluebl_6;
			real    rcvaluebl_7                      ;  //rcvaluebl_7;
			real    rcvaluebl_8                      ;  //rcvaluebl_8;
			real    rcvaluebl                        ;  //rcvaluebl;
			string  rc1                              ;  //rc1;
			string  rc2                              ;  //rc2;
			string  rc3                              ;  //rc3;
			string  rc4                              ;  //rc4;
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
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	telcordia_type                   := le.phone_verification.telcordia_type;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_communications_count03       := le.acc_logs.communications.count03;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_category            := le.professional_license.plcategory;
	inferred_age                     := le.inferred_age;

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

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)   ;

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(in_dob = '0', 0, if(in_dob = '', -1, (sysdate - _in_dob) / 365.25));

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_va007_add_vacant := map(
    not(add1_pop)                                                  => ' ',
    trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y' => '1',
                                                                      '0');

iv_va040_add_prison_hist := if(not(truedid), NULL, (integer)addrs_prison_history);

iv_de001_eviction_recency := map(
    not(truedid)                                                => NULL,
    attr_eviction_count90 > 0                                   => 3,
    attr_eviction_count180 > 0                                  => 6,
    attr_eviction_count12 > 0                                   => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    attr_eviction_count24 > 0                                   => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    attr_eviction_count36 > 0                                   => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    attr_eviction_count60 > 0                                   => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and email_src_im		 => 1,
                                              impulse_count);

iv_ed001_college_ind_37 := map(
    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 37                                                                                                                                                                      => ' ',
    ams_college_code != '' or trim(trim(ams_college_type, LEFT), LEFT, RIGHT) != '' or ams_college_tier >= '0' or trim(trim(ams_college_major, LEFT), LEFT, RIGHT) != '' or (trim(trim(ams_file_type, LEFT), LEFT, RIGHT) in ['H', 'C', 'A']) => '1',
    trim(trim(ams_file_type, LEFT), LEFT, RIGHT) = 'M'                                                                                                                                                                                        => '0',
    trim(trim(ams_class, LEFT), LEFT, RIGHT) != '' or trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) != ''                                                                                                                              => '1',
                                                                                                                                                                                                                                                 '0');

iv_src_property_adl_count := if(not(truedid), 
																NULL, 
																max(
																		if(max(Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')) = '', 
																				NULL, 
																				sum(
																						if(Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',') = '', 
																								0, 
																								(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')
																							)
																					 )
																			), 
																		0
																	 )
															 );

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

iv_best_match_address := map(
    add1_isbestmatch => 'ADD1',
    add2_isbestmatch => 'ADD2',
    add3_isbestmatch => 'ADD3',
                        'NONE');

// iv_inp_addr_house_number_match := if(not(add1_pop), NULL, add1_house_number_match);
iv_inp_addr_house_number_match := if(not(add1_pop), '', if(add1_house_number_match, '1', '0'));

iv_inp_addr_ownership_lvl := map(
    not(add1_pop)        => '            ',
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_avm_land_use := map(
    not(truedid)     => '',
    add1_isbestmatch => add1_avm_land_use,
                        add2_avm_land_use);

iv_avg_prop_assess_purch_amt := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
                                         -1);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

iv_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));

_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

iv_mos_since_infutor_first_seen := map(
    not(hphnpop)                    => NULL,
    not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
                                       -1);

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

iv_attr_addrs_recency := map(
    not(truedid)      		=> NULL,
    attr_addrs_last30 > 0 => 1,
    attr_addrs_last90 > 0 => 3,
    attr_addrs_last12 > 0 => 12,
    attr_addrs_last24 > 0 => 24,
    attr_addrs_last36 > 0 => 36,
    addrs_5yr         > 0 => 60,
    addrs_10yr        > 0 => 120,
    addrs_15yr        > 0 => 180,
    addrs_per_adl > 0 		=> 999,
														 0);

iv_derog_ratio := map(
    not(truedid)                                            => NULL,
    attr_num_nonderogs = 0 and attr_total_number_derogs = 0 => -1,
    attr_num_nonderogs > 0 and attr_total_number_derogs = 0 => 100 + 10 * min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10),
                                                               if (attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10 >= 0, roundup(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10), truncate(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10)) * 10);

iv_liens_unrel_x_rel := if(not(truedid),'   ',trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL,NULL,sum(if(liens_recent_unreleased_count = NULL, 0,	liens_recent_unreleased_count),if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))= NULL,-NULL,if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL,NULL,sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count),if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

iv_liens_unrel_cj_ct := if(not(truedid), NULL, liens_unrel_CJ_ct);

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

iv_criminal_x_felony := if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_prof_license_category := map(
    not(truedid)                 => '  ',
    prof_license_category = '' 	 => '-1',
                                    prof_license_category);

iv_pb_total_orders := map(
    not(truedid)           						=> NULL,
    pb_total_orders = '' 							=> -1,
																				 (integer)pb_total_orders);

bri_subscore0 := map(
    (iv_va007_add_vacant in ['Other', '0']) => 0.000915,
    (iv_va007_add_vacant in ['1'])          => -0.169060,
                                               0.000000);

bri_subscore1 := map(
    NULL < iv_va040_add_prison_hist AND iv_va040_add_prison_hist < 1 => 0.000124,
    1 <= iv_va040_add_prison_hist                                    => -0.159605,
                                                                        0.000000);

bri_subscore2 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.008203,
    3 <= iv_de001_eviction_recency                                     => -0.227475,
                                                                          0.000000);

bri_subscore3 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.004485,
    1 <= iv_ds001_impulse_count                                  => -0.520610,
                                                                    0.000000);

bri_subscore4 := map(
    (iv_ed001_college_ind_37 in ['Other']) => 0.000000,
    (iv_ed001_college_ind_37 in ['0'])     => -0.051781,
    (iv_ed001_college_ind_37 in ['1'])     => 0.190623,
                                              0.000000);

bri_subscore5 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 6 => -0.011326,
    6 <= iv_src_property_adl_count                                     => 0.339263,
                                                                          0.000000);

bri_subscore6 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.081709,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => -0.044351,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.048975,
    3 <= iv_addr_non_phn_src_ct                                  => 0.096122,
                                                                    0.000000);

bri_subscore7 := map(
    (iv_best_match_address in ['ADD1'])                 => 0.013095,
    (iv_best_match_address in ['ADD2', 'ADD3', 'NONE']) => -0.033678,
                                                           0.000000);

bri_subscore8 := map(
    (iv_inp_addr_house_number_match in ['Other', '0']) => -0.064222,
    (iv_inp_addr_house_number_match in ['1'])          => 0.008852,
                                                          0.000000);

bri_subscore9 := map(
    (iv_inp_addr_ownership_lvl in ['Other'])                              => 0.000000,
    (iv_inp_addr_ownership_lvl in ['Applicant'])                          => 0.096292,
    (iv_inp_addr_ownership_lvl in ['Family', 'No Ownership', 'Occupant']) => -0.041978,
                                                                             0.000000);

bri_subscore10 := map(
    not(truedid)     														 => 0.000000,  //needed to add this to distinguish when truedid=false 
    (iv_bst_addr_avm_land_use in ['Other', ''])  => -0.039069,
    (iv_bst_addr_avm_land_use in ['1', '2'])     => 0.049564,
                                                    0.000000);

bri_subscore11 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 1000     => -0.014463,
    1000 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 29350   => -0.194187,
    29350 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 49913  => -0.136971,
    49913 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 102994 => 0.013585,
    102994 <= iv_avg_prop_assess_purch_amt                                          => 0.159782,
                                                                                       -0.000000);

bri_subscore12 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 5 => 0.010781,
    5 <= iv_addrs_5yr                        => -0.087778,
                                                0.000000);

bri_subscore13 := map(
    NULL < iv_credit_seeking AND iv_credit_seeking < 1 => 0.035885,
    1 <= iv_credit_seeking                             => -0.260160,
                                                          0.000000);

bri_subscore14 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 0 => -0.017519,
    0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 26  => -0.207729,
    26 <= iv_mos_since_infutor_first_seen                                          => 0.050678,
                                                                                      0.000000);

bri_subscore15 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0'])                              => -0.020657,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '3-3']) => -0.160409,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-1', '3-1'])                             => -0.078395,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])                             => 0.066576,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.255532,
                                                                                    0.000000);

bri_subscore16 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.017819,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => 0.025060,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => -0.036546,
    3 <= iv_email_domain_free_count AND iv_email_domain_free_count < 4   => -0.095478,
    4 <= iv_email_domain_free_count                                      => -0.191259,
                                                                            0.000000);

bri_subscore17 := map(
    NULL < iv_attr_addrs_recency AND iv_attr_addrs_recency < 12 => -0.087071,
    12 <= iv_attr_addrs_recency AND iv_attr_addrs_recency < 24  => -0.041618,
    24 <= iv_attr_addrs_recency AND iv_attr_addrs_recency < 36  => 0.023110,
    36 <= iv_attr_addrs_recency AND iv_attr_addrs_recency < 120 => 0.054117,
    120 <= iv_attr_addrs_recency                                => 0.094092,
                                                                   0.000000);

bri_subscore18 := map(
    NULL < iv_derog_ratio AND iv_derog_ratio < 40  => 0.000000,
    40 <= iv_derog_ratio AND iv_derog_ratio < 50   => 0.000000,
    50 <= iv_derog_ratio AND iv_derog_ratio < 80   => 0.000000,
    80 <= iv_derog_ratio AND iv_derog_ratio < 110  => -0.072799,
    110 <= iv_derog_ratio AND iv_derog_ratio < 120 => -0.067746,
    120 <= iv_derog_ratio AND iv_derog_ratio < 130 => -0.026213,
    130 <= iv_derog_ratio AND iv_derog_ratio < 140 => 0.004682,
    140 <= iv_derog_ratio AND iv_derog_ratio < 150 => 0.017574,
    150 <= iv_derog_ratio AND iv_derog_ratio < 160 => 0.048114,
    160 <= iv_derog_ratio                          => 0.110594,
                                                      0.000000);

bri_subscore19 := map(
    (iv_liens_unrel_x_rel in ['Other', '0-0'])      => 0.049579,
    (iv_liens_unrel_x_rel in ['0-2', '1-1', '2-2']) => -0.018131,
    (iv_liens_unrel_x_rel in ['0-1'])               => -0.103589,
    (iv_liens_unrel_x_rel in ['1-2', '2-1'])        => -0.107446,
    (iv_liens_unrel_x_rel in ['1-0'])               => -0.151218,
    (iv_liens_unrel_x_rel in ['3-1', '3-2'])        => -0.233914,
    (iv_liens_unrel_x_rel in ['2-0', '3-0'])        => -0.281951,
                                                       0.000000);

bri_subscore20 := map(
    NULL < iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 3 => 0.002042,
    3 <= iv_liens_unrel_cj_ct                                => -0.102838,
                                                                0.000000);

bri_subscore21 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.011266,
    1 <= iv_liens_unrel_sc_ct                                => -0.198791,
                                                                0.000000);

bri_subscore22 := map(
    (iv_criminal_x_felony in ['Other'])                                         => 0.000000,
    (iv_criminal_x_felony in ['0-0'])                                           => 0.007614,
    (iv_criminal_x_felony in ['1-0', '2-0'])                                    => -0.157413,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.292956,
                                                                                   0.000000);

bri_subscore23 := map(
    (iv_prof_license_category in ['Other', '-1']) => -0.007406,
    (iv_prof_license_category in ['0', '1', '2']) => 0.067344,
    (iv_prof_license_category in ['3', '4', '5']) => 0.155543,
                                                     0.000000);

bri_subscore24 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.068404,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 3   => 0.024663,
    3 <= iv_pb_total_orders                              => 0.131609,
                                                            0.000000);

bri_rawscore := bri_subscore0 +
    bri_subscore1 +
    bri_subscore2 +
    bri_subscore3 +
    bri_subscore4 +
    bri_subscore5 +
    bri_subscore6 +
    bri_subscore7 +
    bri_subscore8 +
    bri_subscore9 +
    bri_subscore10 +
    bri_subscore11 +
    bri_subscore12 +
    bri_subscore13 +
    bri_subscore14 +
    bri_subscore15 +
    bri_subscore16 +
    bri_subscore17 +
    bri_subscore18 +
    bri_subscore19 +
    bri_subscore20 +
    bri_subscore21 +
    bri_subscore22 +
    bri_subscore23 +
    bri_subscore24;

bri_lnoddsscore := bri_rawscore + 2.197620;

bri_probscore := exp(bri_lnoddsscore) / (1 + exp(bri_lnoddsscore));

bbase := 685;

bpts := 55;

blogit := ln(.90 / .10);

rva1304_1_0 := map(
    rc_decsflag = '1'  => 200,
    iv_riskview_222s 	 => 222,
                        round(min(if(max(bpts * (bri_lnoddsscore - blogit) / ln(2) + bbase, (real)501) = NULL, -NULL, max(bpts * (bri_lnoddsscore - blogit) / ln(2) + bbase, (real)501)), 900)));


criminal_flag := criminal_count > 0;

lien_unrel_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bankruptcy_flag := (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0;

impulse_flag := impulse_count > 0;

eviction_flag := attr_eviction_count > 0;

derog_flag_sum := if(max((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag, (integer)impulse_flag, (integer)eviction_flag) = NULL, NULL, sum((integer)criminal_flag, (integer)lien_unrel_flag, (integer)bankruptcy_flag, (integer)impulse_flag, (integer)eviction_flag));

divptslost_iv_derog_ratio := map(
    derog_flag_sum = 0   => 0,
    iv_derog_ratio > 100 => 0,
                            (0.110594 - bri_subscore18) / derog_flag_sum);

glrc9k := add1_pop;

glrc9n := truedid;

glrcev := truedid and attr_eviction_count > 0;

glrc9h := truedid and impulse_count > 0;

glrc9e := add1_pop and truedid;

glrc99 := add1_pop and truedid;

glrc30 := add1_pop and truedid;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrcpv := truedid and iv_avg_prop_assess_purch_amt > 0;

glrc9d := truedid;

glrc9o := hphnpop and add1_pop and (nap_summary in [0, 1, 2, 3, 4]);

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc97 := truedid and criminal_count > 0;

glrc9w := truedid and bankruptcy_flag;

glrcbl := 0;

rcvalue9k_1 := 0.000915 - bri_subscore0;

rcvalue9k := (integer)glrc9k * if(max(rcvalue9k_1) = NULL, NULL, sum(if(rcvalue9k_1 = NULL, 0, rcvalue9k_1)));

rcvalue9n_1 := 0.000124 - bri_subscore1;

rcvalue9n := (integer)glrc9n * if(max(rcvalue9n_1) = NULL, NULL, sum(if(rcvalue9n_1 = NULL, 0, rcvalue9n_1)));

rcvalueev_1 := 0.008203 - bri_subscore2;

rcvalueev_2 := divptslost_iv_derog_ratio * (integer)eviction_flag;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1, rcvalueev_2) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1), if(rcvalueev_2 = NULL, 0, rcvalueev_2)));

rcvalue9h_1 := 0.004485 - bri_subscore3;

rcvalue9h_2 := divptslost_iv_derog_ratio * (integer)impulse_flag;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));

rcvalue9e_1 := 0.096122 - bri_subscore6;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue99_1 := 0.013095 - bri_subscore7;

rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

rcvalue30_1 := 0.008852 - bri_subscore8;

rcvalue30 := (integer)glrc30 * if(max(rcvalue30_1) = NULL, NULL, sum(if(rcvalue30_1 = NULL, 0, rcvalue30_1)));

rcvalue9a_1 := 0.096292 - bri_subscore9;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvaluepv_1 := 0.159782 - bri_subscore11;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvalue9d_1 := 0.010781 - bri_subscore12;

rcvalue9d_2 := 0.094092 - bri_subscore17;

rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

rcvalue9o_1 := 0.255532 - bri_subscore15;

rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));

rcvalue98_1 := 0.049579 - bri_subscore19;

rcvalue98_2 := 0.002042 - bri_subscore20;

rcvalue98_3 := 0.011266 - bri_subscore21;

rcvalue98_4 := divptslost_iv_derog_ratio * (integer)lien_unrel_flag;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3, rcvalue98_4) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3), if(rcvalue98_4 = NULL, 0, rcvalue98_4)));

rcvalue97_1 := 0.007614 - bri_subscore22;

rcvalue97_2 := divptslost_iv_derog_ratio * (integer)criminal_flag;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvalue9w_1 := divptslost_iv_derog_ratio * (integer)bankruptcy_flag;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvaluebl_1 := 0.190623 - bri_subscore4;

rcvaluebl_2 := 0.339263 - bri_subscore5;

rcvaluebl_3 := 0.096292 - bri_subscore10;

rcvaluebl_4 := 0.050678 - bri_subscore14;

rcvaluebl_5 := 0.025060 - bri_subscore16;

rcvaluebl_6 := 0.155543 - bri_subscore23;

rcvaluebl_7 := 0.131609 - bri_subscore24;

rcvaluebl_8 := 0.035885 - bri_subscore13;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6, rcvaluebl_7, rcvaluebl_8) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6), if(rcvaluebl_7 = NULL, 0, rcvaluebl_7), if(rcvaluebl_8 = NULL, 0, rcvaluebl_8)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'9K', RCValue9K},
	{'9N', RCValue9N},
	{'EV', RCValueEV},
	{'9H', RCValue9H},
	{'9E', RCValue9E},
	{'99', RCValue99},
	{'30', RCValue30},
	{'9A', RCValue9A},
	{'PV', RCValuePV},
	{'9D', RCValue9D},
	{'9O', RCValue9O},
	{'98', RCValue98},
	{'97', RCValue97},
	{'9W', RCValue9W},
	{'BL', RCValueBL}
    ], ds_layout)(value > 0);


	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9p1 := rcs_top4[1];
	rcs_9p2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc not in ['', '36'] and 500 < rva1304_1_0 AND rva1304_1_0 < 620, 		//If only one reason code is set and it's not '36', set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4;

	rcs_override := MAP(
											rva1304_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1304_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1304_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
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
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes

//Intermediate variables
	#if(RVA_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self._in_dob                          := _in_dob;
		self.yr_in_dob                        := yr_in_dob;
		self.yr_in_dob_int                    := yr_in_dob_int;
		self.age_estimate                     := age_estimate;
		self.iv_ag001_age                     := iv_ag001_age;
		self.iv_va007_add_vacant              := iv_va007_add_vacant;
		self.iv_va040_add_prison_hist         := iv_va040_add_prison_hist;
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self.iv_ed001_college_ind_37          := iv_ed001_college_ind_37;
		self.iv_src_property_adl_count        := iv_src_property_adl_count;
		self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
		self.iv_best_match_address            := iv_best_match_address;
		self.iv_inp_addr_house_number_match   := iv_inp_addr_house_number_match;
		self.iv_inp_addr_ownership_lvl        := iv_inp_addr_ownership_lvl;
		self.iv_bst_addr_avm_land_use         := iv_bst_addr_avm_land_use;
		self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_credit_seeking                := iv_credit_seeking;
		self._infutor_first_seen              := _infutor_first_seen;
		self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_email_domain_free_count       := iv_email_domain_free_count;
		self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
		self.iv_derog_ratio                   := iv_derog_ratio;
		self.iv_liens_unrel_x_rel             := iv_liens_unrel_x_rel;
		self.iv_liens_unrel_cj_ct             := iv_liens_unrel_cj_ct;
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
		self.iv_criminal_x_felony             := iv_criminal_x_felony;
		self.iv_prof_license_category         := iv_prof_license_category;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.bri_subscore0                    := bri_subscore0;
		self.bri_subscore1                    := bri_subscore1;
		self.bri_subscore2                    := bri_subscore2;
		self.bri_subscore3                    := bri_subscore3;
		self.bri_subscore4                    := bri_subscore4;
		self.bri_subscore5                    := bri_subscore5;
		self.bri_subscore6                    := bri_subscore6;
		self.bri_subscore7                    := bri_subscore7;
		self.bri_subscore8                    := bri_subscore8;
		self.bri_subscore9                    := bri_subscore9;
		self.bri_subscore10                   := bri_subscore10;
		self.bri_subscore11                   := bri_subscore11;
		self.bri_subscore12                   := bri_subscore12;
		self.bri_subscore13                   := bri_subscore13;
		self.bri_subscore14                   := bri_subscore14;
		self.bri_subscore15                   := bri_subscore15;
		self.bri_subscore16                   := bri_subscore16;
		self.bri_subscore17                   := bri_subscore17;
		self.bri_subscore18                   := bri_subscore18;
		self.bri_subscore19                   := bri_subscore19;
		self.bri_subscore20                   := bri_subscore20;
		self.bri_subscore21                   := bri_subscore21;
		self.bri_subscore22                   := bri_subscore22;
		self.bri_subscore23                   := bri_subscore23;
		self.bri_subscore24                   := bri_subscore24;
		self.bri_rawscore                     := bri_rawscore;
		self.bri_lnoddsscore                  := bri_lnoddsscore;
		self.bri_probscore                    := bri_probscore;
		self.bbase                            := bbase;
		self.bpts                             := bpts;
		self.blogit                           := blogit;
		self.rva1304_1_0                      := rva1304_1_0;
		self.criminal_flag                    := criminal_flag;
		self.lien_unrel_flag                  := lien_unrel_flag;
		self.bankruptcy_flag                  := bankruptcy_flag;
		self.impulse_flag                     := impulse_flag;
		self.eviction_flag                    := eviction_flag;
		self.derog_flag_sum                   := derog_flag_sum;
		self.divptslost_iv_derog_ratio        := divptslost_iv_derog_ratio;
		self.glrc9k                           := glrc9k;
		self.glrc9n                           := glrc9n;
		self.glrcev                           := glrcev;
		self.glrc9h                           := glrc9h;
		self.glrc9e                           := glrc9e;
		self.glrc99                           := glrc99;
		self.glrc30                           := glrc30;
		self.glrc9a                           := glrc9a;
		self.glrcpv                           := glrcpv;
		self.glrc9d                           := glrc9d;
		self.glrc9o                           := glrc9o;
		self.glrc98                           := glrc98;
		self.glrc97                           := glrc97;
		self.glrc9w                           := glrc9w;
		self.glrcbl                           := glrcbl;
		self.rcvalue9k_1                      := rcvalue9k_1;
		self.rcvalue9k                        := rcvalue9k;
		self.rcvalue9n_1                      := rcvalue9n_1;
		self.rcvalue9n                        := rcvalue9n;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev_2                      := rcvalueev_2;
		self.rcvalueev                        := rcvalueev;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h_2                      := rcvalue9h_2;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue99_1                      := rcvalue99_1;
		self.rcvalue99                        := rcvalue99;
		self.rcvalue30_1                      := rcvalue30_1;
		self.rcvalue30                        := rcvalue30;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d_2                      := rcvalue9d_2;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98_3                      := rcvalue98_3;
		self.rcvalue98_4                      := rcvalue98_4;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97_2                      := rcvalue97_2;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
		self.rcvaluebl_4                      := rcvaluebl_4;
		self.rcvaluebl_5                      := rcvaluebl_5;
		self.rcvaluebl_6                      := rcvaluebl_6;
		self.rcvaluebl_7                      := rcvaluebl_7;
		self.rcvaluebl_8                      := rcvaluebl_8;
		self.rcvaluebl                        := rcvaluebl;
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)RVA1304_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;
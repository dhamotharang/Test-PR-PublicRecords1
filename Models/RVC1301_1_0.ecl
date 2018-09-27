import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1301_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  RVC_DEBUG := false;

  #if(RVC_DEBUG)
    layout_debug := record
			integer sysdate                          ; // sysdate;
			boolean iv_pots_phone                    ; // iv_pots_phone;
			boolean iv_add_apt                       ; // iv_add_apt;
			boolean iv_riskview_222s                 ; // iv_riskview_222s;
			integer _reported_dob                    ; // _reported_dob;
			integer reported_age                     ; // reported_age;
			integer iv_combined_age                  ; // iv_combined_age;
			integer iv_src_bureau_addr_count         ; // iv_src_bureau_addr_count;
			string  iv_valid_phone                   ; // iv_valid_phone;
			integer iv_inp_addr_naprop               ; // iv_inp_addr_naprop;
			integer iv_prop1_sale_price              ; // iv_prop1_sale_price;
			integer iv_avg_mo_per_addr               ; // iv_avg_mo_per_addr;
			integer _gong_did_first_seen             ; // _gong_did_first_seen;
			integer iv_mos_since_gong_did_fst_seen   ; // iv_mos_since_gong_did_fst_seen;
			integer iv_ssns_per_adl                  ; // iv_ssns_per_adl;
			integer iv_max_ids_per_addr              ; // iv_max_ids_per_addr;
			integer iv_inq_highriskcredit_count12    ; // iv_inq_highriskcredit_count12;
			integer iv_derog_diff                    ; // iv_derog_diff;
			string  iv_bk_disposition_lvl            ; // iv_bk_disposition_lvl;
			integer iv_liens_unrel_sc_ct             ; // iv_liens_unrel_sc_ct;
			string  iv_ams_college_tier              ; // iv_ams_college_tier;
			integer iv_estimated_income              ; // iv_estimated_income;
			integer bst_addr_avm_auto_val            ; // bst_addr_avm_auto_val;
			integer bst_addr_mortgage_amount         ; // bst_addr_mortgage_amount;
			integer bst_addr_mortgage_avm_diff       ; // bst_addr_mortgage_avm_diff;
			integer inp_addr_avm_change_3yr_pct      ; // inp_addr_avm_change_3yr_pct;
			real    a_subscore0                      ; // a_subscore0;
			real    a_subscore1                      ; // a_subscore1;
			real    a_subscore2                      ; // a_subscore2;
			real    a_subscore3                      ; // a_subscore3;
			real    a_subscore4                      ; // a_subscore4;
			real    a_subscore5                      ; // a_subscore5;
			real    a_subscore6                      ; // a_subscore6;
			real    a_subscore7                      ; // a_subscore7;
			real    a_subscore8                      ; // a_subscore8;
			real    a_subscore9                      ; // a_subscore9;
			real    a_subscore10                     ; // a_subscore10;
			real    a_subscore11                     ; // a_subscore11;
			real    a_subscore12                     ; // a_subscore12;
			real    a_subscore13                     ; // a_subscore13;
			real    a_subscore14                     ; // a_subscore14;
			real    a_subscore15                     ; // a_subscore15;
			real    a_subscore16                     ; // a_subscore16;
			real    a_rawscore                       ; // a_rawscore;
			real    a_lnoddsscore                    ; // a_lnoddsscore;
			real    a_probscore                      ; // a_probscore;
			integer base                             ; // base;
			integer point                            ; // point;
			real    odds                             ; // odds;
			integer rvc1301_1_0                      ; // rvc1301_1_0;
			boolean glrc9m                           ; // glrc9m;
			boolean glrc99                           ; // glrc99;
			boolean glrc9i                           ; // glrc9i;
			boolean glrc9t                           ; // glrc9t;
			boolean glrc9e                           ; // glrc9e;
			boolean glrcms                           ; // glrcms;
			boolean glrc9a                           ; // glrc9a;
			boolean glrc9w                           ; // glrc9w;
			boolean glrc97                           ; // glrc97;
			boolean glrc9c                           ; // glrc9c;
			boolean glrc98                           ; // glrc98;
			boolean glrc9p                           ; // glrc9p;
			boolean glrcpv                           ; // glrcpv;
			boolean glrcbl                           ; // glrcbl;
			boolean bk_flag                          ; // bk_flag;
			boolean crim_flag                        ; // crim_flag;
			boolean lien_flag                        ; // lien_flag;
			real    rcvalue9m_1                      ; // rcvalue9m_1;
			real    rcvalue9m_2                      ; // rcvalue9m_2;
			real    rcvalue9m                        ; // rcvalue9m;
			real    rcvalue99_1                      ; // rcvalue99_1;
			real    rcvalue99                        ; // rcvalue99;
			real    rcvalue9i_1                      ; // rcvalue9i_1;
			real    rcvalue9i                        ; // rcvalue9i;
			real    rcvalue9t_1                      ; // rcvalue9t_1;
			real    rcvalue9t                        ; // rcvalue9t;
			real    rcvalue9e_1                      ; // rcvalue9e_1;
			real    rcvalue9e                        ; // rcvalue9e;
			real    rcvaluems_1                      ; // rcvaluems_1;
			real    rcvaluems                        ; // rcvaluems;
			real    rcvalue9a_1                      ; // rcvalue9a_1;
			real    rcvalue9a                        ; // rcvalue9a;
			real    rcvalue9w_1                      ; // rcvalue9w_1;
			real    rcvalue9w_2                      ; // rcvalue9w_2;
			real    rcvalue9w                        ; // rcvalue9w;
			real    rcvalue97_1                      ; // rcvalue97_1;
			real    rcvalue97                        ; // rcvalue97;
			real    rcvalue9c_1                      ; // rcvalue9c_1;
			real    rcvalue9c                        ; // rcvalue9c;
			real    rcvalue98_1                      ; // rcvalue98_1;
			real    rcvalue98_2                      ; // rcvalue98_2;
			real    rcvalue98                        ; // rcvalue98;
			real    rcvalue9p_1                      ; // rcvalue9p_1;
			real    rcvalue9p                        ; // rcvalue9p;
			real    rcvaluepv_1                      ; // rcvaluepv_1;
			real    rcvaluepv                        ; // rcvaluepv;
			real    rcvaluebl_1                      ; // rcvaluebl_1;
			real    rcvaluebl_2                      ; // rcvaluebl_2;
			real    rcvaluebl_3                      ; // rcvaluebl_3;
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
		adl_addr                         := le.adl_shell_flags.adl_addr;
		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_dwelltype                     := le.iid.dwelltype;
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
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		ams_age                          := le.student.age;
		ams_college_tier                 := le.student.college_tier;
		input_dob_age                    := le.shell_input.age;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;


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

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) 					=> NULL,
    age > 0                					=> age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    (integer)inferred_age > 0       => (integer)inferred_age,
    reported_age > 0       					=> reported_age,
    (integer)ams_age > 0            => (integer)ams_age,
																			 -1);

iv_src_bureau_addr_count := if(
																not(truedid), NULL, 
																max(
																		if(
																				max((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ','), (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ','), (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ','), (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ','), (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',')) = 0, NULL, 
																				sum(if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',') = 0, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TN' , ', ', 'E'), ',')), if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',') = 0, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TS' , ', ', 'E'), ',')), if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',') = 0, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'TU' , ', ', 'E'), ',')), if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',') = 0, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EN' , ', ', 'E'), ',')), if((integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',') = 0, 0, (integer)Models.Common.getw(ver_addr_sources_count, Models.Common.findw_cpp(ver_addr_sources, 'EQ' , ', ', 'E'), ',')))
																			), 
																		0)
															);

iv_valid_phone := map(
    not(hphnpop)                                                 			=> '             ',
    rc_phonevalflag = '0' or rc_hphonevalflag = '0'                  	=> 'Invalid Phn  ',
    rc_phonevalflag = '1' or rc_hphonevalflag = '1'                  	=> 'Valid Bus Phn',
    rc_phonevalflag = '3' or (rc_hphonevalflag in ['3', '4', '5']) 		=> 'Valid Oth Phn',
    rc_phonevalflag = '2' or rc_hphonevalflag = '2'                  	=> 'Valid Res Phn',
																																				 '             ');

iv_inp_addr_naprop := if(not(add1_pop), NULL, add1_naprop);

iv_prop1_sale_price := if(not(truedid), NULL, prop1_sale_price);

iv_avg_mo_per_addr := map(
    not(truedid)            => NULL,
    avg_mo_per_addr = -9999 => -1,
    unique_addr_count = 0   => -1,
                               avg_mo_per_addr);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

iv_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

iv_derog_diff := if(not(truedid), NULL, min(if(max(attr_num_nonderogs - attr_total_number_derogs, -10) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -10)), 10));

iv_bk_disposition_lvl := map(
    not(truedid or ssnlength > '0')                                                                                             => '          ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => 'Discharged',
    (disposition in ['Dismissed'])                                                                                              => 'Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 		=> 'OtherBK  ',
                                                                                                                                   'No BK');

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

iv_ams_college_tier := map(
    not(truedid)            => '  ',
    ams_college_tier = '' 	=> '-1',
                               ams_college_tier);

iv_estimated_income := if(not(truedid), NULL, estimated_income);

bst_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

bst_addr_mortgage_avm_diff := map(
    not(truedid)     								=> NULL,
    bst_addr_mortgage_amount = 0 		=> NULL,
    bst_addr_avm_auto_val = 0    		=> NULL,
																			 bst_addr_avm_auto_val - bst_addr_mortgage_amount);

inp_addr_avm_change_3yr_pct := map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_4,
                                                                               NULL);

a_subscore0 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 20000   => -0.329995,
    20000 <= iv_estimated_income AND iv_estimated_income < 29000 => -0.119215,
    29000 <= iv_estimated_income AND iv_estimated_income < 40000 => 0.079646,
    40000 <= iv_estimated_income                                 => 0.351760,
                                                                    0.000000);

a_subscore1 := map(
    (adl_addr in [0])      	=> -0.966840,
    (adl_addr in [2])      	=> 0.149963,
    (adl_addr in [1, 3]) 		=> -0.119818,
                               -0.000000);

a_subscore2 := map(
    (iv_ams_college_tier in ['-1'])          => -0.025551,
    (iv_ams_college_tier in ['0'])           => 0.000000,
    (iv_ams_college_tier in ['1', '2', '3']) => 0.691367,
    (iv_ams_college_tier in ['4'])           => 0.433993,
    (iv_ams_college_tier in ['5'])           => -0.010610,
    (iv_ams_college_tier in ['6'])           => -0.762035,
                                                0.000000);

a_subscore3 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.143476,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 14  => -0.277546,
    14 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 45 => -0.114328,
    45 <= iv_mos_since_gong_did_fst_seen                                         => -0.023778,
                                                                                    -0.000000);

a_subscore4 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr < 1 => 0.184456,
    1 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 5   => 0.181322,
    5 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 10  => 0.061271,
    10 <= iv_max_ids_per_addr                              => -0.102227,
                                                              0.000000);

a_subscore5 := map(
    (iv_valid_phone in ['             '])                                 => -0.079933,
    (iv_valid_phone in ['Invalid Phn', 'Valid Bus Phn', 'Valid Oth Phn']) => -0.091956,
    (iv_valid_phone in ['Valid Res Phn'])                                 => 0.140379,
                                                                             -0.000000);

a_subscore6 := map(
    NULL < iv_prop1_sale_price AND iv_prop1_sale_price < 1    => -0.019189,
    1 <= iv_prop1_sale_price AND iv_prop1_sale_price < 168586 => -0.035811,
    168586 <= iv_prop1_sale_price                             => 0.662309,
                                                                 -0.000000);

a_subscore7 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.291613,
    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 4   => 0.016264,
    4 <= iv_src_bureau_addr_count                                    => 0.267094,
                                                                        -0.000000);

a_subscore8 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 1 => -0.061458,
    1 <= iv_ssns_per_adl AND iv_ssns_per_adl < 2   => 0.063503,
    2 <= iv_ssns_per_adl                           => -0.171195,
                                                      0.000000);

a_subscore9 := map(
    (iv_inp_addr_naprop in [0])    => 0.053643,
    (iv_inp_addr_naprop in [1, 2]) => -0.136906,
    (iv_inp_addr_naprop in [3])    => 0.189895,
    (iv_inp_addr_naprop in [4])    => 0.025863,
                                      0.000000);

a_subscore10 := map(
    (iv_bk_disposition_lvl in ['             ']) => 0.000000,
    (iv_bk_disposition_lvl in ['Discharged'])    => 0.298413,
    (iv_bk_disposition_lvl in ['OtherBK'])       => -0.048581,
    (iv_bk_disposition_lvl in ['Dismissed'])     => -0.331870,
    (iv_bk_disposition_lvl in ['No BK'])         => -0.022284,
                                                    0.000000);

a_subscore11 := map(
    NULL < iv_derog_diff AND iv_derog_diff < 0 => -0.142818,
    0 <= iv_derog_diff AND iv_derog_diff < 3   => -0.055303,
    3 <= iv_derog_diff AND iv_derog_diff < 5   => 0.077404,
    5 <= iv_derog_diff                         => 0.227685,
                                                  -0.000000);

a_subscore12 := map(
    NULL < iv_avg_mo_per_addr AND iv_avg_mo_per_addr < 1 => -0.785013,
    1 <= iv_avg_mo_per_addr AND iv_avg_mo_per_addr < 10  => -0.203206,
    10 <= iv_avg_mo_per_addr AND iv_avg_mo_per_addr < 57 => -0.002121,
    57 <= iv_avg_mo_per_addr                             => 0.057267,
                                                            -0.000000);

a_subscore13 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.024307,
    1 <= iv_liens_unrel_sc_ct                                => -0.304792,
                                                                0.000000);

a_subscore14 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.012934,
    1 <= iv_inq_highriskcredit_count12                                         => -0.408607,
                                                                                  -0.000000);

a_subscore15 := map(
    NULL < inp_addr_avm_change_3yr_pct AND inp_addr_avm_change_3yr_pct < 0.46  => -0.163652,
    0.46 <= inp_addr_avm_change_3yr_pct AND inp_addr_avm_change_3yr_pct < 0.82 => -0.057718,
    0.82 <= inp_addr_avm_change_3yr_pct AND inp_addr_avm_change_3yr_pct < 0.9  => 0.018635,
    0.9 <= inp_addr_avm_change_3yr_pct                                         => 0.173052,
                                                                                  -0.000000);

a_subscore16 := map(
    NULL < bst_addr_mortgage_avm_diff AND bst_addr_mortgage_avm_diff < -23435   => -0.195536,
    -23435 <= bst_addr_mortgage_avm_diff AND bst_addr_mortgage_avm_diff < 27977 => 0.015094,
    27977 <= bst_addr_mortgage_avm_diff                                         => 0.196285,
                                                                                   0.000000);

a_rawscore := a_subscore0 +
    a_subscore1 +
    a_subscore2 +
    a_subscore3 +
    a_subscore4 +
    a_subscore5 +
    a_subscore6 +
    a_subscore7 +
    a_subscore8 +
    a_subscore9 +
    a_subscore10 +
    a_subscore11 +
    a_subscore12 +
    a_subscore13 +
    a_subscore14 +
    a_subscore15 +
    a_subscore16;

a_lnoddsscore := a_rawscore + -2.166852;

a_probscore := exp(a_lnoddsscore) / (1 + exp(a_lnoddsscore));

base := 750;

point := 40;

odds := 0.103 / (1 - 0.103);

rvc1301_1_0 := map(
    rc_decsflag = '1'  	=> 200,
    iv_riskview_222s 		=> 222,
													 max(min(if(round(point * (ln(a_probscore / (1 - a_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(a_probscore / (1 - a_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

glrc9m := truedid;

glrc99 := (adl_addr in [0, 1, 3]);

glrc9i := truedid and 18 <= iv_combined_age AND iv_combined_age <= 25;

glrc9t := truedid and hphnpop;

glrc9e := addrpop;

glrcms := truedid and ssns_per_adl > 1;

glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));

glrc9w := truedid and filing_count > 0;

glrc97 := truedid and criminal_count > 0;

glrc9c := truedid and avg_mo_per_addr > 0;

glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

glrc9p := truedid and iv_inq_highRiskCredit_count12 > 0;

glrcpv := truedid and bst_addr_mortgage_amount > 0 and bst_addr_avm_auto_val > 0;

glrcbl := 0;

bk_flag := filing_count > 0;

crim_flag := criminal_count > 0;

lien_flag := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

rcvalue9m_1 := 0.35176 - a_subscore0;

rcvalue9m_2 := 0.662309 - a_subscore6;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2)));

rcvalue99_1 := 0.149963 - a_subscore1;

rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));

rcvalue9i_1 := 0.691367 - a_subscore2;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9t_1 := 0.140379 - a_subscore5;

rcvalue9t := (integer)glrc9t * if(max(rcvalue9t_1) = NULL, NULL, sum(if(rcvalue9t_1 = NULL, 0, rcvalue9t_1)));

rcvalue9e_1 := 0.267094 - a_subscore7;

rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvaluems_1 := 0.063503 - a_subscore8;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalue9a_1 := 0.189895 - a_subscore9;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9w_1 := 0.298413 - a_subscore10;

rcvalue9w_2 := if(bk_flag,   
								 (integer)bk_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.227685 - a_subscore11), 
								 0);

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

rcvalue97_1 := if(crim_flag,
								 (integer)crim_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.227685 - a_subscore11),
								 0);

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue9c_1 := 0.057267 - a_subscore12;

rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

rcvalue98_1 := 0.024307 - a_subscore13;

rcvalue98_2 := if(lien_flag,
								 (integer)lien_flag / if(max((integer)bk_flag, (integer)crim_flag, (integer)lien_flag) = NULL, NULL, sum((integer)bk_flag, (integer)crim_flag, (integer)lien_flag)) * (0.227685 - a_subscore11),
								 0);

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2)));

rcvalue9p_1 := 0.012934 - a_subscore14;

rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

rcvaluepv_1 := 0.196285 - a_subscore16;

rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

rcvaluebl_1 := 0.143476 - a_subscore3;

rcvaluebl_2 := 0.184456 - a_subscore4;

rcvaluebl_3 := 0.173052 - a_subscore15;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'9M', rcvalue9m},
	{'99', rcvalue99},
	{'9I', rcvalue9i},
	{'9T', rcvalue9t},
	{'9E', rcvalue9e},
	{'MS', rcvaluems},
	{'9A', rcvalue9a},
	{'9W', rcvalue9w},
	{'97', rcvalue97},
	{'9C', rcvalue9c},
	{'98', rcvalue98},
	{'9P', rcvalue9p},
	{'PV', rcvaluepv},
	{'BL', rcvaluebl}
    ], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	
	rcs_9p1 := rcs_top4[1];
	rcs_9p2 := IF(rcs_top4[2].rc = '' and rcs_top4[1].rc <> '', 		//If only one reason code is set, set RC2 to '36'
								ROW({'36', NULL}, ds_layout), 
								rcs_top4[2]);
	rcs_9p3 := rcs_top4[3];
	rcs_9p4 := rcs_top4[4];
	rcs_9p5 := IF(glrc9p and inq_highRiskCredit_count12 > 0 AND NOT EXISTS(rcs_top4 (rc = '9P')),  	// Check to see if RC 9P is a part of the score, but not in the first 4 RC's
								ROW({'9P', NULL}, ds_layout)); 																										// If so - make it the 5th reason code.
	
	
	rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;

	rcs_override := MAP(
											rvc1301_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvc1301_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvc1301_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
											NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
											rcs_9p
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

	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
		self.iv_valid_phone                   := iv_valid_phone;
		self.iv_inp_addr_naprop               := iv_inp_addr_naprop;
		self.iv_prop1_sale_price              := iv_prop1_sale_price;
		self.iv_avg_mo_per_addr               := iv_avg_mo_per_addr;
		self._gong_did_first_seen             := _gong_did_first_seen;
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		self.iv_ssns_per_adl                  := iv_ssns_per_adl;
		self.iv_max_ids_per_addr              := iv_max_ids_per_addr;
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
		self.iv_derog_diff                    := iv_derog_diff;
		self.iv_bk_disposition_lvl            := iv_bk_disposition_lvl;
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
		self.iv_ams_college_tier              := iv_ams_college_tier;
		self.iv_estimated_income              := iv_estimated_income;
		self.bst_addr_avm_auto_val            := bst_addr_avm_auto_val;
		self.bst_addr_mortgage_amount         := bst_addr_mortgage_amount;
		self.bst_addr_mortgage_avm_diff       := bst_addr_mortgage_avm_diff;
		self.inp_addr_avm_change_3yr_pct      := inp_addr_avm_change_3yr_pct;
		self.a_subscore0                      := a_subscore0;
		self.a_subscore1                      := a_subscore1;
		self.a_subscore2                      := a_subscore2;
		self.a_subscore3                      := a_subscore3;
		self.a_subscore4                      := a_subscore4;
		self.a_subscore5                      := a_subscore5;
		self.a_subscore6                      := a_subscore6;
		self.a_subscore7                      := a_subscore7;
		self.a_subscore8                      := a_subscore8;
		self.a_subscore9                      := a_subscore9;
		self.a_subscore10                     := a_subscore10;
		self.a_subscore11                     := a_subscore11;
		self.a_subscore12                     := a_subscore12;
		self.a_subscore13                     := a_subscore13;
		self.a_subscore14                     := a_subscore14;
		self.a_subscore15                     := a_subscore15;
		self.a_subscore16                     := a_subscore16;
		self.a_rawscore                       := a_rawscore;
		self.a_lnoddsscore                    := a_lnoddsscore;
		self.a_probscore                      := a_probscore;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.rvc1301_1_0                      := rvc1301_1_0;
		self.glrc9m                           := glrc9m;
		self.glrc99                           := glrc99;
		self.glrc9i                           := glrc9i;
		self.glrc9t                           := glrc9t;
		self.glrc9e                           := glrc9e;
		self.glrcms                           := glrcms;
		self.glrc9a                           := glrc9a;
		self.glrc9w                           := glrc9w;
		self.glrc97                           := glrc97;
		self.glrc9c                           := glrc9c;
		self.glrc98                           := glrc98;
		self.glrc9p                           := glrc9p;
		self.glrcpv                           := glrcpv;
		self.glrcbl                           := glrcbl;
		self.bk_flag                          := bk_flag;
		self.crim_flag                        := crim_flag;
		self.lien_flag                        := lien_flag;
		self.rcvalue9m_1                      := rcvalue9m_1;
		self.rcvalue9m_2                      := rcvalue9m_2;
		self.rcvalue9m                        := rcvalue9m;
		self.rcvalue99_1                      := rcvalue99_1;
		self.rcvalue99                        := rcvalue99;
		self.rcvalue9i_1                      := rcvalue9i_1;
		self.rcvalue9i                        := rcvalue9i;
		self.rcvalue9t_1                      := rcvalue9t_1;
		self.rcvalue9t                        := rcvalue9t;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w_2                      := rcvalue9w_2;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue9c_1                      := rcvalue9c_1;
		self.rcvalue9c                        := rcvalue9c;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98_2                      := rcvalue98_2;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9p_1                      := rcvalue9p_1;
		self.rcvalue9p                        := rcvalue9p;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl_3                      := rcvaluebl_3;
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
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											(string3)RVC1301_1_0
										);
END;

		model := project( clam, doModel(left) );

		return model;
END;
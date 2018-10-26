import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1208_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN xmlPreScreenOptOut = FALSE ) := FUNCTION

  RVC_DEBUG := false;

  #if(RVC_DEBUG)
    layout_debug := record
				integer sysdate                          ; //sysdate;
				integer4 ver_src_ba_pos                   ; //ver_src_ba_pos;
				boolean ver_src_ba                       ; //ver_src_ba;
				integer4 ver_src_ds_pos                   ; //ver_src_ds_pos;
				boolean ver_src_ds                       ; //ver_src_ds;
				integer4 ver_src_l2_pos                   ; //ver_src_l2_pos;
				boolean ver_src_l2                       ; //ver_src_l2;
				integer4 ver_src_li_pos                   ; //ver_src_li_pos;
				boolean ver_src_li                       ; //ver_src_li;
				integer _gong_did_last_seen              ; //_gong_did_last_seen;
				integer iv_mos_since_gong_did_lst_seen   ; //iv_mos_since_gong_did_lst_seen;
				real dual_subscore0                   ; //dual_subscore0;
				real dual_subscore1                   ; //dual_subscore1;
				integer iv_src_property_adl_count        ; //iv_src_property_adl_count;
				real dual_subscore2                   ; //dual_subscore2;
				integer iv_estimated_income              ; //iv_estimated_income;
				real dual_subscore3                   ; //dual_subscore3;
				real dual_subscore4                   ; //dual_subscore4;
				integer iv_unreleased_liens_ct           ; //iv_unreleased_liens_ct;
				real dual_subscore5                   ; //dual_subscore5;
				integer iv_impulse_count                 ; //iv_impulse_count;
				real dual_subscore6                   ; //dual_subscore6;
				integer iv_bst_addr_avm_auto_val         ; //iv_bst_addr_avm_auto_val;
				real dual_subscore7                   ; //dual_subscore7;
				integer iv_ssns_per_adl                  ; //iv_ssns_per_adl;
				real dual_subscore8                   ; //dual_subscore8;
				integer iv_adls_per_addr                 ; //iv_adls_per_addr;
				real dual_subscore9                   ; //dual_subscore9;
				string iv_criminal_x_felony             ; //iv_criminal_x_felony;
				real dual_subscore10                  ; //dual_subscore10;
				string iv_bk_disposition_lvl            ; //iv_bk_disposition_lvl;
				real dual_subscore11                  ; //dual_subscore11;
				integer iv_prv_addr_avm_auto_val         ; //iv_prv_addr_avm_auto_val;
				real dual_subscore12                  ; //dual_subscore12;
				integer iv_eviction_count                ; //iv_eviction_count;
				real dual_subscore13                  ; //dual_subscore13;
				integer iv_max_lres                      ; //iv_max_lres;
				real dual_subscore14                  ; //dual_subscore14;
				integer _reported_dob                    ; //_reported_dob;
				integer reported_age                     ; //reported_age;
				integer iv_combined_age                  ; //iv_combined_age;
				real dual_subscore15                  ; //dual_subscore15;
				integer iv_bst_addr_naprop               ; //iv_bst_addr_naprop;
				real dual_subscore16                  ; //dual_subscore16;
				real dual_subscore17                  ; //dual_subscore17;
				real dual_subscore18                  ; //dual_subscore18;
				integer iv_inq_per_ssn                   ; //iv_inq_per_ssn;
				real dual_subscore19                  ; //dual_subscore19;
				real dual_rawscore                    ; //dual_rawscore;
				real dual_lnoddsscore                 ; //dual_lnoddsscore;
				integer point                            ; //point;
				integer base                             ; //base;
				integer odds                             ; //odds;
				integer _rvc1208_1_0                     ; //_rvc1208_1_0;
				boolean bk_flag                          ; //bk_flag;
				boolean lien_rec_unrel_flag              ; //lien_rec_unrel_flag;
				boolean lien_hist_unrel_flag             ; //lien_hist_unrel_flag;
				boolean lien_flag                        ; //lien_flag;
				boolean ssn_deceased                     ; //ssn_deceased;
				boolean scored_222s                      ; //scored_222s;
				integer rvc1208_1_0                      ; //rvc1208_1_0;
				boolean glrc97                           ; //glrc97;
				boolean glrc98                           ; //glrc98;
				boolean glrc9a                           ; //glrc9a;
				integer inp_addr_date_first_seen         ; //inp_addr_date_first_seen;
				integer iv_mos_since_inp_addr_fseen      ; //iv_mos_since_inp_addr_fseen;
				boolean glrc9c                           ; //glrc9c;
				boolean glrc9f                           ; //glrc9f;
				boolean glrc9g                           ; //glrc9g;
				boolean glrc9h                           ; //glrc9h;
				boolean glrc9i                           ; //glrc9i;
				boolean glrc9m                           ; //glrc9m;
				boolean glrc9q                           ; //glrc9q;
				boolean glrc9w                           ; //glrc9w;
				boolean glrcev                           ; //glrcev;
				boolean glrcms                           ; //glrcms;
				boolean glrcpv                           ; //glrcpv;
				boolean glrcbl                           ; //glrcbl;
				real rcvalue97_1                      ; //rcvalue97_1;
				real rcvalue97                        ; //rcvalue97;
				real rcvalue98_1                      ; //rcvalue98_1;
				real rcvalue98                        ; //rcvalue98;
				real rcvalue9a_1                      ; //rcvalue9a_1;
				real rcvalue9a_2                      ; //rcvalue9a_2;
				real rcvalue9a                        ; //rcvalue9a;
				real rcvalue9c_1                      ; //rcvalue9c_1;
				real rcvalue9c                        ; //rcvalue9c;
				real rcvalue9f_1                      ; //rcvalue9f_1;
				real rcvalue9f                        ; //rcvalue9f;
				real rcvalue9g_1                      ; //rcvalue9g_1;
				real rcvalue9g                        ; //rcvalue9g;
				real rcvalue9h_1                      ; //rcvalue9h_1;
				real rcvalue9h                        ; //rcvalue9h;
				real rcvalue9i_1                      ; //rcvalue9i_1;
				real rcvalue9i                        ; //rcvalue9i;
				real rcvalue9m_1                      ; //rcvalue9m_1;
				real rcvalue9m                        ; //rcvalue9m;
				real rcvalue9q_1                      ; //rcvalue9q_1;
				real rcvalue9q                        ; //rcvalue9q;
				real rcvalue9w_1                      ; //rcvalue9w_1;
				real rcvalue9w                        ; //rcvalue9w;
				real rcvalueev_1                      ; //rcvalueev_1;
				real rcvalueev                        ; //rcvalueev;
				real rcvaluems_1                      ; //rcvaluems_1;
				real rcvaluems                        ; //rcvaluems;
				real rcvaluepv_1                      ; //rcvaluepv_1;
				real rcvaluepv_2                      ; //rcvaluepv_2;
				real rcvaluepv                        ; //rcvaluepv;
				real rcvaluebl_1                      ; //rcvaluebl_1;
				real rcvaluebl_2                      ; //rcvaluebl_2;
				real rcvaluebl                        ; //rcvaluebl;
				string rc1                              ; // rc1;
				string rc2                              ; //rc2;
				string rc3                              ; //rc3;
				string rc4                              ; //rc4;
				string rc5                              ; //rc5;
				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
		adl_hphn                         := le.adl_shell_flags.adl_hphn;
		adl_addr                         := le.adl_shell_flags.adl_addr;
		in_hphnpop                       := le.adl_shell_flags.in_hphnpop;
		truedid                          := le.truedid;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_decsflag                      := le.iid.decsflag;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
		max_lres                         := le.other_address_info.max_lres;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_perssn                       := le.acc_logs.inquiryperssn;
		impulse_count                    := le.impulse.count;
		attr_eviction_count              := le.bjl.eviction_count;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		ams_age                          := le.student.age;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;
		archive_date                     := le.historydate;

//Start of model code

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));


sysdate := map(
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

ver_src_ds := ver_src_ds_pos > 0;

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

ver_src_l2 := ver_src_l2_pos > 0;

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

ver_src_li := ver_src_li_pos > 0;

_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

dual_subscore0 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 0 => 0.331027,
    0 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 2   => 0.123239,
    2 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 3   => -0.416544,
    3 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 4   => -0.496857,
    4 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 5   => -0.071465,
    5 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 6   => 0.005990,
    6 <= iv_mos_since_gong_did_lst_seen                                          => 0.194343,
                                                                                    0.000000);

dual_subscore1 := map(
    NULL < adl_hphn AND adl_hphn < 1 => 0.124090,
    1 <= adl_hphn AND adl_hphn < 2   => -0.295636,
    2 <= adl_hphn AND adl_hphn < 3   => 0.578764,
    3 <= adl_hphn                    => 0.057312,
                                        -0.000000);

iv_src_property_adl_count := if(not(truedid), 
																NULL, 
																max(if(max(Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')) = (string)NULL, 
																		NULL, 
																		sum(if(Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',') = (string)NULL, 
																				0, 
																				(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')))), 
																		0));

dual_subscore2 := map(
    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.175053,
    1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => 0.067215,
    2 <= iv_src_property_adl_count AND iv_src_property_adl_count < 3   => 0.176382,
    3 <= iv_src_property_adl_count                                     => 0.297223,
                                                                          -0.000000);

iv_estimated_income := if(not(truedid), NULL, estimated_income);

dual_subscore3 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 20000   => -0.315473,
    20000 <= iv_estimated_income AND iv_estimated_income < 25000 => -0.198360,
    25000 <= iv_estimated_income AND iv_estimated_income < 32000 => -0.116309,
    32000 <= iv_estimated_income AND iv_estimated_income < 36000 => 0.073564,
    36000 <= iv_estimated_income AND iv_estimated_income < 50000 => 0.220775,
    50000 <= iv_estimated_income AND iv_estimated_income < 74000 => 0.238483,
    74000 <= iv_estimated_income                                 => 0.504157,
                                                                    0.000000);

// iv_ams_college_tier := map(
    // not(truedid)            => '  ',
    // ams_college_tier = '' 	=> '-1',
                               // ams_college_tier);

// dual_subscore4 := map(
    // NULL < iv_ams_college_tier AND iv_ams_college_tier < 0 => -0.045878,
    // 0 <= iv_ams_college_tier                               => 0.513183,
                                                             // 0.000000);
																														 
//Per Corey - replaced the above code with the following in order to resolve syntax check errors but keep same results
dual_subscore4 := map(
		not(truedid)            => 	0.000000,
		ams_college_tier = '  '	=> -0.045878,
																0.513183);
                                                            
iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

dual_subscore5 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.092201,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.158182,
    2 <= iv_unreleased_liens_ct                                  => -0.328684,
                                                                    0.000000);

iv_impulse_count := if(not(truedid), NULL, impulse_count);

dual_subscore6 := map(
    NULL < iv_impulse_count AND iv_impulse_count < 1 => 0.033954,
    1 <= iv_impulse_count                            => -0.637296,
                                                        0.000000);

iv_bst_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

dual_subscore7 := map(
    NULL < iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 2722      => 0.042933,
    2722 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 24868    => -0.748851,
    24868 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 54597   => -0.291171,
    54597 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 67000   => -0.158907,
    67000 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 115736  => -0.068399,
    115736 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 176768 => 0.126363,
    176768 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 227250 => 0.025431,
    227250 <= iv_bst_addr_avm_auto_val AND iv_bst_addr_avm_auto_val < 440891 => 0.150471,
    440891 <= iv_bst_addr_avm_auto_val                                       => 0.351826,
                                                                                0.000000);

iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);

dual_subscore8 := map(
    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 1 => -0.341750,
    1 <= iv_ssns_per_adl AND iv_ssns_per_adl < 2   => 0.083506,
    2 <= iv_ssns_per_adl AND iv_ssns_per_adl < 3   => -0.080157,
    3 <= iv_ssns_per_adl AND iv_ssns_per_adl < 4   => -0.145460,
    4 <= iv_ssns_per_adl AND iv_ssns_per_adl < 5   => -0.477951,
    5 <= iv_ssns_per_adl                           => -0.430288,
                                                      0.000000);

iv_adls_per_addr := if(not(add1_pop), NULL, adls_per_addr);

dual_subscore9 := map(
    NULL < iv_adls_per_addr AND iv_adls_per_addr < 1 => 0.141662,
    1 <= iv_adls_per_addr AND iv_adls_per_addr < 2   => -0.072264,
    2 <= iv_adls_per_addr AND iv_adls_per_addr < 3   => 0.150386,
    3 <= iv_adls_per_addr AND iv_adls_per_addr < 8   => 0.172816,
    8 <= iv_adls_per_addr AND iv_adls_per_addr < 10  => 0.080474,
    10 <= iv_adls_per_addr AND iv_adls_per_addr < 13 => -0.045571,
    13 <= iv_adls_per_addr AND iv_adls_per_addr < 20 => -0.093377,
    20 <= iv_adls_per_addr                           => -0.162080,
                                                        0.000000);
mincriminal	:= min(criminal_count, 3);		
minfelony		:= min(felony_count, 3);
iv_criminal_x_felony := if(not(truedid), '   ', trim((string)mincriminal, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)minfelony, LEFT, RIGHT));

dual_subscore10 := map(
    (iv_criminal_x_felony in ['Other'])                                  => 0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.026945,
    (iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => -0.608979,
    (iv_criminal_x_felony in ['1-2', '1-1', '1-3', '2-2', '2-3', '3-3']) => -2.010168,
                                                                            0.000000);

iv_bk_disposition_lvl := map(
    not(truedid or (integer)ssnlength > 0)                                                                                               => '          ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => 'Discharged',
    (disposition in ['Dismissed'])                                                                                              => 'Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => 'OtherBK  ',
                                                                                                                                   'No BK');

dual_subscore11 := map(
    (iv_bk_disposition_lvl in ['Other'])      => 0.000000,
    (iv_bk_disposition_lvl in ['Discharged']) => 0.178453,
    (iv_bk_disposition_lvl in ['No BK'])      => 0.004594,
    (iv_bk_disposition_lvl in ['OtherBK'])    => -0.451724,
    (iv_bk_disposition_lvl in ['Dismissed'])  => -0.615066,
                                                 0.000000);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

dual_subscore12 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 496       => 0.007770,
    496 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 32396     => -0.421453,
    32396 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 50800   => -0.187575,
    50800 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 74645   => -0.094469,
    74645 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 182701  => 0.039289,
    182701 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 360179 => 0.156158,
    360179 <= iv_prv_addr_avm_auto_val                                       => 0.429349,
                                                                                0.000000);

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

dual_subscore13 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.047967,
    1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.240578,
    2 <= iv_eviction_count                             => -0.565379,
                                                          0.000000);

iv_max_lres := if(not(truedid), NULL, max_lres);

dual_subscore14 := map(
    NULL < iv_max_lres AND iv_max_lres < 189 => -0.058586,
    189 <= iv_max_lres AND iv_max_lres < 286 => 0.158424,
    286 <= iv_max_lres                       => 0.261907,
                                                -0.000000);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) => NULL,
    age > 0                => age,
    input_dob_age > '0'    => (integer)input_dob_age,
    inferred_age > 0       => inferred_age,
    reported_age > 0       => reported_age,
    ams_age > '0'          => (integer)ams_age,
                              -1);

dual_subscore15 := map(
    NULL < iv_combined_age AND iv_combined_age < 19 => -0.629919,
    19 <= iv_combined_age AND iv_combined_age < 21  => -0.492863,
    21 <= iv_combined_age AND iv_combined_age < 61  => 0.009338,
    61 <= iv_combined_age                           => 0.102409,
                                                       0.000000);

iv_bst_addr_naprop := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_naprop,
                        add2_naprop);

dual_subscore16 := map(
    NULL < iv_bst_addr_naprop AND iv_bst_addr_naprop < 1 => -0.048412,
    1 <= iv_bst_addr_naprop AND iv_bst_addr_naprop < 2   => -0.078464,
    2 <= iv_bst_addr_naprop AND iv_bst_addr_naprop < 3   => 0.201701,
    3 <= iv_bst_addr_naprop AND iv_bst_addr_naprop < 4   => 0.156644,
    4 <= iv_bst_addr_naprop                              => 0.105789,
                                                            -0.000000);

dual_subscore17 := map(
    NULL < adl_addr AND adl_addr < 2 => 0.000000,
    2 <= adl_addr AND adl_addr < 3   => 0.047281,
    3 <= adl_addr                    => -0.072251,
                                        0.000000);

// iv_prof_license_flag := if(not(truedid), NULL, prof_license_flag);

// dual_subscore18 := map(
    // NULL < iv_prof_license_flag AND iv_prof_license_flag < 1 => -0.007441,
    // 1 <= iv_prof_license_flag                                => 0.098345,
                                                                // 0.000000);

//Per Corey - this code replaces the commented code above...
dual_subscore18 := map(
		not(truedid)																							=> 0.000000,
    prof_license_flag                                					=> 0.098345,
																																-0.007441);
																																	
iv_inq_per_ssn := if(not(ssnlength > '0'), NULL, inq_perssn);

dual_subscore19 := map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.002409,
    1 <= iv_inq_per_ssn                          => -0.019425,
                                                    0.000000);

dual_rawscore := if(max(dual_subscore0, dual_subscore1, dual_subscore2, dual_subscore3, dual_subscore4, dual_subscore5, dual_subscore6, dual_subscore7, dual_subscore8, dual_subscore9, dual_subscore10, dual_subscore11, dual_subscore12, dual_subscore13, dual_subscore14, dual_subscore15, dual_subscore16, dual_subscore17, dual_subscore18, dual_subscore19) = NULL, NULL, sum(if(dual_subscore0 = NULL, 0, dual_subscore0), if(dual_subscore1 = NULL, 0, dual_subscore1), if(dual_subscore2 = NULL, 0, dual_subscore2), if(dual_subscore3 = NULL, 0, dual_subscore3), if(dual_subscore4 = NULL, 0, dual_subscore4), if(dual_subscore5 = NULL, 0, dual_subscore5), if(dual_subscore6 = NULL, 0, dual_subscore6), if(dual_subscore7 = NULL, 0, dual_subscore7), if(dual_subscore8 = NULL, 0, dual_subscore8), if(dual_subscore9 = NULL, 0, dual_subscore9), if(dual_subscore10 = NULL, 0, dual_subscore10), if(dual_subscore11 = NULL, 0, dual_subscore11), if(dual_subscore12 = NULL, 0, dual_subscore12), if(dual_subscore13 = NULL, 0, dual_subscore13), if(dual_subscore14 = NULL, 0, dual_subscore14), if(dual_subscore15 = NULL, 0, dual_subscore15), if(dual_subscore16 = NULL, 0, dual_subscore16), if(dual_subscore17 = NULL, 0, dual_subscore17), if(dual_subscore18 = NULL, 0, dual_subscore18), if(dual_subscore19 = NULL, 0, dual_subscore19)));

dual_lnoddsscore := dual_rawscore + -2.386671;

point := 40;

base := 700;

odds := .1466 / (1 - .1466);

_rvc1208_1_0 := round(point * (dual_lnoddsscore - ln(odds)) / ln(2) + base);

rvc1208_1_0_1 := min(if(max(round(_rvc1208_1_0), 501) = NULL, -NULL, max(round(_rvc1208_1_0), 501)), 900);

bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

lien_flag := ver_src_l2 or ver_src_li or lien_rec_unrel_flag or lien_hist_unrel_flag;

ssn_deceased := rc_decsflag = '1' or ver_src_ds;

// scored_222s := if(max(property_owned_total, property_sold_total) = NULL,NULL,sum(if(property_owned_total = NULL,0,property_owned_total),if(property_sold_total = NULL,0,property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= 7 or lien_flag > 0 or criminal_count > 0 or bk_flag > 0 or ssn_deceased > 0 or truedid > 0);

//Replaced the above code with this...

scored_222s := sum(property_owned_total,property_sold_total)>0
									or (90 <= combo_dobscore AND combo_dobscore <= 100) 
									or (integer)input_dob_match_level >= 7 
									or lien_flag 
									or criminal_count > 0 
									or bk_flag
									or ssn_deceased
									or truedid;

rvc1208_1_0 := map(
    ssn_deceased                                                                		=> 200,
    riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
                                                                                       rvc1208_1_0_1);

glrc97 := criminal_count > 0;

glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

glrc9a := NOT(property_owned_total > 0 OR (add1_naprop >= 2 or add1_family_owned or iv_src_property_adl_count > 0));

inp_addr_date_first_seen := common.sas_date((string)(add1_date_first_seen));

iv_mos_since_inp_addr_fseen := map(
    not(add1_pop)                   => NULL,
    inp_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - inp_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - inp_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - inp_addr_date_first_seen) / (365.25 / 12))));

glrc9c := addrpop and iv_mos_since_inp_addr_fseen > 0;

glrc9f := 0;

glrc9g := 18 <= iv_combined_age AND iv_combined_age < 21;

glrc9h := impulse_count > 0;

glrc9i := 18 <= iv_combined_age AND iv_combined_age <= 25;

glrc9m := (integer)wealth_index < 6;

glrc9q := Inq_count12 > 0;

glrc9w := bankrupt;

glrcev := attr_eviction_count > 0;

glrcms := ssns_per_adl >= 2;

glrcpv := 1;

glrcbl := 0;

rcvalue97_1 := 0.026945 - dual_subscore10;

rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue98_1 := 0.092201 - dual_subscore5;

rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9a_1 := 0.201701 - dual_subscore16;

rcvalue9a_2 := 0.297223 - dual_subscore2;

rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2)));

rcvalue9c_1 := 0.261907 - dual_subscore14;

rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));

rcvalue9f_1 := 0.194343 - dual_subscore0;

rcvalue9f := glrc9f * if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

rcvalue9g_1 := 0.102409 - dual_subscore15;

rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

rcvalue9h_1 := 0.033954 - dual_subscore6;

rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9i_1 := 0.513183 - dual_subscore4;

rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9m_1 := 0.504157 - dual_subscore3;

rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

rcvalue9q_1 := 0.002409 - dual_subscore19;

rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

rcvalue9w_1 := 0.178453 - dual_subscore11;

rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

rcvalueev_1 := 0.047967 - dual_subscore13;

rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

rcvaluems_1 := 0.083506 - dual_subscore8;

rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvaluepv_1 := 0.351826 - dual_subscore7;

rcvaluepv_2 := 0.429349 - dual_subscore12;

rcvaluepv := glrcpv * if(max(rcvaluepv_1, rcvaluepv_2) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2)));

rcvaluebl_1 := 0.172816 - dual_subscore9;

rcvaluebl_2 := 0.098345 - dual_subscore18;

rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'97',	RCValue97},
	{'98',	RCValue98},
	{'9A',	RCValue9A},
	{'9C',	RCValue9C},
	{'9F',	RCValue9F},
	{'9G',	RCValue9G},
	{'9H',	RCValue9H},
	{'9I',	RCValue9I},
	{'9M',	RCValue9M},
	{'9Q',	RCValue9Q},
	{'9W',	RCValue9W},
	{'EV',	RCValueEV},
	{'MS',	RCValueMS},
	{'PV',	RCValuePV},
	{'BL',	RCValueBL}
    ], ds_layout) (value > 0);

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
											rvc1208_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvc1208_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
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

	#if(RVC_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.ver_src_ba_pos                   := ver_src_ba_pos;
		self.ver_src_ba                       := ver_src_ba;
		self.ver_src_ds_pos                   := ver_src_ds_pos;
		self.ver_src_ds                       := ver_src_ds;
		self.ver_src_l2_pos                   := ver_src_l2_pos;
		self.ver_src_l2                       := ver_src_l2;
		self.ver_src_li_pos                   := ver_src_li_pos;
		self.ver_src_li                       := ver_src_li;
		self._gong_did_last_seen              := _gong_did_last_seen;
		self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;
		self.dual_subscore0                   := dual_subscore0;
		self.dual_subscore1                   := dual_subscore1;
		self.iv_src_property_adl_count        := iv_src_property_adl_count;
		self.dual_subscore2                   := dual_subscore2;
		self.iv_estimated_income              := iv_estimated_income;
		self.dual_subscore3                   := dual_subscore3;
		self.dual_subscore4                   := dual_subscore4;
		self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
		self.dual_subscore5                   := dual_subscore5;
		self.iv_impulse_count                 := iv_impulse_count;
		self.dual_subscore6                   := dual_subscore6;
		self.iv_bst_addr_avm_auto_val         := iv_bst_addr_avm_auto_val;
		self.dual_subscore7                   := dual_subscore7;
		self.iv_ssns_per_adl                  := iv_ssns_per_adl;
		self.dual_subscore8                   := dual_subscore8;
		self.iv_adls_per_addr                 := iv_adls_per_addr;
		self.dual_subscore9                   := dual_subscore9;
		self.iv_criminal_x_felony             := iv_criminal_x_felony;
		self.dual_subscore10                  := dual_subscore10;
		self.iv_bk_disposition_lvl            := iv_bk_disposition_lvl;
		self.dual_subscore11                  := dual_subscore11;
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
		self.dual_subscore12                  := dual_subscore12;
		self.iv_eviction_count                := iv_eviction_count;
		self.dual_subscore13                  := dual_subscore13;
		self.iv_max_lres                      := iv_max_lres;
		self.dual_subscore14                  := dual_subscore14;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.dual_subscore15                  := dual_subscore15;
		self.iv_bst_addr_naprop               := iv_bst_addr_naprop;
		self.dual_subscore16                  := dual_subscore16;
		self.dual_subscore17                  := dual_subscore17;
		self.dual_subscore18                  := dual_subscore18;
		self.iv_inq_per_ssn                   := iv_inq_per_ssn;
		self.dual_subscore19                  := dual_subscore19;
		self.dual_rawscore                    := dual_rawscore;
		self.dual_lnoddsscore                 := dual_lnoddsscore;
		self.point                            := point;
		self.base                             := base;
		self.odds                             := odds;
		self._rvc1208_1_0                     := _rvc1208_1_0;
		self.bk_flag                          := bk_flag;
		self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
		self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
		self.lien_flag                        := lien_flag;
		self.ssn_deceased                     := ssn_deceased;
		self.scored_222s                      := scored_222s;
		self.rvc1208_1_0                      := rvc1208_1_0;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.glrc9a                           := glrc9a;
		self.inp_addr_date_first_seen         := inp_addr_date_first_seen;
		self.iv_mos_since_inp_addr_fseen      := iv_mos_since_inp_addr_fseen;
		self.glrc9c                           := glrc9c;
		self.glrc9f                           := glrc9f;
		self.glrc9g                           := glrc9g;
		self.glrc9h                           := glrc9h;
		self.glrc9i                           := glrc9i;
		self.glrc9m                           := glrc9m;
		self.glrc9q                           := glrc9q;
		self.glrc9w                           := glrc9w;
		self.glrcev                           := glrcev;
		self.glrcms                           := glrcms;
		self.glrcpv                           := glrcpv;
		self.glrcbl                           := glrcbl;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a_2                      := rcvalue9a_2;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9c_1                      := rcvalue9c_1;
		self.rcvalue9c                        := rcvalue9c;
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
		self.rcvalue9q_1                      := rcvalue9q_1;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvaluepv_1                      := rcvaluepv_1;
		self.rcvaluepv_2                      := rcvaluepv_2;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvaluebl_1                      := rcvaluebl_1;
		self.rcvaluebl_2                      := rcvaluebl_2;
		self.rcvaluebl                        := rcvaluebl;
		SELF.rc1 															:= reasons[1].rc;
		SELF.rc2 															:= reasons[2].rc;
		SELF.rc3 															:= reasons[3].rc;
		SELF.rc4 															:= reasons[4].rc;
		SELF.rc5 															:= reasons[5].rc;
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1208_1_0);
END;

		model := project( clam, doModel(left) );

		return model;
END;

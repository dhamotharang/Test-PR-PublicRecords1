IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT rvt1605_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, Boolean isCalifornia = False) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
   Integer sysdate;
   String iv_vs099_addr_not_ver_w_ssn;
   Boolean email_src_im;
   Real iv_ds001_impulse_count;
   Integer iv_mi001_adlperssn_count;
   Real iv_pv001_inp_avm_autoval;
   Real iv_pv001_bst_avm_autoval;
   String iv_ed001_college_ind;
   Boolean iv_truedid;
   Integer prop_adl_p_lseen_pos;
   String prop_adl_lseen_p;
   Integer _prop_adl_lseen_p;
   Integer _src_prop_adl_lseen;
   Integer iv_mos_src_property_adl_lseen;
   Real emerge_adl_em_count_pos;
   Real emerge_adl_count_em;
   Real emerge_adl_e1_count_pos;
   Real emerge_adl_count_e1;
   Real emerge_adl_e2_count_pos;
   Real emerge_adl_count_e2;
   Real emerge_adl_e3_count_pos;
   Real emerge_adl_count_e3;
   Real emerge_adl_e4_count_pos;
   Real emerge_adl_count_e4;
   Real iv_src_emerge_adl_count;
   Integer iv_dob_score;
   String iv_inp_addr_ownership_lvl;
   String iv_bst_addr_ownership_lvl;
   Real iv_bst_addr_assessed_total_val;
   Real iv_prv_addr_avm_auto_val;
   Real iv_addr_lres_6mo_count;
   Integer _gong_did_first_seen;
   Integer iv_mos_since_gong_did_fst_seen;
   Integer _gong_did_last_seen;
   Integer iv_mos_since_gong_did_lst_seen;
   Integer iv_max_ids_per_addr_c6;
   Real iv_inq_highriskcredit_recency;
   Real iv_inq_phones_per_adl;
   Real iv_inq_per_phone;
   Real iv_paw_source_count;
   String iv_criminal_x_felony;
   Real w_subscore0;
   Real w_subscore1;
   Real w_subscore2;
   Real w_subscore3;
   Real w_subscore4;
   Real w_subscore5;
   Real w_subscore6;
   Real w_subscore7;
   Real w_subscore8;
   Real w_subscore9;
   Real w_subscore10;
   Real w_subscore11;
   Real w_subscore12;
   Real w_subscore13;
   Real w_subscore14;
   Real w_subscore15;
   Real w_subscore16;
   Real w_subscore17;
   Real w_subscore18;
   Real w_subscore19;
   Real w_subscore20;
   Real w_subscore21;
   Real w_subscore22;
   Real w_rawscore;
   Real w_lnoddsscore;
   Real w_probscore;
   String w_aacd_0;
   Real w_dist_0;
   String w_aacd_1;
   Real w_dist_1;
   String w_aacd_2;
   Real w_dist_2;
   String w_aacd_3;
   Real w_dist_3;
   String w_aacd_4;
   Real w_dist_4;
   String w_aacd_5;
   Real w_dist_5;
   String w_aacd_6;
   Real w_dist_6;
   String w_aacd_7;
   Real w_dist_7;
   String w_aacd_8;
   Real w_dist_8;
   String w_aacd_9;
   Real w_dist_9;
   String w_aacd_10;
   Real w_dist_10;
   String w_aacd_11;
   Real w_dist_11;
   String w_aacd_12;
   Real w_dist_12;
   String w_aacd_13;
   Real w_dist_13;
   String w_aacd_14;
   Real w_dist_14;
   String w_aacd_15;
   Real w_dist_15;
   String w_aacd_16;
   Real w_dist_16;
   String w_aacd_17;
   Real w_dist_17;
   String w_aacd_18;
   Real w_dist_18;
   String w_aacd_19;
   Real w_dist_19;
   String w_aacd_20;
   Real w_dist_20;
   String w_aacd_21;
   Real w_dist_21;
   Real w_dist_22;
   Real w_rcvalue9i;
   Real w_rcvalue9h;
   Real w_rcvaluepv;
   Real w_rcvalue9a;
   Real w_rcvalue36;
   Real w_rcvalue9d;
   Real w_rcvalue9q;
   Real w_rcvalue9r;
   Real w_rcvalue97;
   Integer base;
   Real odds;
   Real point;
   Boolean ssn_deceased;
   Boolean iv_riskview_222s;
   Integer rvt1605_2_1;
   String w_rc1;
   String w_rc2;
   String w_rc3;
   String w_rc4;
   Real w_vl1;
   Real w_vl2;
   Real w_vl3;
   Real w_vl4;
   String _rc_inq;
   String rc1;
   String rc2;
   String rc3;
   String rc4;
   String rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addr_lres_6mo_count              := le.address_history_summary.lres_6mo_count;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_perphone                     := le.acc_logs.inquiryperphone;
	paw_source_count                 := le.employment.source_ct;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

iv_vs099_addr_not_ver_w_ssn := if(not(truedid and ssnlength > '0'), ' ', (String)(Integer)(nas_summary in [4, 7, 9]));

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                           => NULL,
    impulse_count = 0 and (Integer)email_src_im > 0 => 1,
                                              impulse_count);

iv_mi001_adlperssn_count := map(
    not(ssnlength > '0')  => NULL,
    adlperssn_count = 0 => 1,
                           adlperssn_count);

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_ed001_college_ind := map(
    not(truedid)                                   => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or
	 (integer)ams_college_tier > 0 or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                            => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                       => '1',
                                     '0');

iv_truedid := truedid;

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

emerge_adl_em_count_pos := Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E');

emerge_adl_count_em := if(emerge_adl_em_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_em_count_pos, ','));

emerge_adl_e1_count_pos := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E');

emerge_adl_count_e1 := if(emerge_adl_e1_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e1_count_pos, ','));

emerge_adl_e2_count_pos := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E');

emerge_adl_count_e2 := if(emerge_adl_e2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e2_count_pos, ','));

emerge_adl_e3_count_pos := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E');

emerge_adl_count_e3 := if(emerge_adl_e3_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e3_count_pos, ','));

emerge_adl_e4_count_pos := Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E');

emerge_adl_count_e4 := if(emerge_adl_e4_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e4_count_pos, ','));

iv_src_emerge_adl_count := if(not(truedid), NULL, max(if(max(emerge_adl_count_em, emerge_adl_count_e1, emerge_adl_count_e2, emerge_adl_count_e3, emerge_adl_count_e4) = NULL, NULL, sum(if(emerge_adl_count_em = NULL, 0, emerge_adl_count_em), if(emerge_adl_count_e1 = NULL, 0, emerge_adl_count_e1), if(emerge_adl_count_e2 = NULL, 0, emerge_adl_count_e2), if(emerge_adl_count_e3 = NULL, 0, emerge_adl_count_e3), if(emerge_adl_count_e4 = NULL, 0, emerge_adl_count_e4))), (real)0));

iv_dob_score := if(not(truedid and dobpop), NULL, combo_dobscore);

iv_inp_addr_ownership_lvl := map(
    not(add1_pop)        => '            ',
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl_c18 := map(
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl_c19 := map(
    add2_applicant_owned => 'Applicant   ',
    add2_family_owned    => 'Family      ',
    add2_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl := map(
    not(truedid)     => ' ',
    add1_isbestmatch => iv_bst_addr_ownership_lvl_c18,
                        iv_bst_addr_ownership_lvl_c19);

iv_bst_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_assessed_total_value,
                        add2_assessed_total_value);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_addr_lres_6mo_count := map(
    not(truedid)                => NULL,
    addr_lres_6mo_count = -9999 => -1,
                                   addr_lres_6mo_count);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

iv_mos_since_gong_did_lst_seen_1 := if(not(truedid), NULL, NULL);

iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

iv_max_ids_per_addr_c6 := if(not(add1_pop), NULL, max(adls_per_addr_c6, ssns_per_addr_c6));

iv_inq_highriskcredit_recency := map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                 0);

iv_inq_phones_per_adl := if(not(truedid), NULL, inq_phonesperadl);

iv_inq_per_phone := if(not(hphnpop), NULL, inq_perphone);

iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

iv_criminal_x_felony := if(not(truedid), '   ', trim((String)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((String)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

w_subscore0 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 1 => 0.076882,
    1 <= iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 2   => -0.514691,
    2 <= iv_inq_phones_per_adl                                 => -1.363096,
                                                                  0);

w_subscore1 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.086399,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 24725       => -0.739736,
    24725 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 50077   => -0.274506,
    50077 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 78689   => -0.199888,
    78689 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 116808  => 0.000372,
    116808 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 148335 => 0.098685,
    148335 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 174760 => 0.150159,
    174760 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 219268 => 0.283976,
    219268 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 329950 => 0.335412,
    329950 <= iv_pv001_inp_avm_autoval                                       => 0.485882,
                                                                                0);

w_subscore2 := map(
    (iv_ed001_college_ind in [' ']) => 0.071822,
    (iv_ed001_college_ind in ['0']) => -0.052953,
    (iv_ed001_college_ind in ['1']) => 0.961572,
                                       0);

w_subscore3 := map(
    (iv_criminal_x_felony in [' '])                                                                  => 0,
    (iv_criminal_x_felony in ['0-0'])                                                                => 0.042829,
    (iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                                                  => -0.800615,
    (iv_criminal_x_felony in ['1-1', '0-1'])                                                         => -1.323363,
    (iv_criminal_x_felony in ['0-2', '0-3', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => -1.349354,
                                                                                                        0);

w_subscore4 := map(
    (iv_bst_addr_ownership_lvl in [' '])                   => 0.000253,
    (iv_bst_addr_ownership_lvl in ['Applicant', 'Family']) => 0.298251,
    (iv_bst_addr_ownership_lvl in ['Occupant'])            => -0.025215,
    (iv_bst_addr_ownership_lvl in ['No Ownership'])        => -0.162954,
                                                              0);

w_subscore5 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => 0.021087,
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 3056        => -0.733159,
    3056 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 14848    => -0.335667,
    14848 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 22026   => -0.093943,
    22026 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 72157   => -0.053907,
    72157 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 118506  => 0.019065,
    118506 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 219401 => 0.198804,
    219401 <= iv_bst_addr_assessed_total_val                                             => 0.264383,
                                                                                            0);

w_subscore6 := map(
    (iv_inp_addr_ownership_lvl in [' '])                   => 0,
    (iv_inp_addr_ownership_lvl in ['Applicant', 'Family']) => 0.275166,
    (iv_inp_addr_ownership_lvl in ['Occupant'])            => -0.067365,
    (iv_inp_addr_ownership_lvl in ['No Ownership'])        => -0.137151,
                                                              0);

w_subscore7 := map(
    NULL < iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 1 => 0.113582,
    1 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 2   => -0.120464,
    2 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 3   => -0.187725,
    3 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 4   => -0.451457,
    4 <= iv_max_ids_per_addr_c6                                  => -0.574277,
                                                                    0);

w_subscore8 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.089371,
    2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => -0.171324,
    3 <= iv_mi001_adlperssn_count                                    => -0.366435,
                                                                        0);

w_subscore9 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => -0.037628,
    0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 53  => 0.853193,
    53 <= iv_mos_src_property_adl_lseen                                        => 0.47753,
                                                                                  0);

w_subscore10 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => -0.019841,
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 40156       => -0.589844,
    40156 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 131254  => 0.008405,
    131254 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 274969 => 0.355747,
    274969 <= iv_prv_addr_avm_auto_val                                       => 0.525044,
                                                                                0);

w_subscore11 := map(
    (iv_vs099_addr_not_ver_w_ssn in [' ']) => 0,
    (iv_vs099_addr_not_ver_w_ssn in ['0']) => 0.083316,
    (iv_vs099_addr_not_ver_w_ssn in ['1']) => -0.182724,
                                              0);

w_subscore12 := map(
    NULL < iv_inq_per_phone AND iv_inq_per_phone < 1 => 0.044349,
    1 <= iv_inq_per_phone                            => -0.349982,
                                                        0);

w_subscore13 := map(
    NULL < iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 1 => -0.0305,
    1 <= iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 2   => 0.178816,
    2 <= iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 3   => 0.368215,
    3 <= iv_src_emerge_adl_count                                   => 0.764242,
                                                                      0);

w_subscore14 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 0  => -0.006155,
    0 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 13   => 0.319934,
    13 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 106 => -0.282422,
    106 <= iv_mos_since_gong_did_lst_seen                                         => -0.871017,
                                                                                     0);

w_subscore15 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0   => 0.01939,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 95    => -0.282038,
    95 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 116  => -0.012871,
    116 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 134 => 0.356378,
    134 <= iv_mos_since_gong_did_fst_seen                                          => 0.556793,
                                                                                      0);

w_subscore16 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.015057,
    1 <= iv_inq_highriskcredit_recency                                         => -1.089639,
                                                                                  0);

w_subscore17 := map(
    NULL < iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 0 => 0.00581,
    0 <= iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 1   => 0.040979,
    1 <= iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 2   => -0.022839,
    2 <= iv_addr_lres_6mo_count                                  => -0.357663,
                                                                    0);

w_subscore18 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.010079,
    1 <= iv_ds001_impulse_count                                  => -1.288658,
                                                                    0);

w_subscore19 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.012394,
    1 <= iv_paw_source_count                               => 0.669486,
                                                              0);

w_subscore20 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => 0.011394,
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 28259       => -0.311749,
    28259 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 55225   => -0.15696,
    55225 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 119662  => -0.080294,
    119662 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 162244 => -0.040745,
    162244 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 312757 => 0.046003,
    312757 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 455450 => 0.15794,
    455450 <= iv_pv001_bst_avm_autoval                                       => 0.213472,
                                                                                0);

w_subscore21 := map(
    NULL < iv_dob_score AND iv_dob_score < 100 => -0.217248,
    100 <= iv_dob_score AND iv_dob_score < 255 => 0.02888,
    255 <= iv_dob_score                        => 0,
                                                  0);

w_subscore22 := map(
    (Not iv_truedid) => 0.011844,
    (iv_truedid) => -0.000838,
                             0);

w_rawscore := w_subscore0 +
    w_subscore1 +
    w_subscore2 +
    w_subscore3 +
    w_subscore4 +
    w_subscore5 +
    w_subscore6 +
    w_subscore7 +
    w_subscore8 +
    w_subscore9 +
    w_subscore10 +
    w_subscore11 +
    w_subscore12 +
    w_subscore13 +
    w_subscore14 +
    w_subscore15 +
    w_subscore16 +
    w_subscore17 +
    w_subscore18 +
    w_subscore19 +
    w_subscore20 +
    w_subscore21 +
    w_subscore22;

w_lnoddsscore := w_rawscore + 0.707672;

w_probscore := exp(w_lnoddsscore) / (1 + exp(w_lnoddsscore));

w_aacd_0 := map(
    NULL < iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 1 => '9Q',
    1 <= iv_inq_phones_per_adl AND iv_inq_phones_per_adl < 2   => '9Q',
    2 <= iv_inq_phones_per_adl                                 => '9Q',
                                                                  '');

w_dist_0 := w_subscore0 - 0.076882;

w_aacd_1 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 24725       => 'PV',
    24725 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 50077   => 'PV',
    50077 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 78689   => 'PV',
    78689 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 116808  => 'PV',
    116808 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 148335 => 'PV',
    148335 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 174760 => 'PV',
    174760 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 219268 => 'PV',
    219268 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 329950 => 'PV',
    329950 <= iv_pv001_inp_avm_autoval                                       => 'PV',
                                                                                '');

w_dist_1 := w_subscore1 - 0.485882;

w_aacd_2 := map(
    (iv_ed001_college_ind in [' ']) => '36',
    (iv_ed001_college_ind in ['0']) => '9I',
    (iv_ed001_college_ind in ['1']) => '9I',
                                       '');

w_dist_2 := w_subscore2 - 0.961572;

w_aacd_3 := map(
    (iv_criminal_x_felony in [' '])                                                                  => '36',
    (iv_criminal_x_felony in ['0-0'])                                                                => '97',
    (iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                                                  => '97',
    (iv_criminal_x_felony in ['1-1', '0-1'])                                                         => '97',
    (iv_criminal_x_felony in ['0-2', '0-3', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3']) => '97',
                                                                                                        '');

w_dist_3 := w_subscore3 - 0.042829;

w_aacd_4 := map(
    (iv_bst_addr_ownership_lvl in [' '])                   => '36',
    (iv_bst_addr_ownership_lvl in ['Applicant', 'Family']) => '9A',
    (iv_bst_addr_ownership_lvl in ['Occupant'])            => '9A',
    (iv_bst_addr_ownership_lvl in ['No Ownership'])        => '9A',
                                                              '');

w_dist_4 := w_subscore4 - 0.298251;

w_aacd_5 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => 'PV',
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 3056        => 'PV',
    3056 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 14848    => 'PV',
    14848 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 22026   => 'PV',
    22026 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 72157   => 'PV',
    72157 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 118506  => 'PV',
    118506 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 219401 => 'PV',
    219401 <= iv_bst_addr_assessed_total_val                                             => 'PV',
                                                                                            '');

w_dist_5 := w_subscore5 - 0.264383;

w_aacd_6 := map(
    (iv_inp_addr_ownership_lvl in [' '])                   => '36',
    (iv_inp_addr_ownership_lvl in ['Applicant', 'Family']) => '9A',
    (iv_inp_addr_ownership_lvl in ['Occupant'])            => '9A',
    (iv_inp_addr_ownership_lvl in ['No Ownership'])        => '9A',
                                                              '');

w_dist_6 := w_subscore6 - 0.275166;

w_aacd_7 := map(
    NULL < iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 1 => '',
    1 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 2   => '',
    2 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 3   => '',
    3 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 4   => '',
    4 <= iv_max_ids_per_addr_c6                                  => '',
                                                                    '');

w_dist_7 := w_subscore7 - 0.113582;

w_aacd_8 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => '',
    2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => '',
    3 <= iv_mi001_adlperssn_count                                    => '',
                                                                        '');

w_dist_8 := w_subscore8 - 0.089371;

w_aacd_9 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => '36',
    0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 53  => '36',
    53 <= iv_mos_src_property_adl_lseen                                        => '36',
                                                                                  '');

w_dist_9 := w_subscore9 - 0.853193;

w_aacd_10 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => 'PV',
    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 40156       => 'PV',
    40156 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 131254  => 'PV',
    131254 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 274969 => 'PV',
    274969 <= iv_prv_addr_avm_auto_val                                       => 'PV',
                                                                                '');

w_dist_10 := w_subscore10 - 0.525044;

w_aacd_11 := map(
    (iv_vs099_addr_not_ver_w_ssn in [' ']) => '36',
    (iv_vs099_addr_not_ver_w_ssn in ['0']) => '36',
    (iv_vs099_addr_not_ver_w_ssn in ['1']) => '36',
                                              '');

w_dist_11 := w_subscore11 - 0.083316;

w_aacd_12 := map(
    NULL < iv_inq_per_phone AND iv_inq_per_phone < 1 => '9Q',
    1 <= iv_inq_per_phone                            => '9Q',
                                                        '');

w_dist_12 := w_subscore12 - 0.044349;

w_aacd_13 := map(
    NULL < iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 1 => '36',
    1 <= iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 2   => '36',
    2 <= iv_src_emerge_adl_count AND iv_src_emerge_adl_count < 3   => '36',
    3 <= iv_src_emerge_adl_count                                   => '36',
                                                                      '');

w_dist_13 := w_subscore13 - 0.764242;

w_aacd_14 := map(
    NULL < iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 0  => '9R',
    0 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 13   => '9R',
    13 <= iv_mos_since_gong_did_lst_seen AND iv_mos_since_gong_did_lst_seen < 106 => '9R',
    106 <= iv_mos_since_gong_did_lst_seen                                         => '9R',
                                                                                     '');

w_dist_14 := w_subscore14 - 0.319934;

w_aacd_15 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0   => '9R',
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 95    => '9R',
    95 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 116  => '9R',
    116 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 134 => '9R',
    134 <= iv_mos_since_gong_did_fst_seen                                          => '9R',
                                                                                      '');

w_dist_15 := w_subscore15 - 0.556793;

w_aacd_16 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => '9Q',
    1 <= iv_inq_highriskcredit_recency                                         => '9Q',
                                                                                  '');

w_dist_16 := w_subscore16 - 0.015057;

w_aacd_17 := map(
    NULL < iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 0 => '9D',
    0 <= iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 1   => '9D',
    1 <= iv_addr_lres_6mo_count AND iv_addr_lres_6mo_count < 2   => '9D',
    2 <= iv_addr_lres_6mo_count                                  => '9D',
                                                                    '');

w_dist_17 := w_subscore17 - 0.040979;

w_aacd_18 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => '9H',
    1 <= iv_ds001_impulse_count                                  => '9H',
                                                                    '');

w_dist_18 := w_subscore18 - 0.010079;

w_aacd_19 := map(
    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => '36',
    1 <= iv_paw_source_count                               => '36',
                                                              '');

w_dist_19 := w_subscore19 - 0.669486;

w_aacd_20 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => 'PV',
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 28259       => 'PV',
    28259 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 55225   => 'PV',
    55225 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 119662  => 'PV',
    119662 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 162244 => 'PV',
    162244 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 312757 => 'PV',
    312757 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 455450 => 'PV',
    455450 <= iv_pv001_bst_avm_autoval                                       => 'PV',
                                                                                '');

w_dist_20 := w_subscore20 - 0.213472;

w_aacd_21 := map(
    NULL < iv_dob_score AND iv_dob_score < 100 => '36',
    100 <= iv_dob_score AND iv_dob_score < 255 => '36',
    255 <= iv_dob_score                        => '36',
                                                  '');

w_dist_21 := w_subscore21 - 0.02888;

w_dist_22 := w_subscore22 - 0.011844;

w_rcvalue9i := (integer)(w_aacd_0 = '9I') * w_dist_0 +
    (integer)(w_aacd_1 = '9I') * w_dist_1 +
    (integer)(w_aacd_2 = '9I') * w_dist_2 +
    (integer)(w_aacd_3 = '9I') * w_dist_3 +
    (integer)(w_aacd_4 = '9I') * w_dist_4 +
    (integer)(w_aacd_5 = '9I') * w_dist_5 +
    (integer)(w_aacd_6 = '9I') * w_dist_6 +
    (integer)(w_aacd_7 = '9I') * w_dist_7 +
    (integer)(w_aacd_8 = '9I') * w_dist_8 +
    (integer)(w_aacd_9 = '9I') * w_dist_9 +
    (integer)(w_aacd_10 = '9I') * w_dist_10 +
    (integer)(w_aacd_11 = '9I') * w_dist_11 +
    (integer)(w_aacd_12 = '9I') * w_dist_12 +
    (integer)(w_aacd_13 = '9I') * w_dist_13 +
    (integer)(w_aacd_14 = '9I') * w_dist_14 +
    (integer)(w_aacd_15 = '9I') * w_dist_15 +
    (integer)(w_aacd_16 = '9I') * w_dist_16 +
    (integer)(w_aacd_17 = '9I') * w_dist_17 +
    (integer)(w_aacd_18 = '9I') * w_dist_18 +
    (integer)(w_aacd_19 = '9I') * w_dist_19 +
    (integer)(w_aacd_20 = '9I') * w_dist_20 +
    (integer)(w_aacd_21 = '9I') * w_dist_21;

w_rcvalue9h := (integer)(w_aacd_0 = '9H') * w_dist_0 +
    (integer)(w_aacd_1 = '9H') * w_dist_1 +
    (integer)(w_aacd_2 = '9H') * w_dist_2 +
    (integer)(w_aacd_3 = '9H') * w_dist_3 +
    (integer)(w_aacd_4 = '9H') * w_dist_4 +
    (integer)(w_aacd_5 = '9H') * w_dist_5 +
    (integer)(w_aacd_6 = '9H') * w_dist_6 +
    (integer)(w_aacd_7 = '9H') * w_dist_7 +
    (integer)(w_aacd_8 = '9H') * w_dist_8 +
    (integer)(w_aacd_9 = '9H') * w_dist_9 +
    (integer)(w_aacd_10 = '9H') * w_dist_10 +
    (integer)(w_aacd_11 = '9H') * w_dist_11 +
    (integer)(w_aacd_12 = '9H') * w_dist_12 +
    (integer)(w_aacd_13 = '9H') * w_dist_13 +
    (integer)(w_aacd_14 = '9H') * w_dist_14 +
    (integer)(w_aacd_15 = '9H') * w_dist_15 +
    (integer)(w_aacd_16 = '9H') * w_dist_16 +
    (integer)(w_aacd_17 = '9H') * w_dist_17 +
    (integer)(w_aacd_18 = '9H') * w_dist_18 +
    (integer)(w_aacd_19 = '9H') * w_dist_19 +
    (integer)(w_aacd_20 = '9H') * w_dist_20 +
    (integer)(w_aacd_21 = '9H') * w_dist_21;

w_rcvaluepv := (integer)(w_aacd_0 = 'PV') * w_dist_0 +
    (integer)(w_aacd_1 = 'PV') * w_dist_1 +
    (integer)(w_aacd_2 = 'PV') * w_dist_2 +
    (integer)(w_aacd_3 = 'PV') * w_dist_3 +
    (integer)(w_aacd_4 = 'PV') * w_dist_4 +
    (integer)(w_aacd_5 = 'PV') * w_dist_5 +
    (integer)(w_aacd_6 = 'PV') * w_dist_6 +
    (integer)(w_aacd_7 = 'PV') * w_dist_7 +
    (integer)(w_aacd_8 = 'PV') * w_dist_8 +
    (integer)(w_aacd_9 = 'PV') * w_dist_9 +
    (integer)(w_aacd_10 = 'PV') * w_dist_10 +
    (integer)(w_aacd_11 = 'PV') * w_dist_11 +
    (integer)(w_aacd_12 = 'PV') * w_dist_12 +
    (integer)(w_aacd_13 = 'PV') * w_dist_13 +
    (integer)(w_aacd_14 = 'PV') * w_dist_14 +
    (integer)(w_aacd_15 = 'PV') * w_dist_15 +
    (integer)(w_aacd_16 = 'PV') * w_dist_16 +
    (integer)(w_aacd_17 = 'PV') * w_dist_17 +
    (integer)(w_aacd_18 = 'PV') * w_dist_18 +
    (integer)(w_aacd_19 = 'PV') * w_dist_19 +
    (integer)(w_aacd_20 = 'PV') * w_dist_20 +
    (integer)(w_aacd_21 = 'PV') * w_dist_21;

w_rcvalue9a := (integer)(w_aacd_0 = '9A') * w_dist_0 +
    (integer)(w_aacd_1 = '9A') * w_dist_1 +
    (integer)(w_aacd_2 = '9A') * w_dist_2 +
    (integer)(w_aacd_3 = '9A') * w_dist_3 +
    (integer)(w_aacd_4 = '9A') * w_dist_4 +
    (integer)(w_aacd_5 = '9A') * w_dist_5 +
    (integer)(w_aacd_6 = '9A') * w_dist_6 +
    (integer)(w_aacd_7 = '9A') * w_dist_7 +
    (integer)(w_aacd_8 = '9A') * w_dist_8 +
    (integer)(w_aacd_9 = '9A') * w_dist_9 +
    (integer)(w_aacd_10 = '9A') * w_dist_10 +
    (integer)(w_aacd_11 = '9A') * w_dist_11 +
    (integer)(w_aacd_12 = '9A') * w_dist_12 +
    (integer)(w_aacd_13 = '9A') * w_dist_13 +
    (integer)(w_aacd_14 = '9A') * w_dist_14 +
    (integer)(w_aacd_15 = '9A') * w_dist_15 +
    (integer)(w_aacd_16 = '9A') * w_dist_16 +
    (integer)(w_aacd_17 = '9A') * w_dist_17 +
    (integer)(w_aacd_18 = '9A') * w_dist_18 +
    (integer)(w_aacd_19 = '9A') * w_dist_19 +
    (integer)(w_aacd_20 = '9A') * w_dist_20 +
    (integer)(w_aacd_21 = '9A') * w_dist_21;

w_rcvalue36 := (integer)(w_aacd_0 = '36') * w_dist_0 +
    (integer)(w_aacd_1 = '36') * w_dist_1 +
    (integer)(w_aacd_2 = '36') * w_dist_2 +
    (integer)(w_aacd_3 = '36') * w_dist_3 +
    (integer)(w_aacd_4 = '36') * w_dist_4 +
    (integer)(w_aacd_5 = '36') * w_dist_5 +
    (integer)(w_aacd_6 = '36') * w_dist_6 +
    (integer)(w_aacd_7 = '36') * w_dist_7 +
    (integer)(w_aacd_8 = '36') * w_dist_8 +
    (integer)(w_aacd_9 = '36') * w_dist_9 +
    (integer)(w_aacd_10 = '36') * w_dist_10 +
    (integer)(w_aacd_11 = '36') * w_dist_11 +
    (integer)(w_aacd_12 = '36') * w_dist_12 +
    (integer)(w_aacd_13 = '36') * w_dist_13 +
    (integer)(w_aacd_14 = '36') * w_dist_14 +
    (integer)(w_aacd_15 = '36') * w_dist_15 +
    (integer)(w_aacd_16 = '36') * w_dist_16 +
    (integer)(w_aacd_17 = '36') * w_dist_17 +
    (integer)(w_aacd_18 = '36') * w_dist_18 +
    (integer)(w_aacd_19 = '36') * w_dist_19 +
    (integer)(w_aacd_20 = '36') * w_dist_20 +
    (integer)(w_aacd_21 = '36') * w_dist_21;

w_rcvalue9d := (integer)(w_aacd_0 = '9D') * w_dist_0 +
    (integer)(w_aacd_1 = '9D') * w_dist_1 +
    (integer)(w_aacd_2 = '9D') * w_dist_2 +
    (integer)(w_aacd_3 = '9D') * w_dist_3 +
    (integer)(w_aacd_4 = '9D') * w_dist_4 +
    (integer)(w_aacd_5 = '9D') * w_dist_5 +
    (integer)(w_aacd_6 = '9D') * w_dist_6 +
    (integer)(w_aacd_7 = '9D') * w_dist_7 +
    (integer)(w_aacd_8 = '9D') * w_dist_8 +
    (integer)(w_aacd_9 = '9D') * w_dist_9 +
    (integer)(w_aacd_10 = '9D') * w_dist_10 +
    (integer)(w_aacd_11 = '9D') * w_dist_11 +
    (integer)(w_aacd_12 = '9D') * w_dist_12 +
    (integer)(w_aacd_13 = '9D') * w_dist_13 +
    (integer)(w_aacd_14 = '9D') * w_dist_14 +
    (integer)(w_aacd_15 = '9D') * w_dist_15 +
    (integer)(w_aacd_16 = '9D') * w_dist_16 +
    (integer)(w_aacd_17 = '9D') * w_dist_17 +
    (integer)(w_aacd_18 = '9D') * w_dist_18 +
    (integer)(w_aacd_19 = '9D') * w_dist_19 +
    (integer)(w_aacd_20 = '9D') * w_dist_20 +
    (integer)(w_aacd_21 = '9D') * w_dist_21;

w_rcvalue9q := (integer)(w_aacd_0 = '9Q') * w_dist_0 +
    (integer)(w_aacd_1 = '9Q') * w_dist_1 +
    (integer)(w_aacd_2 = '9Q') * w_dist_2 +
    (integer)(w_aacd_3 = '9Q') * w_dist_3 +
    (integer)(w_aacd_4 = '9Q') * w_dist_4 +
    (integer)(w_aacd_5 = '9Q') * w_dist_5 +
    (integer)(w_aacd_6 = '9Q') * w_dist_6 +
    (integer)(w_aacd_7 = '9Q') * w_dist_7 +
    (integer)(w_aacd_8 = '9Q') * w_dist_8 +
    (integer)(w_aacd_9 = '9Q') * w_dist_9 +
    (integer)(w_aacd_10 = '9Q') * w_dist_10 +
    (integer)(w_aacd_11 = '9Q') * w_dist_11 +
    (integer)(w_aacd_12 = '9Q') * w_dist_12 +
    (integer)(w_aacd_13 = '9Q') * w_dist_13 +
    (integer)(w_aacd_14 = '9Q') * w_dist_14 +
    (integer)(w_aacd_15 = '9Q') * w_dist_15 +
    (integer)(w_aacd_16 = '9Q') * w_dist_16 +
    (integer)(w_aacd_17 = '9Q') * w_dist_17 +
    (integer)(w_aacd_18 = '9Q') * w_dist_18 +
    (integer)(w_aacd_19 = '9Q') * w_dist_19 +
    (integer)(w_aacd_20 = '9Q') * w_dist_20 +
    (integer)(w_aacd_21 = '9Q') * w_dist_21;

w_rcvalue9r := (integer)(w_aacd_0 = '9R') * w_dist_0 +
    (integer)(w_aacd_1 = '9R') * w_dist_1 +
    (integer)(w_aacd_2 = '9R') * w_dist_2 +
    (integer)(w_aacd_3 = '9R') * w_dist_3 +
    (integer)(w_aacd_4 = '9R') * w_dist_4 +
    (integer)(w_aacd_5 = '9R') * w_dist_5 +
    (integer)(w_aacd_6 = '9R') * w_dist_6 +
    (integer)(w_aacd_7 = '9R') * w_dist_7 +
    (integer)(w_aacd_8 = '9R') * w_dist_8 +
    (integer)(w_aacd_9 = '9R') * w_dist_9 +
    (integer)(w_aacd_10 = '9R') * w_dist_10 +
    (integer)(w_aacd_11 = '9R') * w_dist_11 +
    (integer)(w_aacd_12 = '9R') * w_dist_12 +
    (integer)(w_aacd_13 = '9R') * w_dist_13 +
    (integer)(w_aacd_14 = '9R') * w_dist_14 +
    (integer)(w_aacd_15 = '9R') * w_dist_15 +
    (integer)(w_aacd_16 = '9R') * w_dist_16 +
    (integer)(w_aacd_17 = '9R') * w_dist_17 +
    (integer)(w_aacd_18 = '9R') * w_dist_18 +
    (integer)(w_aacd_19 = '9R') * w_dist_19 +
    (integer)(w_aacd_20 = '9R') * w_dist_20 +
    (integer)(w_aacd_21 = '9R') * w_dist_21;

w_rcvalue97 := (integer)(w_aacd_0 = '97') * w_dist_0 +
    (integer)(w_aacd_1 = '97') * w_dist_1 +
    (integer)(w_aacd_2 = '97') * w_dist_2 +
    (integer)(w_aacd_3 = '97') * w_dist_3 +
    (integer)(w_aacd_4 = '97') * w_dist_4 +
    (integer)(w_aacd_5 = '97') * w_dist_5 +
    (integer)(w_aacd_6 = '97') * w_dist_6 +
    (integer)(w_aacd_7 = '97') * w_dist_7 +
    (integer)(w_aacd_8 = '97') * w_dist_8 +
    (integer)(w_aacd_9 = '97') * w_dist_9 +
    (integer)(w_aacd_10 = '97') * w_dist_10 +
    (integer)(w_aacd_11 = '97') * w_dist_11 +
    (integer)(w_aacd_12 = '97') * w_dist_12 +
    (integer)(w_aacd_13 = '97') * w_dist_13 +
    (integer)(w_aacd_14 = '97') * w_dist_14 +
    (integer)(w_aacd_15 = '97') * w_dist_15 +
    (integer)(w_aacd_16 = '97') * w_dist_16 +
    (integer)(w_aacd_17 = '97') * w_dist_17 +
    (integer)(w_aacd_18 = '97') * w_dist_18 +
    (integer)(w_aacd_19 = '97') * w_dist_19 +
    (integer)(w_aacd_20 = '97') * w_dist_20 +
    (integer)(w_aacd_21 = '97') * w_dist_21;

base := 700;

odds := (1 - 0.2853) / 0.2853;

point := 40;

ssn_deceased := rc_decsflag = '1' or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvt1605_2_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(point * (w_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (w_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_w := DATASET([
    {'9I', w_rcvalue9I},
    {'9H', w_rcvalue9H},
    {'PV', w_rcvaluePV},
    {'9A', w_rcvalue9A},
    {'36', w_rcvalue36},
    {'9D', w_rcvalue9D},
    {'9Q', w_rcvalue9Q},
    {'9R', w_rcvalue9R},
    {'97', w_rcvalue97}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_w_sorted := sort(rc_dataset_w, rc_dataset_w.value);

w_rc1 := rc_dataset_w_sorted[1].rc;
w_rc2 := rc_dataset_w_sorted[2].rc;
w_rc3 := rc_dataset_w_sorted[3].rc;
w_rc4 := rc_dataset_w_sorted[4].rc;

w_vl1 := rc_dataset_w_sorted[1].value;
w_vl2 := rc_dataset_w_sorted[2].value;
w_vl3 := rc_dataset_w_sorted[3].value;
w_vl4 := rc_dataset_w_sorted[4].value;
//*************************************************************************************//

rc1_2 := w_rc1;

rc2_2 := w_rc2;

rc3_2 := w_rc3;

rc4_2 := w_rc4;

_rc_inq := map(
    iv_inq_phones_per_adl > 0         => '9Q',
    iv_inq_per_phone > 0              => '9Q',
    iv_inq_highriskcredit_recency > 0 => '9Q',
                                         '');

// rc4_c81 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             // '');

// rc1_c81 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

// rc3_c81 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

// rc2_c81 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             // '');

rc5_c81 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc5_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc5_c81, '');

// rc4_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc4_c81, rc4_2);

// rc2_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc2_c81, rc2_2);

// rc3_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc3_c81, rc3_2);

// rc1_1 := if(not((rc1_2 in ['9Q'])) and not((rc2_2 in ['9Q'])) and not((rc3_2 in ['9Q'])) and not((rc4_2 in ['9Q'])), rc1_c81, rc1_2);

rc5 := map(
    rvt1605_2_1 = 200 => '',
    rvt1605_2_1 = 222 => '',
                         rc5_1);

rc3 := map(
    rvt1605_2_1 = 200 => '',
    rvt1605_2_1 = 222 => '',
                         rc3_2);

rc1 := map(
    rvt1605_2_1 = 200 => '02',
    rvt1605_2_1 = 222 => '9X',
                         rc1_2);

rc2 := map(
    rvt1605_2_1 = 200 => '',
    rvt1605_2_1 = 222 => '',
                         rc2_2);

rc4 := map(
    rvt1605_2_1 = 200 => '',
    rvt1605_2_1 = 222 => '',
                         rc4_2);


	//*************************************************************************************//
	//                       End RiskView Version 4.1 Reason Code Logic
	//*************************************************************************************//


	//*************************************************************************************//
	//                      RiskView Version 4.1 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V4.1 MODELS HAVE THIS
	//*************************************************************************************//
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	
	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
	
	reasonsTemp := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout)(HRI NOT IN ['', '00']);
	reasons := IF(ut.Exists2(reasonsTemp), reasonsTemp, DATASET([{'36'}], HRILayout));
	
	riCorrectionsTemp := PROJECT(RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4), TRANSFORM(HRILayout, SELF.HRI := LEFT.hri)) (HRI NOT IN ['', '00']);

	reasonsOverrides := MAP(
													inCalif           =>	DATASET([{'35'}], HRILayout),
													rvt1605_2_1 = 200 =>	DATASET([{'02'}], HRILayout),
													rvt1605_2_1 = 222 =>	DATASET([{'9X'}], HRILayout),
													rvt1605_2_1 = 900 =>	DATASET([{' '}], HRILayout),
													rvt1605_2_1 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
													rvt1605_2_1 BETWEEN 501 AND 720 AND reasons[1].HRI != '9E' AND reasons[2].HRI = ''					 => DATASET([{reasons[1].HRI}, {'9E'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp(trim(hri)<>''))	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides(trim(hri)<>''))	=> reasonsOverrides, 
																													 reasons(trim(HRI) <> '')) (trim(HRI) <> '');
																													 
																													 
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	// reasonCodes := CHOOSEN(reasons, 5); // Keep up to 5 reason codes

	//*************************************************************************************//
	//                   End RiskView Version 4.1 Reason Code Overrides
	//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
	 self.seq															 := le.seq;
   self.sysdate         := sysdate;
   self.iv_vs099_addr_not_ver_w_ssn      := iv_vs099_addr_not_ver_w_ssn;
   self.email_src_im    := email_src_im;
   self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
   self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
   self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
   self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
   self.iv_ed001_college_ind             := iv_ed001_college_ind;
   self.iv_truedid      := iv_truedid;
   self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
   self.prop_adl_lseen_p                 := prop_adl_lseen_p;
   self._prop_adl_lseen_p                := _prop_adl_lseen_p;
   self._src_prop_adl_lseen              := _src_prop_adl_lseen;
   self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
   self.emerge_adl_em_count_pos          := emerge_adl_em_count_pos;
   self.emerge_adl_count_em              := emerge_adl_count_em;
   self.emerge_adl_e1_count_pos          := emerge_adl_e1_count_pos;
   self.emerge_adl_count_e1              := emerge_adl_count_e1;
   self.emerge_adl_e2_count_pos          := emerge_adl_e2_count_pos;
   self.emerge_adl_count_e2              := emerge_adl_count_e2;
   self.emerge_adl_e3_count_pos          := emerge_adl_e3_count_pos;
   self.emerge_adl_count_e3              := emerge_adl_count_e3;
   self.emerge_adl_e4_count_pos          := emerge_adl_e4_count_pos;
   self.emerge_adl_count_e4              := emerge_adl_count_e4;
   self.iv_src_emerge_adl_count          := iv_src_emerge_adl_count;
   self.iv_dob_score    := iv_dob_score;
   self.iv_inp_addr_ownership_lvl        := iv_inp_addr_ownership_lvl;
   self.iv_bst_addr_ownership_lvl        := iv_bst_addr_ownership_lvl;
   self.iv_bst_addr_assessed_total_val   := iv_bst_addr_assessed_total_val;
   self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
   self.iv_addr_lres_6mo_count           := iv_addr_lres_6mo_count;
   self._gong_did_first_seen             := _gong_did_first_seen;
   self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
   self._gong_did_last_seen              := _gong_did_last_seen;
   self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;
   self.iv_max_ids_per_addr_c6           := iv_max_ids_per_addr_c6;
   self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
   self.iv_inq_phones_per_adl            := iv_inq_phones_per_adl;
   self.iv_inq_per_phone                 := iv_inq_per_phone;
   self.iv_paw_source_count              := iv_paw_source_count;
   self.iv_criminal_x_felony             := iv_criminal_x_felony;
   self.w_subscore0     := w_subscore0;
   self.w_subscore1     := w_subscore1;
   self.w_subscore2     := w_subscore2;
   self.w_subscore3     := w_subscore3;
   self.w_subscore4     := w_subscore4;
   self.w_subscore5     := w_subscore5;
   self.w_subscore6     := w_subscore6;
   self.w_subscore7     := w_subscore7;
   self.w_subscore8     := w_subscore8;
   self.w_subscore9     := w_subscore9;
   self.w_subscore10    := w_subscore10;
   self.w_subscore11    := w_subscore11;
   self.w_subscore12    := w_subscore12;
   self.w_subscore13    := w_subscore13;
   self.w_subscore14    := w_subscore14;
   self.w_subscore15    := w_subscore15;
   self.w_subscore16    := w_subscore16;
   self.w_subscore17    := w_subscore17;
   self.w_subscore18    := w_subscore18;
   self.w_subscore19    := w_subscore19;
   self.w_subscore20    := w_subscore20;
   self.w_subscore21    := w_subscore21;
   self.w_subscore22    := w_subscore22;
   self.w_rawscore      := w_rawscore;
   self.w_lnoddsscore   := w_lnoddsscore;
   self.w_probscore     := w_probscore;
   self.w_aacd_0        := w_aacd_0;
   self.w_dist_0        := w_dist_0;
   self.w_aacd_1        := w_aacd_1;
   self.w_dist_1        := w_dist_1;
   self.w_aacd_2        := w_aacd_2;
   self.w_dist_2        := w_dist_2;
   self.w_aacd_3        := w_aacd_3;
   self.w_dist_3        := w_dist_3;
   self.w_aacd_4        := w_aacd_4;
   self.w_dist_4        := w_dist_4;
   self.w_aacd_5        := w_aacd_5;
   self.w_dist_5        := w_dist_5;
   self.w_aacd_6        := w_aacd_6;
   self.w_dist_6        := w_dist_6;
   self.w_aacd_7        := w_aacd_7;
   self.w_dist_7        := w_dist_7;
   self.w_aacd_8        := w_aacd_8;
   self.w_dist_8        := w_dist_8;
   self.w_aacd_9        := w_aacd_9;
   self.w_dist_9        := w_dist_9;
   self.w_aacd_10       := w_aacd_10;
   self.w_dist_10       := w_dist_10;
   self.w_aacd_11       := w_aacd_11;
   self.w_dist_11       := w_dist_11;
   self.w_aacd_12       := w_aacd_12;
   self.w_dist_12       := w_dist_12;
   self.w_aacd_13       := w_aacd_13;
   self.w_dist_13       := w_dist_13;
   self.w_aacd_14       := w_aacd_14;
   self.w_dist_14       := w_dist_14;
   self.w_aacd_15       := w_aacd_15;
   self.w_dist_15       := w_dist_15;
   self.w_aacd_16       := w_aacd_16;
   self.w_dist_16       := w_dist_16;
   self.w_aacd_17       := w_aacd_17;
   self.w_dist_17       := w_dist_17;
   self.w_aacd_18       := w_aacd_18;
   self.w_dist_18       := w_dist_18;
   self.w_aacd_19       := w_aacd_19;
   self.w_dist_19       := w_dist_19;
   self.w_aacd_20       := w_aacd_20;
   self.w_dist_20       := w_dist_20;
   self.w_aacd_21       := w_aacd_21;
   self.w_dist_21       := w_dist_21;
   self.w_dist_22       := w_dist_22;
   self.w_rcvalue9i     := w_rcvalue9i;
   self.w_rcvalue9h     := w_rcvalue9h;
   self.w_rcvaluepv     := w_rcvaluepv;
   self.w_rcvalue9a     := w_rcvalue9a;
   self.w_rcvalue36     := w_rcvalue36;
   self.w_rcvalue9d     := w_rcvalue9d;
   self.w_rcvalue9q     := w_rcvalue9q;
   self.w_rcvalue9r     := w_rcvalue9r;
   self.w_rcvalue97     := w_rcvalue97;
   self.base            := base;
   self.odds            := odds;
   self.point           := point;
   self.ssn_deceased    := ssn_deceased;
   self.iv_riskview_222s                 := iv_riskview_222s;
   self.rvt1605_2_1     := rvt1605_2_1;
   self.w_rc1           := w_rc1;
   self.w_rc2           := w_rc2;
   self.w_rc3           := w_rc3;
   self.w_rc4           := w_rc4;
   self.w_vl1           := w_vl1;
   self.w_vl2           := w_vl2;
   self.w_vl3           := w_vl3;
   self.w_vl4           := w_vl4;
   self._rc_inq         := _rc_inq;
   self.rc1             := rc1;
   self.rc2             := rc2;
   self.rc3             := rc3;
   self.rc4             := rc4;
   self.rc5             := rc5;

	 SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)rvt1605_2_1);

		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
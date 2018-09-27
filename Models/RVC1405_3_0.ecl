import risk_indicators, riskwise, riskwisefcra, ut, riskview;

export RVC1405_3_0( grouped dataset(risk_indicators.Layout_Boca_shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := False;

	#if(RVC_DEBUG)
		layout_debug := record
			INTEGER sysdate                       ;
			Boolean iv_pots_phone                 ;
			Boolean iv_add_apt                    ;
			Boolean iv_riskview_222s              ;
			Integer iv_mi001_adlperssn_count      ;
			String iv_in001_wealth_index          ;
			Boolean evidence_of_college           ;
			String iv_ed001_college_ind           ;
			Integer iv_dg001_derog_count          ;
			Boolean email_src_im                  ;
			Integer iv_ds001_impulse_count        ;
			Integer iv_pv001_bst_avm_autoval      ;
			Integer iv_pl002_addrs_15yr           ;
			Integer iv_avg_num_sources_per_addr   ;
			Integer iv_gong_did_phone_ct          ;
			String iv_prof_license_flag           ;
			Integer iv_pb_total_orders            ;
			String iv_po001_inp_addr_naprop       ;
			Integer iv_inp_addr_assessed_total_val;
			Integer iv_addrs_10yr                 ;
			Integer iv_paw_active_phone_count     ;
			Integer iv_criminal_count             ;
			Integer cs_outstanding_liens_ct       ;
			Real r_phone_subscore0                ;
			Real r_phone_subscore1                ;
			Real r_phone_subscore2                ;
			Real r_phone_subscore3                ;
			Real r_phone_subscore4                ;
			Real r_phone_subscore5                ;
			Real r_phone_subscore6                ;
			Real r_phone_subscore7                ;
			Real r_phone_subscore8                ;
			Real r_phone_subscore9                ;
			Real r_phone_subscore10               ;
			Real r_phone_rawscore                 ;
			Real r_phone_lnoddsscore              ;
			Real r_phone_probscore                ;
			Real r_nophone_subscore0              ;
			Real r_nophone_subscore1              ;
			Real r_nophone_subscore2              ;
			Real r_nophone_subscore3              ;
			Real r_nophone_subscore4              ;
			Real r_nophone_subscore5              ;
			Real r_nophone_subscore6              ;
			Real r_nophone_subscore7              ;
			Real r_nophone_subscore8              ;
			Real r_nophone_rawscore               ;
			Real r_nophone_lnoddsscore            ;
			Real r_nophone_probscore              ;
			Integer point                         ;
			Integer base                          ;
			Real odds                             ;
			Real _r_phone_transformed_score       ;
			Real r_phone_transformed_score        ;
			Real _r_nophone_transformed_score     ;
			Real r_nophone_transformed_score      ;
			Integer _rvc1405_3_0                  ;
			Boolean ver_src_ds                    ;
			Boolean ssn_deceased                  ;
			Integer rvc1405_3_0                   ;
			Boolean glrc9q                        ;
			String rc1                            ;
			String rc2                            ;
			String rc3                            ;
			String rc4                            ;
			String rc5                            ;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	in_hphnpop                       := le.adl_shell_flags.in_hphnpop;
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
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_count2                      := le.address_history_summary.addr_count2;
	addr_count_ge3                   := le.address_history_summary.addr_count3;
	addr_count_ge6                   := le.address_history_summary.addr_count6;
	addr_count_ge10                  := le.address_history_summary.addr_count10;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	inq_count12                      := le.acc_logs.inquiries.count12;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_total_number_derogs         := le.total_number_derogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

iv_mi001_adlperssn_count := map(
    not((Integer)ssnlength > 0)  => NULL,
    (Integer)adlperssn_count = 0 => 1,
                                    (Integer)adlperssn_count);

iv_in001_wealth_index := if(not(truedid), ' ', wealth_index);

evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or not(ams_college_tier = '') or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                         => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                      => '1',
                                                                                                                                                                   '0');

iv_dg001_derog_count := if(not(truedid), NULL, attr_total_number_derogs);

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                                    => NULL,
    impulse_count = 0 and (Integer)email_src_im > 0 => 1,
                                                       impulse_count);

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

iv_avg_num_sources_per_addr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             if (if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))) >= 0, truncate(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))), roundup(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))))));

iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

iv_prof_license_flag := if(not(truedid), ' ', (String)((Integer)prof_license_flag));

iv_pb_total_orders := map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                            (Integer)pb_total_orders);

iv_po001_inp_addr_naprop := if(not(add1_pop), ' ', (String)add1_naprop);

iv_inp_addr_assessed_total_val := if(not(add1_pop), NULL, add1_assessed_total_value);

iv_addrs_10yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_10yr);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

iv_criminal_count := if(not(truedid), NULL, criminal_count);

cs_outstanding_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) - if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

r_phone_subscore0 := map(
		iv_ed001_college_ind = ' '                                                 => -0.000000,
    NULL < (Integer)iv_ed001_college_ind AND (Integer)iv_ed001_college_ind < 1 => -0.279368,
    1 <= (Integer)iv_ed001_college_ind                                         => 0.530210,
                                                                                  -0.000000);

r_phone_subscore1 := map(
    NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 1 => 0.181305,
    1 <= iv_gong_did_phone_ct                                => -0.319230,
                                                                0.000000);

r_phone_subscore2 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.332443,
    2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 5   => 0.153946,
    5 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 8   => -0.152882,
    8 <= iv_pl002_addrs_15yr                               => -0.290158,
                                                              0.000000);

r_phone_subscore3 := map(
    NULL < iv_dg001_derog_count AND iv_dg001_derog_count < 2 => 0.083088,
    2 <= iv_dg001_derog_count AND iv_dg001_derog_count < 3   => -0.328636,
    3 <= iv_dg001_derog_count                                => -0.795934,
                                                                -0.000000);

r_phone_subscore4 := map(
		iv_in001_wealth_index = ' '                                                  => -0.000000,
    NULL < (Integer)iv_in001_wealth_index AND (Integer)iv_in001_wealth_index < 3 => -0.150795,
    3 <= (Integer)iv_in001_wealth_index AND (Integer)iv_in001_wealth_index < 4   => 0.195852,
    4 <= (Integer)iv_in001_wealth_index                                          => 0.371836,
                                                                                    -0.000000);

r_phone_subscore5 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.049364,
    1 <= iv_ds001_impulse_count                                  => -0.987728,
                                                                    0.000000);

r_phone_subscore6 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.168911,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => 0.018724,
    2 <= iv_pb_total_orders                              => 0.301090,
                                                            -0.000000);

r_phone_subscore7 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 7991    => -0.062112,
    7991 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 106065 => 0.094197,
    106065 <= iv_pv001_bst_avm_autoval                                     => 0.186962,
                                                                              0.000000);

r_phone_subscore8 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.077901,
    2 <= iv_mi001_adlperssn_count                                    => -0.115024,
                                                                        -0.000000);

r_phone_subscore9 := map(
		iv_prof_license_flag = ' '                                                 => -0.000000,
    NULL < (Integer)iv_prof_license_flag AND (Integer)iv_prof_license_flag < 1 => -0.019438,
    1 <= (Integer)iv_prof_license_flag                                         => 0.485319,
                                                                                  -0.000000);

r_phone_subscore10 := map(
    NULL < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 3 => -0.046736,
    3 <= iv_avg_num_sources_per_addr                                       => 0.137251,
                                                                              -0.000000);

r_phone_rawscore := r_phone_subscore0 +
    r_phone_subscore1 +
    r_phone_subscore2 +
    r_phone_subscore3 +
    r_phone_subscore4 +
    r_phone_subscore5 +
    r_phone_subscore6 +
    r_phone_subscore7 +
    r_phone_subscore8 +
    r_phone_subscore9 +
    r_phone_subscore10;

r_phone_lnoddsscore := r_phone_rawscore + -2.154481;

r_phone_probscore := exp(r_phone_lnoddsscore) / (1 + exp(r_phone_lnoddsscore));

r_nophone_subscore0 := map(
		iv_ed001_college_ind = ' '                                                 => -0.000000,
    NULL < (Integer)iv_ed001_college_ind AND (Integer)iv_ed001_college_ind < 1 => -0.208528,
    1 <= (Integer)iv_ed001_college_ind                                         => 0.831362,
                                                                                  -0.000000);

r_nophone_subscore1 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 60       => -0.128614,
    60 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 63750     => -0.464111,
    63750 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 102681 => 0.046951,
    102681 <= iv_inp_addr_assessed_total_val                                            => 0.524076,
                                                                                           0.000000);

r_nophone_subscore2 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.143231,
    1 <= iv_criminal_count                             => -0.753126,
                                                          0.000000);

r_nophone_subscore3 := map(
		iv_in001_wealth_index = ' '                                                  => -0.000000,
    NULL < (Integer)iv_in001_wealth_index AND (Integer)iv_in001_wealth_index < 2 => -0.249075,
    2 <= (Integer)iv_in001_wealth_index AND (Integer)iv_in001_wealth_index < 3   => 0.142697,
    3 <= (Integer)iv_in001_wealth_index AND (Integer)iv_in001_wealth_index < 5   => 0.166050,
    5 <= (Integer)iv_in001_wealth_index                                          => 0.986494,
                                                                                    -0.000000);

r_nophone_subscore4 := map(
    NULL < cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 1 => 0.080693,
    1 <= cs_outstanding_liens_ct                                   => -0.844493,
                                                                      -0.000000);

r_nophone_subscore5 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.218495,
    2 <= iv_mi001_adlperssn_count                                    => -0.288399,
                                                                        -0.000000);

r_nophone_subscore6 := map(
    NULL < iv_addrs_10yr AND iv_addrs_10yr < 3 => 0.112236,
    3 <= iv_addrs_10yr                         => -0.073467,
                                                  -0.000000);

r_nophone_subscore7 := map(
		iv_po001_inp_addr_naprop = ' '                                                     => -0.000000,
    NULL < (Integer)iv_po001_inp_addr_naprop AND (Integer)iv_po001_inp_addr_naprop < 2 => -0.039684,
    2 <= (Integer)iv_po001_inp_addr_naprop                                             => 0.113477,
                                                                                          -0.000000);

r_nophone_subscore8 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.013465,
    1 <= iv_paw_active_phone_count                                     => 0.245325,
                                                                          0.000000);

r_nophone_rawscore := r_nophone_subscore0 +
    r_nophone_subscore1 +
    r_nophone_subscore2 +
    r_nophone_subscore3 +
    r_nophone_subscore4 +
    r_nophone_subscore5 +
    r_nophone_subscore6 +
    r_nophone_subscore7 +
    r_nophone_subscore8;

r_nophone_lnoddsscore := r_nophone_rawscore + -3.071844;

r_nophone_probscore := exp(r_nophone_lnoddsscore) / (1 + exp(r_nophone_lnoddsscore));

point := 40;

base := 700;

odds := .10 / .90;

_r_phone_transformed_score := round(point * (r_phone_lnoddsscore - ln(odds)) / ln(2) + base);

r_phone_transformed_score := min(if(max(round(_r_phone_transformed_score), 501) = NULL, -NULL, max(round(_r_phone_transformed_score), 501)), 900);

_r_nophone_transformed_score := round(point * (r_nophone_lnoddsscore - ln(odds)) / ln(2) + base);

r_nophone_transformed_score := min(if(max(round(_r_nophone_transformed_score), 501) = NULL, -NULL, max(round(_r_nophone_transformed_score), 501)), 900);

_rvc1405_3_0 := if(in_hphnpop = 1, r_phone_transformed_score, r_nophone_transformed_score);

ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0;

ssn_deceased := (Integer)rc_decsflag = 1 or (Integer)ver_src_ds = 1;

rvc1405_3_0 := map(
    (Integer)ssn_deceased = 1     => 200,
    (Integer)iv_riskview_222s = 1 => 222,
                                     _rvc1405_3_0);

glrc9q := inq_count12 > 0;

glrc97_c40_b1 := criminal_count > 0;

glrc98_c40_b1 := liens_historical_unreleased_ct + liens_recent_unreleased_count > 0;

glrc9d_c40_b1 := iv_pl002_addrs_15yr >= 5;

glrc9e_c40_b1 := truedid and add1_pop;

glrc9h_c40_b1 := iv_ds001_impulse_count > 0;

glrc9i_c40_b1 := age < 30 and not(evidence_of_college);

glrc9w_c40_b1 := (Integer)bankrupt > 0;

glrc9y_c40_b1 := truedid and iv_pb_total_orders < 1;

glrcmi_c40_b1 := adlperssn_count > 1;

glrcpv_c40_b1 := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 150000;

glrcbl_c40_b1 := 0;

rcvalue9i_1_c40_b1 := 0.530210 - r_phone_subscore0;

rcvaluebl_1_c40_b1 := 0.181305 - r_phone_subscore1;

rcvaluebl_2_c40_b1 := 0.485319 - r_phone_subscore9;

rcvalue9d_1_c40_b1 := 0.332443 - r_phone_subscore2;

rcvaluepv_1_c40_b1 := 0.371836 - r_phone_subscore4;

rcvaluepv_2_c40_b1 := 0.186962 - r_phone_subscore7;

rcvalue9h_1_c40_b1 := 0.049364 - r_phone_subscore5;

rcvalue9y_1_c40_b1 := 0.301090 - r_phone_subscore6;

rcvaluemi_1_c40_b1 := 0.077901 - r_phone_subscore8;

rcvalue9e_1_c40_b1 := 0.137251 - r_phone_subscore10;

contributing_derogs_c40_b1 := criminal_count +
    filing_count +
    liens_historical_unreleased_ct +
    liens_recent_unreleased_count;

rcvalue97_1_c40_b1 := criminal_count / contributing_derogs_c40_b1 * (0.083088 - r_phone_subscore3);

rcvalue98_1_c40_b1 := (liens_historical_unreleased_ct + liens_recent_unreleased_count) / contributing_derogs_c40_b1 * (0.083088 - r_phone_subscore3);

rcvalue9w_1_c40_b1 := filing_count / contributing_derogs_c40_b1 * (0.083088 - r_phone_subscore3);

glrc97_c40_b2 := criminal_count > 0;

glrc98_c40_b2 := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) > 0;

glrc9a_c40_b2 := property_owned_total = 0;

glrc9d_c40_b2 := iv_addrs_10yr >= 3;

glrc9i_c40_b2 := age < 30 and not(evidence_of_college);

glrcmi_c40_b2 := adlperssn_count > 1;

glrcpv_c40_b2 := truedid and addrpop and 0 < add1_assessed_total_value AND add1_assessed_total_value < 150000 and add1_avm_automated_valuation < 150000;

glrcbl_c40_b2 := 0;

rcvalue9i_1_c40_b2 := 0.831362 - r_nophone_subscore0;

rcvaluepv_1_c40_b2 := 0.524076 - r_nophone_subscore1;

rcvaluepv_2_c40_b2 := 0.986494 - r_nophone_subscore3;

rcvalue97_1_c40_b2 := 0.143231 - r_nophone_subscore2;

rcvalue98_1_c40_b2 := 0.080693 - r_nophone_subscore4;

rcvaluemi_1_c40_b2 := 0.218495 - r_nophone_subscore5;

rcvalue9d_1_c40_b2 := 0.112236 - r_nophone_subscore6;

rcvalue9a_1_c40_b2 := 0.113477 - r_nophone_subscore7;

rcvaluebl_1_c40_b2 := 0.245325 - r_nophone_subscore8;

rcvalue9i := if(in_hphnpop = 1, (integer)glrc9i_c40_b1 * if(max(rcvalue9i_1_c40_b1) = NULL, NULL, sum(if(rcvalue9i_1_c40_b1 = NULL, 0, rcvalue9i_1_c40_b1))), (integer)glrc9i_c40_b2 * if(max(rcvalue9i_1_c40_b2) = NULL, NULL, sum(if(rcvalue9i_1_c40_b2 = NULL, 0, rcvalue9i_1_c40_b2))));

rcvaluemi := if(in_hphnpop = 1, (integer)glrcmi_c40_b1 * if(max(rcvaluemi_1_c40_b1) = NULL, NULL, sum(if(rcvaluemi_1_c40_b1 = NULL, 0, rcvaluemi_1_c40_b1))), (integer)glrcmi_c40_b2 * if(max(rcvaluemi_1_c40_b2) = NULL, NULL, sum(if(rcvaluemi_1_c40_b2 = NULL, 0, rcvaluemi_1_c40_b2))));

rcvalue9d := if(in_hphnpop = 1, (integer)glrc9d_c40_b1 * if(max(rcvalue9d_1_c40_b1) = NULL, NULL, sum(if(rcvalue9d_1_c40_b1 = NULL, 0, rcvalue9d_1_c40_b1))), (integer)glrc9d_c40_b2 * if(max(rcvalue9d_1_c40_b2) = NULL, NULL, sum(if(rcvalue9d_1_c40_b2 = NULL, 0, rcvalue9d_1_c40_b2))));

rcvalue98 := if(in_hphnpop = 1, (integer)glrc98_c40_b1 * if(max(rcvalue98_1_c40_b1) = NULL, NULL, sum(if(rcvalue98_1_c40_b1 = NULL, 0, rcvalue98_1_c40_b1))), (integer)glrc98_c40_b2 * if(max(rcvalue98_1_c40_b2) = NULL, NULL, sum(if(rcvalue98_1_c40_b2 = NULL, 0, rcvalue98_1_c40_b2))));

rcvaluepv := if(in_hphnpop = 1, (integer)glrcpv_c40_b1 * if(max(rcvaluepv_1_c40_b1, rcvaluepv_2_c40_b1) = NULL, NULL, sum(if(rcvaluepv_1_c40_b1 = NULL, 0, rcvaluepv_1_c40_b1), if(rcvaluepv_2_c40_b1 = NULL, 0, rcvaluepv_2_c40_b1))), (integer)glrcpv_c40_b2 * if(max(rcvaluepv_1_c40_b2, rcvaluepv_2_c40_b2) = NULL, NULL, sum(if(rcvaluepv_1_c40_b2 = NULL, 0, rcvaluepv_1_c40_b2), if(rcvaluepv_2_c40_b2 = NULL, 0, rcvaluepv_2_c40_b2))));

rcvalue97 := if(in_hphnpop = 1, (integer)glrc97_c40_b1 * if(max(rcvalue97_1_c40_b1) = NULL, NULL, sum(if(rcvalue97_1_c40_b1 = NULL, 0, rcvalue97_1_c40_b1))), (integer)glrc97_c40_b2 * if(max(rcvalue97_1_c40_b2) = NULL, NULL, sum(if(rcvalue97_1_c40_b2 = NULL, 0, rcvalue97_1_c40_b2))));

rcvalue9w := if(in_hphnpop = 1, (integer)glrc9w_c40_b1 * if(max(rcvalue9w_1_c40_b1) = NULL, NULL, sum(if(rcvalue9w_1_c40_b1 = NULL, 0, rcvalue9w_1_c40_b1))), NULL);

rcvalue9y := if(in_hphnpop = 1, (integer)glrc9y_c40_b1 * if(max(rcvalue9y_1_c40_b1) = NULL, NULL, sum(if(rcvalue9y_1_c40_b1 = NULL, 0, rcvalue9y_1_c40_b1))), NULL);

rcvalue9h := if(in_hphnpop = 1, (integer)glrc9h_c40_b1 * if(max(rcvalue9h_1_c40_b1) = NULL, NULL, sum(if(rcvalue9h_1_c40_b1 = NULL, 0, rcvalue9h_1_c40_b1))), NULL);

rcvalue9e := if(in_hphnpop = 1, (integer)glrc9e_c40_b1 * if(max(rcvalue9e_1_c40_b1) = NULL, NULL, sum(if(rcvalue9e_1_c40_b1 = NULL, 0, rcvalue9e_1_c40_b1))), NULL);

rcvalue9a := if(in_hphnpop = 1, NULL, (integer)glrc9a_c40_b2 * if(max(rcvalue9a_1_c40_b2) = NULL, NULL, sum(if(rcvalue9a_1_c40_b2 = NULL, 0, rcvalue9a_1_c40_b2))));

rcvaluebl := if(in_hphnpop = 1, glrcbl_c40_b1 * if(max(rcvaluebl_1_c40_b1, rcvaluebl_2_c40_b1) = NULL, NULL, sum(if(rcvaluebl_1_c40_b1 = NULL, 0, rcvaluebl_1_c40_b1), if(rcvaluebl_2_c40_b1 = NULL, 0, rcvaluebl_2_c40_b1))), glrcbl_c40_b2 * if(max(rcvaluebl_1_c40_b2) = NULL, NULL, sum(if(rcvaluebl_1_c40_b2 = NULL, 0, rcvaluebl_1_c40_b2))));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
    {'9I', RCValue9I},
    {'BL', RCValueBL},
    {'9D', RCValue9D},
    {'PV', RCValuePV},
    {'9H', RCValue9H},
    {'9Y', RCValue9Y},
    {'MI', RCValueMI},
    {'9E', RCValue9E},
    {'97', RCValue97},
    {'98', RCValue98},
    {'9W', RCValue9W},
    {'9A', RCValue9A}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := if(rcs_top4[1].rc = '' and rvc1405_3_0 != 900, ROW({'36', NULL}, ds_layout), rcs_top4[1]);
rcs_9p2 := rcs_top4[2];
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
rcs_9p5 := IF(GLRC9Q AND NOT EXISTS(rcs_top4 (rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
									inq_count12 > 0,
										DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.
	
rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;

rcs_override := MAP( rvc1405_3_0 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvc1405_3_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     rvc1405_3_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
                     NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
                     rcs_9p);
										 
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables

	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
		self.iv_in001_wealth_index            := iv_in001_wealth_index;
		self.evidence_of_college              := evidence_of_college;
		self.iv_ed001_college_ind             := iv_ed001_college_ind;
		self.iv_dg001_derog_count             := iv_dg001_derog_count;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
		self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
		self.iv_avg_num_sources_per_addr      := iv_avg_num_sources_per_addr;
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
		self.iv_prof_license_flag             := iv_prof_license_flag;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;
		self.iv_inp_addr_assessed_total_val   := iv_inp_addr_assessed_total_val;
		self.iv_addrs_10yr                    := iv_addrs_10yr;
		self.iv_paw_active_phone_count        := iv_paw_active_phone_count;
		self.iv_criminal_count                := iv_criminal_count;
		self.cs_outstanding_liens_ct          := cs_outstanding_liens_ct;
		self.r_phone_subscore0                := r_phone_subscore0;
		self.r_phone_subscore1                := r_phone_subscore1;
		self.r_phone_subscore2                := r_phone_subscore2;
		self.r_phone_subscore3                := r_phone_subscore3;
		self.r_phone_subscore4                := r_phone_subscore4;
		self.r_phone_subscore5                := r_phone_subscore5;
		self.r_phone_subscore6                := r_phone_subscore6;
		self.r_phone_subscore7                := r_phone_subscore7;
		self.r_phone_subscore8                := r_phone_subscore8;
		self.r_phone_subscore9                := r_phone_subscore9;
		self.r_phone_subscore10               := r_phone_subscore10;
		self.r_phone_rawscore                 := r_phone_rawscore;
		self.r_phone_lnoddsscore              := r_phone_lnoddsscore;
		self.r_phone_probscore                := r_phone_probscore;
		self.r_nophone_subscore0              := r_nophone_subscore0;
		self.r_nophone_subscore1              := r_nophone_subscore1;
		self.r_nophone_subscore2              := r_nophone_subscore2;
		self.r_nophone_subscore3              := r_nophone_subscore3;
		self.r_nophone_subscore4              := r_nophone_subscore4;
		self.r_nophone_subscore5              := r_nophone_subscore5;
		self.r_nophone_subscore6              := r_nophone_subscore6;
		self.r_nophone_subscore7              := r_nophone_subscore7;
		self.r_nophone_subscore8              := r_nophone_subscore8;
		self.r_nophone_rawscore               := r_nophone_rawscore;
		self.r_nophone_lnoddsscore            := r_nophone_lnoddsscore;
		self.r_nophone_probscore              := r_nophone_probscore;
		self.point                            := point;
		self.base                             := base;
		self.odds                             := odds;
		self._r_phone_transformed_score       := _r_phone_transformed_score;
		self.r_phone_transformed_score        := r_phone_transformed_score;
		self._r_nophone_transformed_score     := _r_nophone_transformed_score;
		self.r_nophone_transformed_score      := r_nophone_transformed_score;
		self._rvc1405_3_0                     := _rvc1405_3_0;
		self.ver_src_ds                       := ver_src_ds;
		self.ssn_deceased                     := ssn_deceased;
		self.rvc1405_3_0                      := rvc1405_3_0;
		self.glrc9q                           := glrc9q;
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
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1405_3_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;
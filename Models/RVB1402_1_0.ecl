IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVB1402_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
				

			/* Model Intermediate Variables */
			
REAL   		sysdate                          ;
REAL   		_in_dob                          ;
REAL   		yr_in_dob                        ;
REAL   		yr_in_dob_int                    ;
REAL   		age_estimate                     ;
REAL   		iv_ag001_age                     ;
STRING   	iv_inp_own_prop_x_addr_naprop    ;
STRING	  mortgage_type                    ;
BOOLEAN   mortgage_present                 ;
STRING    iv_inp_addr_mortgage_type        ;
BOOLEAN   iv_add_apt                       ;
REAL   		iv_adls_per_sfd_addr             ;
STRING   	iv_ams_college_code              ;
STRING   	iv_prof_license_flag             ;
REAL   		iv_attr_addrs_recency            ;
STRING   	iv_pb_total_orders               ;
REAL   iv_pv001_inp_avm_autoval         ;
REAL   iv_iq001_inq_count12             ;
REAL   iv_inp_addr_source_count         ;
REAL   iv_addr_non_phn_src_ct           ;
REAL   iv_email_domain_free_count       ;
REAL   iv_filing_count                  ;
REAL   iv_unreleased_liens_ct           ;
REAL   iv_pl002_addrs_15yr              ;
REAL   iv_in001_estimated_income        ;
REAL   iv_paw_active_phone_count        ;
REAL   is_subscore0                     ;
REAL   is_subscore1                     ;
REAL   is_subscore2                     ;
REAL   is_subscore3                     ;
REAL   is_subscore4                     ;
REAL   is_subscore5                     ;
REAL   is_subscore6                     ;
REAL   is_subscore7                     ;
REAL   is_subscore8                     ;
REAL   is_subscore9                     ;
REAL   is_subscore10                    ;
REAL   is_subscore11                    ;
REAL   is_rawscore                      ;
REAL   is_lnoddsscore                   ;
REAL   is_probscore                     ;
REAL   il_subscore0                     ;
REAL   il_subscore1                     ;
REAL   il_subscore2                     ;
REAL   il_subscore3                     ;
REAL   il_subscore4                     ;
REAL   il_subscore5                     ;
REAL   il_subscore6                     ;
REAL   il_subscore7                     ;
REAL   il_subscore8                     ;
REAL   il_subscore9                     ;
REAL   il_subscore10                    ;
REAL   il_subscore11                    ;
REAL   il_subscore12                    ;
REAL   il_subscore13                    ;
REAL   il_rawscore                      ;
REAL   il_lnoddsscore                   ;
REAL   il_probscore                     ;
REAL   bureau_adl_eq_fseen_pos          ;
STRING   bureau_adl_fseen_eq              ;
REAL   _bureau_adl_fseen_eq             ;
INTEGER   mos_bureau_adl_fs                ;
STRING   ln_segment                       ;
REAL   lnoddsscore                      ;
REAL   base                             ;
REAL   odds                             ;
REAL   point                            ;
BOOLEAN   ssn_deceased                     ;
BOOLEAN   iv_riskview_222s                 ;
REAL   rvb1402_1                      ;
BOOLEAN  short                            ;
BOOLEAN   long                             ;
BOOLEAN   glrc98                           ;
BOOLEAN   srcprop                          ;
BOOLEAN  glrc9a                           ;
BOOLEAN   glrc9b                           ;
BOOLEAN   glrc9d                           ;
BOOLEAN   glrc9e                           ;
BOOLEAN   glrc9f                           ;
BOOLEAN   glrc9h                           ;
BOOLEAN   glrc9i                           ;
REAL   _header_first_seen               ;
REAL   mos_header_fseen                 ;
BOOLEAN   glrc9j                           ;
BOOLEAN   glrc9k                           ;
BOOLEAN   glrc9q                           ;
BOOLEAN   glrc9s                           ;
BOOLEAN   glrc9w                           ;
// BOOLEAN   glrc9y                           ;
BOOLEAN   glrcpv                           ;
REAL   glrcbl                           ;
REAL   rcvalue98_1                      ;
REAL   rcvalue98_2                      ;
REAL   rcvalue98                        ;
REAL   rcvalue9a_1                      ;
REAL   rcvalue9a_2                      ;
REAL   rcvalue9a                        ;
REAL   rcvalue9b_1                      ;
REAL   rcvalue9b_2                      ;
REAL   rcvalue9b                        ;
REAL   rcvalue9d_1                      ;
REAL   rcvalue9d_2                      ;
REAL   rcvalue9d                        ;
REAL   rcvalue9e_1                      ;
REAL   rcvalue9e_2                      ;
REAL   rcvalue9e                        ;
REAL   rcvalue9f_1                      ;
REAL   rcvalue9f                        ;
REAL   rcvalue9h_1                      ;
REAL   rcvalue9h_2                      ;
REAL   rcvalue9h                        ;
REAL   rcvalue9i_1                      ;
REAL   rcvalue9i                        ;
REAL   rcvalue9j_1                      ;
REAL   rcvalue9j_2                      ;
REAL   rcvalue9j                        ;
REAL   rcvalue9k_1                      ;
REAL   rcvalue9k_2                      ;
REAL   rcvalue9k                        ;
REAL   rcvalue9q_1                      ;
REAL   rcvalue9q_2                      ;
REAL   rcvalue9q                        ;
REAL   rcvalue9s_1                      ;
REAL   rcvalue9s                        ;
REAL   rcvalue9w_1                      ;
REAL   rcvalue9w_2                      ;
REAL   rcvalue9w                        ;
// REAL   rcvalue9y_1                      ;
// REAL   rcvalue9y                        ;
REAL   rcvaluepv_1                      ;
REAL   rcvaluepv_2                      ;
REAL   rcvaluepv_3                      ;
REAL   rcvaluepv                        ;
REAL   rcvaluebl_1                      ;
REAL   rcvaluebl_2                      ;
REAL   rcvaluebl                        ;
STRING         rc1                              ;
STRING         rc4                              ;
STRING         rc2                              ;
STRING         rc3                              ;
STRING         rc5                              ;
                   

			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
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
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	inq_count12                      := le.acc_logs.inquiries.count12;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	impulse_count                    := le.impulse.count;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	ams_college_code                 := le.student.college_code;
	prof_license_flag                := le.professional_license.professional_license_flag;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

_in_dob := common.sas_date((string)(in_dob));

// yr_in_dob := if(in_dob = '', -1, (sysdate - _in_dob) / 365.25);

yr_in_dob := map( in_dob[1..2]='18' =>NULL,
									in_dob = '0' => NULL, 
                  in_dob = ' ' => -1,
																	(sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
                                '0' + (string)add1_naprop);

mortgage_type := add1_mortgage_type;

mortgage_present := not(((string)add1_mortgage_date in ['0', ' ']));

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
    not(mortgage_type = ' ' )                             => 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage');

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_adls_per_sfd_addr := map(
    not(add1_pop)  => NULL,
    (integer)iv_add_apt = 1 => -1,
                      adls_per_addr);

iv_ams_college_code := map(
    not(truedid)            => '  ',
    ams_college_code = ' '  => '-1',
                               trim(ams_college_code, LEFT));

iv_prof_license_flag := if(not(truedid), ' ', (string)((integer)prof_license_flag));

iv_attr_addrs_recency := map(
    not(truedid)      => NULL,
    (boolean)attr_addrs_last30 => 1,
    (boolean)attr_addrs_last90 => 3,
    (boolean)attr_addrs_last12 => 12,
    (boolean)attr_addrs_last24 => 24,
    (boolean)attr_addrs_last36 => 36,
    (boolean)addrs_5yr         => 60,
    (boolean)addrs_10yr        => 120,
    (boolean)addrs_15yr        => 180,
    addrs_per_adl > 0 => 999,
                         0);

iv_pb_total_orders := map(
    not(truedid)           => (STRING)NULL,
    pb_total_orders = ' ' => '-1',
                              (string)((integer)pb_total_orders));

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

iv_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);

iv_filing_count := if(not(truedid), NULL, filing_count);

iv_unreleased_liens_ct := if(not(truedid), NULL, liens_recent_unreleased_count + liens_historical_unreleased_ct);

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

is_subscore0 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 18 => -0.000000,
    18 <= iv_ag001_age AND iv_ag001_age < 23  => -0.600848,
    23 <= iv_ag001_age AND iv_ag001_age < 39  => 0.017710,
    39 <= iv_ag001_age AND iv_ag001_age < 49  => 0.357294,
    49 <= iv_ag001_age AND iv_ag001_age < 56  => 0.638011,
    56 <= iv_ag001_age                        => 0.881963,
                                                 -0.000000);

is_subscore1 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.161089,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.600070,
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.633495,
    3 <= iv_unreleased_liens_ct                                  => -0.916744,
                                                                    0.000000);

is_subscore2 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.115529,
    1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => -0.806942,
    2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 3   => -1.032572,
    3 <= iv_iq001_inq_count12                                => -1.084250,
                                                                0.000000);

is_subscore3 := map(
    (iv_inp_own_prop_x_addr_naprop in [' '])        => 0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['01'])       => -0.188641,
    (iv_inp_own_prop_x_addr_naprop in ['00', '11']) => -0.036000,
    (iv_inp_own_prop_x_addr_naprop in ['02', '03']) => 0.076274,
    (iv_inp_own_prop_x_addr_naprop in ['10'])       => 0.100056,
    (iv_inp_own_prop_x_addr_naprop in ['12', '13']) => 0.183208,
    (iv_inp_own_prop_x_addr_naprop in ['04'])       => 0.287296,
    (iv_inp_own_prop_x_addr_naprop in ['14'])       => 0.342278,
                                                       0.000000);

is_subscore4 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => 0.003650,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 31782       => -0.460486,
    31782 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 81700   => -0.159552,
    81700 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 118546  => -0.101441,
    118546 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 174729 => -0.034943,
    174729 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 205000 => 0.145905,
    205000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 253532 => 0.174955,
    253532 <= iv_pv001_inp_avm_autoval                                       => 0.278162,
                                                                                0.000000);

is_subscore5 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.295815,
    1 <= iv_inp_addr_source_count                                    => 0.083552,
                                                                        0.000000);

is_subscore6 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => -0.004438,
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 1   => 0.000000,
    1 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 2   => 0.061157,
    2 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 4   => 0.454367,
    4 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 6   => 0.282333,
    6 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 9   => 0.111491,
    9 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 16  => -0.005681,
    16 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 20 => -0.082255,
    20 <= iv_adls_per_sfd_addr                               => -0.143209,
                                                                0.000000);

is_subscore7 := map(
    NULL < iv_filing_count AND iv_filing_count < 1 => 0.028235,
    1 <= iv_filing_count                           => -0.546108,
                                                      0.000000);

is_subscore8 := map(
    (iv_ams_college_code in [' '])           => -0.000000,
    (iv_ams_college_code in ['-1'])          => -0.034417,
    (iv_ams_college_code in ['1', '2', '4']) => 0.338515,
                                                -0.000000);

is_subscore9 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.053124,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => -0.043388,
    3 <= iv_email_domain_free_count                                      => -0.223757,
                                                                            -0.000000);

is_subscore10 := map(
    (iv_inp_addr_mortgage_type in [' '])                                                                                                        => -0.000000,
    (iv_inp_addr_mortgage_type in ['Conventional'])                                                                                             => 0.431997,
    (iv_inp_addr_mortgage_type in ['Equity Loan'])                                                                                              => 0.083914,
    (iv_inp_addr_mortgage_type in ['Commercial', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.015881,
                                                                                                                                                   -0.000000);

is_subscore11 := map(
    (iv_prof_license_flag in [' ']) => 0.000000,
    (iv_prof_license_flag in ['0']) => -0.003783,
    (iv_prof_license_flag in ['1']) => 0.077803,
                                       0.000000);

is_rawscore := is_subscore0 +
    is_subscore1 +
    is_subscore2 +
    is_subscore3 +
    is_subscore4 +
    is_subscore5 +
    is_subscore6 +
    is_subscore7 +
    is_subscore8 +
    is_subscore9 +
    is_subscore10 +
    is_subscore11;

is_lnoddsscore := is_rawscore+ 2.481385;

is_probscore := exp(is_lnoddsscore) / (1 + exp(is_lnoddsscore));

il_subscore0 := map(
    NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => 0.226598,
    1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => -0.497801,
    2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => -0.623779,
    3 <= iv_unreleased_liens_ct                                  => -0.842512,
                                                                    0.000000);

il_subscore1 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => -0.000000,
    19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 23000 => -0.733119,
    23000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 26000 => -0.271599,
    26000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 30000 => -0.086369,
    30000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 34000 => -0.051828,
    34000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 44000 => 0.170466,
    44000 <= iv_in001_estimated_income                                       => 0.433046,
                                                                                -0.000000);

il_subscore2 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 18 => 0.000000,
    18 <= iv_ag001_age AND iv_ag001_age < 36  => -0.718523,
    36 <= iv_ag001_age AND iv_ag001_age < 40  => -0.509641,
    40 <= iv_ag001_age AND iv_ag001_age < 45  => -0.443054,
    45 <= iv_ag001_age AND iv_ag001_age < 48  => -0.215235,
    48 <= iv_ag001_age AND iv_ag001_age < 53  => -0.079904,
    53 <= iv_ag001_age AND iv_ag001_age < 57  => 0.159777,
    57 <= iv_ag001_age AND iv_ag001_age < 62  => 0.180565,
    62 <= iv_ag001_age                        => 0.410810,
                                                 0.000000);

il_subscore3 := map(
    NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.115643,
    1 <= iv_iq001_inq_count12                                => -0.977306,
                                                                -0.000000);

il_subscore4 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.386139,
    2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3   => 0.206985,
    3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 4   => 0.087894,
    4 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 5   => -0.035528,
    5 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => -0.113498,
    6 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 7   => -0.145666,
    7 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 8   => -0.206102,
    8 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 9   => -0.254457,
    9 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 10  => -0.302817,
    10 <= iv_pl002_addrs_15yr                              => -0.394390,
                                                              -0.000000);

il_subscore5 := map(
    NULL < iv_filing_count AND iv_filing_count < 1 => 0.084090,
    1 <= iv_filing_count                           => -0.572857,
                                                      0.000000);

il_subscore6 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => -0.145664,
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 1   => 0.000000,
    1 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 2   => 0.333980,
    2 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 5   => 0.378899,
    5 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 7   => 0.189266,
    7 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 9   => 0.162966,
    9 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 11  => 0.010104,
    11 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 14 => -0.112577,
    14 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 22 => -0.136358,
    22 <= iv_adls_per_sfd_addr                               => -0.168634,
                                                                0.000000);

il_subscore7 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.299430,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => -0.129699,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.052771,
    3 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 4   => 0.209933,
    4 <= iv_addr_non_phn_src_ct                                  => 0.240384,
                                                                    -0.000000);

il_subscore8 := map(
    (iv_inp_own_prop_x_addr_naprop in [' '])        => -0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['01'])       => -0.238443,
    (iv_inp_own_prop_x_addr_naprop in ['00', '11']) => -0.114900,
    (iv_inp_own_prop_x_addr_naprop in ['02', '03']) => 0.037579,
    (iv_inp_own_prop_x_addr_naprop in ['10'])       => 0.067311,
    (iv_inp_own_prop_x_addr_naprop in ['12', '13']) => 0.090620,
    (iv_inp_own_prop_x_addr_naprop in ['04', '14']) => 0.140945,
                                                       -0.000000);

il_subscore9 := map(
    NULL < iv_email_domain_free_count AND iv_email_domain_free_count < 1 => 0.064920,
    1 <= iv_email_domain_free_count AND iv_email_domain_free_count < 2   => -0.007544,
    2 <= iv_email_domain_free_count AND iv_email_domain_free_count < 3   => -0.116197,
    3 <= iv_email_domain_free_count                                      => -0.440084,
                                                                            0.000000);

il_subscore10 := map(
    NULL < (real)iv_pb_total_orders AND (real)iv_pb_total_orders < 1 => -0.107040,
    1 <= (real)iv_pb_total_orders AND (real)iv_pb_total_orders < 2   => -0.043003,
    2 <= (real)iv_pb_total_orders AND (real)iv_pb_total_orders < 4   => 0.036334,
    4 <= (real)iv_pb_total_orders AND (real)iv_pb_total_orders < 7   => 0.109022,
    7 <= (real)iv_pb_total_orders                              => 0.170754,
                                                            0.000000);

il_subscore11 := map(
    (iv_attr_addrs_recency in [1, 3, 12, 24, 36, 60]) => -0.040612,
    (iv_attr_addrs_recency in [120, 180, 999])        => 0.240269,
                                                         0.000000);

il_subscore12 := map(
    NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 1         => -0.014051,
    1 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 33767       => -0.184313,
    33767 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 72581   => -0.132902,
    72581 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 92367   => -0.087213,
    92367 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 115119  => -0.019027,
    115119 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 155183 => 0.007713,
    155183 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 191690 => 0.042312,
    191690 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 252194 => 0.079382,
    252194 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 324520 => 0.111002,
    324520 <= iv_pv001_inp_avm_autoval                                       => 0.134480,
                                                                                0.000000);

il_subscore13 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.009557,
    1 <= iv_paw_active_phone_count                                     => 0.226528,
                                                                          0.000000);

il_rawscore := il_subscore0 +
    il_subscore1 +
    il_subscore2 +
    il_subscore3 +
    il_subscore4 +
    il_subscore5 +
    il_subscore6 +
    il_subscore7 +
    il_subscore8 +
    il_subscore9 +
    il_subscore10 +
    il_subscore11 +
    il_subscore12 +
    il_subscore13;

il_lnoddsscore := il_rawscore + 2.929265;

il_probscore := exp(il_lnoddsscore) / (1 + exp(il_lnoddsscore));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

// mos_bureau_adl_fs := if(bureau_adl_eq_fseen_pos = 0, -1, if ((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12) >= 0, truncate((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12)), roundup((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12))));
	mos_bureau_adl_fs := if(bureau_adl_eq_fseen_pos = 0, -1, if(_bureau_adl_fseen_eq = NULL, 0, 
			if ((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12) >= 0, truncate((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12)), roundup((sysdate - _bureau_adl_fseen_eq) / (365.25 / 12)))));

ln_segment := if(mos_bureau_adl_fs <= 216, '0 Short TOF', '1 Long TOF');

lnoddsscore := map(
    trim((string)ln_segment, LEFT, RIGHT) = '0 Short TOF' => is_lnoddsscore,
    trim((string)ln_segment, LEFT, RIGHT) = '1 Long TOF'  => il_lnoddsscore,
                                                             NULL);

base := 700;

odds := (1 - 0.06) / 0.06;

point := 40;

ssn_deceased := (integer)rc_decsflag = 1 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

//*************************************************************************************//
	//                     RiskView Version 5 - RVB1402_1_0 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Lex ID Only On Input = 222 (FLAGSHIP MODELS ONLY)
	// SSNPrior OR Corrections = 680
	// Score Range: 501 - 900
	//*************************************************************************************//
rvb1402_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

// rc1_3 := '';

// rc2_4 := '';

// rc3_2 := '';

// rc4_2 := '';

short := trim((string)ln_segment, LEFT, RIGHT) = '0 Short TOF';

long := trim((string)ln_segment, LEFT, RIGHT) = '1 Long TOF';

glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

srcprop := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',') > 0;

glrc9a := property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and (integer)srcprop = 0;

glrc9b := property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and (integer)srcprop = 1;

glrc9d := attr_addrs_last36 > 0 or addrs_5yr > 1 or addrs_15yr > 3;

glrc9e := (integer)addrpop = 1 and (add1_source_count <= 2 or rc_addrcount <= 2);

glrc9f := (integer)truedid = 1 and (integer)short = 1;

glrc9h := email_domain_free_count > 0 and impulse_count > 0;

glrc9i := not((ams_college_code in ['1', '2', '4'])) and 18 <= iv_ag001_age AND iv_ag001_age < 40;

_header_first_seen := common.sas_date((string)(header_first_seen));

mos_header_fseen := if(((String)header_first_seen in ['', '0']), -1, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))));

glrc9j := (integer)truedid = 1 and 18 <= iv_ag001_age AND iv_ag001_age < 40 and 0 <= mos_header_fseen AND mos_header_fseen <= 240;

glrc9k := (integer)addrpop = 1 and rc_dwelltype != '';

glrc9q := inq_count12 > 0;

glrc9s := (integer)addrpop = 1 and (integer)mortgage_present = 1 and not((mortgage_type in ['CNV', 'N']));

glrc9w := filing_count > 0;

// glrc9y := pb_total_orders = '';

glrcpv := (integer)addrpop = 1 and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 200000;

glrcbl := 0;

rcvalue98_1 := (integer)short * (integer)glrc98 * (0.161089 - is_subscore1);

rcvalue98_2 := (integer)long * (integer)glrc98 * (0.226598 - il_subscore0);

rcvalue98 := if(max(rcvalue98_1, rcvalue98_2) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2)));

rcvalue9a_1 := (integer)short * (integer)glrc9a * (0.342278 - is_subscore3);

rcvalue9a_2 := (integer)long * (integer)glrc9a * (0.140945 - il_subscore8);

rcvalue9a := if(max(rcvalue9a_1, rcvalue9a_2) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2)));

rcvalue9b_1 := (integer)short * (integer)glrc9b * (0.342278 - is_subscore3);

rcvalue9b_2 := (integer)long * (integer)glrc9b * (0.140945 - il_subscore8);

rcvalue9b := if(max(rcvalue9b_1, rcvalue9b_2) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1), if(rcvalue9b_2 = NULL, 0, rcvalue9b_2)));

rcvalue9d_1 := (integer)long * (integer)glrc9d * (0.386139 - il_subscore4);

rcvalue9d_2 := (integer)long * (integer)glrc9d * (0.240269 - il_subscore11);

rcvalue9d := if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

rcvalue9e_1 := (integer)short * (integer)glrc9e * (0.083552 - is_subscore5);

rcvalue9e_2 := (integer)long * (integer)glrc9e * (0.240384 - il_subscore7);

rcvalue9e := if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));

rcvalue9f_1 := (integer)short * (integer)glrc9f * (3.01 - 2.49);

rcvalue9f := if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));

rcvalue9h_1 := (integer)short * (integer)glrc9h * (0.053124 - is_subscore9);

rcvalue9h_2 := (integer)long * (integer)glrc9h * (0.06492 - il_subscore9);

rcvalue9h := if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));

rcvalue9i_1 := (integer)short * (integer)glrc9i * (0.338515 - is_subscore8);

rcvalue9i := if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

rcvalue9j_1 := (integer)short * (integer)glrc9j * (0.881963 - is_subscore0);

rcvalue9j_2 := (integer)long * (integer)glrc9j * (0.41081 - il_subscore2);

rcvalue9j := if(max(rcvalue9j_1, rcvalue9j_2) = NULL, NULL, sum(if(rcvalue9j_1 = NULL, 0, rcvalue9j_1), if(rcvalue9j_2 = NULL, 0, rcvalue9j_2)));

rcvalue9k_1 := (integer)short * (integer)glrc9k * (0.454367 - is_subscore6);

rcvalue9k_2 := (integer)long * (integer)glrc9k * (0.378899 - il_subscore6);

rcvalue9k := if(max(rcvalue9k_1, rcvalue9k_2) = NULL, NULL, sum(if(rcvalue9k_1 = NULL, 0, rcvalue9k_1), if(rcvalue9k_2 = NULL, 0, rcvalue9k_2)));

rcvalue9q_1 := (integer)short * (integer)glrc9q * (0.115529 - is_subscore2);

rcvalue9q_2 := (integer)long * (integer)glrc9q * (0.115643 - il_subscore3);

rcvalue9q := if(max(rcvalue9q_1, rcvalue9q_2) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2)));

rcvalue9s_1 := (integer)short * (integer)glrc9s * (0.431997 - is_subscore10);

rcvalue9s := if(max(rcvalue9s_1) = NULL, NULL, sum(if(rcvalue9s_1 = NULL, 0, rcvalue9s_1)));

rcvalue9w_1 := (integer)short * (integer)glrc9w * (0.028235 - is_subscore7);

rcvalue9w_2 := (integer)long * (integer)glrc9w * (0.08409 - il_subscore5);

rcvalue9w := if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

// rcvalue9y_1 := (integer)long * (integer)glrc9y * (0.170754 - il_subscore10);

// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

rcvaluepv_1 := (integer)short * (integer)glrcpv * (0.278162 - is_subscore4);

rcvaluepv_2 := (integer)long * (integer)glrcpv * (0.433046 - il_subscore1);

rcvaluepv_3 := (integer)long * (integer)glrcpv * (0.13448 - il_subscore12);

rcvaluepv := if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3)));

rcvaluebl_1 := (integer)short * glrcbl * (0.077803 - is_subscore11);

rcvaluebl_2 := (integer)long * glrcbl * (0.226528 - il_subscore13);

rcvaluebl := if(max(rcvaluebl_1, rcvaluebl_2) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'98', RCValue98},
    {'9A', RCValue9A},
    {'9B', RCValue9B},
    {'9D', RCValue9D},
    {'9E', RCValue9E},
    {'9F', RCValue9F},
    {'9H', RCValue9H},
    {'9I', RCValue9I},
    {'9J', RCValue9J},
    {'9K', RCValue9K},
    {'9Q', RCValue9Q},
    {'9S', RCValue9S},
    {'9W', RCValue9W},
    // {'9Y', RCValue9Y},
    {'PV', RCValuePV},
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
// I'll leave the implementation details to the Engineers.
//*************************************************************************************//



		rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
		rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
		

			rcs_9q := rcs_top & if(glrc9q and (count(rcs_top4(rc='9Q')) =0) AND inq_count12 > 0, ROW({'9Q', NULL}, ds_layout));

		 
		rcs_override := MAP(
												rvb1402_1 = 200 => DATASET([{'02', NULL}], ds_layout),
												rvb1402_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
												rvb1402_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
												
												(500 < RVB1402_1) and (RVB1402_1 <= 800) 
												and 
													(rcs_9q[1].rc!='36') and (rcs_9q[2].rc='') => DATASET([{rcs_9q[1].rc, NULL}, {'36', NULL}], ds_layout),
										
												(500 < RVB1402_1) and (RVB1402_1 <= 800) 
												and 
													(rcs_9q[1].rc ='36') and (rcs_9q[2].rc='') => DATASET([{rcs_9q[1].rc, NULL}, {'9R', NULL}], ds_layout),
												
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
							inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
							rcs_final
							);
						
		zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
		
		reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes
	

#if(MODEL_DEBUG)
	
	
		
		

		/* Model Intermediate Variables */
		                    self.sysdate                          := sysdate;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.age_estimate                     := age_estimate;
                    self.iv_ag001_age                     := iv_ag001_age;
                    self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
                    self.mortgage_type                    := mortgage_type;
                    self.mortgage_present                 := mortgage_present;
                    self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
                    self.iv_add_apt                       := iv_add_apt;
                    self.iv_adls_per_sfd_addr             := iv_adls_per_sfd_addr;
                    self.iv_ams_college_code              := iv_ams_college_code;
                    self.iv_prof_license_flag             := iv_prof_license_flag;
                    self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
                    self.iv_pb_total_orders               := iv_pb_total_orders;
                    self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
                    self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
                    self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.iv_email_domain_free_count       := iv_email_domain_free_count;
                    self.iv_filing_count                  := iv_filing_count;
                    self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
                    self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
                    self.iv_in001_estimated_income        := iv_in001_estimated_income;
                    self.iv_paw_active_phone_count        := iv_paw_active_phone_count;
                    self.is_subscore0                     := is_subscore0;
                    self.is_subscore1                     := is_subscore1;
                    self.is_subscore2                     := is_subscore2;
                    self.is_subscore3                     := is_subscore3;
                    self.is_subscore4                     := is_subscore4;
                    self.is_subscore5                     := is_subscore5;
                    self.is_subscore6                     := is_subscore6;
                    self.is_subscore7                     := is_subscore7;
                    self.is_subscore8                     := is_subscore8;
                    self.is_subscore9                     := is_subscore9;
                    self.is_subscore10                    := is_subscore10;
                    self.is_subscore11                    := is_subscore11;
                    self.is_rawscore                      := is_rawscore;
                    self.is_lnoddsscore                   := is_lnoddsscore;
                    self.is_probscore                     := is_probscore;
                    self.il_subscore0                     := il_subscore0;
                    self.il_subscore1                     := il_subscore1;
                    self.il_subscore2                     := il_subscore2;
                    self.il_subscore3                     := il_subscore3;
                    self.il_subscore4                     := il_subscore4;
                    self.il_subscore5                     := il_subscore5;
                    self.il_subscore6                     := il_subscore6;
                    self.il_subscore7                     := il_subscore7;
                    self.il_subscore8                     := il_subscore8;
                    self.il_subscore9                     := il_subscore9;
                    self.il_subscore10                    := il_subscore10;
                    self.il_subscore11                    := il_subscore11;
                    self.il_subscore12                    := il_subscore12;
                    self.il_subscore13                    := il_subscore13;
                    self.il_rawscore                      := il_rawscore;
                    self.il_lnoddsscore                   := il_lnoddsscore;
                    self.il_probscore                     := il_probscore;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self.mos_bureau_adl_fs                := mos_bureau_adl_fs;
                    self.ln_segment                       := ln_segment;
                    self.lnoddsscore                      := lnoddsscore;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.ssn_deceased                     := ssn_deceased;
                    self.iv_riskview_222s                 := iv_riskview_222s;
                    self.rvb1402_1                      := rvb1402_1;
                    self.short                            := short;
                    self.long                             := long;
                    self.glrc98                           := glrc98;
                    self.srcprop                          := srcprop;
                    self.glrc9a                           := glrc9a;
                    self.glrc9b                           := glrc9b;
                    self.glrc9d                           := glrc9d;
                    self.glrc9e                           := glrc9e;
                    self.glrc9f                           := glrc9f;
                    self.glrc9h                           := glrc9h;
                    self.glrc9i                           := glrc9i;
                    self._header_first_seen               := _header_first_seen;
                    self.mos_header_fseen                 := mos_header_fseen;
                    self.glrc9j                           := glrc9j;
                    self.glrc9k                           := glrc9k;
                    self.glrc9q                           := glrc9q;
                    self.glrc9s                           := glrc9s;
                    self.glrc9w                           := glrc9w;
                    // self.glrc9y                           := glrc9y;
                    self.glrcpv                           := glrcpv;
                    self.glrcbl                           := glrcbl;
                    self.rcvalue98_1                      := rcvalue98_1;
                    self.rcvalue98_2                      := rcvalue98_2;
                    self.rcvalue98                        := rcvalue98;
                    self.rcvalue9a_1                      := rcvalue9a_1;
                    self.rcvalue9a_2                      := rcvalue9a_2;
                    self.rcvalue9a                        := rcvalue9a;
                    self.rcvalue9b_1                      := rcvalue9b_1;
                    self.rcvalue9b_2                      := rcvalue9b_2;
                    self.rcvalue9b                        := rcvalue9b;
                    self.rcvalue9d_1                      := rcvalue9d_1;
                    self.rcvalue9d_2                      := rcvalue9d_2;
                    self.rcvalue9d                        := rcvalue9d;
                    self.rcvalue9e_1                      := rcvalue9e_1;
                    self.rcvalue9e_2                      := rcvalue9e_2;
                    self.rcvalue9e                        := rcvalue9e;
                    self.rcvalue9f_1                      := rcvalue9f_1;
                    self.rcvalue9f                        := rcvalue9f;
                    self.rcvalue9h_1                      := rcvalue9h_1;
                    self.rcvalue9h_2                      := rcvalue9h_2;
                    self.rcvalue9h                        := rcvalue9h;
                    self.rcvalue9i_1                      := rcvalue9i_1;
                    self.rcvalue9i                        := rcvalue9i;
                    self.rcvalue9j_1                      := rcvalue9j_1;
                    self.rcvalue9j_2                      := rcvalue9j_2;
                    self.rcvalue9j                        := rcvalue9j;
                    self.rcvalue9k_1                      := rcvalue9k_1;
                    self.rcvalue9k_2                      := rcvalue9k_2;
                    self.rcvalue9k                        := rcvalue9k;
                    self.rcvalue9q_1                      := rcvalue9q_1;
                    self.rcvalue9q_2                      := rcvalue9q_2;
                    self.rcvalue9q                        := rcvalue9q;
                    self.rcvalue9s_1                      := rcvalue9s_1;
                    self.rcvalue9s                        := rcvalue9s;
                    self.rcvalue9w_1                      := rcvalue9w_1;
                    self.rcvalue9w_2                      := rcvalue9w_2;
                    self.rcvalue9w                        := rcvalue9w;
                    // self.rcvalue9y_1                      := rcvalue9y_1;
                    // self.rcvalue9y                        := rcvalue9y;
                    self.rcvaluepv_1                      := rcvaluepv_1;
                    self.rcvaluepv_2                      := rcvaluepv_2;
                    self.rcvaluepv_3                      := rcvaluepv_3;
                    self.rcvaluepv                        := rcvaluepv;
                    self.rcvaluebl_1                      := rcvaluebl_1;
                    self.rcvaluebl_2                      := rcvaluebl_2;
                    self.rcvaluebl                        := rcvaluebl;
                    self.rc1                              := rcs_override[1].rc;
										self.rc2                              := rcs_override[2].rc;
										self.rc3                              := rcs_override[3].rc;
										self.rc4                              := rcs_override[4].rc;
										self.rc5                              := rcs_override[5].rc;    
                     SELF.clam                            := le;

		
		#end
	SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rvb1402_1
										);

	END;

	model := project( clam, doModel(left) );

	return model;
END;


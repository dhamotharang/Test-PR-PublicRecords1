import risk_indicators, riskwise, ut, easi;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1406_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION

FP_DEBUG := False;
	
	#if(FP_DEBUG)
	Layout_Debug := RECORD
		/* Model Input Variables */
	INTEGER sysdate                      ;
	STRING iv_add_apt                    ;
	INTEGER iv_ssns_per_sfd_addr         ;
	INTEGER nf_fp_srchaddrsrchcount      ;
	INTEGER iv_email_count               ;
	STRING iv_cvi                        ;
	INTEGER iv_inq_banking_recency       ;
	STRING iv_input_dob_match_level      ;
	INTEGER inp_addr_nhood_properties_sum;
	INTEGER inp_addr_nhood_sfd_props     ;
	INTEGER nf_inp_addr_nhood_pct_sfd    ;
	INTEGER iv_pl001_bst_addr_lres       ;
	INTEGER iv_unique_addr_count         ;
	STRING iv_bst_addr_ownership_lvl     ;
	INTEGER iv_felony_count              ;
	INTEGER iv_pl002_addrs_per_ssn_c6    ;
	INTEGER iv_pb_total_orders           ;
	STRING iv_va011_add_business         ;
	Integer iv_released_liens_ct         ;
	INTEGER iv_phones_per_addr           ;
	REAL custom3_subscore0    ;
	REAL custom3_subscore1    ;
	REAL custom3_subscore2    ;
	REAL custom3_subscore3    ;
	REAL custom3_subscore4    ;
	REAL custom3_subscore5    ;
	REAL custom3_subscore6    ;
	REAL custom3_subscore7    ;
	REAL custom3_subscore8    ;
	REAL custom3_subscore9    ;
	REAL custom3_subscore10   ;
	REAL custom3_subscore11   ;
	REAL custom3_subscore12   ;
	REAL custom3_subscore13   ;
	REAL custom3_subscore14   ;
	REAL custom3_subscore15   ;
	REAL custom3_subscore16   ;
	REAL custom3_subscore17   ;
	REAL custom3_subscore18   ;
	REAL custom3_rawscore     ;
	REAL custom3_lnoddsscore  ;
	INTEGER point             ;
	INTEGER base              ;
	REAL odds                 ;
	INTEGER _fp1406_1_0       ;
	INTEGER fp1406_1_0        ;                             
		
	models.layout_modelout;
	risk_indicators.Layout_Boca_Shell clam;
	END;
		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	cvi                              := le.iid.cvi;
	rc_dwelltype                     := le.iid.dwelltype;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_nhood_business_count        := le.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.addr_risk_summary.n_mfd_count;
	add1_pop                         := le.addrpop;
	add2_lres                        := le.lres2;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	email_count                      := le.email_summary.email_ct;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	felony_count                     := le.bjl.felony_count;
	input_dob_match_level            := le.dobmatchlevel;
	c_domin_prof                     := ri.domin_prof;
	c_many_cars                      := if(ri.many_cars = '', -999999999, (Integer)ri.many_cars);
	c_white_col                      := if(ri.white_col = '', -999999999, (Real)ri.white_col);


NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_ssns_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        ssns_per_addr);

nf_fp_srchaddrsrchcount := if(not(truedid), NULL, (Integer)fp_srchaddrsrchcount);

iv_email_count := if(not(truedid), NULL, email_count);

iv_cvi := if(not(truedid or (Integer)ssnlength > 0) and not(hphnpop or addrpop), '  ', trim(if(cvi = 0, '00', (string)cvi), LEFT));

iv_inq_banking_recency := map(
    not(truedid)        => NULL,
    (Boolean)inq_banking_count01 => 1,
    (Boolean)inq_banking_count03 => 3,
    (Boolean)inq_banking_count06 => 6,
    (Boolean)inq_banking_count12 => 12,
    (Boolean)inq_banking_count24 => 24,
    (Boolean)inq_banking_count   => 99,
                                    0);

iv_input_dob_match_level := if(not(truedid and dobpop), ' ', input_dob_match_level);

inp_addr_nhood_properties_sum := if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count)));

inp_addr_nhood_sfd_props := add1_nhood_sfd_count;

nf_inp_addr_nhood_pct_sfd := map(
    not(add1_pop)                     => NULL,
    inp_addr_nhood_properties_sum > 0 => if (inp_addr_nhood_sfd_props / inp_addr_nhood_properties_sum * 10 >= 0, roundup(inp_addr_nhood_sfd_props / inp_addr_nhood_properties_sum * 10), truncate(inp_addr_nhood_sfd_props / inp_addr_nhood_properties_sum * 10)) * 10,
                                         -1);

iv_pl001_bst_addr_lres := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_lres,
                        add2_lres);

iv_unique_addr_count := if(not(truedid), NULL, unique_addr_count);

iv_bst_addr_ownership_lvl_c12 := map(
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl_c13 := map(
    add2_applicant_owned => 'Applicant   ',
    add2_family_owned    => 'Family      ',
    add2_occupant_owned  => 'Occupant    ',
                            'No Ownership');

iv_bst_addr_ownership_lvl := map(
    not(truedid)     => '            ',
    add1_isbestmatch => iv_bst_addr_ownership_lvl_c12,
                        iv_bst_addr_ownership_lvl_c13);

iv_felony_count := if(not(truedid), NULL, felony_count);

iv_pl002_addrs_per_ssn_c6 := if(not((Integer)ssnlength > 0), NULL, addrs_per_ssn_c6);

iv_pb_total_orders := map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                            (Integer)pb_total_orders);

iv_va011_add_business := map(
    not(add1_pop)                                                            => ' ',
    (trim(trim(add1_advo_res_or_business, LEFT), LEFT, RIGHT) in ['B', 'D']) => '1',
                                                                                '0');

iv_released_liens_ct := if(not(truedid), NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

iv_phones_per_addr := if(not(add1_pop), NULL, phones_per_addr);

custom3_subscore0 := map(
    NULL < c_many_cars AND c_many_cars < 11 => -0.297213,
    11 <= c_many_cars AND c_many_cars < 21  => -0.079124,
    21 <= c_many_cars AND c_many_cars < 61  => 0.007616,
    61 <= c_many_cars                       => 0.162897,
                                               -0.000000);

custom3_subscore1 := map(
    (c_domin_prof in [' ', 'AB_AV_EDU', 'EXP_HOMES', 'LAR_FAM', 'MANY_CARS', 'MED_INC',
		                  'NO_LABFOR', 'RETIRED', 'RICH_OLD', 'RICH_YOUNG', 'UNATTACH']) => -0.062761,
    (c_domin_prof in ['APT20'])                                                      => 0.255268,
    (c_domin_prof in ['ARMFORCE'])                                                   => 0.170924,
    (c_domin_prof in ['ASIAN_LANG'])                                                 => -0.442114,
    (c_domin_prof in ['BEL_EDU'])                                                    => 0.092772,
    (c_domin_prof in ['BLUE_EMPL'])                                                  => -0.081665,
    (c_domin_prof in ['BORN_USA'])                                                   => -0.076246,
    (c_domin_prof in ['FOR_SALE'])                                                   => 0.069534,
    (c_domin_prof in ['MED_AGE'])                                                    => -0.024586,
    (c_domin_prof in ['NEW_HOMES'])                                                  => 0.114554,
    (c_domin_prof in ['NO_CAR'])                                                     => -0.066228,
    (c_domin_prof in ['NO_MOVE'])                                                    => -0.159279,
    (c_domin_prof in ['NO_TEENS'])                                                   => -0.107134,
    (c_domin_prof in ['OLD_HOMES'])                                                  => -0.039382,
    (c_domin_prof in ['PRESCHL'])                                                    => -0.068557,
    (c_domin_prof in ['RENTAL'])                                                     => 0.148840,
    (c_domin_prof in ['SERV_EMPL'])                                                  => -0.192385,
    (c_domin_prof in ['SPAN_LANG'])                                                  => -0.056439,
    (c_domin_prof in ['SUB_BUS'])                                                    => 0.010222,
    (c_domin_prof in ['TRAILER'])                                                    => 0.393644,
    (c_domin_prof in ['UNEMPL'])                                                     => 0.122405,
    (c_domin_prof in ['VERY_RICH'])                                                  => 0.117930,
    (c_domin_prof in ['WORK_HOME'])                                                  => 0.433826,
                                                                                        -0.000000);

custom3_subscore2 := map(
    NULL < iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 0 => 0.047581,
    0 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 1   => -0.601270,
    1 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 6   => 0.109922,
    6 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 14  => 0.067190,
    14 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 40 => 0.035569,
    40 <= iv_ssns_per_sfd_addr                               => -0.118000,
                                                                0.000000);

custom3_subscore3 := map(
    NULL < nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 1 => -0.097359,
    1 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 5   => 0.119105,
    5 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 13  => -0.023963,
    13 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 20 => -0.062745,
    20 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 25 => -0.227190,
    25 <= nf_fp_srchaddrsrchcount                                  => -0.368655,
                                                                      0.000000);

custom3_subscore4 := map(
    NULL < iv_email_count AND iv_email_count < 2 => -0.088256,
    2 <= iv_email_count                          => 0.174566,
                                                    -0.000000);

custom3_subscore5 := map(
		iv_cvi = ' '                                    => 0.000000, 
    NULL < (Integer)iv_cvi AND (Integer)iv_cvi < 10 => -0.724574,
    10 <= (Integer)iv_cvi AND (Integer)iv_cvi < 20  => -0.246973,
    20 <= (Integer)iv_cvi AND (Integer)iv_cvi < 50  => -0.000587,
    50 <= (Integer)iv_cvi                           => 0.057301,
                                                       0.000000);

custom3_subscore6 := map(
    NULL < iv_inq_banking_recency AND iv_inq_banking_recency < 1 => -0.023354,
    1 <= iv_inq_banking_recency AND iv_inq_banking_recency < 24  => 0.414703,
    24 <= iv_inq_banking_recency AND iv_inq_banking_recency < 99 => 0.041506,
    99 <= iv_inq_banking_recency                                 => -0.042753,
                                                                    0.000000);

custom3_subscore7 := map(
    NULL < (Real)c_white_col AND (Real)c_white_col < 30.7 => -0.066724,
    30.7 <= (Real)c_white_col                             => 0.129348,
                                                             0.000000);

custom3_subscore8 := map(
		iv_input_dob_match_level = ' '                                                     => 0.000000,
    NULL < (Integer)iv_input_dob_match_level AND (Integer)iv_input_dob_match_level < 6 => -0.361701,
    6 <= (Integer)iv_input_dob_match_level AND (Integer)iv_input_dob_match_level < 7   => -0.317782,
    7 <= (Integer)iv_input_dob_match_level AND (Integer)iv_input_dob_match_level < 8   => -0.036149,
    8 <= (Integer)iv_input_dob_match_level                                             => 0.027526,
                                                                                          0.000000);

custom3_subscore9 := map(
    NULL < nf_inp_addr_nhood_pct_sfd AND nf_inp_addr_nhood_pct_sfd < 20 => -0.130323,
    20 <= nf_inp_addr_nhood_pct_sfd AND nf_inp_addr_nhood_pct_sfd < 30  => -0.018132,
    30 <= nf_inp_addr_nhood_pct_sfd AND nf_inp_addr_nhood_pct_sfd < 40  => 0.009785,
    40 <= nf_inp_addr_nhood_pct_sfd AND nf_inp_addr_nhood_pct_sfd < 100 => 0.029931,
    100 <= nf_inp_addr_nhood_pct_sfd                                    => 0.068533,
                                                                           0.000000);

custom3_subscore10 := map(
    NULL < iv_pl001_bst_addr_lres AND iv_pl001_bst_addr_lres < 5 => 0.260445,
    5 <= iv_pl001_bst_addr_lres                                  => -0.015487,
                                                                    0.000000);

custom3_subscore11 := map(
    NULL < iv_unique_addr_count AND iv_unique_addr_count < 1 => -0.000000,
    1 <= iv_unique_addr_count AND iv_unique_addr_count < 2   => -0.054205,
    2 <= iv_unique_addr_count AND iv_unique_addr_count < 12  => -0.029728,
    12 <= iv_unique_addr_count AND iv_unique_addr_count < 15 => 0.021461,
    15 <= iv_unique_addr_count                               => 0.130986,
                                                                -0.000000);

custom3_subscore12 := map(
    (iv_bst_addr_ownership_lvl in [' '])            => -0.000000,
    (iv_bst_addr_ownership_lvl in ['Applicant'])    => 0.062267,
    (iv_bst_addr_ownership_lvl in ['Family'])       => -0.092092,
    (iv_bst_addr_ownership_lvl in ['No Ownership']) => -0.032677,
    (iv_bst_addr_ownership_lvl in ['Occupant'])     => 0.076880,
                                                       -0.000000);

custom3_subscore13 := map(
    NULL < iv_felony_count AND iv_felony_count < 1 => 0.020315,
    1 <= iv_felony_count                           => -0.132125,
                                                      -0.000000);

custom3_subscore14 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 < 1 => -0.016998,
    1 <= iv_pl002_addrs_per_ssn_c6                                     => 0.154264,
                                                                          0.000000);

custom3_subscore15 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.040409,
    1 <= iv_pb_total_orders                              => 0.049127,
                                                            0.000000);

custom3_subscore16 := map(
		iv_va011_add_business = ''                                                   => -0.000000,
    NULL < (Integer)iv_va011_add_business AND (Integer)iv_va011_add_business < 1 => 0.011227,
    1 <= (Integer)iv_va011_add_business                                          => -0.132657,
                                                                                    -0.000000);

custom3_subscore17 := map(
    NULL < iv_released_liens_ct AND iv_released_liens_ct < 1 => -0.013877,
    1 <= iv_released_liens_ct                                => 0.077313,
                                                                -0.000000);

custom3_subscore18 := map(
    NULL < iv_phones_per_addr AND iv_phones_per_addr < 1 => 0.025828,
    1 <= iv_phones_per_addr                              => -0.010180,
                                                            -0.000000);

custom3_rawscore := custom3_subscore0 +
    custom3_subscore1 +
    custom3_subscore2 +
    custom3_subscore3 +
    custom3_subscore4 +
    custom3_subscore5 +
    custom3_subscore6 +
    custom3_subscore7 +
    custom3_subscore8 +
    custom3_subscore9 +
    custom3_subscore10 +
    custom3_subscore11 +
    custom3_subscore12 +
    custom3_subscore13 +
    custom3_subscore14 +
    custom3_subscore15 +
    custom3_subscore16 +
    custom3_subscore17 +
    custom3_subscore18;

custom3_lnoddsscore := custom3_rawscore + 0.570670;

point := 100;

base := 600;

odds := .638 / .362;

_fp1406_1_0 := round(point * (custom3_lnoddsscore - ln(odds)) / ln(2) + base);

fp1406_1_0 := min(if(max(round(_fp1406_1_0), 300) = NULL, -NULL, max(round(_fp1406_1_0), 300)), 999);

#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam															:= le;
	self.sysdate                          := sysdate;
	self.iv_add_apt                       := iv_add_apt;
	self.iv_ssns_per_sfd_addr             := iv_ssns_per_sfd_addr;
	self.nf_fp_srchaddrsrchcount          := nf_fp_srchaddrsrchcount;
	self.iv_email_count                   := iv_email_count;
	self.iv_cvi                           := iv_cvi;
	self.iv_inq_banking_recency           := iv_inq_banking_recency;
	self.iv_input_dob_match_level         := iv_input_dob_match_level;
	self.inp_addr_nhood_properties_sum    := inp_addr_nhood_properties_sum;
	self.inp_addr_nhood_sfd_props         := inp_addr_nhood_sfd_props;
	self.nf_inp_addr_nhood_pct_sfd        := nf_inp_addr_nhood_pct_sfd;
	self.iv_pl001_bst_addr_lres           := iv_pl001_bst_addr_lres;
	self.iv_unique_addr_count             := iv_unique_addr_count;
	self.iv_bst_addr_ownership_lvl        := iv_bst_addr_ownership_lvl;
	self.iv_felony_count                  := iv_felony_count;
	self.iv_pl002_addrs_per_ssn_c6        := iv_pl002_addrs_per_ssn_c6;
	self.iv_pb_total_orders               := iv_pb_total_orders;
	self.iv_va011_add_business            := iv_va011_add_business;
	self.iv_released_liens_ct             := iv_released_liens_ct;
	self.iv_phones_per_addr               := iv_phones_per_addr;
	self.custom3_subscore0                := custom3_subscore0;
	self.custom3_subscore1                := custom3_subscore1;
	self.custom3_subscore2                := custom3_subscore2;
	self.custom3_subscore3                := custom3_subscore3;
	self.custom3_subscore4                := custom3_subscore4;
	self.custom3_subscore5                := custom3_subscore5;
	self.custom3_subscore6                := custom3_subscore6;
	self.custom3_subscore7                := custom3_subscore7;
	self.custom3_subscore8                := custom3_subscore8;
	self.custom3_subscore9                := custom3_subscore9;
	self.custom3_subscore10               := custom3_subscore10;
	self.custom3_subscore11               := custom3_subscore11;
	self.custom3_subscore12               := custom3_subscore12;
	self.custom3_subscore13               := custom3_subscore13;
	self.custom3_subscore14               := custom3_subscore14;
	self.custom3_subscore15               := custom3_subscore15;
	self.custom3_subscore16               := custom3_subscore16;
	self.custom3_subscore17               := custom3_subscore17;
	self.custom3_subscore18               := custom3_subscore18;
	self.custom3_rawscore                 := custom3_rawscore;
	self.custom3_lnoddsscore              := custom3_lnoddsscore;
	self.point                            := point;
	self.base                             := base;
	self.odds                             := odds;
	self._fp1406_1_0                      := _fp1406_1_0;
	self.fp1406_1_0                       := fp1406_1_0;
#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1406_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1406_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;

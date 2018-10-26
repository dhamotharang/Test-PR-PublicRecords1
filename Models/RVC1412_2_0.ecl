IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT;

EXPORT RVC1412_2_0 (grouped dataset(risk_indicators.Layout_Bocashell_with_Custom) clam,
								BOOLEAN isCalifornia = FALSE) := FUNCTION
 
	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
  Layout_Debug := RECORD
			/* Model Input Variables */
			STRING agency;
			STRING acct_balance;
			BOOLEAN truedid;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING rc_decsflag;
			STRING rc_bansflag;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_addr_sources;
			STRING ver_addr_sources_count;
			BOOLEAN addrpop;
			INTEGER age;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_source_count;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_occupant_owned;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			BOOLEAN add1_pop;
			INTEGER property_owned_total;
			INTEGER property_sold_total;
			INTEGER add2_source_count;
			BOOLEAN add2_applicant_owned;
			BOOLEAN add2_occupant_owned;
			BOOLEAN add2_family_owned;
			INTEGER add2_naprop;
			BOOLEAN add2_pop;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			INTEGER unique_addr_count;
			INTEGER addrs_per_adl;
			STRING4 pb_total_orders;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_eviction_count;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER bk_disposed_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER criminal_count;
			STRING ams_class;
			STRING ams_college_code;
			STRING ams_college_type;
			STRING ams_income_level_code;
			STRING ams_file_type;
			STRING ams_college_tier;
			STRING ams_college_major;
			INTEGER sysdate;
			BOOLEAN ssn_deceased;
			BOOLEAN iv_riskview_222s;
			INTEGER client_agency;
		  REAL   client2_placed_balance;
			INTEGER bureau_addr_tn_count_pos;
			INTEGER bureau_addr_count_tn;
			INTEGER bureau_addr_ts_count_pos;
			INTEGER bureau_addr_count_ts;
			INTEGER bureau_addr_tu_count_pos;
			INTEGER bureau_addr_count_tu;
			INTEGER bureau_addr_en_count_pos;
			INTEGER bureau_addr_count_en;
			INTEGER bureau_addr_eq_count_pos;
			INTEGER bureau_addr_count_eq;
			REAL _src_bureau_addr_count;
			REAL iv_src_bureau_addr_count;
			INTEGER iv_bst_addr_source_count;
			STRING iv_bst_addr_ownership_lvl_c9;
			STRING iv_bst_addr_ownership_lvl_c10;
			STRING iv_bst_addr_ownership_lvl;
			INTEGER iv_addrs_per_adl;
			INTEGER iv_attr_addrs_recency;
			INTEGER iv_eviction_count;
			INTEGER iv_bk_disposed_recent_count;
			INTEGER iv_criminal_count;
			STRING iv_ams_college_tier;
			INTEGER iv_pb_total_orders;
			STRING iv_ed001_college_ind;
			REAL payerp_subscore0;
			REAL payerp_subscore1;
			REAL payerp_subscore2;
			REAL payerp_subscore3;
			REAL payerp_subscore4;
			REAL payerp_subscore5;
			REAL payerp_subscore6;
			REAL payerp_subscore7;
			REAL payerp_subscore8;
			REAL payerp_subscore9;
			REAL payerp_subscore10;
			REAL payerp_subscore11;
			REAL payerp_rawscore;
			REAL payerp_lnoddsscore;
			REAL payerp_probscore;
			INTEGER base;
			INTEGER point;
			REAL odds;
			INTEGER rvc1412_2_0;
			INTEGER rc1v;
			STRING rc2_2;
			INTEGER rc2v;
			STRING rc3_2;
			INTEGER rc3v;
			STRING rc4_2;
			INTEGER rc4v;
			STRING rc5_2;
			BOOLEAN glrc97;
			BOOLEAN glrc9a;
			BOOLEAN glrc9d;
			BOOLEAN glrc9e_1;
			BOOLEAN glrc9e_2;
			BOOLEAN glrc9e_3;
			BOOLEAN glrc9f;
			BOOLEAN glrc9y;
			BOOLEAN glrcev;
			INTEGER glrcbl;
			REAL rcvalue97_1;
			REAL rcvalue97;
			REAL rcvalue9a_1;
			REAL rcvalue9a;
			REAL rcvalue9d_1;
			REAL rcvalue9d;
			REAL rcvalue9e_1;
			REAL rcvalue9e_2;
			REAL rcvalue9e_3;
			REAL rcvalue9e;
			REAL rcvalue9f_1;
			REAL rcvalue9f;
			REAL rcvalue9y_1;
			REAL rcvalue9y;
			REAL rcvalueev_1;
			REAL rcvalueev;
			REAL rcvaluebl_1;
			REAL rcvaluebl_2;
			REAL rcvaluebl_3;
			REAL rcvaluebl;
			STRING rc1_2;		
			STRING rc4_1;
			STRING rc3_1;
			STRING rc5_1;
			STRING rc2_1;
			STRING rc1_1;
			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;
			models.layout_modelout;
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		
		
//=====================================
//== Define the doModel TRANSFORM
//== use either the debug layout 
//== or the ModelOut layout depending
//== on the debug flag set above  
//=====================================			
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	acct_balance                     := trim(le.custom_input1);
	agency                           := trim(le.custom_input2);
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	addrpop                          := le.input_validation.address;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_source_count                := le.address_verification.address_history_1.source_count;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_pop                         := le.addrpop2;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	
	
// ************************************************************************************
// * Fields from Client                                                               *
// ************************************************************************************

    // Field Name                                      Description
// -------------------------------------------------------------------------------------
//    AGENCY                                          Number of agencies that have had the account
//    ACCT_BALANCE                                    Balance at time of placement


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
		
	sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
	
	ssn_deceased := rc_decsflag = '1' or (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;
	
	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
	
	client_agency := (INTEGER)AGENCY;
	
	client2_placed_balance := (REAL)ACCT_BALANCE;
	
	bureau_addr_tn_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');
	
	bureau_addr_count_tn := if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ','));
	
	bureau_addr_ts_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');
	
	bureau_addr_count_ts := if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ','));
	
	bureau_addr_tu_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');
	
	bureau_addr_count_tu := if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ','));
	
	bureau_addr_en_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');
	
	bureau_addr_count_en := if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ','));
	
	bureau_addr_eq_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');
	
	bureau_addr_count_eq := if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ','));
	
	_src_bureau_addr_count := max(if(
		max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL,
		NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), 
		if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), 
		if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), 
		if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), 
		if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0);
	
	iv_src_bureau_addr_count := map(
	    not(truedid)                  => NULL,
	    _src_bureau_addr_count = NULL => -1,
	                                     _src_bureau_addr_count);
	
	iv_bst_addr_source_count := map(
	    not(truedid)     => NULL,
	    add1_isbestmatch => add1_source_count,
	                        add2_source_count);
	
	iv_bst_addr_ownership_lvl_c9 := map(
	    add1_applicant_owned => 'Applicant   ',
	    add1_family_owned    => 'Family      ',
	    add1_occupant_owned  => 'Occupant    ',
	                            'No Ownership');
	
	iv_bst_addr_ownership_lvl_c10 := map(
	    add2_applicant_owned => 'Applicant   ',
	    add2_family_owned    => 'Family      ',
	    add2_occupant_owned  => 'Occupant    ',
	                            'No Ownership');
	
	iv_bst_addr_ownership_lvl := map(
	    not(truedid)     => '',
	    add1_isbestmatch => iv_bst_addr_ownership_lvl_c9,
	                        iv_bst_addr_ownership_lvl_c10);
	iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);	
	
	iv_attr_addrs_recency := map(
	    not(truedid)               => 0, 
	    (BOOLEAN)attr_addrs_last30 => 1,
	    (BOOLEAN)attr_addrs_last90 => 3,
	    (BOOLEAN)attr_addrs_last12 => 12,
	    (BOOLEAN)attr_addrs_last24 => 24,
	    (BOOLEAN)attr_addrs_last36 => 36,
	    (BOOLEAN)addrs_5yr         => 60,
	    (BOOLEAN)addrs_10yr        => 120,
	    (BOOLEAN)addrs_15yr        => 180,
	    addrs_per_adl > 0          => 999,
	                                  0);
	
	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);
	iv_bk_disposed_recent_count := if(not(truedid), NULL, bk_disposed_recent_count);	
	iv_criminal_count := if(not(truedid), NULL, criminal_count);
	
	iv_ams_college_tier := map(
	    not(truedid)                     => '  ',
	    (INTEGER)ams_college_tier = NULL => '-1',
			ams_college_tier = '' 					 => '-1',
	                                     ams_college_tier);
	
	iv_pb_total_orders := map(
	    not(truedid)                    => NULL,
			pb_total_orders = ''   => -1,
	        (INTEGER)pb_total_orders);
	
	iv_ed001_college_ind := map(
	    not(truedid)                                                         => ' ',
	    not(ams_college_code = '') 
			or not(ams_college_type = '') 
			or (not ams_college_tier= '' and (integer)ams_college_tier >= 0) 
			  or not(ams_college_major = '') 
			  or (ams_file_type in ['H', 'C', 'A'])                              => '1',
	    ams_file_type = 'M'                                                  => '0',
	    not(ams_class = '') or not(ams_income_level_code = '')               => '1',
	                                                                            '0');
	
	payerp_subscore0 := map(
	    (client_agency > 0 AND client_agency < 3) => 0.384635,
	    3 <= client_agency AND client_agency < 5   => -0.049758,
	    5 <= client_agency AND client_agency < 8   => -0.351820,
	    8 <= client_agency AND client_agency < 9   => -0.711772,
	    9 <= client_agency AND client_agency < 17  => -1.031135,
	    17 <= client_agency AND client_agency < 21 => -1.396058,
	    21 <= client_agency                        => -1.900750,
	                                                  0.000000);
	
	payerp_subscore1 := map(
	    (client2_placed_balance >= NULL AND client2_placed_balance < 5149.55)     => -0.378987,
	    5149.55 <= client2_placed_balance AND client2_placed_balance < 10523.64  => -0.214496,
	    10523.64 <= client2_placed_balance AND client2_placed_balance < 16297.16 => -0.000208,
	    16297.16 <= client2_placed_balance AND client2_placed_balance < 26806.86 => 0.163806,
	    26806.86 <= client2_placed_balance AND client2_placed_balance < 38238.95 => 0.433953,
	    38238.95 <= client2_placed_balance                                       => 0.620919,
	                                                                                0.000000);
	
	payerp_subscore2 := map(
			iv_criminal_count = NULL													 => 0.000000,
	    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.051733,
	    1 <= iv_criminal_count AND iv_criminal_count < 2   => -0.454821,
	    2 <= iv_criminal_count AND iv_criminal_count < 3   => -0.710141,
	    3 <= iv_criminal_count                             => -1.048049,
	                                                          -0.000000);
	
	payerp_subscore3 := map(
			iv_pb_total_orders = NULL													   => 0.000000,
	    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.175746,
	    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => 0.130636,
	    2 <= iv_pb_total_orders AND iv_pb_total_orders < 5   => 0.187553,
	    5 <= iv_pb_total_orders                              => 0.320385,
	                                                            0.000000);
	
	payerp_subscore4 := map(
	    NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 4 => 0.212599,
	    4 <= iv_addrs_per_adl AND iv_addrs_per_adl < 5   => 0.080301,
	    5 <= iv_addrs_per_adl AND iv_addrs_per_adl < 10  => 0.011893,
	    10 <= iv_addrs_per_adl AND iv_addrs_per_adl < 12 => -0.075514,
	    12 <= iv_addrs_per_adl AND iv_addrs_per_adl < 16 => -0.144012,
	    16 <= iv_addrs_per_adl                           => -0.245430,
	                                                        -0.000000);
	
	payerp_subscore5 := map(
	    NULL < iv_bst_addr_source_count AND iv_bst_addr_source_count < 2 => -0.102357,
	    2 <= iv_bst_addr_source_count AND iv_bst_addr_source_count < 3   => 0.015293,
	    3 <= iv_bst_addr_source_count AND iv_bst_addr_source_count < 4   => 0.113774,
	    4 <= iv_bst_addr_source_count AND iv_bst_addr_source_count < 5   => 0.267554,
	    5 <= iv_bst_addr_source_count                                    => 0.393616,
	                                                                        -0.000000);
	
	payerp_subscore6 := map(
	    (iv_attr_addrs_recency in [0])            => 0.000000,
	    (iv_attr_addrs_recency in [1, 3, 12, 24]) => 0.181811,
	    (iv_attr_addrs_recency in [36, 60, 120])  => -0.066468,
	    (iv_attr_addrs_recency in [180])          => -0.129140,
	    (iv_attr_addrs_recency in [999])          => -0.281959,
	                                                 0.000000);
	
	payerp_subscore7 := map(
	    (iv_ams_college_tier in [' '])      => -0.000000,
	    (iv_ams_college_tier in ['-1'])     => -0.041956,
	    (iv_ams_college_tier in ['0'])      => -0.000000,
	    (iv_ams_college_tier in ['1', '2']) => 0.372040,
	    (iv_ams_college_tier in ['3'])      => 0.370624,
	    (iv_ams_college_tier in ['4'])      => 0.246949,
	    (iv_ams_college_tier in ['5'])      => 0.103484,
	    (iv_ams_college_tier in ['6'])      => -0.015329,
	                                           -0.000000);
	
	payerp_subscore8 := map(
	    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.299937,
	    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 2   => -0.000824,
	    2 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 3   => 0.000512,
	    3 <= iv_src_bureau_addr_count                                    => 0.140879,
	                                                                        -0.000000);
	
	payerp_subscore9 := map(
	    (iv_bst_addr_ownership_lvl in [' '])            => -0.000000,
	    (iv_bst_addr_ownership_lvl in ['Applicant'])    => 0.281720,
	    (iv_bst_addr_ownership_lvl in ['Family'])       => 0.045470,
	    (iv_bst_addr_ownership_lvl in ['No Ownership']) => -0.024361,
	    (iv_bst_addr_ownership_lvl in ['Occupant'])     => -0.044544,
	                                                       -0.000000);
	
	payerp_subscore10 := map(
	    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.027816,
	    1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.135930,
	    2 <= iv_eviction_count                             => -0.245311,
	                                                          -0.000000);
	
	payerp_subscore11 := map(
	    NULL < iv_bk_disposed_recent_count AND iv_bk_disposed_recent_count < 1 => -0.007885,
	    1 <= iv_bk_disposed_recent_count                                       => 0.602641,
	                                                                              0.000000);
	
	payerp_rawscore := payerp_subscore0 +
	    payerp_subscore1 +
	    payerp_subscore2 +
	    payerp_subscore3 +
	    payerp_subscore4 +
	    payerp_subscore5 +
	    payerp_subscore6 +
	    payerp_subscore7 +
	    payerp_subscore8 +
	    payerp_subscore9 +
	    payerp_subscore10 +
	    payerp_subscore11;
	
	payerp_lnoddsscore := payerp_rawscore + -2.377947;
	
	payerp_probscore := exp(payerp_lnoddsscore) / (1 + exp(payerp_lnoddsscore));
	
	base := 700;
	
	point := 40;
	
	odds := .088 / (1 - .088);
	
	rvc1412_2_0 := map(
	    ssn_deceased     => 200,
	    iv_riskview_222s => 222,
	                        min(if(max(round(base + point * (payerp_lnoddsscore - ln(odds)) / ln(2)), 501) = NULL, -NULL, max(round(base + point * (payerp_lnoddsscore - ln(odds)) / ln(2)), 501)), 900));
	
	rc_null    := '';
	
	rc1v := 0;
	
	rc2_2_null := '';
	
	rc2v := 0;
	
	rc3_2_null := '';
	
	rc3v := 0;
	
	rc4_2_null := '';
	
	rc4v := 0;
	
	rc5_2 := '';
	
	glrc97 := (INTEGER)truedid = 1 and criminal_count > 0;

	glrc9a := truedid and ((add1_pop and 
				property_owned_total = 0 and add1_naprop < 4 )
				or (add2_pop and property_owned_total = 0 
				and add2_naprop < 4));
	
	glrc9d := truedid  and unique_addr_count > 1;
	
	glrc9e_1 := truedid and (add1_pop or add2_pop);
	
	glrc9e_2 := truedid and iv_ed001_college_ind = '0' and age < 30;
	
	glrc9e_3 := truedid and addrpop;
	
	glrc9f := truedid and addrs_per_adl > 0;
	
	glrc9y := truedid and (INTEGER)pb_total_orders < 1;
	
	glrcev := truedid and attr_eviction_count > 0;
	
	glrcbl := 0;
	
	rcvalue97_1 := (integer)glrc97 * (0.051733 - payerp_subscore2);
	
	rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));
	
	rcvalue9a_1 := (integer)glrc9a * (0.281720 - payerp_subscore9);
	
	rcvalue9a := if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));
	
	rcvalue9d_1 := (integer)glrc9d * (0.212599 - payerp_subscore4);
	
	rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));
	
	rcvalue9e_1 := (integer)glrc9e_1 * (0.393616 - payerp_subscore5);
	
	rcvalue9e_2 := (integer)glrc9e_2 * (0.372040 - payerp_subscore7);
	
	rcvalue9e_3 := (integer)glrc9e_3 * (0.140879 - payerp_subscore8);
	
	rcvalue9e := if(max(rcvalue9e_1, rcvalue9e_2, rcvalue9e_3) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2), if(rcvalue9e_3 = NULL, 0, rcvalue9e_3)));
	
	rcvalue9f_1 := (integer)glrc9f * (0.181811 - payerp_subscore6);
	
	rcvalue9f := if(max(rcvalue9f_1) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1)));
	
	rcvalue9y_1 := (integer)glrc9y * (0.320385 - payerp_subscore3);
	
	// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));	
	rcvalue9y := 0;
	
	rcvalueev_1 := (integer)glrcev * (0.027816 - payerp_subscore10);
	
	rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));
	
	rcvaluebl_1 := glrcbl * (0.384635 - payerp_subscore0);
	
	rcvaluebl_2 := glrcbl * (0.620919 - payerp_subscore1);
	
	rcvaluebl_3 := glrcbl * (0.602641 - payerp_subscore11);
	
	rcvaluebl := if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	
	rc_dataset := DATASET([
	    {'97', RCValue97},
	    {'9A', RCValue9A},
	    {'9D', RCValue9D},
	    {'9E', RCValue9E},
	    {'9F', RCValue9F},
	    {'9Y', RCValue9Y},
	    {'EV', RCValueEV},
	    {'BL', RCValueBL}
	    ], ds_layout)(value > 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
	// I'll leave the implementation details to the Engineers.
	//*************************************************************************************//
	
	rc_dataset_sorted := sort(rc_dataset, -rc_dataset.value);
	
	rc1_2 := rc_dataset_sorted[1].rc;
	rc2_2 := rc_dataset_sorted[2].rc;
	rc3_2 := rc_dataset_sorted[3].rc;
	rc4_2 := rc_dataset_sorted[4].rc;
	
	rc4_1 := map(
	    rvc1412_2_0 = 200 => '',
	    rvc1412_2_0 = 222 => '',
	                         rc4_2);
	
	rc3_1 := map(
	    rvc1412_2_0 = 200 => '',
	    rvc1412_2_0 = 222 => '',
	                         rc3_2);
	
	rc5_1 := '';
	
	rc2_1 := map(
	    rvc1412_2_0 = 200 => '',
	    rvc1412_2_0 = 222 => '',
	                         rc2_2);

	rc1_1 := map(rvc1412_2_0 = 200 => '02',
							 rvc1412_2_0 = 222 => '9X',
							 rc1_2 = '' => '36',
							 rc1_2);
	
	rc2 := if(rvc1412_2_0 = 900, '', rc2_1);
	
	rc1 := if(rvc1412_2_0 = 900, '', rc1_1);
	
	rc4 := if(rvc1412_2_0 = 900, '', rc4_1);
	
	rc3 := if(rvc1412_2_0 = 900, '', rc3_1);
	
	rc5 := if(rvc1412_2_0 = 900, '', rc5_1);
	
//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides - used here for 4 also
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	risk_indicators.Layout_Desc;
END;
reasons := DATASET([{rc1, NULL}, {rc2, NULL}, {rc3, NULL}, {rc4, NULL}, {rc5, NULL}], HRILayout);
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVC1412_2_0 = 200 => DATASET([{'02', NULL}], HRILayout),
													RVC1412_2_0 = 222 => DATASET([{'9X', NULL}], HRILayout),
													RVC1412_2_0 = 900 => DATASET([{' ', NULL}], HRILayout),
																							 DATASET([], HRILayout)
													);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00', NULL}, {'00', NULL}, {'00', NULL}, {'00', NULL}, {'00', NULL}], HRILayout);

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

inCalif := isCalifornia AND (
					(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
					+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
					+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;		

ri := MAP(
					riTemp[1].hri <> '00' => riTemp,
					inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
					reasonsFinalTemp
					);
reasonCodes := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.agency := agency;
		SELF.acct_balance := acct_balance;
		SELF.truedid := truedid;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_bansflag := rc_bansflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_addr_sources := ver_addr_sources;
		SELF.ver_addr_sources_count := ver_addr_sources_count;
		SELF.addrpop := addrpop;
		SELF.age := age;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_source_count := add1_source_count;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_occupant_owned := add1_occupant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_pop := add1_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_total := property_sold_total;
		SELF.add2_source_count := add2_source_count;
		SELF.add2_applicant_owned := add2_applicant_owned;
		SELF.add2_occupant_owned := add2_occupant_owned;
		SELF.add2_family_owned := add2_family_owned;
		SELF.add2_naprop := add2_naprop;
		SELF.add2_pop := add2_pop;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.unique_addr_count := unique_addr_count;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.pb_total_orders := pb_total_orders;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.bk_disposed_recent_count := bk_disposed_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.criminal_count := criminal_count;
		SELF.ams_class := ams_class;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.ams_income_level_code := ams_income_level_code;
		SELF.ams_file_type := ams_file_type;
		SELF.ams_college_tier := ams_college_tier;
		SELF.ams_college_major := ams_college_major;

		/* Model Intermediate Variables */

		SELF.sysdate := sysdate;
		SELF.ssn_deceased := ssn_deceased;
		SELF.iv_riskview_222s := iv_riskview_222s;
		SELF.client_agency := client_agency;
		SELF.client2_placed_balance := client2_placed_balance;
		SELF.bureau_addr_tn_count_pos := bureau_addr_tn_count_pos;
		SELF.bureau_addr_count_tn := bureau_addr_count_tn;
		SELF.bureau_addr_ts_count_pos := bureau_addr_ts_count_pos;
		SELF.bureau_addr_count_ts := bureau_addr_count_ts;
		SELF.bureau_addr_tu_count_pos := bureau_addr_tu_count_pos;
		SELF.bureau_addr_count_tu := bureau_addr_count_tu;
		SELF.bureau_addr_en_count_pos := bureau_addr_en_count_pos;
		SELF.bureau_addr_count_en := bureau_addr_count_en;
		SELF.bureau_addr_eq_count_pos := bureau_addr_eq_count_pos;
		SELF.bureau_addr_count_eq := bureau_addr_count_eq;
		SELF._src_bureau_addr_count := _src_bureau_addr_count;
		SELF.iv_src_bureau_addr_count := iv_src_bureau_addr_count;
		SELF.iv_bst_addr_source_count := iv_bst_addr_source_count;
		SELF.iv_bst_addr_ownership_lvl_c9 := iv_bst_addr_ownership_lvl_c9;
		SELF.iv_bst_addr_ownership_lvl_c10 := iv_bst_addr_ownership_lvl_c10;
		SELF.iv_bst_addr_ownership_lvl := iv_bst_addr_ownership_lvl;
		SELF.iv_addrs_per_adl := iv_addrs_per_adl;
		SELF.iv_attr_addrs_recency := iv_attr_addrs_recency;
		SELF.iv_eviction_count := iv_eviction_count;
		SELF.iv_bk_disposed_recent_count := iv_bk_disposed_recent_count;
		SELF.iv_criminal_count := iv_criminal_count;
		SELF.iv_ams_college_tier := iv_ams_college_tier;
		SELF.iv_pb_total_orders := iv_pb_total_orders;
		SELF.iv_ed001_college_ind := iv_ed001_college_ind;
		SELF.payerp_subscore0 := payerp_subscore0;
		SELF.payerp_subscore1 := payerp_subscore1;
		SELF.payerp_subscore2 := payerp_subscore2;
		SELF.payerp_subscore3 := payerp_subscore3;
		SELF.payerp_subscore4 := payerp_subscore4;
		SELF.payerp_subscore5 := payerp_subscore5;
		SELF.payerp_subscore6 := payerp_subscore6;
		SELF.payerp_subscore7 := payerp_subscore7;
		SELF.payerp_subscore8 := payerp_subscore8;
		SELF.payerp_subscore9 := payerp_subscore9;
		SELF.payerp_subscore10 := payerp_subscore10;
		SELF.payerp_subscore11 := payerp_subscore11;
		SELF.payerp_rawscore := payerp_rawscore;
		SELF.payerp_lnoddsscore := payerp_lnoddsscore;
		SELF.payerp_probscore := payerp_probscore;
		SELF.base := base;
		SELF.point := point;
		SELF.odds := odds;
		SELF.rvc1412_2_0 := rvc1412_2_0;
		SELF.rc1v := rc1v;
		SELF.rc2_2 := rc2_2;
		SELF.rc2v := rc2v;
		SELF.rc3v := rc3v;
		SELF.rc4v := rc4v;
		SELF.rc5_2 := rc5_2;
		SELF.glrc97 := glrc97;
		SELF.glrc9a := glrc9a;
		SELF.glrc9d := glrc9d;
		SELF.glrc9e_1 := glrc9e_1;
		SELF.glrc9e_2 := glrc9e_2;
		SELF.glrc9e_3 := glrc9e_3;
		SELF.glrc9f := glrc9f;
		SELF.glrc9y := glrc9y;
		SELF.glrcev := glrcev;
		SELF.glrcbl := glrcbl;
		SELF.rcvalue97_1 := rcvalue97_1;
		SELF.rcvalue97 := rcvalue97;
		SELF.rcvalue9a_1 := rcvalue9a_1;
		SELF.rcvalue9a := rcvalue9a;
		SELF.rcvalue9d_1 := rcvalue9d_1;
		SELF.rcvalue9d := rcvalue9d;
		SELF.rcvalue9e_1 := rcvalue9e_1;
		SELF.rcvalue9e_2 := rcvalue9e_2;
		SELF.rcvalue9e_3 := rcvalue9e_3;
		SELF.rcvalue9e := rcvalue9e;
		SELF.rcvalue9f_1 := rcvalue9f_1;
		SELF.rcvalue9f := rcvalue9f;
		SELF.rcvalue9y_1 := rcvalue9y_1;
		SELF.rcvalue9y := rcvalue9y;
		SELF.rcvalueev_1 := rcvalueev_1;
		SELF.rcvalueev := rcvalueev;
		SELF.rcvaluebl_1 := rcvaluebl_1;
		SELF.rcvaluebl_2 := rcvaluebl_2;
		SELF.rcvaluebl_3 := rcvaluebl_3;
		SELF.rcvaluebl := rcvaluebl;

		SELF.rc1_2 := rc1_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF.rc4_1 := rc4_1;
		SELF.rc3_1 := rc3_1;
		SELF.rc5_1 := rc5_1;
		SELF.rc2_1 := rc2_1;
		SELF.rc1_1 := rc1_1;

		self.rc1                              := if(reasonCodes[1].hri = '00', '', reasonCodes[1].hri);
		self.rc2                              := if(reasonCodes[2].hri = '00', '', reasonCodes[2].hri);
		self.rc3                              := if(reasonCodes[3].hri = '00', '', reasonCodes[3].hri);
		self.rc4                              := if(reasonCodes[4].hri = '00', '', reasonCodes[4].hri);
		self.rc5                              := if(reasonCodes[5].hri = '00', '', reasonCodes[5].hri);                                              

		SELF.clam := le;
	#end
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.score := if(reasonCodes[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasonCodes[1].hri + 10),(string3)rvc1412_2_0);
		SELF.seq := le.seq;
	END;
//================================
//== end of the doModel TRANSFORM
//================================

//==================================================
//==  join the custom_inputs to the boca shell and 
//==  execute the doModel TRANSFORM for each row 
//==  passed to the model                           
//==================================================
		model := project( clam, doModel(left) );
		
//===============================================
//==  Return either the full debug record or   
//==  just the score and reason codes depending 
//==  on the debug flag
//===============================================

	RETURN(model);
	
END;
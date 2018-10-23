IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVT1402_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			BOOLEAN truedid;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING rc_decsflag;
			STRING rc_bansflag;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_count;
			STRING ver_addr_sources;
			STRING ver_addr_sources_count;
			BOOLEAN addrpop;
			INTEGER ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			INTEGER age;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_avm_tax_assessed_valuation;
			INTEGER add1_naprop;
			INTEGER add1_date_first_seen;
			BOOLEAN add1_pop;
			INTEGER property_owned_total;
			INTEGER property_sold_total;
			BOOLEAN add2_isbestmatch;
			INTEGER add2_assessed_total_value;
			INTEGER add2_date_first_seen;
			BOOLEAN add3_isbestmatch;
			INTEGER add3_assessed_total_value;
			INTEGER recent_disconnects;
			INTEGER adls_per_addr_c6;
			INTEGER inq_highriskcredit_count;
			INTEGER inq_highriskcredit_count01;
			INTEGER inq_highriskcredit_count03;
			INTEGER inq_highriskcredit_count06;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_highriskcredit_count24;
			STRING pb_total_orders;
			INTEGER infutor_last_seen;
			INTEGER impulse_count;
			INTEGER email_count;
			STRING email_source_list;
			INTEGER attr_eviction_count;
			BOOLEAN bankrupt;
			STRING disposition;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_unrel_sc_ct;
			INTEGER criminal_count;
			INTEGER ams_age;
			STRING ams_class;
			STRING ams_college_code;
			STRING ams_college_type;
			STRING ams_income_level_code;
			STRING ams_file_type;
			STRING ams_college_tier;
			STRING ams_college_major;
			INTEGER input_dob_age;
			INTEGER inferred_age;
			INTEGER reported_dob;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			STRING iv_db001_bankruptcy;
			BOOLEAN email_src_im;
			INTEGER iv_ds001_impulse_count;
			INTEGER _in_dob;
			REAL yr_in_dob;
			REAL yr_in_dob_int;
			INTEGER age_estimate;
			INTEGER iv_ag001_age;
			STRING iv_ed001_college_ind_35;
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
			INTEGER prop_adl_p_count_pos;
			INTEGER prop_adl_count_p;
			REAL _src_prop_adl_count;
			REAL iv_src_property_adl_count;
			INTEGER _reported_dob;
			INTEGER reported_age;
			INTEGER iv_combined_age;
			STRING iv_best_match_address;
			INTEGER bst_addr_date_first_seen;
			INTEGER iv_mos_since_bst_addr_fseen;
			INTEGER iv_prv_addr_assessed_total_val;
			INTEGER iv_recent_disconnects;
			INTEGER iv_adls_per_addr_c6;
			INTEGER iv_inq_highriskcredit_recency;
			INTEGER _infutor_last_seen;
			INTEGER iv_mos_since_infutor_last_seen;
			INTEGER iv_email_count;
			INTEGER iv_eviction_count;
			INTEGER iv_liens_unrel_sc_ct;
			INTEGER iv_criminal_count;
			INTEGER iv_pb_total_orders;
			REAL subscore0;
			REAL subscore1;
			REAL subscore2;
			REAL subscore3;
			REAL subscore4;
			REAL subscore5;
			REAL subscore6;
			REAL subscore7;
			REAL subscore8;
			REAL subscore9;
			REAL subscore10;
			REAL subscore11;
			REAL subscore12;
			REAL subscore13;
			REAL subscore14;
			REAL subscore15;
			REAL subscore16;
			REAL subscore17;
			REAL rawscore;
			REAL lnoddsscore;
			INTEGER base;
			REAL odds;
			INTEGER point;
			BOOLEAN ssn_deceased;
			BOOLEAN iv_riskview_222s;
			INTEGER rvt1402_1_0;
			BOOLEAN glrc07;
			BOOLEAN glrc97;
			BOOLEAN glrc98;
			BOOLEAN glrc99;
			BOOLEAN glrc9a;
			BOOLEAN glrc9c;
			BOOLEAN glrc9e;
			BOOLEAN glrc9h;
			BOOLEAN glrc9i;
			BOOLEAN glrc9p;
			BOOLEAN glrc9r;
			BOOLEAN glrc9w;
			BOOLEAN glrc9y;
			BOOLEAN glrcev;
			BOOLEAN glrcpv;
			INTEGER glrcbl;
			REAL rcvalue07_1;
			REAL rcvalue07;
			REAL rcvalue97_1;
			REAL rcvalue97;
			REAL rcvalue98_1;
			REAL rcvalue98;
			REAL rcvalue99_1;
			REAL rcvalue99;
			REAL rcvalue9a_1;
			REAL rcvalue9a;
			REAL rcvalue9c_1;
			REAL rcvalue9c;
			REAL rcvalue9e_1;
			REAL rcvalue9e;
			REAL rcvalue9h_1;
			REAL rcvalue9h;
			REAL rcvalue9i_1;
			REAL rcvalue9i;
			REAL rcvalue9p_1;
			REAL rcvalue9p;
			REAL rcvalue9r_1;
			REAL rcvalue9r;
			REAL rcvalue9w_1;
			REAL rcvalue9w;
			REAL rcvalue9y_1;
			REAL rcvalue9y;
			REAL rcvalueev_1;
			REAL rcvalueev;
			REAL rcvaluepv_1;
			REAL rcvaluepv;
			STRING rc1_3;
			STRING rc2_3;
			STRING rc3_2;
			STRING rc4_2;
			STRING rc5_2;
			STRING rc1_2;
			STRING rc4_1;
			STRING rc2_2;
			STRING rc3_1;
			STRING rc5_1;
			STRING rc5_3;
			STRING rc1_1;
			STRING rc2_1;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;

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
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (INTEGER)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
	add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
	recent_disconnects               := le.phone_verification.recent_disconnects;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	impulse_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := (INTEGER)le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := (INTEGER)le.bjl.filing_count;
	bk_recent_count                  := (INTEGER)le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	ams_age                          := (INTEGER)le.student.age;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	input_dob_age                    := (INTEGER)le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	
	INTEGER indexw(string source, string target, string delim) :=
		(INTEGER)((source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim));
	
	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));
	
	iv_db001_bankruptcy := map(
	    not(truedid or ssnlength > 0)                                                                                               => '                 ',
	    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
	    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
	    (rc_bansflag in ['1', '2']) or bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
	                                                                                                                                   '0 - No BK        ');
	
	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;
	
	iv_ds001_impulse_count := map(
	    not(truedid)                           		=> NULL,
	    impulse_count = 0 and email_src_im = TRUE => 1,
																									impulse_count);
	
	_in_dob := Common.SAS_Date((STRING)(in_dob));
	
	yr_in_dob := MAP(TRIM(in_dob) = ''	=> -1,
									 _in_dob = NULL			=> NULL,
																				 ((sysdate - _in_dob) / 365.25));
	
	yr_in_dob_int := MAP(yr_in_dob = NULL	=> NULL,
											 yr_in_dob = -1		=> -1,
											 yr_in_dob >= 0		=> roundup(yr_in_dob), 
																					 truncate(yr_in_dob));
	
	age_estimate := map(
	    yr_in_dob_int > 0 => yr_in_dob_int,
	    inferred_age > 0  => inferred_age,
	                         -1);
	
	iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));
	
	iv_ed001_college_ind_35 := map(
	    not(truedid) or (iv_ag001_age in [-1, NULL, 0]) or iv_ag001_age > 35	=> ' ',
	    not(ams_college_code = '') or not(ams_college_type = '') or 
			((integer)ams_college_tier >= 0 AND ams_college_tier <> '') or 
			not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A'])			=> '1',
	    ams_file_type = 'M'                                                   => '0',
	    not(ams_class = '') or not(ams_income_level_code = '')                => '1',
	                                                                             '0');
	
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
	
	_src_bureau_addr_count := max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0);
	
	iv_src_bureau_addr_count := map(
	    not(truedid)                  => NULL,
	    _src_bureau_addr_count = NULL => -1,
	                                     _src_bureau_addr_count);
	
	prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');
	
	prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));
	
	_src_prop_adl_count := max(prop_adl_count_p, (real)0);
	
	iv_src_property_adl_count := map(
	    not(truedid)               => NULL,
	    _src_prop_adl_count = NULL => -1,
	                                  _src_prop_adl_count);
	
	_reported_dob := Common.SAS_Date((STRING)(reported_dob));
	
	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
	
	iv_combined_age := map(
	    not(truedid or dobpop) => NULL,
	    age > 0                => age,
	    input_dob_age > 0      => input_dob_age,
	    inferred_age > 0       => inferred_age,
	    reported_age > 0       => reported_age,
	    ams_age > 0            => ams_age,
	                              -1);
	
	iv_best_match_address := map(
	    add1_isbestmatch => 'ADD1',
	    add2_isbestmatch => 'ADD2',
	    add3_isbestmatch => 'ADD3',
	                        'NONE');
	
	bst_addr_date_first_seen := if(add1_isbestmatch, Common.SAS_Date((STRING)(add1_date_first_seen)), Common.SAS_Date((STRING)(add2_date_first_seen)));
	
	iv_mos_since_bst_addr_fseen := map(
	    not(truedid)                    => NULL,
	    bst_addr_date_first_seen = NULL => -1,
	                                       if ((sysdate - bst_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - bst_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - bst_addr_date_first_seen) / (365.25 / 12))));
	
	iv_prv_addr_assessed_total_val := map(
	    not(truedid)     => NULL,
	    add1_isbestmatch => add2_assessed_total_value,
	                        add3_assessed_total_value);
	
	iv_recent_disconnects := if(not(hphnpop), NULL, recent_disconnects);
	
	iv_adls_per_addr_c6 := if(not(add1_pop), NULL, adls_per_addr_c6);
	
	iv_inq_highriskcredit_recency := map(
	    not(truedid)               => NULL,
	    inq_highRiskCredit_count01 > 0 => 1,
	    inq_highRiskCredit_count03 > 0 => 3,
	    inq_highRiskCredit_count06 > 0 => 6,
	    inq_highRiskCredit_count12 > 0 => 12,
	    inq_highRiskCredit_count24 > 0 => 24,
	    inq_highRiskCredit_count > 0   => 99,
	                                  0);
	
	_infutor_last_seen := Common.SAS_Date((STRING)(infutor_last_seen));
	
	iv_mos_since_infutor_last_seen := map(
	    not(hphnpop)                   => NULL,
	    not(_infutor_last_seen = NULL) => if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))),
	                                      -1);
	
	iv_email_count := if(not(truedid), NULL, email_count);
	
	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);
	
	iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);
	
	iv_criminal_count := if(not(truedid), NULL, criminal_count);
	
	iv_pb_total_orders := map(
	    not(truedid)           => NULL,
	    pb_total_orders = '' 	 => -1,
	                              (INTEGER)pb_total_orders);
	
	subscore0 := map(
	    NULL < iv_email_count AND iv_email_count < 1 => 0.192042,
	    1 <= iv_email_count AND iv_email_count < 2   => 0.079583,
	    2 <= iv_email_count                          => -0.234416,
	                                                    0.000000);
	
	subscore1 := map(
	    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.052062,
	    1 <= iv_criminal_count AND iv_criminal_count < 2   => -0.232090,
	    2 <= iv_criminal_count AND iv_criminal_count < 3   => -0.647060,
	    3 <= iv_criminal_count                             => -0.896047,
	                                                          -0.000000);
	
	subscore2 := map(
	    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.062323,
	    1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.166487,
	    2 <= iv_eviction_count AND iv_eviction_count < 3   => -0.330456,
	    3 <= iv_eviction_count                             => -0.748040,
	                                                          -0.000000);
	
	subscore3 := map(
	    NULL < iv_combined_age AND iv_combined_age < 18 => -0.000000,
	    18 <= iv_combined_age AND iv_combined_age < 26  => -0.243995,
	    26 <= iv_combined_age AND iv_combined_age < 43  => 0.030893,
	    43 <= iv_combined_age                           => 0.203601,
	                                                       -0.000000);
	
	subscore4 := map(
	    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.042583,
	    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -0.840017,
	    3 <= iv_inq_highriskcredit_recency                                         => -0.494007,
	                                                                                  0.000000);
	
	subscore5 := map(
	    (iv_best_match_address in ['ADD1'])                 => 0.145239,
	    (iv_best_match_address in ['ADD2', 'ADD3', 'NONE']) => -0.151266,
	                                                           0.000000);
	
	subscore6 := map(
	    NULL < iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 0 => 0.000000,
	    0 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 5   => -0.200534,
	    5 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 10  => -0.144859,
	    10 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 21 => -0.039399,
	    21 <= iv_mos_since_bst_addr_fseen AND iv_mos_since_bst_addr_fseen < 51 => 0.082828,
	    51 <= iv_mos_since_bst_addr_fseen                                      => 0.172564,
	                                                                              0.000000);
	
	subscore7 := map(
	    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.104432,
	    1 <= iv_pb_total_orders AND iv_pb_total_orders < 3   => 0.133892,
	    3 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.164881,
	    4 <= iv_pb_total_orders                              => 0.326959,
	                                                            0.000000);
	
	subscore8 := map(
	    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.042154,
	    1 <= iv_ds001_impulse_count                                  => -0.449504,
	                                                                    -0.000000);
	
	subscore9 := map(
	    NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.073399,
	    1 <= iv_src_property_adl_count                                     => 0.237813,
	                                                                          -0.000000);
	
	subscore10 := map(
	    NULL < iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 14       => 0.048738,
	    14 <= iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 8239      => -0.385586,
	    8239 <= iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 17390   => -0.065638,
	    17390 <= iv_prv_addr_assessed_total_val AND iv_prv_addr_assessed_total_val < 115415 => -0.055594,
	    115415 <= iv_prv_addr_assessed_total_val                                            => 0.200857,
	                                                                                           0.000000);
	
	subscore11 := map(
	    (iv_db001_bankruptcy in ['0 - No BK'])                        => 0.013309,
	    (iv_db001_bankruptcy in ['1 - BK Discharged'])                => 0.158321,
	    (iv_db001_bankruptcy in ['2 - BK Dismissed', '3 - BK Other']) => -0.609681,
	                                                                     0.000000);
	
	subscore12 := map(
	    NULL < iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen < 0 => -0.158603,
	    0 <= iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen < 9   => 0.122276,
	    9 <= iv_mos_since_infutor_last_seen AND iv_mos_since_infutor_last_seen < 24  => 0.072848,
	    24 <= iv_mos_since_infutor_last_seen                                         => -0.075009,
	                                                                                    0.000000);
	
	subscore13 := map(
	    NULL < iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 < 1 => 0.079300,
	    1 <= iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 < 3   => -0.101000,
	    3 <= iv_adls_per_addr_c6 AND iv_adls_per_addr_c6 < 4   => -0.252961,
	    4 <= iv_adls_per_addr_c6                               => -0.415730,
	                                                              0.000000);
	
	subscore14 := map(
	    (iv_ed001_college_ind_35 in [' ']) => -0.000000,
	    (iv_ed001_college_ind_35 in ['0']) => -0.039304,
	    (iv_ed001_college_ind_35 in ['1']) => 0.539649,
	                                          -0.000000);
	
	subscore15 := map(
	    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 2 => -0.042542,
	    2 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 3   => -0.021914,
	    3 <= iv_src_bureau_addr_count                                    => 0.178376,
	                                                                        0.000000);
	
	subscore16 := map(
	    NULL < iv_recent_disconnects AND iv_recent_disconnects < 1 => 0.012793,
	    1 <= iv_recent_disconnects                                 => -0.379728,
	                                                                  -0.000000);
	
	subscore17 := map(
	    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.015407,
	    1 <= iv_liens_unrel_sc_ct                                => -0.227347,
	                                                                0.000000);
	
	rawscore := subscore0 +
	    subscore1 +
	    subscore2 +
	    subscore3 +
	    subscore4 +
	    subscore5 +
	    subscore6 +
	    subscore7 +
	    subscore8 +
	    subscore9 +
	    subscore10 +
	    subscore11 +
	    subscore12 +
	    subscore13 +
	    subscore14 +
	    subscore15 +
	    subscore16 +
	    subscore17;
	
	lnoddsscore := rawscore + 1.883008;
	
	base := 700;
	
	odds := (1 - 0.1304) / 0.1304;
	
	point := 40;
	
	ssn_deceased := ((INTEGER)rc_decsflag = 1) or 
									(indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0);
	
	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
	
	

	//*************************************************************************************//
	//                     RiskView Version 4.1 - RVT1402_1_0 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//
	rvt1402_1_0 := map(
	    ssn_deceased     => 200,
	    iv_riskview_222s => 222,
	                        min(if(max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));
	
	//*************************************************************************************//
	//                        RiskView Version 4.1 Reason Code Logic
	//*************************************************************************************//
	rc5_3 := '';
	
	glrc07 := (INTEGER)hphnpop = 1 and recent_disconnects > 0;
	
	glrc97 := criminal_count > 0;
	
	glrc98 := liens_unrel_SC_ct > 0;
	
	glrc99 := (INTEGER)add1_isbestmatch = 0;
	
	glrc9a := property_owned_total = 0 and iv_src_property_adl_count = 0;
	
	glrc9c := (INTEGER)addrpop > 0;
	
	glrc9e := iv_src_bureau_addr_count < 2;
	
	glrc9h := (INTEGER)impulse_count > 0;
	
	glrc9i := iv_ag001_age < 35 and ((INTEGER)iv_ed001_college_ind_35 = 0 AND TRIM(iv_ed001_college_ind_35) <> '');
	
	glrc9p := (INTEGER)inq_highriskCredit_count > 0;
	
	glrc9r := (INTEGER)dobpop = 1 and 18 <= iv_combined_age AND iv_combined_age < 43;
	
	glrc9w := (rc_bansflag in ['1', '2']) or (INTEGER)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or (INTEGER)filing_count > 0 or (INTEGER)bk_recent_count > 0;
	
	glrc9y := pb_total_orders = '';
	
	glrcev := (INTEGER)attr_eviction_count > 0;
	
	glrcpv := 0 < add1_avm_tax_assessed_valuation AND add1_avm_tax_assessed_valuation < 118000;
	
	glrcbl := 0;
	
	rcvalue07_1 := (integer)glrc07 * (0.012793 - subscore16);
	
	rcvalue07 := if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));
	
	rcvalue97_1 := (integer)glrc97 * (0.052062 - subscore1);
	
	rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1))) * 2;
	
	rcvalue98_1 := (integer)glrc98 * (0.015407 - subscore17);
	
	rcvalue98 := if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1))) * 2;
	
	rcvalue99_1 := (integer)glrc99 * (0.145239 - subscore5);
	
	rcvalue99 := if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));
	
	rcvalue9a_1 := (integer)glrc9a * (0.237813 - subscore9);
	
	rcvalue9a := if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));
	
	rcvalue9c_1 := (integer)glrc9c * (0.172564 - subscore6);
	
	rcvalue9c := if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));
	
	rcvalue9e_1 := (integer)glrc9e * (0.178376 - subscore15);
	
	rcvalue9e := if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));
	
	rcvalue9h_1 := (integer)glrc9h * (0.042154 - subscore8);
	
	rcvalue9h := if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));
	
	rcvalue9i_1 := (integer)glrc9i * (0.539649 - subscore14);
	
	rcvalue9i := if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1))) / 3;
	
	rcvalue9p_1 := (integer)glrc9p * (0.042583 - subscore4);
	
	rcvalue9p := if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));
	
	rcvalue9r_1 := (integer)glrc9r * (0.203601 - subscore3);
	
	rcvalue9r := if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));
	
	rcvalue9w_1 := (integer)glrc9w * (0.158321 - subscore11);
	
	rcvalue9w := if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));
	
	rcvalue9y_1 := (integer)glrc9y * (0.326959 - subscore7);
	
	// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1))) / 3;
	rcvalue9y := 0;
	
	rcvalueev_1 := (integer)glrcev * (0.062323 - subscore2);
	
	rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));
	
	rcvaluepv_1 := (integer)glrcpv * (0.200857 - subscore10);
	
	rcvaluepv := if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));
	
	
	ds_layout := {STRING rc, REAL value};
	
	rc_dataset := DATASET([
	    {'07', RCValue07},
	    {'97', RCValue97},
	    {'98', RCValue98},
	    {'99', RCValue99},
	    {'9A', RCValue9A},
	    {'9C', RCValue9C},
	    {'9E', RCValue9E},
	    {'9H', RCValue9H},
	    {'9I', RCValue9I},
	    {'9P', RCValue9P},
	    {'9R', RCValue9R},
	    {'9W', RCValue9W},
	    {'9Y', RCValue9Y},
	    {'EV', RCValueEV},
	    {'PV', RCValuePV}
	    ], ds_layout) (value > 0);
		
	rc_dataset_sorted := sort(rc_dataset, -value);
	
	rc1_3 := rc_dataset_sorted[1].rc;
	rc2_3 := rc_dataset_sorted[2].rc;
	rc3_2 := rc_dataset_sorted[3].rc;
	rc4_2 := rc_dataset_sorted[4].rc;
	
	
	rc5_2 := if((INTEGER)glrc9p > 0 AND rc1_3 != '9P' AND rc2_3 != '9P' AND rc3_2 != '9P' AND rc4_2 != '9P' AND (INTEGER)inq_highRiskCredit_count > 0, '9P', '');
	
	rc1_2 := map(
	    rvt1402_1_0 = 200 => '02',
	    rvt1402_1_0 = 222 => '9X',
	                         rc1_3);
	
	rc4_1 := map(
	    rvt1402_1_0 = 200 => '',
	    rvt1402_1_0 = 222 => '',
	                         rc4_2);
	
	rc2_2 := map(
	    rvt1402_1_0 = 200 => '',
	    rvt1402_1_0 = 222 => '',
	                         rc2_3);
	
	rc3_1 := map(
	    rvt1402_1_0 = 200 => '',
	    rvt1402_1_0 = 222 => '',
	                         rc3_2);
	
	rc5_1 := map(
	    rvt1402_1_0 = 200 => '',
	    rvt1402_1_0 = 222 => '',
	                         rc5_2);
	
	rc1_1 := if(rc1_2 = '', '36', rc1_2);
	
	rc2_1 := if(not((rc1_1 in ['', '36'])) and rc2_2 = '' and 500 < rvt1402_1_0 AND rvt1402_1_0 <= 720, '36', rc2_2);
	
	rc1 := if(rvt1402_1_0 = 900, '', rc1_1);
	
	rc4 := if(rvt1402_1_0 = 900, '', rc4_1);
	
	rc2 := if(rvt1402_1_0 = 900, '', rc2_1);
	
	rc3 := if(rvt1402_1_0 = 900, '', rc3_1);
	
	rc5 := if(rvt1402_1_0 = 900, '', rc5_1);

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
	
	reasonsTemp := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout) (HRI NOT IN ['', '00']);
	reasons := IF(ut.Exists2(reasonsTemp), reasonsTemp, DATASET([{'36'}], HRILayout));
	
	riCorrectionsTemp := PROJECT(RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4), TRANSFORM(HRILayout, SELF.HRI := LEFT.hri)) (HRI NOT IN ['', '00']);

	reasonsOverrides := MAP(
													inCalif						=>	DATASET([{'35'}], HRILayout),
													RVT1402_1_0 = 200 =>	DATASET([{'02'}], HRILayout),
													RVT1402_1_0 = 222 =>	DATASET([{'9X'}], HRILayout),
													RVT1402_1_0 = 900 =>	DATASET([{' '}], HRILayout),
													RVT1402_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp)	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides)	=> reasonsOverrides, 
																													 reasons) (HRI <> '');
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

	//*************************************************************************************//
	//                   End RiskView Version 4.1 Reason Code Overrides
	//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_bansflag := rc_bansflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_count := ver_sources_count;
		SELF.ver_addr_sources := ver_addr_sources;
		SELF.ver_addr_sources_count := ver_addr_sources_count;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.age := age;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_avm_tax_assessed_valuation := add1_avm_tax_assessed_valuation;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_date_first_seen := add1_date_first_seen;
		SELF.add1_pop := add1_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_total := property_sold_total;
		SELF.add2_isbestmatch := add2_isbestmatch;
		SELF.add2_assessed_total_value := add2_assessed_total_value;
		SELF.add2_date_first_seen := add2_date_first_seen;
		SELF.add3_isbestmatch := add3_isbestmatch;
		SELF.add3_assessed_total_value := add3_assessed_total_value;
		SELF.recent_disconnects := recent_disconnects;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.pb_total_orders := pb_total_orders;
		SELF.infutor_last_seen := infutor_last_seen;
		SELF.impulse_count := impulse_count;
		SELF.email_count := email_count;
		SELF.email_source_list := email_source_list;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.bankrupt := bankrupt;
		SELF.disposition := disposition;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.criminal_count := criminal_count;
		SELF.ams_age := ams_age;
		SELF.ams_class := ams_class;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.ams_income_level_code := ams_income_level_code;
		SELF.ams_file_type := ams_file_type;
		SELF.ams_college_tier := ams_college_tier;
		SELF.ams_college_major := ams_college_major;
		SELF.input_dob_age := input_dob_age;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.iv_db001_bankruptcy := iv_db001_bankruptcy;
		SELF.email_src_im := email_src_im;
		SELF.iv_ds001_impulse_count := iv_ds001_impulse_count;
		SELF._in_dob := _in_dob;
		SELF.yr_in_dob := yr_in_dob;
		SELF.yr_in_dob_int := yr_in_dob_int;
		SELF.age_estimate := age_estimate;
		SELF.iv_ag001_age := iv_ag001_age;
		SELF.iv_ed001_college_ind_35 := iv_ed001_college_ind_35;
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
		SELF.prop_adl_p_count_pos := prop_adl_p_count_pos;
		SELF.prop_adl_count_p := prop_adl_count_p;
		SELF._src_prop_adl_count := _src_prop_adl_count;
		SELF.iv_src_property_adl_count := iv_src_property_adl_count;
		SELF._reported_dob := _reported_dob;
		SELF.reported_age := reported_age;
		SELF.iv_combined_age := iv_combined_age;
		SELF.iv_best_match_address := iv_best_match_address;
		SELF.bst_addr_date_first_seen := bst_addr_date_first_seen;
		SELF.iv_mos_since_bst_addr_fseen := iv_mos_since_bst_addr_fseen;
		SELF.iv_prv_addr_assessed_total_val := iv_prv_addr_assessed_total_val;
		SELF.iv_recent_disconnects := iv_recent_disconnects;
		SELF.iv_adls_per_addr_c6 := iv_adls_per_addr_c6;
		SELF.iv_inq_highriskcredit_recency := iv_inq_highriskcredit_recency;
		SELF._infutor_last_seen := _infutor_last_seen;
		SELF.iv_mos_since_infutor_last_seen := iv_mos_since_infutor_last_seen;
		SELF.iv_email_count := iv_email_count;
		SELF.iv_eviction_count := iv_eviction_count;
		SELF.iv_liens_unrel_sc_ct := iv_liens_unrel_sc_ct;
		SELF.iv_criminal_count := iv_criminal_count;
		SELF.iv_pb_total_orders := iv_pb_total_orders;
		SELF.subscore0 := subscore0;
		SELF.subscore1 := subscore1;
		SELF.subscore2 := subscore2;
		SELF.subscore3 := subscore3;
		SELF.subscore4 := subscore4;
		SELF.subscore5 := subscore5;
		SELF.subscore6 := subscore6;
		SELF.subscore7 := subscore7;
		SELF.subscore8 := subscore8;
		SELF.subscore9 := subscore9;
		SELF.subscore10 := subscore10;
		SELF.subscore11 := subscore11;
		SELF.subscore12 := subscore12;
		SELF.subscore13 := subscore13;
		SELF.subscore14 := subscore14;
		SELF.subscore15 := subscore15;
		SELF.subscore16 := subscore16;
		SELF.subscore17 := subscore17;
		SELF.rawscore := rawscore;
		SELF.lnoddsscore := lnoddsscore;
		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.ssn_deceased := ssn_deceased;
		SELF.iv_riskview_222s := iv_riskview_222s;
		SELF.rvt1402_1_0 := rvt1402_1_0;
		SELF.rc5_3 := rc5_3;
		SELF.glrc07 := glrc07;
		SELF.glrc97 := glrc97;
		SELF.glrc98 := glrc98;
		SELF.glrc99 := glrc99;
		SELF.glrc9a := glrc9a;
		SELF.glrc9c := glrc9c;
		SELF.glrc9e := glrc9e;
		SELF.glrc9h := glrc9h;
		SELF.glrc9i := glrc9i;
		SELF.glrc9p := glrc9p;
		SELF.glrc9r := glrc9r;
		SELF.glrc9w := glrc9w;
		SELF.glrc9y := glrc9y;
		SELF.glrcev := glrcev;
		SELF.glrcpv := glrcpv;
		SELF.glrcbl := glrcbl;
		SELF.rcvalue07_1 := rcvalue07_1;
		SELF.rcvalue07 := rcvalue07;
		SELF.rcvalue97_1 := rcvalue97_1;
		SELF.rcvalue97 := rcvalue97;
		SELF.rcvalue98_1 := rcvalue98_1;
		SELF.rcvalue98 := rcvalue98;
		SELF.rcvalue99_1 := rcvalue99_1;
		SELF.rcvalue99 := rcvalue99;
		SELF.rcvalue9a_1 := rcvalue9a_1;
		SELF.rcvalue9a := rcvalue9a;
		SELF.rcvalue9c_1 := rcvalue9c_1;
		SELF.rcvalue9c := rcvalue9c;
		SELF.rcvalue9e_1 := rcvalue9e_1;
		SELF.rcvalue9e := rcvalue9e;
		SELF.rcvalue9h_1 := rcvalue9h_1;
		SELF.rcvalue9h := rcvalue9h;
		SELF.rcvalue9i_1 := rcvalue9i_1;
		SELF.rcvalue9i := rcvalue9i;
		SELF.rcvalue9p_1 := rcvalue9p_1;
		SELF.rcvalue9p := rcvalue9p;
		SELF.rcvalue9r_1 := rcvalue9r_1;
		SELF.rcvalue9r := rcvalue9r;
		SELF.rcvalue9w_1 := rcvalue9w_1;
		SELF.rcvalue9w := rcvalue9w;
		SELF.rcvalue9y_1 := rcvalue9y_1;
		SELF.rcvalue9y := rcvalue9y;
		SELF.rcvalueev_1 := rcvalueev_1;
		SELF.rcvalueev := rcvalueev;
		SELF.rcvaluepv_1 := rcvaluepv_1;
		SELF.rcvaluepv := rcvaluepv;
		SELF.rc1_3 := rc1_3;
		SELF.rc2_3 := rc2_3;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF.rc5_2 := rc5_2;
		SELF.rc1_2 := rc1_2;
		SELF.rc4_1 := rc4_1;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_1 := rc3_1;
		SELF.rc5_1 := rc5_1;
		SELF.rc1_1 := rc1_1;
		SELF.rc2_1 := rc2_1;

		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)RVT1402_1_0);

		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;

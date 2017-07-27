IMPORT ut, EASI, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT rsn1105_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			INTEGER adl_addr;
			INTEGER adl_hphn;
			INTEGER adl_ssn;
			STRING c_span_lang;
			STRING c_many_cars;
			INTEGER in_hphnpop;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_addrcommflag;
			STRING rc_phonetype;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_source_count;
			BOOLEAN add1_eda_sourced;
			INTEGER add1_naprop;
			INTEGER add1_nhood_vacant_properties;
			INTEGER addrs_10yr;
			INTEGER ssns_per_adl;
			INTEGER inq_collection_count;
			INTEGER inq_collection_count03;
			INTEGER inq_auto_count03;
			INTEGER inq_auto_count06;
			INTEGER inq_banking_count03;
			INTEGER inq_banking_count06;
			INTEGER inq_highriskcredit_count;
			INTEGER inq_highriskcredit_count03;
			INTEGER inq_highriskcredit_count06;
			INTEGER inq_highriskcredit_count24;
			INTEGER inq_retail_count03;
			INTEGER inq_retail_count06;
			INTEGER inq_communications_count;
			INTEGER inq_communications_count03;
			INTEGER inq_communications_count06;
			INTEGER inq_other_count03;
			INTEGER inq_other_count06;
			STRING disposition;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER rel_count;
			INTEGER rel_prop_owned_count;
			INTEGER rel_prop_sold_count;
			INTEGER rel_homeunder150_count;
			INTEGER rel_homeunder200_count;
			INTEGER rel_homeunder300_count;
			INTEGER rel_homeunder500_count;
			INTEGER rel_homeover500_count;
			STRING ams_college_code;
			STRING ams_college_type;
			INTEGER estimated_income;

			/* Model Intermediate Variables */
			INTEGER s1_inq_coll_hrcred_comm_lvl;
			INTEGER s1_add1_naprop_lvl;
			INTEGER match_lvl;
			INTEGER missing_lvl;
			INTEGER s1_adl_match_lvl;
			INTEGER ssns_per_adl_lvl;
			INTEGER rel_prop_own_pct;
			INTEGER rel_prop_sold_pct;
			INTEGER s1_rel_prop_sold_pct_a;
			INTEGER c_span_lang_lvl;
			INTEGER other_inq_count03;
			INTEGER other_inq_count06;
			INTEGER other_recent_inq_lvl;
			INTEGER s0_estimated_income_lvl;
			INTEGER ams_attended_college;
			INTEGER c_many_cars_lvl;
			INTEGER s0_addrs_yr_lvl;
			INTEGER rel_home500plus_count;
			INTEGER rel_home300plus_count;
			INTEGER rel_home200plus_count;
			INTEGER rel_home150plus_count;
			INTEGER rel_home100plus_count;
			INTEGER rel_home150plus_pct;
			INTEGER rel_home100plus_pct;
			INTEGER rel_home300plus_pct;
			INTEGER rel_home200plus_pct;
			INTEGER s1_rel_nicehome;
			INTEGER s1_add1_nhood_vacant_prop_flag;
			INTEGER s1_criminal_lvl;
			INTEGER s1_estimated_income_lvl;
			INTEGER s1_last_coll_hrcred_inq_lvl;
			INTEGER s1_liens_unreleased_lvl;
			INTEGER s0_criminal_lvl;
			INTEGER s1_rel_prop_own_pct_a;
			STRING _disposition;
			INTEGER bk_level;
			INTEGER s1_add1_source_lvl;
			BOOLEAN phn_disconnected;
			BOOLEAN phn_inval;
			BOOLEAN phn_nonus;
			BOOLEAN phn_highrisk;
			BOOLEAN phn_cell;
			INTEGER s1_phone_prob;
			REAL p0_subscore0;
			REAL p0_subscore1;
			REAL p0_subscore2;
			REAL p0_subscore3;
			REAL p0_subscore4;
			REAL p0_subscore5;
			REAL p0_subscore6;
			REAL p0_subscore7;
			REAL p0_subscore8;
			REAL p0_subscore9;
			REAL p0_subscore10;
			REAL p0_subscore11;
			REAL p0_subscore12;
			REAL p0_subscore13;
			REAL phn0_subscore_total;
			INTEGER phn0_mod;
			REAL p1_subscore0;
			REAL p1_subscore1;
			REAL p1_subscore2;
			REAL p1_subscore3;
			REAL p1_subscore4;
			REAL p1_subscore5;
			REAL p1_subscore6;
			REAL p1_subscore7;
			REAL p1_subscore8;
			REAL p1_subscore9;
			REAL p1_subscore10;
			REAL p1_subscore11;
			REAL p1_subscore12;
			REAL p1_subscore13;
			REAL phn1_subscore_total;
			INTEGER phn1_mod;
			INTEGER rsn1105_2_0;
		END;
		Layout_Debug doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#else
		Models.Layout_RecoverScore doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_addr                         := le.adl_shell_flags.adl_addr;
	adl_hphn                         := le.adl_shell_flags.adl_hphn;
	adl_ssn                          := le.adl_shell_flags.adl_ssn;
	c_span_lang                      := TRIM(ri.SPAN_LANG);
	c_many_cars                      := TRIM(ri.MANY_CARS);
	in_hphnpop                       := le.ADL_Shell_Flags.in_hphnpop;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_nhood_vacant_properties     := le.addr_risk_summary.n_vacant_properties;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	disposition                      := le.bjl.disposition;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	rel_count                        := le.relatives.relative_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	s1_inq_coll_hrcred_comm_lvl := map(
	    Inq_Collection_count > 1 and Inq_HighRiskCredit_count > 1 and Inq_Communications_count > 0 => 5,
	    Inq_Collection_count > 1 and Inq_HighRiskCredit_count > 1                                  => 4,
	    Inq_Collection_count <= 1 and Inq_HighRiskCredit_count > 1                                 => 3,
	    Inq_Collection_count > 1 and Inq_HighRiskCredit_count = 1                                  => 3,
	    Inq_Collection_count <= 1 and Inq_HighRiskCredit_count = 1                                 => 2,
	    Inq_Collection_count > 1 and Inq_HighRiskCredit_count = 0                                  => 2,
	    Inq_Collection_count = 1 and Inq_HighRiskCredit_count = 0                                  => 1,
	    Inq_Collection_count = 0 and Inq_HighRiskCredit_count = 0                                  => 0,
	                                                                                                  2);
	
	s1_add1_naprop_lvl := map(
	    add1_naprop = 4 and add1_eda_sourced => 3,
	    add1_naprop = 4                      => 2,
	    (add1_naprop in [2, 3])              => 2,
	    add1_naprop = 1                      => 1,
	    not(add1_isbestmatch)                => -1,
	                                            0);
	
	match_lvl := (INTEGER1)(adl_addr = 2) + (INTEGER1)(adl_hphn = 2) + (INTEGER1)(adl_ssn = 2);
	
	missing_lvl := (INTEGER1)(adl_addr=0) + (INTEGER1)(adl_hphn=0) + (INTEGER1)(adl_ssn=0);
	
	s1_adl_match_lvl := map(
	    match_lvl = 3 and missing_lvl = 0 => 3,
	    match_lvl = 2 and missing_lvl = 1 => 2,
	    match_lvl = 2 and missing_lvl = 0 => 1,
	                                         0);
	
	ssns_per_adl_lvl := if(ssns_per_adl = 0, 2, min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 4));
	
	rel_prop_own_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_prop_owned_count * 100 / rel_count));
	
	rel_prop_sold_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_prop_sold_count * 100 / rel_count));
	
	s1_rel_prop_sold_pct_a := map(
	    rel_count = 0                    => -1,
	    rel_prop_sold_pct >= 30          => 3,
	    rel_prop_sold_pct >= 20          => 2,
	    rel_prop_sold_pct >= 10          => 1,
	    0 < rel_count AND rel_count <= 4 => 2,
	                                        0);
	
	c_span_lang_lvl := map(
			TRIM(C_SPAN_LANG) = ''																								=> 1,
	    (INTEGER)TRIM(C_SPAN_LANG) <= 50                               				=> 1,
	    50 < (INTEGER)TRIM(C_SPAN_LANG) AND (INTEGER)TRIM(C_SPAN_LANG) <= 160 => 2,
																																							 3);
	
	other_inq_count03 := if(max(Inq_Auto_count03, Inq_Banking_count03, Inq_Retail_count03, Inq_Communications_count03, Inq_Other_count03) = NULL, NULL, sum(if(Inq_Auto_count03 = NULL, 0, Inq_Auto_count03), if(Inq_Banking_count03 = NULL, 0, Inq_Banking_count03), if(Inq_Retail_count03 = NULL, 0, Inq_Retail_count03), if(Inq_Communications_count03 = NULL, 0, Inq_Communications_count03), if(Inq_Other_count03 = NULL, 0, Inq_Other_count03)));
	
	other_inq_count06 := if(max(Inq_Auto_count06, Inq_Banking_count06, Inq_Retail_count06, Inq_Communications_count06, Inq_Other_count06) = NULL, NULL, sum(if(Inq_Auto_count06 = NULL, 0, Inq_Auto_count06), if(Inq_Banking_count06 = NULL, 0, Inq_Banking_count06), if(Inq_Retail_count06 = NULL, 0, Inq_Retail_count06), if(Inq_Communications_count06 = NULL, 0, Inq_Communications_count06), if(Inq_Other_count06 = NULL, 0, Inq_Other_count06)));
	
	other_recent_inq_lvl := map(
	    other_inq_count03 > 0 => 2,
	    other_inq_count06 > 0 => 1,
	                             0);
	
	s0_estimated_income_lvl := map(
	    estimated_income <= 0     => 2,
	    estimated_income <= 28000 => 1,
	    estimated_income <= 36000 => 2,
	                                 3);
	
	ams_attended_college := if(not(ams_college_code = ' ') and not(ams_college_type = ' '), 1, 0);
	
	c_many_cars_lvl := map(
			TRIM(C_MANY_CARS) = ''																								=> 1,
	    (INTEGER)TRIM(C_MANY_CARS) <= 80                               				=> 1,
	    80 < (INTEGER)TRIM(C_MANY_CARS) AND (INTEGER)TRIM(C_MANY_CARS) <= 140 => 2,
																																							 3);
	
	s0_addrs_yr_lvl := map(
	    addrs_10yr <= 0  => 3,
	    addrs_10yr <= 2  => 0,
	    addrs_10yr <= 5  => 1,
	    addrs_10yr <= 7  => 2,
	    addrs_10yr <= 10 => 3,
	                        4);
	
	rel_home500plus_count := rel_homeover500_count;
	
	rel_home300plus_count := if(max(rel_home500plus_count, rel_homeunder500_count) = NULL, NULL, sum(if(rel_home500plus_count = NULL, 0, rel_home500plus_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count)));
	
	rel_home200plus_count := if(max(rel_home300plus_count, rel_homeunder300_count) = NULL, NULL, sum(if(rel_home300plus_count = NULL, 0, rel_home300plus_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count)));
	
	rel_home150plus_count := if(max(rel_home200plus_count, rel_homeunder200_count) = NULL, NULL, sum(if(rel_home200plus_count = NULL, 0, rel_home200plus_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count)));
	
	rel_home100plus_count := if(max(rel_home150plus_count, rel_homeunder150_count) = NULL, NULL, sum(if(rel_home150plus_count = NULL, 0, rel_home150plus_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count)));
	
	rel_home150plus_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_home150plus_count * 100 / rel_count));
	
	rel_home100plus_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_home100plus_count * 100 / rel_count));
	
	rel_home300plus_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_home300plus_count * 100 / rel_count));
	
	rel_home200plus_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_home200plus_count * 100 / rel_count));
	
	s1_rel_nicehome := if(rel_home300plus_pct >= 50 or rel_home200plus_pct >= 60 or rel_home150plus_pct >= 80 or rel_home100plus_pct >= 90, 1, 0);
	
	s1_add1_nhood_vacant_prop_flag := if(add1_Nhood_Vacant_Properties >= 10, 1, 0);
	
	s1_criminal_lvl := map(
	    felony_count > 0   => 2,
	    criminal_count > 0 => 1,
	                          0);
	
	s1_estimated_income_lvl := map(
	    estimated_income <= 0     => 1,
	    estimated_income <= 32000 => 1,
	    estimated_income <= 50000 => 2,
	                                 3);
	
	s1_last_coll_hrcred_inq_lvl := map(
	    Inq_HighRiskCredit_count03 > 0                                => 3,
	    Inq_HighRiskCredit_count06 > 0 and Inq_Collection_count03 > 0 => 3,
	    Inq_HighRiskCredit_count06 > 0                                => 2,
	    Inq_HighRiskCredit_count24 > 0 and Inq_Collection_count03 > 0 => 2,
	    Inq_HighRiskCredit_count24 > 0                                => 1,
	    Inq_Collection_count03 > 0                                    => 1,
	                                                                     0);
	
	s1_liens_unreleased_lvl := map(
	    liens_historical_unreleased_ct = 0 and liens_recent_unreleased_count > 0 => 1,
	    liens_historical_unreleased_ct > 0 and liens_recent_unreleased_count > 0 => 2,
	                                                                                min(if(liens_historical_unreleased_ct = NULL, -NULL, liens_historical_unreleased_ct), 2));
	
	s0_criminal_lvl := if(felony_count > 0, 3, min(if(criminal_count = NULL, -NULL, criminal_count), 2));
	
	s1_rel_prop_own_pct_a := map(
	    rel_count = 0                    => 1,
	    rel_prop_own_pct >= 40           => 3,
	    rel_prop_own_pct >= 20           => 2,
	    rel_prop_own_pct >= 10           => 1,
	    rel_count = 1                    => 2,
	    1 < rel_count AND rel_count <= 3 => 1,
	                                        0);
	
	_disposition := map(
	    StringLib.StringToUpperCase(disposition) = 'DISMISSED' => 'DISMISSED',
	    disposition = ' '                                      => 'NONE',
	                                                              'DISCHARGE');
	
	bk_level := map(
	    _disposition = 'DISMISSED' => 2,
	    _disposition = 'DISCHARGE' => 0,
	                                  1);
	
	s1_add1_source_lvl := map(
	    add1_source_count >= 6 => 5,
	    add1_source_count >= 5 => 4,
	    add1_source_count >= 4 => 3,
	    add1_source_count >= 2 => 2,
	    add1_source_count >= 1 => 1,
	                              0);
	
	phn_disconnected := rc_hriskphoneflag = (string)5;
	
	phn_inval := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']);
	
	phn_nonus := (rc_phonetype in ['3', '4']);
	
	phn_highrisk := rc_hriskphoneflag = (string)6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = (string)3 or rc_addrcommflag = (string)1;
	
	phn_cell := (rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']);
	
	s1_phone_prob := map(
	    phn_cell                                                   => -1,
	    phn_disconnected or phn_inval or phn_nonus or phn_highrisk => 1,
	                                                                  0);
	
	p0_subscore0 := map(
	    (s1_inq_coll_hrcred_comm_lvl in [0]) => 51.058181,
	    (s1_inq_coll_hrcred_comm_lvl in [1]) => 56.702082,
	    (s1_inq_coll_hrcred_comm_lvl in [2]) => 44.546754,
	    (s1_inq_coll_hrcred_comm_lvl in [3]) => 42.386069,
	    (s1_inq_coll_hrcred_comm_lvl in [4]) => 28.778384,
	    (s1_inq_coll_hrcred_comm_lvl in [5]) => 34.788256,
	                                            46.717898);
	
	p0_subscore1 := map(
	    (other_recent_inq_lvl in [0]) => 49.761147,
	    (other_recent_inq_lvl in [1]) => 36.484974,
	    (other_recent_inq_lvl in [2]) => 39.369961,
	                                     46.717898);
	
	p0_subscore2 := map(
	    (s1_add1_naprop_lvl in [-1]) => 50.190118,
	    (s1_add1_naprop_lvl in [0])  => 44.662559,
	    (s1_add1_naprop_lvl in [1])  => 42.239939,
	    (s1_add1_naprop_lvl in [2])  => 49.784043,
	    (s1_add1_naprop_lvl in [3])  => 72.636623,
	                                    46.717898);
	
	p0_subscore3 := map(
	    (s1_adl_match_lvl in [0]) => 41.506319,
	    (s1_adl_match_lvl in [1]) => 51.676806,
	    (s1_adl_match_lvl in [2]) => 56.678310,
	                                 46.717898);
	
	p0_subscore4 := map(
	    (s0_estimated_income_lvl in [1]) => 34.074452,
	    (s0_estimated_income_lvl in [2]) => 41.298265,
	    (s0_estimated_income_lvl in [3]) => 58.171313,
	                                        46.717898);
	
	p0_subscore5 := map(
	    (ams_attended_college in [0]) => 45.462326,
	    (ams_attended_college in [1]) => 67.518577,
	                                     46.717898);
	
	p0_subscore6 := map(
	    (c_many_cars_lvl in [1]) => 51.311045,
	    (c_many_cars_lvl in [2]) => 45.425354,
	    (c_many_cars_lvl in [3]) => 28.489024,
	                                46.717898);
	
	p0_subscore7 := map(
	    (s0_addrs_yr_lvl in [0]) => 49.991606,
	    (s0_addrs_yr_lvl in [1]) => 50.241183,
	    (s0_addrs_yr_lvl in [2]) => 48.480449,
	    (s0_addrs_yr_lvl in [3]) => 43.010535,
	    (s0_addrs_yr_lvl in [4]) => 42.961331,
	                                46.717898);
	
	p0_subscore8 := map(
	    (ssns_per_adl_lvl in [1]) => 48.126993,
	    (ssns_per_adl_lvl in [2]) => 47.091175,
	    (ssns_per_adl_lvl in [3]) => 33.552181,
	    (ssns_per_adl_lvl in [4]) => 34.123993,
	                                 46.717898);
	
	p0_subscore9 := map(
	    (s1_rel_nicehome in [0]) => 43.610954,
	    (s1_rel_nicehome in [1]) => 62.596599,
	                                46.717898);
	
	p0_subscore10 := map(
	    (s1_add1_nhood_vacant_prop_flag in [0]) => 58.533421,
	    (s1_add1_nhood_vacant_prop_flag in [1]) => 41.951489,
	                                               46.717898);
	
	p0_subscore11 := map(
	    (s1_criminal_lvl in [0]) => 48.129139,
	    (s1_criminal_lvl in [1]) => 42.915257,
	    (s1_criminal_lvl in [2]) => 38.206205,
	                                46.717898);
	
	p0_subscore12 := map(
	    (s1_rel_prop_sold_pct_a in [-1]) => 60.293689,
	    (s1_rel_prop_sold_pct_a in [0])  => 38.521678,
	    (s1_rel_prop_sold_pct_a in [1])  => 46.165848,
	    (s1_rel_prop_sold_pct_a in [2])  => 49.277341,
	    (s1_rel_prop_sold_pct_a in [3])  => 66.668735,
	                                        46.717898);
	
	p0_subscore13 := map(
	    (c_span_lang_lvl in [1]) => 52.690534,
	    (c_span_lang_lvl in [2]) => 46.843567,
	    (c_span_lang_lvl in [3]) => 45.410243,
	                                46.717898);
	
	phn0_subscore_total := p0_subscore0 +
	    p0_subscore1 +
	    p0_subscore2 +
	    p0_subscore3 +
	    p0_subscore4 +
	    p0_subscore5 +
	    p0_subscore6 +
	    p0_subscore7 +
	    p0_subscore8 +
	    p0_subscore9 +
	    p0_subscore10 +
	    p0_subscore11 +
	    p0_subscore12 +
	    p0_subscore13;
	
	phn0_mod := round(min(if(max(phn0_subscore_total + 90, (real)301) = NULL, -NULL, max(phn0_subscore_total + 90, (real)301)), 999));
	
	p1_subscore0 := map(
	    (s1_inq_coll_hrcred_comm_lvl in [0]) => 59.207823,
	    (s1_inq_coll_hrcred_comm_lvl in [1]) => 53.096166,
	    (s1_inq_coll_hrcred_comm_lvl in [2]) => 48.519595,
	    (s1_inq_coll_hrcred_comm_lvl in [3]) => 47.667189,
	    (s1_inq_coll_hrcred_comm_lvl in [4]) => 41.409070,
	    (s1_inq_coll_hrcred_comm_lvl in [5]) => 35.662073,
	                                            51.671491);
	
	p1_subscore1 := map(
	    (s1_estimated_income_lvl in [1]) => 38.294302,
	    (s1_estimated_income_lvl in [2]) => 53.557385,
	    (s1_estimated_income_lvl in [3]) => 72.539058,
	                                        51.671491);
	
	p1_subscore2 := map(
	    (s1_last_coll_hrcred_inq_lvl in [0]) => 54.787708,
	    (s1_last_coll_hrcred_inq_lvl in [1]) => 47.903642,
	    (s1_last_coll_hrcred_inq_lvl in [2]) => 44.889333,
	    (s1_last_coll_hrcred_inq_lvl in [3]) => 33.624528,
	                                            51.671491);
	
	p1_subscore3 := map(
	    (s1_liens_unreleased_lvl in [0]) => 55.615589,
	    (s1_liens_unreleased_lvl in [1]) => 48.073533,
	    (s1_liens_unreleased_lvl in [2]) => 38.835156,
	                                        51.671491);
	
	p1_subscore4 := map(
	    (s0_criminal_lvl in [0]) => 54.283754,
	    (s0_criminal_lvl in [1]) => 44.232908,
	    (s0_criminal_lvl in [2]) => 46.002995,
	    (s0_criminal_lvl in [3]) => 29.788038,
	                                51.671491);
	
	p1_subscore5 := map(
	    (s1_adl_match_lvl in [0]) => 44.861498,
	    (s1_adl_match_lvl in [1]) => 57.610891,
	    (s1_adl_match_lvl in [2]) => 54.267787,
	    (s1_adl_match_lvl in [3]) => 75.131502,
	                                 51.671491);
	
	p1_subscore6 := map(
	    (s1_rel_prop_own_pct_a in [0]) => 46.887660,
	    (s1_rel_prop_own_pct_a in [1]) => 50.031067,
	    (s1_rel_prop_own_pct_a in [2]) => 56.797149,
	    (s1_rel_prop_own_pct_a in [3]) => 69.191133,
	                                      51.671491);
	
	p1_subscore7 := map(
	    (ssns_per_adl_lvl in [1]) => 54.040632,
	    (ssns_per_adl_lvl in [2]) => 48.614739,
	    (ssns_per_adl_lvl in [3]) => 44.953716,
	    (ssns_per_adl_lvl in [4]) => 42.774699,
	                                 51.671491);
	
	p1_subscore8 := map(
	    (s1_add1_naprop_lvl in [-1]) => 39.495599,
	    (s1_add1_naprop_lvl in [0])  => 51.070214,
	    (s1_add1_naprop_lvl in [1])  => 49.964689,
	    (s1_add1_naprop_lvl in [2])  => 56.187772,
	    (s1_add1_naprop_lvl in [3])  => 60.790880,
	                                    51.671491);
	
	p1_subscore9 := map(
	    (bk_level in [0]) => 62.566199,
	    (bk_level in [1]) => 51.067506,
	    (bk_level in [2]) => 28.730950,
	                         51.671491);
	
	p1_subscore10 := map(
	    (s1_add1_source_lvl in [0])       => 70.224055,
	    (s1_add1_source_lvl in [1])       => 41.422072,
	    (s1_add1_source_lvl in [2, 3, 4]) => 50.927103,
	    (s1_add1_source_lvl in [5])       => 53.244964,
	                                         51.671491);
	
	p1_subscore11 := map(
	    (s1_phone_prob in [-1]) => 50.882500,
	    (s1_phone_prob in [0])  => 53.631019,
	    (s1_phone_prob in [1])  => 42.491050,
	                               51.671491);
	
	p1_subscore12 := map(
	    (c_span_lang_lvl in [1]) => 59.630486,
	    (c_span_lang_lvl in [2]) => 52.332128,
	    (c_span_lang_lvl in [3]) => 49.013669,
	                                51.671491);
	
	p1_subscore13 := map(
	    (s1_rel_prop_sold_pct_a in [-1]) => 54.453561,
	    (s1_rel_prop_sold_pct_a in [0])  => 49.403967,
	    (s1_rel_prop_sold_pct_a in [1])  => 57.066683,
	    (s1_rel_prop_sold_pct_a in [2])  => 52.060265,
	    (s1_rel_prop_sold_pct_a in [3])  => 52.414368,
	                                        51.671491);
	
	phn1_subscore_total := p1_subscore0 +
	    p1_subscore1 +
	    p1_subscore2 +
	    p1_subscore3 +
	    p1_subscore4 +
	    p1_subscore5 +
	    p1_subscore6 +
	    p1_subscore7 +
	    p1_subscore8 +
	    p1_subscore9 +
	    p1_subscore10 +
	    p1_subscore11 +
	    p1_subscore12 +
	    p1_subscore13;
	
	phn1_mod := round(min(if(max(phn1_subscore_total + 90, (real)301) = NULL, -NULL, max(phn1_subscore_total + 90, (real)301)), 999));
	
	rsn1105_2_0 := if(in_hphnpop = 0, phn0_mod, phn1_mod);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.adl_addr := adl_addr;
		SELF.adl_hphn := adl_hphn;
		SELF.adl_ssn := adl_ssn;
		SELF.missing_lvl := missing_lvl;
		SELF.c_span_lang := c_span_lang;
		SELF.c_many_cars := c_many_cars;
		SELF.in_hphnpop := in_hphnpop;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_phonetype := rc_phonetype;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_source_count := add1_source_count;
		SELF.add1_eda_sourced := add1_eda_sourced;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_nhood_vacant_properties := add1_nhood_vacant_properties;
		SELF.addrs_10yr := addrs_10yr;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.inq_collection_count := inq_collection_count;
		SELF.inq_collection_count03 := inq_collection_count03;
		SELF.inq_auto_count03 := inq_auto_count03;
		SELF.inq_auto_count06 := inq_auto_count06;
		SELF.inq_banking_count03 := inq_banking_count03;
		SELF.inq_banking_count06 := inq_banking_count06;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.inq_retail_count03 := inq_retail_count03;
		SELF.inq_retail_count06 := inq_retail_count06;
		SELF.inq_communications_count := inq_communications_count;
		SELF.inq_communications_count03 := inq_communications_count03;
		SELF.inq_communications_count06 := inq_communications_count06;
		SELF.inq_other_count03 := inq_other_count03;
		SELF.inq_other_count06 := inq_other_count06;
		SELF.disposition := disposition;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.rel_count := rel_count;
		SELF.rel_prop_owned_count := rel_prop_owned_count;
		SELF.rel_prop_sold_count := rel_prop_sold_count;
		SELF.rel_homeunder150_count := rel_homeunder150_count;
		SELF.rel_homeunder200_count := rel_homeunder200_count;
		SELF.rel_homeunder300_count := rel_homeunder300_count;
		SELF.rel_homeunder500_count := rel_homeunder500_count;
		SELF.rel_homeover500_count := rel_homeover500_count;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.estimated_income := estimated_income;

		/* Model Intermediate Variables */
		SELF.s1_inq_coll_hrcred_comm_lvl := s1_inq_coll_hrcred_comm_lvl;
		SELF.s1_add1_naprop_lvl := s1_add1_naprop_lvl;
		SELF.match_lvl := match_lvl;
		SELF.s1_adl_match_lvl := s1_adl_match_lvl;
		SELF.ssns_per_adl_lvl := ssns_per_adl_lvl;
		SELF.rel_prop_own_pct := rel_prop_own_pct;
		SELF.rel_prop_sold_pct := rel_prop_sold_pct;
		SELF.s1_rel_prop_sold_pct_a := s1_rel_prop_sold_pct_a;
		SELF.c_span_lang_lvl := c_span_lang_lvl;
		SELF.other_inq_count03 := other_inq_count03;
		SELF.other_inq_count06 := other_inq_count06;
		SELF.other_recent_inq_lvl := other_recent_inq_lvl;
		SELF.s0_estimated_income_lvl := s0_estimated_income_lvl;
		SELF.ams_attended_college := ams_attended_college;
		SELF.c_many_cars_lvl := c_many_cars_lvl;
		SELF.s0_addrs_yr_lvl := s0_addrs_yr_lvl;
		SELF.rel_home500plus_count := rel_home500plus_count;
		SELF.rel_home300plus_count := rel_home300plus_count;
		SELF.rel_home200plus_count := rel_home200plus_count;
		SELF.rel_home150plus_count := rel_home150plus_count;
		SELF.rel_home100plus_count := rel_home100plus_count;
		SELF.rel_home150plus_pct := rel_home150plus_pct;
		SELF.rel_home100plus_pct := rel_home100plus_pct;
		SELF.rel_home300plus_pct := rel_home300plus_pct;
		SELF.rel_home200plus_pct := rel_home200plus_pct;
		SELF.s1_rel_nicehome := s1_rel_nicehome;
		SELF.s1_add1_nhood_vacant_prop_flag := s1_add1_nhood_vacant_prop_flag;
		SELF.s1_criminal_lvl := s1_criminal_lvl;
		SELF.s1_estimated_income_lvl := s1_estimated_income_lvl;
		SELF.s1_last_coll_hrcred_inq_lvl := s1_last_coll_hrcred_inq_lvl;
		SELF.s1_liens_unreleased_lvl := s1_liens_unreleased_lvl;
		SELF.s0_criminal_lvl := s0_criminal_lvl;
		SELF.s1_rel_prop_own_pct_a := s1_rel_prop_own_pct_a;
		SELF._disposition := _disposition;
		SELF.bk_level := bk_level;
		SELF.s1_add1_source_lvl := s1_add1_source_lvl;
		SELF.phn_disconnected := phn_disconnected;
		SELF.phn_inval := phn_inval;
		SELF.phn_nonus := phn_nonus;
		SELF.phn_highrisk := phn_highrisk;
		SELF.phn_cell := phn_cell;
		SELF.s1_phone_prob := s1_phone_prob;
		SELF.p0_subscore0 := p0_subscore0;
		SELF.p0_subscore1 := p0_subscore1;
		SELF.p0_subscore2 := p0_subscore2;
		SELF.p0_subscore3 := p0_subscore3;
		SELF.p0_subscore4 := p0_subscore4;
		SELF.p0_subscore5 := p0_subscore5;
		SELF.p0_subscore6 := p0_subscore6;
		SELF.p0_subscore7 := p0_subscore7;
		SELF.p0_subscore8 := p0_subscore8;
		SELF.p0_subscore9 := p0_subscore9;
		SELF.p0_subscore10 := p0_subscore10;
		SELF.p0_subscore11 := p0_subscore11;
		SELF.p0_subscore12 := p0_subscore12;
		SELF.p0_subscore13 := p0_subscore13;
		SELF.phn0_subscore_total := phn0_subscore_total;
		SELF.phn0_mod := phn0_mod;
		SELF.p1_subscore0 := p1_subscore0;
		SELF.p1_subscore1 := p1_subscore1;
		SELF.p1_subscore2 := p1_subscore2;
		SELF.p1_subscore3 := p1_subscore3;
		SELF.p1_subscore4 := p1_subscore4;
		SELF.p1_subscore5 := p1_subscore5;
		SELF.p1_subscore6 := p1_subscore6;
		SELF.p1_subscore7 := p1_subscore7;
		SELF.p1_subscore8 := p1_subscore8;
		SELF.p1_subscore9 := p1_subscore9;
		SELF.p1_subscore10 := p1_subscore10;
		SELF.p1_subscore11 := p1_subscore11;
		SELF.p1_subscore12 := p1_subscore12;
		SELF.p1_subscore13 := p1_subscore13;
		SELF.phn1_subscore_total := phn1_subscore_total;
		SELF.phn1_mod := phn1_mod;
		SELF.rsn1105_2_0 := rsn1105_2_0;

		SELF.clam := le;
	#else
		SELF.recover_score := (STRING3)rsn1105_2_0;
		SELF.seq := (STRING)le.seq;
	#end
	END;

	model := JOIN(clam, EASI.Key_Easi_Census, 
							KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
							doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.Max_Atmost), KEEP(1));

	RETURN(model);
END;

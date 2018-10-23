/*2016-02-17T22:44:43Z (brandon helm)
Modified to accept AJ's input.
*/
IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, RiskView;

export RVG1601_1_0 (grouped dataset(risk_indicators.Layout_Boca_Shell) clam, 
										dataset(riskview.layouts.Layout_Custom_Inputs) channel_inputs
										) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
				
		/* Model Input Variables */
		INTEGER seq;
		STRING tuln_channel;
		BOOLEAN truedid;
		INTEGER nas_summary;
		INTEGER nap_summary;
		INTEGER rc_ssndod;
		STRING rc_input_addr_not_most_recent;
		STRING rc_decsflag;
		STRING ver_sources;
		BOOLEAN addrpop;
		INTEGER ssnlength;
		BOOLEAN dobpop;
		BOOLEAN add_input_isbestmatch;
		INTEGER add_input_naprop;
		BOOLEAN add_input_pop;
		INTEGER property_owned_total;
		BOOLEAN add_curr_isbestmatch;
		INTEGER add_curr_lres;
		INTEGER add_curr_naprop;
		BOOLEAN add_curr_pop;
		INTEGER add_prev_naprop;
		INTEGER max_lres;
		INTEGER addrs_5yr;
		INTEGER addrs_10yr;
		UNSIGNED8 adls_per_ssn;
		INTEGER adls_per_addr_curr;
		INTEGER inq_count;
		INTEGER inq_count01;
		INTEGER inq_count03;
		INTEGER inq_count06;
		INTEGER inq_count12;
		INTEGER inq_count24;
		INTEGER inq_auto_count12;
		INTEGER inq_collection_count12;
		INTEGER inq_communications_count;
		INTEGER inq_communications_count01;
		INTEGER inq_communications_count03;
		INTEGER inq_communications_count06;
		INTEGER inq_communications_count12;
		INTEGER inq_communications_count24;
		INTEGER inq_highriskcredit_count;
		INTEGER inq_highriskcredit_count01;
		INTEGER inq_highriskcredit_count03;
		INTEGER inq_highriskcredit_count06;
		INTEGER inq_highriskcredit_count12;
		INTEGER inq_highriskcredit_count24;
		STRING pb_total_dollars;
		STRING pb_total_orders;
		INTEGER infutor_nap;
		INTEGER stl_inq_count;
		INTEGER attr_num_aircraft;
		UNSIGNED1 attr_eviction_count;
		UNSIGNED1 attr_eviction_count90;
		UNSIGNED1 attr_eviction_count180;
		UNSIGNED1 attr_eviction_count12;
		UNSIGNED1 attr_eviction_count24;
		UNSIGNED1 attr_eviction_count36;
		UNSIGNED1 attr_eviction_count60;
		BOOLEAN bankrupt;
		STRING disposition;
		INTEGER filing_count;
		INTEGER bk_dismissed_recent_count;
		INTEGER bk_dismissed_historical_count;
		INTEGER bk_disposed_recent_count;
		INTEGER bk_disposed_historical_count;
		INTEGER criminal_count;
		INTEGER felony_count;
		INTEGER watercraft_count;
		STRING input_dob_match_level;

		/* Model Intermediate Variables */
		// STRING NULL;
		// BOOLEAN indexw(string source, string target, string delim);
		INTEGER sysdate;
		STRING rv_d32_criminal_x_felony;
		STRING rv_d31_all_bk;
		STRING rv_d33_eviction_recency;
		UNSIGNED8 rv_s66_adlperssn_count; // WAS STRING
		STRING rv_f03_address_match;
		INTEGER rv_c14_addrs_10yr;
		STRING rv_ever_asset_owner;
		INTEGER rv_i60_inq_auto_count12;
		INTEGER rv_i60_inq_hiriskcred_recency;
		INTEGER rv_i60_inq_comm_count12;
		INTEGER rv_l79_adls_per_addr_curr;
		INTEGER rv_a50_pb_total_dollars;
		STRING rv_f03_input_add_not_most_rec;
		INTEGER rv_d32_criminal_count;
		INTEGER rv_c21_stl_inq_count;
		INTEGER rv_c13_max_lres;
		STRING rv_prop_owner_history;
		INTEGER rv_a50_pb_total_orders;
		STRING rv_f00_input_dob_match_level;
		STRING rv_d31_mostrec_bk;
		INTEGER rv_c14_addrs_5yr;
		INTEGER rv_i61_inq_collection_count12;
		INTEGER rv_i60_inq_comm_recency;
		INTEGER rv_c13_curr_addr_lres;
		INTEGER rv_i60_inq_recency;
		REAL core_subscore0;
		REAL core_subscore1;
		REAL core_subscore2;
		REAL core_subscore3;
		REAL core_subscore4;
		REAL core_subscore5;
		REAL core_subscore6;
		REAL core_subscore7;
		REAL core_subscore8;
		REAL core_subscore9;
		REAL core_subscore10;
		REAL core_subscore11;
		REAL core_rawscore;
		REAL core_lnoddsscore;
		REAL core_probscore;
		STRING core_aacd_0;
		REAL core_dist_0;
		STRING core_aacd_1;
		REAL core_dist_1;
		STRING core_aacd_2;
		REAL core_dist_2;
		STRING core_aacd_3;
		REAL core_dist_3;
		STRING core_aacd_4;
		REAL core_dist_4;
		STRING core_aacd_5;
		REAL core_dist_5;
		STRING core_aacd_6;
		REAL core_dist_6;
		STRING core_aacd_7;
		REAL core_dist_7;
		STRING core_aacd_8;
		REAL core_dist_8;
		STRING core_aacd_9;
		REAL core_dist_9;
		STRING core_aacd_10;
		REAL core_dist_10;
		STRING core_aacd_11;
		REAL core_dist_11;
		REAL core_rcvaluel79;
		REAL core_rcvaluea40;
		REAL core_rcvalued32;
		REAL core_rcvalued33;
		REAL core_rcvalued31;
		REAL core_rcvaluea50;
		REAL core_rcvaluei60;
		REAL core_rcvaluef03;
		REAL core_rcvaluec13;
		REAL core_rcvalues66;
		REAL core_rcvaluec14;
		REAL kmart_subscore0;
		REAL kmart_subscore1;
		REAL kmart_subscore2;
		REAL kmart_subscore3;
		REAL kmart_subscore4;
		REAL kmart_subscore5;
		REAL kmart_subscore6;
		REAL kmart_subscore7;
		REAL kmart_subscore8;
		REAL kmart_subscore9;
		REAL kmart_subscore10;
		REAL kmart_rawscore;
		REAL kmart_lnoddsscore;
		REAL kmart_probscore;
		STRING kmart_aacd_0;
		REAL kmart_dist_0;
		STRING kmart_aacd_1;
		REAL kmart_dist_1;
		STRING kmart_aacd_2;
		REAL kmart_dist_2;
		STRING kmart_aacd_3;
		REAL kmart_dist_3;
		STRING kmart_aacd_4;
		REAL kmart_dist_4;
		STRING kmart_aacd_5;
		REAL kmart_dist_5;
		STRING kmart_aacd_6;
		REAL kmart_dist_6;
		STRING kmart_aacd_7;
		REAL kmart_dist_7;
		STRING kmart_aacd_8;
		REAL kmart_dist_8;
		STRING kmart_aacd_9;
		REAL kmart_dist_9;
		STRING kmart_aacd_10;
		REAL kmart_dist_10;
		REAL kmart_rcvaluel79;
		REAL kmart_rcvalued32;
		REAL kmart_rcvalued33;
		REAL kmart_rcvalued31;
		REAL kmart_rcvaluea50;
		REAL kmart_rcvaluec21;
		REAL kmart_rcvaluei60;
		REAL kmart_rcvaluef03;
		REAL kmart_rcvaluea41;
		REAL kmart_rcvaluec13;
		REAL kmart_rcvaluea42;
		REAL sears_subscore0;
		REAL sears_subscore1;
		REAL sears_subscore2;
		REAL sears_subscore3;
		REAL sears_subscore4;
		REAL sears_subscore5;
		REAL sears_subscore6;
		REAL sears_subscore7;
		REAL sears_subscore8;
		REAL sears_subscore9;
		REAL sears_subscore10;
		REAL sears_subscore11;
		REAL sears_subscore12;
		REAL sears_subscore13;
		REAL sears_rawscore;
		REAL sears_lnoddsscore;
		REAL sears_probscore;
		STRING sears_aacd_0;
		REAL sears_dist_0;
		STRING sears_aacd_1;
		REAL sears_dist_1;
		STRING sears_aacd_2;
		REAL sears_dist_2;
		STRING sears_aacd_3;
		REAL sears_dist_3;
		STRING sears_aacd_4;
		REAL sears_dist_4;
		STRING sears_aacd_5;
		REAL sears_dist_5;
		STRING sears_aacd_6;
		REAL sears_dist_6;
		STRING sears_aacd_7;
		REAL sears_dist_7;
		STRING sears_aacd_8;
		REAL sears_dist_8;
		STRING sears_aacd_9;
		REAL sears_dist_9;
		STRING sears_aacd_10;
		REAL sears_dist_10;
		STRING sears_aacd_11;
		REAL sears_dist_11;
		STRING sears_aacd_12;
		REAL sears_dist_12;
		STRING sears_aacd_13;
		REAL sears_dist_13;
		REAL sears_rcvaluel79;
		REAL sears_rcvaluei61;
		REAL sears_rcvalued32;
		REAL sears_rcvalued33;
		REAL sears_rcvalued31;
		REAL sears_rcvaluea50;
		REAL sears_rcvaluec21;
		REAL sears_rcvaluei60;
		REAL sears_rcvaluef00;
		REAL sears_rcvaluef03;
		REAL sears_rcvaluea41;
		REAL sears_rcvaluec13;
		REAL sears_rcvaluea42;
		REAL sears_rcvaluec14;
		REAL wnli_subscore0;
		REAL wnli_subscore1;
		REAL wnli_subscore2;
		REAL wnli_subscore3;
		REAL wnli_subscore4;
		REAL wnli_subscore5;
		REAL wnli_rawscore;
		REAL wnli_lnoddsscore;
		REAL wnli_probscore;
		STRING wnli_aacd_0;
		REAL wnli_dist_0;
		STRING wnli_aacd_1;
		REAL wnli_dist_1;
		STRING wnli_aacd_2;
		REAL wnli_dist_2;
		STRING wnli_aacd_3;
		REAL wnli_dist_3;
		STRING wnli_aacd_4;
		REAL wnli_dist_4;
		STRING wnli_aacd_5;
		REAL wnli_dist_5;
		REAL wnli_rcvaluec13;
		REAL wnli_rcvaluei60;
		REAL wnli_rcvaluea40;
		REAL wnli_rcvaluef03;
		REAL wnli_rcvalued31;
		STRING wnli_segment;
		BOOLEAN iv_rv5_deceased;
		STRING iv_rv5_unscorable;
		INTEGER base;
		INTEGER pts;
		REAL odds;
		REAL probscore;
		INTEGER rvg1601_1_0_score;
		// STRING ds_layout;
		// STRING rc_dataset_core;
		// STRING rc_dataset_core_sorted;
		// STRING rc_dataset_wnli;
		// STRING rc_dataset_wnli_sorted;
		// STRING rc_dataset_kmart;
		// STRING rc_dataset_kmart_sorted;
		// STRING rc_dataset_sears;
		// STRING rc_dataset_sears_sorted;
		STRING core_rc1;			// Was commented out
		STRING core_rc2;
		STRING core_rc3;
		STRING core_rc4;
		STRING wnli_rc1;
		STRING wnli_rc2;
		STRING wnli_rc3;
		STRING wnli_rc4;
		STRING kmart_rc1;
		STRING kmart_rc2;
		STRING kmart_rc3;
		STRING kmart_rc4;
		STRING sears_rc1;
		STRING sears_rc2;
		STRING sears_rc3;
		STRING sears_rc4;
		STRING rc1_2;
		STRING rc2_2;
		STRING rc3_2;
		STRING rc4_2;
		STRING4 _rc_inq;
		STRING rc4_c122;
		STRING rc1_c122;
		STRING rc3_c122;
		STRING rc5_c122;
		STRING rc2_c122;
		STRING rc5_1;
		// STRING rc3_1;
		// STRING rc4_1;
		// STRING rc1_1;
		// STRING rc2_1;					// Was commented out
		STRING4 rc1;
		STRING4 rc2;
		STRING4 rc3;
		STRING4 rc4;
		STRING4 rc5;
		
		Risk_Indicators.Layout_Boca_Shell clam;
		
		END;
		
		Layout_Debug doModel(clam le, channel_inputs rt) := TRANSFORM
		#else

		Layout_ModelOut doModel(clam le, channel_inputs rt) := TRANSFORM
		#end

	/* *************************************************************
	   *             Model Input Variable Assignments              *
	   ************************************************************* */
	seq															 := le.seq;
	tuln_channel                     := stringlib.stringtouppercase(trim(rt.Custom_Inputs(stringlib.stringtolowercase(OptionName)='tuln_channel')[1].OptionValue));
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := (string)le.iid.inputaddrnotmostrecent;  // cast as string
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (integer)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_dollars                 := (string)le.ibehavior.total_dollars;  // cast as string
	pb_total_orders                  := (string)le.ibehavior.total_number_of_orders; // cast as string
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	UNSIGNED8 NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	
	BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
	// sysdate := common.sas_date('20150501');
	
	rv_d32_criminal_x_felony := if(not(truedid), '', 
			(trim((string)(min(if(criminal_count = NULL, -NULL, criminal_count), 3)), LEFT, RIGHT)
			+ trim('-', LEFT, RIGHT) 
			+ trim((string)(min(if(felony_count = NULL, -NULL, felony_count), 3)), LEFT, RIGHT)));
	
	
	rv_d31_all_bk := map(
	    not(truedid)                                                                                                                                                                                                                                                                                                   => '',
	    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => '1 - BK DISMISSED ',
	    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => '2 - BK DISCHARGED',
	    bankrupt or filing_count > 0                                                                                                                                                                                                                                                                              		 => '3 - BK OTHER     ',
	                                                                                                                                                                                                                                                                                                                      '0 - NO BK        ');

	rv_d33_eviction_recency := map(
	    not(truedid)                                                => '  ',
	    (boolean)attr_eviction_count90                              => '03',
	    (boolean)attr_eviction_count180                             => '06',
	    (boolean)attr_eviction_count12                              => '12',
	    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => '24',
	    (boolean)attr_eviction_count24                              => '25',
	    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => '36',
	    (boolean)attr_eviction_count36                              => '37',
	    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
	    (boolean)attr_eviction_count60                              => '61',
	    attr_eviction_count >= 2                                    => '98',
	    attr_eviction_count >= 1                                    => '99',
	                                                                   '00');
	
	rv_s66_adlperssn_count := map(
	    not (ssnlength > 0) 		=> NULL,
	    (adls_per_ssn = 0)  		=> 1,
	                        min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	rv_f03_address_match := map(
	    not(truedid)                                => '                          ',
	    add_input_isbestmatch                       => '4 INPUT=CURR              ',
	    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
	    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
	    add_curr_pop                                => '1 CURR ONHDRONLY          ',
	    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
	                                                   '');
	
	rv_c14_addrs_10yr := map(
	    not(truedid)     => NULL,
	    (integer)add_curr_pop = 0 => -1,  // cast as integer
	                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
																																																																						
	rv_ever_asset_owner := map(
	    not(truedid)                                                                                                                                                                                                 => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => '1',  // fixed delimiters
	                                                                                                                                                                                                                    '0');
	
	rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));
	
	rv_i60_inq_hiriskcred_recency := map(
	    not(truedid)               => NULL,
	    (boolean)inq_highRiskCredit_count01 => 1,  // cast all variables as boolean
	    (boolean)inq_highRiskCredit_count03 => 3,
	    (boolean)inq_highRiskCredit_count06 => 6,
	    (boolean)inq_highRiskCredit_count12 => 12,
	    (boolean)inq_highRiskCredit_count24 => 24,
	    (boolean)inq_highRiskCredit_count   => 99,
																					0);
	
	rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));
	
	rv_l79_adls_per_addr_curr := if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));
	
	rv_a50_pb_total_dollars := map(
	    not(truedid)          => NULL,
	    pb_total_dollars = '' => -1,  // changed comparison from NULL to ''
	                          (integer)pb_total_dollars); // cast as integer
	
	// This is simply a casting statement with some formatting options, potentially not even needed.
	rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), '', (string)((integer)rc_input_addr_not_most_recent));  // eliminated the following SAS function: put(rc_input_addr_not_most_recent, 1.)
	
	rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
	rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));
	
	rv_c13_max_lres := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));
	
	rv_prop_owner_history := map(
	    not(truedid)                                                                     => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
	    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',  // fixed delimiters
	                                                                                        'NEVER');
	
	rv_a50_pb_total_orders := map(
	    not(truedid)           => NULL,
	    pb_total_orders = ''   => -1,  // changed comparison from NULL to ''
	                           (integer)pb_total_orders);
	
	rv_f00_input_dob_match_level := if(not(truedid and dobpop), ' ', input_dob_match_level);
	
	rv_d31_mostrec_bk := map(
	    not(truedid)                                                         		=> '',
	    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1     => '1 - BK DISMISSED ',
	    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 		=> '2 - BK DISCHARGED',
	    bankrupt or filing_count > 0                                     				=> '3 - BK OTHER     ',
																																								 '0 - NO BK        ');
	
	rv_c14_addrs_5yr := map(
	    not(truedid)     => NULL,
	    (integer)add_curr_pop = 0 => -1, // cast as integer
	                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));
	
	rv_i60_inq_comm_recency := map(
	    not(truedid)               					=> NULL,
	    (boolean)inq_communications_count01 => 1,
	    (boolean)inq_communications_count03 => 3,
	    (boolean)inq_communications_count06 => 6,
	    (boolean)inq_communications_count12 => 12,
	    (boolean)inq_communications_count24 => 24,
	    (boolean)inq_communications_count   => 99,
																					0);
	
	rv_c13_curr_addr_lres := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
	
	rv_i60_inq_recency := map(
	    not(truedid) 					=> NULL,
	    (boolean)inq_count01  => 1,
	    (boolean)inq_count03  => 3,
	    (boolean)inq_count06  => 6,
	    (boolean)inq_count12  => 12,
	    (boolean)inq_count24  => 24,
	    (boolean)inq_count    => 99,
														0);
	
	core_subscore0 := map(
	    (rv_ever_asset_owner in [' ']) => 0,
	    (rv_ever_asset_owner in ['0']) => -0.150982,
	    (rv_ever_asset_owner in ['1']) => 0.389639,
	                                      0);
	
	core_subscore1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.077503,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.830282,
	    6 <= rv_i60_inq_hiriskcred_recency                                         => -0.329141,
	                                                                                  0);
	
	core_subscore2 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.066542,
	    1 <= rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2   => -0.400508,
	    2 <= rv_i60_inq_comm_count12                                   => -0.623137,
	                                                                      0);
	
	core_subscore3 := map(
	    (rv_d33_eviction_recency in [' '])                          => 0,
	    (rv_d33_eviction_recency in ['00'])                         => 0.075501,
	    (rv_d33_eviction_recency in ['03', '06'])                   => -0.519107,
	    (rv_d33_eviction_recency in ['12', '24', '25', '36'])       => -0.36742,
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => -0.262631,
	                                                                   0);
	
	core_subscore4 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 0 => 0,
	    0 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1   => 0.282459,
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 0.143812,
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 0.088237,
	    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => -0.07551,
	    5 <= rv_c14_addrs_10yr                             => -0.213441,
	                                                          0);
	
	core_subscore5 := map(
	    (rv_f03_address_match in [' '])                                                                        => 0,
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.184284,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 0.143533,
	                                                                                                              0);
	
	core_subscore6 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => -0.116344,
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 179 => 0.000477,
	    179 <= rv_a50_pb_total_dollars                                 => 0.298138,
	                                                                      0);
	
	core_subscore7 := map(
	    (rv_d31_all_bk in [' '])                                              => 0,
	    (rv_d31_all_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 0.021015,
	    (rv_d31_all_bk in ['1 - BK DISMISSED'])                               => -0.541249,
	                                                                             0);
	
	core_subscore8 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6 => 0.026923,
	    6 <= rv_l79_adls_per_addr_curr                                     => -0.390209,
	                                                                          0);
	
	core_subscore9 := map(
	    (rv_d32_criminal_x_felony in [''])                                      => 0,
	    (rv_d32_criminal_x_felony in ['0-0'])                                    => 0.018889,
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => -0.350082,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.857358,
	                                                                                0);
	
	core_subscore10 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 0.058006,
	    1 <= rv_i60_inq_auto_count12                                   => -0.151842,
	                                                                      0);
	
	core_subscore11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 0.032889,
	    3 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 4   => -0.128587,
	    4 <= rv_s66_adlperssn_count                                  => -0.405853,
	                                                                    0);
	
	core_rawscore := core_subscore0 +
	    core_subscore1 +
	    core_subscore2 +
	    core_subscore3 +
	    core_subscore4 +
	    core_subscore5 +
	    core_subscore6 +
	    core_subscore7 +
	    core_subscore8 +
	    core_subscore9 +
	    core_subscore10 +
	    core_subscore11;
	
	core_lnoddsscore := core_rawscore + 1.463679;
	
	core_probscore := exp(core_lnoddsscore) / (1 + exp(core_lnoddsscore));
	
	core_aacd_0 := map(
	    (rv_ever_asset_owner in [' ']) => '',
	    (rv_ever_asset_owner in ['0']) => 'A40',
	    (rv_ever_asset_owner in ['1']) => 'A40',
	                                      '');
	
	core_dist_0 := core_subscore0 - 0.389639;
	
	/* **************************************************************************** */
	/* **************************************************************************** */
	core_aacd_1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
	    6 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
	                                                                                  '');
	
	core_dist_1 := core_subscore1 - 0.077503;
	
	core_aacd_2 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2   => 'I60',
	    2 <= rv_i60_inq_comm_count12                                   => 'I60',
	                                                                      '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	
	core_dist_2 := core_subscore2 - 0.066542;
	
	core_aacd_3 := map(
	    (rv_d33_eviction_recency in [' '])                          => '',
	    (rv_d33_eviction_recency in ['00'])                         => 'D33',
	    (rv_d33_eviction_recency in ['03', '06'])                   => 'D33',
	    (rv_d33_eviction_recency in ['12', '24', '25', '36'])       => 'D33',
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => 'D33',
	                                                                   '');
	
	core_dist_3 := core_subscore3 - 0.075501;
	
	core_aacd_4 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 0 => 'C13',
	    0 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1   => 'C14',
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 'C14',
	    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 'C14',
	    5 <= rv_c14_addrs_10yr                             => 'C14',
	                                                          'C13');
	
	core_dist_4 := core_subscore4 - 0.282459;
	
	core_aacd_5 := map(
	    (rv_f03_address_match in [' '])                                                                        => '',
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 'F03',
	                                                                                                              '');
	
	core_dist_5 := core_subscore5 - 0.143533;
	
	core_aacd_6 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => 'A50',
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 179 => 'A50',
	    179 <= rv_a50_pb_total_dollars                                 => 'A50',
	                                                                      '');
	
	// core_dist_6 := core_subscore6 - 0.298138;
	core_dist_6 := 0;  // Hard coded to 0 to remove ibehavior reason codes
	
	core_aacd_7 := map(
	    (rv_d31_all_bk in [' '])                                              => '',
	    (rv_d31_all_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 'D31',
	    (rv_d31_all_bk in ['1 - BK DISMISSED'])                               => 'D31',
	                                                                             '');
	
	core_dist_7 := core_subscore7 - 0.021015;
	
	core_aacd_8 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6 => 'L79',
	    6 <= rv_l79_adls_per_addr_curr                                     => 'L79',
	                                                                          'C13');
	
	core_dist_8 := core_subscore8 - 0.026923;
	
	core_aacd_9 := map(
	    (rv_d32_criminal_x_felony in [' '])                                      => '',
	    (rv_d32_criminal_x_felony in ['0-0'])                                    => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 'D32',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                '');
	
	core_dist_9 := core_subscore9 - 0.018889;

	/* **************************************************************************** */
	/* **************************************************************************** */
	core_aacd_10 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_auto_count12                                   => 'I60',
	                                                                      '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	core_dist_10 := core_subscore10 - 0.058006;
	
	core_aacd_11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 'S66',
	    3 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 4   => 'S66',
	    4 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	core_dist_11 := core_subscore11 - 0.032889;
	
	core_rcvaluel79 := (integer)(core_aacd_0 = 'L79') * core_dist_0 +
	    (integer)(core_aacd_1 = 'L79') * core_dist_1 +
	    (integer)(core_aacd_2 = 'L79') * core_dist_2 +
	    (integer)(core_aacd_3 = 'L79') * core_dist_3 +
	    (integer)(core_aacd_4 = 'L79') * core_dist_4 +
	    (integer)(core_aacd_5 = 'L79') * core_dist_5 +
	    (integer)(core_aacd_6 = 'L79') * core_dist_6 +
	    (integer)(core_aacd_7 = 'L79') * core_dist_7 +
	    (integer)(core_aacd_8 = 'L79') * core_dist_8 +
	    (integer)(core_aacd_9 = 'L79') * core_dist_9 +
	    (integer)(core_aacd_10 = 'L79') * core_dist_10 +
	    (integer)(core_aacd_11 = 'L79') * core_dist_11;
	
	core_rcvaluea40 := (integer)(core_aacd_0 = 'A40') * core_dist_0 +
	    (integer)(core_aacd_1 = 'A40') * core_dist_1 +
	    (integer)(core_aacd_2 = 'A40') * core_dist_2 +
	    (integer)(core_aacd_3 = 'A40') * core_dist_3 +
	    (integer)(core_aacd_4 = 'A40') * core_dist_4 +
	    (integer)(core_aacd_5 = 'A40') * core_dist_5 +
	    (integer)(core_aacd_6 = 'A40') * core_dist_6 +
	    (integer)(core_aacd_7 = 'A40') * core_dist_7 +
	    (integer)(core_aacd_8 = 'A40') * core_dist_8 +
	    (integer)(core_aacd_9 = 'A40') * core_dist_9 +
	    (integer)(core_aacd_10 = 'A40') * core_dist_10 +
	    (integer)(core_aacd_11 = 'A40') * core_dist_11;
	
	core_rcvalued32 := (integer)(core_aacd_0 = 'D32') * core_dist_0 +
	    (integer)(core_aacd_1 = 'D32') * core_dist_1 +
	    (integer)(core_aacd_2 = 'D32') * core_dist_2 +
	    (integer)(core_aacd_3 = 'D32') * core_dist_3 +
	    (integer)(core_aacd_4 = 'D32') * core_dist_4 +
	    (integer)(core_aacd_5 = 'D32') * core_dist_5 +
	    (integer)(core_aacd_6 = 'D32') * core_dist_6 +
	    (integer)(core_aacd_7 = 'D32') * core_dist_7 +
	    (integer)(core_aacd_8 = 'D32') * core_dist_8 +
	    (integer)(core_aacd_9 = 'D32') * core_dist_9 +
	    (integer)(core_aacd_10 = 'D32') * core_dist_10 +
	    (integer)(core_aacd_11 = 'D32') * core_dist_11;
	
	core_rcvalued33 := (integer)(core_aacd_0 = 'D33') * core_dist_0 +
	    (integer)(core_aacd_1 = 'D33') * core_dist_1 +
	    (integer)(core_aacd_2 = 'D33') * core_dist_2 +
	    (integer)(core_aacd_3 = 'D33') * core_dist_3 +
	    (integer)(core_aacd_4 = 'D33') * core_dist_4 +
	    (integer)(core_aacd_5 = 'D33') * core_dist_5 +
	    (integer)(core_aacd_6 = 'D33') * core_dist_6 +
	    (integer)(core_aacd_7 = 'D33') * core_dist_7 +
	    (integer)(core_aacd_8 = 'D33') * core_dist_8 +
	    (integer)(core_aacd_9 = 'D33') * core_dist_9 +
	    (integer)(core_aacd_10 = 'D33') * core_dist_10 +
	    (integer)(core_aacd_11 = 'D33') * core_dist_11;
	
	core_rcvalued31 := (integer)(core_aacd_0 = 'D31') * core_dist_0 +
	    (integer)(core_aacd_1 = 'D31') * core_dist_1 +
	    (integer)(core_aacd_2 = 'D31') * core_dist_2 +
	    (integer)(core_aacd_3 = 'D31') * core_dist_3 +
	    (integer)(core_aacd_4 = 'D31') * core_dist_4 +
	    (integer)(core_aacd_5 = 'D31') * core_dist_5 +
	    (integer)(core_aacd_6 = 'D31') * core_dist_6 +
	    (integer)(core_aacd_7 = 'D31') * core_dist_7 +
	    (integer)(core_aacd_8 = 'D31') * core_dist_8 +
	    (integer)(core_aacd_9 = 'D31') * core_dist_9 +
	    (integer)(core_aacd_10 = 'D31') * core_dist_10 +
	    (integer)(core_aacd_11 = 'D31') * core_dist_11;
	
	core_rcvaluea50 := (integer)(core_aacd_0 = 'A50') * core_dist_0 +
	    (integer)(core_aacd_1 = 'A50') * core_dist_1 +
	    (integer)(core_aacd_2 = 'A50') * core_dist_2 +
	    (integer)(core_aacd_3 = 'A50') * core_dist_3 +
	    (integer)(core_aacd_4 = 'A50') * core_dist_4 +
	    (integer)(core_aacd_5 = 'A50') * core_dist_5 +
	    (integer)(core_aacd_6 = 'A50') * core_dist_6 +
	    (integer)(core_aacd_7 = 'A50') * core_dist_7 +
	    (integer)(core_aacd_8 = 'A50') * core_dist_8 +
	    (integer)(core_aacd_9 = 'A50') * core_dist_9 +
	    (integer)(core_aacd_10 = 'A50') * core_dist_10 +
	    (integer)(core_aacd_11 = 'A50') * core_dist_11;
	
	core_rcvaluei60 := (integer)(core_aacd_0 = 'I60') * core_dist_0 +
	    (integer)(core_aacd_1 = 'I60') * core_dist_1 +
	    (integer)(core_aacd_2 = 'I60') * core_dist_2 +
	    (integer)(core_aacd_3 = 'I60') * core_dist_3 +
	    (integer)(core_aacd_4 = 'I60') * core_dist_4 +
	    (integer)(core_aacd_5 = 'I60') * core_dist_5 +
	    (integer)(core_aacd_6 = 'I60') * core_dist_6 +
	    (integer)(core_aacd_7 = 'I60') * core_dist_7 +
	    (integer)(core_aacd_8 = 'I60') * core_dist_8 +
	    (integer)(core_aacd_9 = 'I60') * core_dist_9 +
	    (integer)(core_aacd_10 = 'I60') * core_dist_10 +
	    (integer)(core_aacd_11 = 'I60') * core_dist_11;
	
	core_rcvaluef03 := (integer)(core_aacd_0 = 'F03') * core_dist_0 +
	    (integer)(core_aacd_1 = 'F03') * core_dist_1 +
	    (integer)(core_aacd_2 = 'F03') * core_dist_2 +
	    (integer)(core_aacd_3 = 'F03') * core_dist_3 +
	    (integer)(core_aacd_4 = 'F03') * core_dist_4 +
	    (integer)(core_aacd_5 = 'F03') * core_dist_5 +
	    (integer)(core_aacd_6 = 'F03') * core_dist_6 +
	    (integer)(core_aacd_7 = 'F03') * core_dist_7 +
	    (integer)(core_aacd_8 = 'F03') * core_dist_8 +
	    (integer)(core_aacd_9 = 'F03') * core_dist_9 +
	    (integer)(core_aacd_10 = 'F03') * core_dist_10 +
	    (integer)(core_aacd_11 = 'F03') * core_dist_11;
	
	core_rcvaluec13 := (integer)(core_aacd_0 = 'C13') * core_dist_0 +
	    (integer)(core_aacd_1 = 'C13') * core_dist_1 +
	    (integer)(core_aacd_2 = 'C13') * core_dist_2 +
	    (integer)(core_aacd_3 = 'C13') * core_dist_3 +
	    (integer)(core_aacd_4 = 'C13') * core_dist_4 +
	    (integer)(core_aacd_5 = 'C13') * core_dist_5 +
	    (integer)(core_aacd_6 = 'C13') * core_dist_6 +
	    (integer)(core_aacd_7 = 'C13') * core_dist_7 +
	    (integer)(core_aacd_8 = 'C13') * core_dist_8 +
	    (integer)(core_aacd_9 = 'C13') * core_dist_9 +
	    (integer)(core_aacd_10 = 'C13') * core_dist_10 +
	    (integer)(core_aacd_11 = 'C13') * core_dist_11;
	
	core_rcvalues66 := (integer)(core_aacd_0 = 'S66') * core_dist_0 +
	    (integer)(core_aacd_1 = 'S66') * core_dist_1 +
	    (integer)(core_aacd_2 = 'S66') * core_dist_2 +
	    (integer)(core_aacd_3 = 'S66') * core_dist_3 +
	    (integer)(core_aacd_4 = 'S66') * core_dist_4 +
	    (integer)(core_aacd_5 = 'S66') * core_dist_5 +
	    (integer)(core_aacd_6 = 'S66') * core_dist_6 +
	    (integer)(core_aacd_7 = 'S66') * core_dist_7 +
	    (integer)(core_aacd_8 = 'S66') * core_dist_8 +
	    (integer)(core_aacd_9 = 'S66') * core_dist_9 +
	    (integer)(core_aacd_10 = 'S66') * core_dist_10 +
	    (integer)(core_aacd_11 = 'S66') * core_dist_11;
	
	core_rcvaluec14 := (integer)(core_aacd_0 = 'C14') * core_dist_0 +
	    (integer)(core_aacd_1 = 'C14') * core_dist_1 +
	    (integer)(core_aacd_2 = 'C14') * core_dist_2 +
	    (integer)(core_aacd_3 = 'C14') * core_dist_3 +
	    (integer)(core_aacd_4 = 'C14') * core_dist_4 +
	    (integer)(core_aacd_5 = 'C14') * core_dist_5 +
	    (integer)(core_aacd_6 = 'C14') * core_dist_6 +
	    (integer)(core_aacd_7 = 'C14') * core_dist_7 +
	    (integer)(core_aacd_8 = 'C14') * core_dist_8 +
	    (integer)(core_aacd_9 = 'C14') * core_dist_9 +
	    (integer)(core_aacd_10 = 'C14') * core_dist_10 +
	    (integer)(core_aacd_11 = 'C14') * core_dist_11;
	
	kmart_subscore0 := map(
	    (rv_prop_owner_history in [' '])          => 0,
	    (rv_prop_owner_history in ['CURRENT'])    => 0.314277,
	    (rv_prop_owner_history in ['HISTORICAL']) => 0.073167,
	    (rv_prop_owner_history in ['NEVER'])      => -0.13338,
	                                                 0);
	
	kmart_subscore1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.071426,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.662027,
	    6 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => -0.487022,
	    12 <= rv_i60_inq_hiriskcred_recency                                        => -0.402298,
	                                                                                  0);
	
	kmart_subscore2 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.187235,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 0.033314,
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 4   => 0.083037,
	    4 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 13  => 0.284315,
	    13 <= rv_a50_pb_total_orders                                 => 0.463551,
	                                                                    0);
	
	kmart_subscore3 := map(
	    (rv_d33_eviction_recency in [' '])                    => 0,
	    (rv_d33_eviction_recency in ['00'])                   => 0.058848,
	    (rv_d33_eviction_recency in ['03', '06'])             => -0.610371,
	    (rv_d33_eviction_recency in ['12', '24', '25', '36']) => -0.470189,
	    (rv_d33_eviction_recency in ['37', '60'])             => -0.346624,
	    (rv_d33_eviction_recency in ['61', '98', '99'])       => -0.230572,
	                                                             0);
	
	kmart_subscore4 := map(
	    NULL < rv_c13_max_lres AND rv_c13_max_lres < 38  => -0.229814,
	    38 <= rv_c13_max_lres AND rv_c13_max_lres < 104  => -0.080766,
	    104 <= rv_c13_max_lres AND rv_c13_max_lres < 158 => 0.012533,
	    158 <= rv_c13_max_lres AND rv_c13_max_lres < 197 => 0.093528,
	    197 <= rv_c13_max_lres                           => 0.214433,
	                                                        0);
	
	kmart_subscore5 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.041168,
	    1 <= rv_i60_inq_comm_count12                                   => -0.377177,
	                                                                      0);
	
	kmart_subscore6 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3 => 0.096861,
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => -0.069382,
	    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => -0.085542,
	    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => -0.163377,
	    6 <= rv_l79_adls_per_addr_curr                                     => -0.272408,
	                                                                          0);
	
	kmart_subscore7 := map(
	    (rv_f03_input_add_not_most_rec in [' ']) => 0,
	    (rv_f03_input_add_not_most_rec in ['0']) => 0.040638,
	    (rv_f03_input_add_not_most_rec in ['1']) => -0.19477,
	                                                0);
	
	kmart_subscore8 := map(
	    (rv_d31_all_bk in [' '])                                              => 0,
	    (rv_d31_all_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 0.017017,
	    (rv_d31_all_bk in ['1 - BK DISMISSED'])                               => -0.395084,
	                                                                             0);
	
	kmart_subscore9 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.03028,
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => -0.138461,
	    2 <= rv_c21_stl_inq_count                                => -0.318289,
	                                                                0);
	
	kmart_subscore10 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 0.010603,
	    1 <= rv_d32_criminal_count                                 => -0.333968,
	                                                                  0);
	
	kmart_rawscore := kmart_subscore0 +
	    kmart_subscore1 +
	    kmart_subscore2 +
	    kmart_subscore3 +
	    kmart_subscore4 +
	    kmart_subscore5 +
	    kmart_subscore6 +
	    kmart_subscore7 +
	    kmart_subscore8 +
	    kmart_subscore9 +
	    kmart_subscore10;
	
	kmart_lnoddsscore := kmart_rawscore + 1.610078;
	
	kmart_probscore := exp(kmart_lnoddsscore) / (1 + exp(kmart_lnoddsscore));
	
	kmart_aacd_0 := map(
	    (rv_prop_owner_history in [' '])          => '',
	    (rv_prop_owner_history in ['CURRENT'])    => '',
	    (rv_prop_owner_history in ['HISTORICAL']) => 'A42',
	    (rv_prop_owner_history in ['NEVER'])      => 'A41',
	                                                 '');
	
	kmart_dist_0 := kmart_subscore0 - 0.314277;

	/* **************************************************************************** */
	/* **************************************************************************** */
	kmart_aacd_1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
	    6 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => 'I60',
	    12 <= rv_i60_inq_hiriskcred_recency                                        => 'I60',
	                                                                                  '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	kmart_dist_1 := kmart_subscore1 - 0.071426;
	
	kmart_aacd_2 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 'A50',
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 4   => 'A50',
	    4 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 13  => 'A50',
	    13 <= rv_a50_pb_total_orders                                 => 'A50',
	                                                                    '');
	
	// kmart_dist_2 := kmart_subscore2 - 0.463551;
	KMart_DIST_2 := 0;	// Hard coded to 0 to remove ibehavior reason codes
	
	kmart_aacd_3 := map(
	    (rv_d33_eviction_recency in [' '])                    => '',
	    (rv_d33_eviction_recency in ['00'])                   => 'D33',
	    (rv_d33_eviction_recency in ['03', '06'])             => 'D33',
	    (rv_d33_eviction_recency in ['12', '24', '25', '36']) => 'D33',
	    (rv_d33_eviction_recency in ['37', '60'])             => 'D33',
	    (rv_d33_eviction_recency in ['61', '98', '99'])       => 'D33',
	                                                             '');
	
	kmart_dist_3 := kmart_subscore3 - 0.058848;
	
	kmart_aacd_4 := map(
	    NULL < rv_c13_max_lres AND rv_c13_max_lres < 38  => 'C13',
	    38 <= rv_c13_max_lres AND rv_c13_max_lres < 104  => 'C13',
	    104 <= rv_c13_max_lres AND rv_c13_max_lres < 158 => 'C13',
	    158 <= rv_c13_max_lres AND rv_c13_max_lres < 197 => 'C13',
	    197 <= rv_c13_max_lres                           => 'C13',
	                                                        'C13');
	
	kmart_dist_4 := kmart_subscore4 - 0.214433;
	

	/* **************************************************************************** */
	/* **************************************************************************** */
	kmart_aacd_5 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_comm_count12                                   => 'I60',
	                                                                      '');
	/* **************************************************************************** */
	/* **************************************************************************** */

	kmart_dist_5 := kmart_subscore5 - 0.041168;
	
	kmart_aacd_6 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3 => 'L79',
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => 'L79',
	    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => 'L79',
	    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => 'L79',
	    6 <= rv_l79_adls_per_addr_curr                                     => 'L79',
	                                                                          '');
	
	kmart_dist_6 := kmart_subscore6 - 0.096861;
	
	kmart_aacd_7 := map(
	    (rv_f03_input_add_not_most_rec in [' ']) => '',
	    (rv_f03_input_add_not_most_rec in ['0']) => 'F03',
	    (rv_f03_input_add_not_most_rec in ['1']) => 'F03',
	                                                '');
	
	kmart_dist_7 := kmart_subscore7 - 0.040638;
	
	kmart_aacd_8 := map(
	    (rv_d31_all_bk in [' '])                                              => '',
	    (rv_d31_all_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 'D31',
	    (rv_d31_all_bk in ['1 - BK DISMISSED'])                               => 'D31',
	                                                                             '');
	
	kmart_dist_8 := kmart_subscore8 - 0.017017;
	
	kmart_aacd_9 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count                                => 'C21',
	                                                                '');
	
	kmart_dist_9 := kmart_subscore9 - 0.03028;
	
	kmart_aacd_10 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 'D32',
	    1 <= rv_d32_criminal_count                                 => 'D32',
	                                                                  '');
	
	kmart_dist_10 := kmart_subscore10 - 0.010603;
	
	kmart_rcvaluel79 := (integer)(kmart_aacd_0 = 'L79') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'L79') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'L79') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'L79') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'L79') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'L79') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'L79') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'L79') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'L79') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'L79') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'L79') * kmart_dist_10;
	
	kmart_rcvalued32 := (integer)(kmart_aacd_0 = 'D32') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'D32') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'D32') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'D32') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'D32') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'D32') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'D32') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'D32') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'D32') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'D32') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'D32') * kmart_dist_10;
	
	kmart_rcvalued33 := (integer)(kmart_aacd_0 = 'D33') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'D33') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'D33') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'D33') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'D33') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'D33') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'D33') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'D33') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'D33') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'D33') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'D33') * kmart_dist_10;
	
	kmart_rcvalued31 := (integer)(kmart_aacd_0 = 'D31') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'D31') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'D31') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'D31') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'D31') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'D31') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'D31') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'D31') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'D31') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'D31') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'D31') * kmart_dist_10;
	
	kmart_rcvaluea50 := (integer)(kmart_aacd_0 = 'A50') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'A50') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'A50') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'A50') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'A50') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'A50') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'A50') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'A50') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'A50') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'A50') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'A50') * kmart_dist_10;
	
	kmart_rcvaluec21 := (integer)(kmart_aacd_0 = 'C21') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'C21') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'C21') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'C21') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'C21') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'C21') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'C21') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'C21') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'C21') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'C21') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'C21') * kmart_dist_10;
	
	kmart_rcvaluei60 := (integer)(kmart_aacd_0 = 'I60') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'I60') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'I60') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'I60') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'I60') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'I60') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'I60') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'I60') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'I60') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'I60') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'I60') * kmart_dist_10;
	
	kmart_rcvaluef03 := (integer)(kmart_aacd_0 = 'F03') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'F03') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'F03') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'F03') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'F03') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'F03') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'F03') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'F03') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'F03') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'F03') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'F03') * kmart_dist_10;
	
	kmart_rcvaluea41 := (integer)(kmart_aacd_0 = 'A41') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'A41') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'A41') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'A41') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'A41') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'A41') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'A41') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'A41') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'A41') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'A41') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'A41') * kmart_dist_10;
	
	kmart_rcvaluec13 := (integer)(kmart_aacd_0 = 'C13') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'C13') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'C13') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'C13') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'C13') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'C13') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'C13') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'C13') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'C13') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'C13') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'C13') * kmart_dist_10;
	
	kmart_rcvaluea42 := (integer)(kmart_aacd_0 = 'A42') * kmart_dist_0 +
	    (integer)(kmart_aacd_1 = 'A42') * kmart_dist_1 +
	    (integer)(kmart_aacd_2 = 'A42') * kmart_dist_2 +
	    (integer)(kmart_aacd_3 = 'A42') * kmart_dist_3 +
	    (integer)(kmart_aacd_4 = 'A42') * kmart_dist_4 +
	    (integer)(kmart_aacd_5 = 'A42') * kmart_dist_5 +
	    (integer)(kmart_aacd_6 = 'A42') * kmart_dist_6 +
	    (integer)(kmart_aacd_7 = 'A42') * kmart_dist_7 +
	    (integer)(kmart_aacd_8 = 'A42') * kmart_dist_8 +
	    (integer)(kmart_aacd_9 = 'A42') * kmart_dist_9 +
	    (integer)(kmart_aacd_10 = 'A42') * kmart_dist_10;
	
	sears_subscore0 := map(
	    (rv_prop_owner_history in [' '])          => 0,
	    (rv_prop_owner_history in ['CURRENT'])    => 0.267797,
	    (rv_prop_owner_history in ['HISTORICAL']) => 0.277933,
	    (rv_prop_owner_history in ['NEVER'])      => -0.16323,
	                                                 0);
	
	sears_subscore1 := map(
	    (rv_d33_eviction_recency in [' '])                    => 0,
	    (rv_d33_eviction_recency in ['00'])                   => 0.0697,
	    (rv_d33_eviction_recency in ['03', '06', '12', '24']) => -0.822894,
	    (rv_d33_eviction_recency in ['25', '36', '37', '60']) => -0.488389,
	    (rv_d33_eviction_recency in ['61', '98', '99'])       => -0.293584,
	                                                             0);
	
	sears_subscore2 := map(
	    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 0.058982,
	    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => -0.682343,
	    6 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 12  => -0.562959,
	    12 <= rv_i60_inq_comm_recency                                  => -0.395528,
	                                                                      0);
	
	sears_subscore3 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 0.067159,
	    1 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2   => -0.016099,
	    2 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 3   => -0.264377,
	    3 <= rv_i60_inq_auto_count12                                   => -0.554233,
	                                                                      0);
	
	sears_subscore4 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 0 => 0,
	    0 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1   => 0.148988,
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 0.056389,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => -0.122843,
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => -0.209028,
	    5 <= rv_c14_addrs_5yr                            => -0.280627,
	                                                        0);
	
	sears_subscore5 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.041574,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => -0.739215,
	    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.616214,
	    6 <= rv_i60_inq_hiriskcred_recency                                         => -0.225331,
	                                                                                  0);
	
	sears_subscore6 := map(
	    (rv_d32_criminal_x_felony in [' '])                                      => 0,
	    (rv_d32_criminal_x_felony in ['0-0'])                                    => 0.030468,
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => -0.478777,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.757227,
	                                                                                0);
	
	sears_subscore7 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.090994,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 0.015428,
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 5   => 0.022959,
	    5 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 7   => 0.21772,
	    7 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 16  => 0.308589,
	    16 <= rv_a50_pb_total_orders                                 => 0.474158,
	                                                                    0);
	
	sears_subscore8 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2 => -0.021874,
	    2 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3   => 0.166813,
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => -0.027754,
	    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => -0.03445,
	    6 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 7   => -0.24556,
	    7 <= rv_l79_adls_per_addr_curr                                     => -0.325407,
	                                                                          0);
	
	sears_subscore9 := map(
	    (rv_f00_input_dob_match_level in [' '])                                    => 0,
	    (rv_f00_input_dob_match_level in ['0', '1', '2', '3', '4', '5', '6', '7']) => -0.126918,
	    (rv_f00_input_dob_match_level in ['8'])                                    => 0.049184,
	                                                                                  0);
	
	sears_subscore10 := map(
	    (rv_f03_input_add_not_most_rec in [' ']) => 0,
	    (rv_f03_input_add_not_most_rec in ['0']) => 0.035549,
	    (rv_f03_input_add_not_most_rec in ['1']) => -0.171532,
	                                                0);
	
	sears_subscore11 := map(
	    (rv_d31_mostrec_bk in [' '])                                              => 0,
	    (rv_d31_mostrec_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 0.012052,
	    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                               => -0.447773,
	                                                                                 0);
	
	sears_subscore12 := map(
	    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 0.018668,
	    1 <= rv_i61_inq_collection_count12                                         => -0.30252,
	                                                                                  0);
	
	sears_subscore13 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.020999,
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => -0.124237,
	    3 <= rv_c21_stl_inq_count                                => -0.507558,
	                                                                0);
	
	sears_rawscore := sears_subscore0 +
	    sears_subscore1 +
	    sears_subscore2 +
	    sears_subscore3 +
	    sears_subscore4 +
	    sears_subscore5 +
	    sears_subscore6 +
	    sears_subscore7 +
	    sears_subscore8 +
	    sears_subscore9 +
	    sears_subscore10 +
	    sears_subscore11 +
	    sears_subscore12 +
	    sears_subscore13;
	
	sears_lnoddsscore := sears_rawscore + 1.823282;
	
	sears_probscore := exp(sears_lnoddsscore) / (1 + exp(sears_lnoddsscore));
	
	sears_aacd_0 := map(
	    (rv_prop_owner_history in [' '])          => '',
	    (rv_prop_owner_history in ['CURRENT'])    => '',
	    (rv_prop_owner_history in ['HISTORICAL']) => 'A42',
	    (rv_prop_owner_history in ['NEVER'])      => 'A41',
	                                                 '');
	
	sears_dist_0 := sears_subscore0 - 0.277933;
	
	sears_aacd_1 := map(
	    (rv_d33_eviction_recency in [' '])                    => '',
	    (rv_d33_eviction_recency in ['00'])                   => 'D33',
	    (rv_d33_eviction_recency in ['03', '06', '12', '24']) => 'D33',
	    (rv_d33_eviction_recency in ['25', '36', '37', '60']) => 'D33',
	    (rv_d33_eviction_recency in ['61', '98', '99'])       => 'D33',
	                                                             '');
	
	sears_dist_1 := sears_subscore1 - 0.0697;
	
	/* **************************************************************************** */
	/* **************************************************************************** */
	sears_aacd_2 := map(
	    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 'I60',
	    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => 'I60',
	    6 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 12  => 'I60',
	    12 <= rv_i60_inq_comm_recency                                  => 'I60',
	                                                                      '');
	
	sears_dist_2 := sears_subscore2 - 0.058982;
	
	sears_aacd_3 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2   => 'I60',
	    2 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 3   => 'I60',
	    3 <= rv_i60_inq_auto_count12                                   => 'I60',
	                                                                      '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	
	sears_dist_3 := sears_subscore3 - 0.067159;
	
	sears_aacd_4 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 0 => 'C13',
	    0 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1   => 'C14',
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 'C14',
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => 'C14',
	    5 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        'C13');
	
	sears_dist_4 := sears_subscore4 - 0.148988;
	
	/* **************************************************************************** */
	/* **************************************************************************** */
	sears_aacd_5 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => 'I60',
	    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
	    6 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
	                                                                                  '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	
	sears_dist_5 := sears_subscore5 - 0.041574;
	
	sears_aacd_6 := map(
	    (rv_d32_criminal_x_felony in [' '])                                      => '',
	    (rv_d32_criminal_x_felony in ['0-0'])                                    => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 'D32',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                '');
	
	sears_dist_6 := sears_subscore6 - 0.030468;
	
	sears_aacd_7 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 'A50',
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 5   => 'A50',
	    5 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 7   => 'A50',
	    7 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 16  => 'A50',
	    16 <= rv_a50_pb_total_orders                                 => 'A50',
	                                                                    '');
	
	// sears_dist_7 := sears_subscore7 - 0.474158;
		Sears_DIST_7 := 0;	// Hard coded to 0 to remove ibehavior reason codes
	
	sears_aacd_8 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 2 => 'C13',
	    2 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3   => 'L79',
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => 'L79',
	    5 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 6   => 'L79',
	    6 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 7   => 'L79',
	    7 <= rv_l79_adls_per_addr_curr                                     => 'L79',
	                                                                          '');
	
	sears_dist_8 := sears_subscore8 - 0.166813;
	
	sears_aacd_9 := map(
	    (rv_f00_input_dob_match_level in [' '])                                    => '',
	    (rv_f00_input_dob_match_level in ['0', '1', '2', '3', '4', '5', '6', '7']) => 'F00',
	    (rv_f00_input_dob_match_level in ['8'])                                    => 'F00',
	                                                                                  '');
	
	sears_dist_9 := sears_subscore9 - 0.049184;
	
	sears_aacd_10 := map(
	    (rv_f03_input_add_not_most_rec in [' ']) => '',
	    (rv_f03_input_add_not_most_rec in ['0']) => 'F03',
	    (rv_f03_input_add_not_most_rec in ['1']) => 'F03',
	                                                '');
	
	sears_dist_10 := sears_subscore10 - 0.035549;
	
	sears_aacd_11 := map(
	    (rv_d31_mostrec_bk in [' '])                                              => '',
	    (rv_d31_mostrec_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 'D31',
	    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                               => 'D31',
	                                                                                 '');
	
	sears_dist_11 := sears_subscore11 - 0.012052;
	
	sears_aacd_12 := map(
	    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 'I61',
	    1 <= rv_i61_inq_collection_count12                                         => 'I61',
	                                                                                  '');
	
	sears_dist_12 := sears_subscore12 - 0.018668;
	
	sears_aacd_13 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => 'C21',
	    3 <= rv_c21_stl_inq_count                                => 'C21',
	                                                                '');
	
	sears_dist_13 := sears_subscore13 - 0.020999;
	
	sears_rcvaluel79 := (integer)(sears_aacd_0 = 'L79') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'L79') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'L79') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'L79') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'L79') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'L79') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'L79') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'L79') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'L79') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'L79') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'L79') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'L79') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'L79') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'L79') * sears_dist_13;
	
	sears_rcvaluei61 := (integer)(sears_aacd_0 = 'I61') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'I61') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'I61') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'I61') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'I61') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'I61') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'I61') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'I61') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'I61') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'I61') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'I61') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'I61') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'I61') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'I61') * sears_dist_13;
	
	sears_rcvalued32 := (integer)(sears_aacd_0 = 'D32') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'D32') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'D32') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'D32') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'D32') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'D32') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'D32') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'D32') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'D32') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'D32') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'D32') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'D32') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'D32') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'D32') * sears_dist_13;
	
	sears_rcvalued33 := (integer)(sears_aacd_0 = 'D33') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'D33') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'D33') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'D33') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'D33') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'D33') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'D33') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'D33') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'D33') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'D33') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'D33') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'D33') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'D33') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'D33') * sears_dist_13;
	
	sears_rcvalued31 := (integer)(sears_aacd_0 = 'D31') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'D31') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'D31') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'D31') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'D31') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'D31') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'D31') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'D31') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'D31') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'D31') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'D31') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'D31') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'D31') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'D31') * sears_dist_13;
	
	sears_rcvaluea50 := (integer)(sears_aacd_0 = 'A50') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'A50') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'A50') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'A50') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'A50') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'A50') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'A50') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'A50') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'A50') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'A50') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'A50') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'A50') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'A50') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'A50') * sears_dist_13;
	
	sears_rcvaluec21 := (integer)(sears_aacd_0 = 'C21') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'C21') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'C21') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'C21') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'C21') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'C21') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'C21') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'C21') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'C21') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'C21') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'C21') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'C21') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'C21') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'C21') * sears_dist_13;
	
	
	
	/* ************************************************************ */
	/* *****  PROBELM MUST BE RELATED TO THE BELOW SECTION!!  ***** */
	/* ************************************************************ */
	sears_rcvaluei60 := (integer)(sears_aacd_0 = 'I60') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'I60') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'I60') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'I60') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'I60') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'I60') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'I60') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'I60') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'I60') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'I60') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'I60') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'I60') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'I60') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'I60') * sears_dist_13;
	
	
	
	sears_rcvaluef00 := (integer)(sears_aacd_0 = 'F00') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'F00') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'F00') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'F00') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'F00') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'F00') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'F00') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'F00') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'F00') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'F00') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'F00') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'F00') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'F00') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'F00') * sears_dist_13;
	
	sears_rcvaluef03 := (integer)(sears_aacd_0 = 'F03') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'F03') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'F03') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'F03') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'F03') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'F03') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'F03') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'F03') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'F03') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'F03') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'F03') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'F03') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'F03') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'F03') * sears_dist_13;
	
	sears_rcvaluea41 := (integer)(sears_aacd_0 = 'A41') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'A41') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'A41') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'A41') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'A41') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'A41') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'A41') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'A41') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'A41') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'A41') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'A41') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'A41') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'A41') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'A41') * sears_dist_13;
	
	sears_rcvaluec13 := (integer)(sears_aacd_0 = 'C13') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'C13') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'C13') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'C13') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'C13') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'C13') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'C13') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'C13') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'C13') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'C13') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'C13') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'C13') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'C13') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'C13') * sears_dist_13;
	
	sears_rcvaluea42 := (integer)(sears_aacd_0 = 'A42') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'A42') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'A42') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'A42') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'A42') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'A42') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'A42') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'A42') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'A42') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'A42') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'A42') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'A42') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'A42') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'A42') * sears_dist_13;
	
	sears_rcvaluec14 := (integer)(sears_aacd_0 = 'C14') * sears_dist_0 +
	    (integer)(sears_aacd_1 = 'C14') * sears_dist_1 +
	    (integer)(sears_aacd_2 = 'C14') * sears_dist_2 +
	    (integer)(sears_aacd_3 = 'C14') * sears_dist_3 +
	    (integer)(sears_aacd_4 = 'C14') * sears_dist_4 +
	    (integer)(sears_aacd_5 = 'C14') * sears_dist_5 +
	    (integer)(sears_aacd_6 = 'C14') * sears_dist_6 +
	    (integer)(sears_aacd_7 = 'C14') * sears_dist_7 +
	    (integer)(sears_aacd_8 = 'C14') * sears_dist_8 +
	    (integer)(sears_aacd_9 = 'C14') * sears_dist_9 +
	    (integer)(sears_aacd_10 = 'C14') * sears_dist_10 +
	    (integer)(sears_aacd_11 = 'C14') * sears_dist_11 +
	    (integer)(sears_aacd_12 = 'C14') * sears_dist_12 +
	    (integer)(sears_aacd_13 = 'C14') * sears_dist_13;
	
	wnli_subscore0 := map(
	    (rv_d31_mostrec_bk in [' '])                                              => 0,
	    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                               => -0.940307,
	    (rv_d31_mostrec_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 0.044757,
	                                                                                 0);
	
	wnli_subscore1 := map(
	    (rv_f03_address_match in [' '])                                              => 0,
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.322927,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 0.116969,
	                                                                                    0);
	
	wnli_subscore2 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 0.150947,
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => -0.401247,
	    3 <= rv_i60_inq_recency AND rv_i60_inq_recency < 6   => -0.251921,
	    6 <= rv_i60_inq_recency                              => -0.051942,
	                                                            0);
	
	wnli_subscore3 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.063741,
	    1 <= rv_i60_inq_comm_count12                                   => -0.60736,
	                                                                      0);
	
	wnli_subscore4 := map(
	    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18 => -0.248643,
	    18 <= rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 182 => 0.094916,
	    182 <= rv_c13_curr_addr_lres                                => 0.243685,
	                                                                   0);
	
	wnli_subscore5 := map(
	    (rv_ever_asset_owner in [' ']) => 0,
	    (rv_ever_asset_owner in ['0']) => -0.15268,
	    (rv_ever_asset_owner in ['1']) => 0.16528,
	                                      0);
	
	wnli_rawscore := wnli_subscore0 +
	    wnli_subscore1 +
	    wnli_subscore2 +
	    wnli_subscore3 +
	    wnli_subscore4 +
	    wnli_subscore5;
	
	wnli_lnoddsscore := wnli_rawscore + 1.983174;
	
	wnli_probscore := exp(wnli_lnoddsscore) / (1 + exp(wnli_lnoddsscore));
	
	wnli_aacd_0 := map(
	    (rv_d31_mostrec_bk in [' '])                                              => '',
	    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                               => 'D31',
	    (rv_d31_mostrec_bk in ['0 - NO BK', '2 - BK DISCHARGED', '3 - BK OTHER']) => 'D31',
	                                                                                 '');
	
	wnli_dist_0 := wnli_subscore0 - 0.044757;
	
	wnli_aacd_1 := map(
	    (rv_f03_address_match in [' '])                                              => '',
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 'F03',
	                                                                                    '');
	
	wnli_dist_1 := wnli_subscore1 - 0.116969;

	/* **************************************************************************** */
	/* **************************************************************************** */
	wnli_aacd_2 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 'I60',
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => 'I60',
	    3 <= rv_i60_inq_recency AND rv_i60_inq_recency < 6   => 'I60',
	    6 <= rv_i60_inq_recency                              => 'I60',
	                                                            '');
	
	wnli_dist_2 := wnli_subscore2 - 0.150947;
	
	wnli_aacd_3 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_comm_count12                                   => 'I60',
	                                                                      '');
	/* **************************************************************************** */
	/* **************************************************************************** */
	wnli_dist_3 := wnli_subscore3 - 0.063741;
	
	wnli_aacd_4 := map(
	    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 18 => 'C13',
	    18 <= rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 182 => 'C13',
	    182 <= rv_c13_curr_addr_lres                                => 'C13',
	                                                                   'C13');
	
	wnli_dist_4 := wnli_subscore4 - 0.243685;
	
	wnli_aacd_5 := map(
	    (rv_ever_asset_owner in [' ']) => '',
	    (rv_ever_asset_owner in ['0']) => 'A40',
	    (rv_ever_asset_owner in ['1']) => 'A40',
	                                      '');
	
	wnli_dist_5 := wnli_subscore5 - 0.16528;
	
	wnli_rcvaluec13 := (integer)(wnli_aacd_0 = 'C13') * wnli_dist_0 +
	    (integer)(wnli_aacd_1 = 'C13') * wnli_dist_1 +
	    (integer)(wnli_aacd_2 = 'C13') * wnli_dist_2 +
	    (integer)(wnli_aacd_3 = 'C13') * wnli_dist_3 +
	    (integer)(wnli_aacd_4 = 'C13') * wnli_dist_4 +
	    (integer)(wnli_aacd_5 = 'C13') * wnli_dist_5;
	
	wnli_rcvaluei60 := (integer)(wnli_aacd_0 = 'I60') * wnli_dist_0 +
	    (integer)(wnli_aacd_1 = 'I60') * wnli_dist_1 +
	    (integer)(wnli_aacd_2 = 'I60') * wnli_dist_2 +
	    (integer)(wnli_aacd_3 = 'I60') * wnli_dist_3 +
	    (integer)(wnli_aacd_4 = 'I60') * wnli_dist_4 +
	    (integer)(wnli_aacd_5 = 'I60') * wnli_dist_5;
	
	wnli_rcvaluea40 := (integer)(wnli_aacd_0 = 'A40') * wnli_dist_0 +
	    (integer)(wnli_aacd_1 = 'A40') * wnli_dist_1 +
	    (integer)(wnli_aacd_2 = 'A40') * wnli_dist_2 +
	    (integer)(wnli_aacd_3 = 'A40') * wnli_dist_3 +
	    (integer)(wnli_aacd_4 = 'A40') * wnli_dist_4 +
	    (integer)(wnli_aacd_5 = 'A40') * wnli_dist_5;
	
	wnli_rcvaluef03 := (integer)(wnli_aacd_0 = 'F03') * wnli_dist_0 +
	    (integer)(wnli_aacd_1 = 'F03') * wnli_dist_1 +
	    (integer)(wnli_aacd_2 = 'F03') * wnli_dist_2 +
	    (integer)(wnli_aacd_3 = 'F03') * wnli_dist_3 +
	    (integer)(wnli_aacd_4 = 'F03') * wnli_dist_4 +
	    (integer)(wnli_aacd_5 = 'F03') * wnli_dist_5;
	
	wnli_rcvalued31 := (integer)(wnli_aacd_0 = 'D31') * wnli_dist_0 +
	    (integer)(wnli_aacd_1 = 'D31') * wnli_dist_1 +
	    (integer)(wnli_aacd_2 = 'D31') * wnli_dist_2 +
	    (integer)(wnli_aacd_3 = 'D31') * wnli_dist_3 +
	    (integer)(wnli_aacd_4 = 'D31') * wnli_dist_4 +
	    (integer)(wnli_aacd_5 = 'D31') * wnli_dist_5;
	
	wnli_segment := map(
	    (tuln_channel in ['KMART', 'PREAPPROVAL_KMART'])                                                     => 'KMART      ',
	    (tuln_channel in ['PREAPPROVAL_SEARS', 'PREAPPROVAL_SEARS_SHO', 'SEARS', 'SEARS_AUTO', 'SEARS_SHO']) => 'SEARS      ',
	    (tuln_channel in ['WNLI'])                                                                           => 'CORE       ',
	    (tuln_channel in ['WNLI_DIRECT'])                                                                    => 'WNLI DIRECT',
	                                                                                                            '           ');
	
	iv_rv5_deceased := (integer)rc_decsflag = 1 or (integer)rc_ssndod != 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;
	// cast all instances above as integers
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	// cast TRUEDID as integer
	base := 700;
	
	pts := 40;
	
	odds := (1 - .1550) / .1550;
	
	probscore := map(
	    wnli_segment = 'KMART'       => kmart_probscore,
	    wnli_segment = 'SEARS'       => sears_probscore,
	    wnli_segment = 'CORE'        => core_probscore,
	    wnli_segment = 'WNLI DIRECT' => wnli_probscore,
	                                    sears_probscore);
	
	rvg1601_1_0_score := map(
	    (integer)iv_rv5_deceased > 0   => 200,
	    (integer)iv_rv5_unscorable = 1 => 222,
							min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));
	
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	 
	//*************************************************************************************//
	rc_dataset_core := DATASET([
	    {'L79', core_rcvalueL79},
	    {'A40', core_rcvalueA40},
	    {'D32', core_rcvalueD32},
	    {'D33', core_rcvalueD33},
	    {'D31', core_rcvalueD31},
	    {'A50', core_rcvalueA50},
	    {'I60', core_rcvalueI60},
	    {'F03', core_rcvalueF03},
	    {'C13', core_rcvalueC13},
	    {'S66', core_rcvalueS66},
	    {'C14', core_rcvalueC14}
	    ], ds_layout);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_core_sorted := sort(rc_dataset_core, rc_dataset_core.value)(value<0);
	
	core_rc1 := rc_dataset_core_sorted[1].rc;
	core_rc2 := rc_dataset_core_sorted[2].rc;
	core_rc3 := rc_dataset_core_sorted[3].rc;
	core_rc4 := rc_dataset_core_sorted[4].rc;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_wnli := DATASET([
	    {'C13', wnli_rcvalueC13},
	    {'I60', wnli_rcvalueI60},
	    {'A40', wnli_rcvalueA40},
	    {'F03', wnli_rcvalueF03},
	    {'D31', wnli_rcvalueD31}
	    ], ds_layout);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_wnli_sorted := sort(rc_dataset_wnli, rc_dataset_wnli.value)(value<0);
	
	wnli_rc1 := rc_dataset_wnli_sorted[1].rc;
	wnli_rc2 := rc_dataset_wnli_sorted[2].rc;
	wnli_rc3 := rc_dataset_wnli_sorted[3].rc;
	wnli_rc4 := rc_dataset_wnli_sorted[4].rc;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_kmart := DATASET([
	    {'L79', kmart_rcvalueL79},
	    {'D32', kmart_rcvalueD32},
	    {'D33', kmart_rcvalueD33},
	    {'D31', kmart_rcvalueD31},
	    {'A50', kmart_rcvalueA50},
	    {'C21', kmart_rcvalueC21},
	    {'I60', kmart_rcvalueI60},
	    {'F03', kmart_rcvalueF03},
	    {'A41', kmart_rcvalueA41},
	    {'C13', kmart_rcvalueC13},
	    {'A42', kmart_rcvalueA42}
	    ], ds_layout);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_kmart_sorted := sort(rc_dataset_kmart, rc_dataset_kmart.value)(value<0);
	
	kmart_rc1 := rc_dataset_kmart_sorted[1].rc;
	kmart_rc2 := rc_dataset_kmart_sorted[2].rc;
	kmart_rc3 := rc_dataset_kmart_sorted[3].rc;
	kmart_rc4 := rc_dataset_kmart_sorted[4].rc;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_sears := DATASET([
	    {'L79', sears_rcvalueL79},
	    {'I61', sears_rcvalueI61},
	    {'D32', sears_rcvalueD32},
	    {'D33', sears_rcvalueD33},
	    {'D31', sears_rcvalueD31},
	    {'A50', sears_rcvalueA50},
	    {'C21', sears_rcvalueC21},
	    {'I60', sears_rcvalueI60},
	    {'F00', sears_rcvalueF00},
	    {'F03', sears_rcvalueF03},
	    {'A41', sears_rcvalueA41},
	    {'C13', sears_rcvalueC13},
	    {'A42', sears_rcvalueA42},
	    {'C14', sears_rcvalueC14}
	    ], ds_layout);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_sears_sorted := sort(rc_dataset_sears, rc_dataset_sears.value)(value<0);
	
	sears_rc1 := rc_dataset_sears_sorted[1].rc;
	sears_rc2 := rc_dataset_sears_sorted[2].rc;
	sears_rc3 := rc_dataset_sears_sorted[3].rc;
	sears_rc4 := rc_dataset_sears_sorted[4].rc;
	//*************************************************************************************//
	
	rc1_2 := map(
	    wnli_segment = 'KMART'       => kmart_rc1,
	    wnli_segment = 'SEARS'       => sears_rc1,
	    wnli_segment = 'CORE'        => core_rc1,
	    wnli_segment = 'WNLI DIRECT' => wnli_rc1,
	                                    sears_rc1);
	
	rc2_2 := map(
	    wnli_segment = 'KMART'       => kmart_rc2,
	    wnli_segment = 'SEARS'       => sears_rc2,
	    wnli_segment = 'CORE'        => core_rc2,
	    wnli_segment = 'WNLI DIRECT' => wnli_rc2,
	                                    sears_rc2);
	
	rc3_2 := map(
	    wnli_segment = 'KMART'       => kmart_rc3,
	    wnli_segment = 'SEARS'       => sears_rc3,
	    wnli_segment = 'CORE'        => core_rc3,
	    wnli_segment = 'WNLI DIRECT' => wnli_rc3,
	                                    sears_rc3);
	
	rc4_2 := map(
	    wnli_segment = 'KMART'       => kmart_rc4,
	    wnli_segment = 'SEARS'       => sears_rc4,
	    wnli_segment = 'CORE'        => core_rc4,
	    wnli_segment = 'WNLI DIRECT' => wnli_rc4,
	                                    sears_rc4);
	
	_rc_inq := map(
	    wnli_segment = 'KMART' and rv_i60_inq_hiriskcred_recency > 0 => 'I60',
	    wnli_segment = 'KMART' and rv_i60_inq_comm_count12 > 0       => 'I60',
	    wnli_segment = 'SEARS' and rv_i61_inq_collection_count12 > 0 => 'I60',
	    wnli_segment = 'SEARS' and rv_i60_inq_auto_count12 > 0       => 'I60',
	    wnli_segment = 'SEARS' and rv_i60_inq_hiriskcred_recency > 0 => 'I60',
	    wnli_segment = 'SEARS' and rv_i60_inq_comm_recency > 0       => 'I60',
	    wnli_segment = 'CORE' and rv_i60_inq_auto_count12 > 0        => 'I60',
	    wnli_segment = 'CORE' and rv_i60_inq_hiriskcred_recency > 0  => 'I60',
	    wnli_segment = 'CORE' and rv_i60_inq_comm_count12 > 0        => 'I60',
	    wnli_segment = 'WNLI DIRECT' and rv_i60_inq_recency > 0      => 'I60',
	    wnli_segment = 'WNLI DIRECT' and rv_i60_inq_comm_count12 > 0 => 'I60',
	    wnli_segment = '' and rv_i61_inq_collection_count12 > 0      => 'I60',
	    wnli_segment = '' and rv_i60_inq_auto_count12 > 0            => 'I60',
	    wnli_segment = '' and rv_i60_inq_hiriskcred_recency > 0      => 'I60',
	    wnli_segment = '' and rv_i60_inq_comm_recency > 0            => 'I60',
	                                                                    '');
	
	rc4_c122 := map(
	    trim(trim(rc1_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,   // Was commented out
	                                                 ''); 		  // Was commented out
	
	rc1_c122 := map(
	    trim(trim(rc1_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,   // Was commented out
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	                                                 '');  		  // Was commented out
	
	rc3_c122 := map(
	    trim(trim(rc1_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,   // Was commented out
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	                                                 '');  		  // Was commented out
	
	rc5_c122 := map(
	    trim(trim(rc1_2, LEFT), LEFT, RIGHT) = '' => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = '' => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = '' => '',
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = '' => '',
	                                                 _rc_inq);
	
	rc2_c122 := map(
	    trim(trim(rc1_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,   // Was commented out
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = '' => '',  			// Was commented out
	                                                 '');  		  // Was commented out
	
	rc1_1 := if(rc1_c122 != '' and rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc1_c122, rc1_2);  // Was commented out
	
	rc2_1 := if(rc2_c122 != '' and rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc2_c122, rc2_2);  // Was commented out
	
	rc3_1 := if(rc3_c122 != '' and rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc3_c122, rc3_2);  // Was commented out
	
	rc4_1 := if(rc4_c122 != '' and rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc4_c122, rc4_2);  // Was commented out
	
  rc5_1 := if(rc5_c122 != '' and rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc5_c122, '');
	
	// rc1 := if((rvg1601_1_0_score in [200, 222]), '', rc1_2);
	
	// rc2 := if((rvg1601_1_0_score in [200, 222]), '', rc2_2);
	
	// rc3 := if((rvg1601_1_0_score in [200, 222]), '', rc3_2);
	
	// rc4 := if((rvg1601_1_0_score in [200, 222]), '', rc4_2);
	
	// rc5 := if((rvg1601_1_0_score in [200, 222]), '', rc5_1);	
	
	rc1 := if((rvg1601_1_0_score in [200, 222]), '', rc1_1);
	
	rc2 := if((rvg1601_1_0_score in [200, 222]), '', rc2_1);
	
	rc3 := if((rvg1601_1_0_score in [200, 222]), '', rc3_1);
	
	rc4 := if((rvg1601_1_0_score in [200, 222]), '', rc4_1);
	
	rc5 := if((rvg1601_1_0_score in [200, 222]), '', rc5_1);
	
	//*************************************************************************************//
	//                      RiskView Version 5 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
	//*************************************************************************************//
	
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	
	// In Version 5 200 and 222 scores will not return reason codes, they will instead return alert codes
	reasonsOverrides := MAP(
		rvg1601_1_0_score = 200 => DATASET([{'00'}], HRILayout),
		rvg1601_1_0_score = 222 => DATASET([{'00'}], HRILayout),
		rvg1601_1_0_score = 900 => DATASET([{'00'}], HRILayout),
															 DATASET([], HRILayout));
																											 
	reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
	
	// If we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
											reasonsOverrides, 
											reasons) (HRI NOT IN ['', '00']);
											
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	
	//*************************************************************************************//
	//                       End RiskView Version 5 Reason Code Logic
	//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.tuln_channel := tuln_channel;
		SELF.truedid := truedid;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_decsflag := rc_decsflag;
		SELF.ver_sources := ver_sources;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
		SELF.add_curr_lres := add_curr_lres;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.max_lres := max_lres;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.inq_count := inq_count;
		SELF.inq_count01 := inq_count01;
		SELF.inq_count03 := inq_count03;
		SELF.inq_count06 := inq_count06;
		SELF.inq_count12 := inq_count12;
		SELF.inq_count24 := inq_count24;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_collection_count12 := inq_collection_count12;
		SELF.inq_communications_count := inq_communications_count;
		SELF.inq_communications_count01 := inq_communications_count01;
		SELF.inq_communications_count03 := inq_communications_count03;
		SELF.inq_communications_count06 := inq_communications_count06;
		SELF.inq_communications_count12 := inq_communications_count12;
		SELF.inq_communications_count24 := inq_communications_count24;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.pb_total_dollars := pb_total_dollars;
		SELF.pb_total_orders := pb_total_orders;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count := stl_inq_count;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.bankrupt := bankrupt;
		SELF.disposition := disposition;
		SELF.filing_count := filing_count;
		SELF.bk_dismissed_recent_count := bk_dismissed_recent_count;
		SELF.bk_dismissed_historical_count := bk_dismissed_historical_count;
		SELF.bk_disposed_recent_count := bk_disposed_recent_count;
		SELF.bk_disposed_historical_count := bk_disposed_historical_count;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.watercraft_count := watercraft_count;
		SELF.input_dob_match_level := input_dob_match_level;

		/* Model Intermediate Variables */
		// SELF.NULL := NULL;
		// SELF.INTEGER contains_i( string haystack, string needle ) := INTEGER contains_i( string haystack, string needle );
		// SELF.BOOLEAN indexw(string source, string target, string delim) := BOOLEAN indexw(string source, string target, string delim);
		SELF.sysdate := sysdate;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_d31_all_bk := rv_d31_all_bk;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
		SELF.rv_ever_asset_owner := rv_ever_asset_owner;
		SELF.rv_i60_inq_auto_count12 := rv_i60_inq_auto_count12;
		SELF.rv_i60_inq_hiriskcred_recency := rv_i60_inq_hiriskcred_recency;
		SELF.rv_i60_inq_comm_count12 := rv_i60_inq_comm_count12;
		SELF.rv_l79_adls_per_addr_curr := rv_l79_adls_per_addr_curr;
		SELF.rv_a50_pb_total_dollars := rv_a50_pb_total_dollars;
		SELF.rv_f03_input_add_not_most_rec := rv_f03_input_add_not_most_rec;
		SELF.rv_d32_criminal_count := rv_d32_criminal_count;
		SELF.rv_c21_stl_inq_count := rv_c21_stl_inq_count;
		SELF.rv_c13_max_lres := rv_c13_max_lres;
		SELF.rv_prop_owner_history := rv_prop_owner_history;
		SELF.rv_a50_pb_total_orders := rv_a50_pb_total_orders;
		SELF.rv_f00_input_dob_match_level := rv_f00_input_dob_match_level;
		SELF.rv_d31_mostrec_bk := rv_d31_mostrec_bk;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_i61_inq_collection_count12 := rv_i61_inq_collection_count12;
		SELF.rv_i60_inq_comm_recency := rv_i60_inq_comm_recency;
		SELF.rv_c13_curr_addr_lres := rv_c13_curr_addr_lres;
		SELF.rv_i60_inq_recency := rv_i60_inq_recency;
		SELF.core_subscore0 := core_subscore0;
		SELF.core_subscore1 := core_subscore1;
		SELF.core_subscore2 := core_subscore2;
		SELF.core_subscore3 := core_subscore3;
		SELF.core_subscore4 := core_subscore4;
		SELF.core_subscore5 := core_subscore5;
		SELF.core_subscore6 := core_subscore6;
		SELF.core_subscore7 := core_subscore7;
		SELF.core_subscore8 := core_subscore8;
		SELF.core_subscore9 := core_subscore9;
		SELF.core_subscore10 := core_subscore10;
		SELF.core_subscore11 := core_subscore11;
		SELF.core_rawscore := core_rawscore;
		SELF.core_lnoddsscore := core_lnoddsscore;
		SELF.core_probscore := core_probscore;
		SELF.core_aacd_0 := core_aacd_0;
		SELF.core_dist_0 := core_dist_0;
		SELF.core_aacd_1 := core_aacd_1;
		SELF.core_dist_1 := core_dist_1;
		SELF.core_aacd_2 := core_aacd_2;
		SELF.core_dist_2 := core_dist_2;
		SELF.core_aacd_3 := core_aacd_3;
		SELF.core_dist_3 := core_dist_3;
		SELF.core_aacd_4 := core_aacd_4;
		SELF.core_dist_4 := core_dist_4;
		SELF.core_aacd_5 := core_aacd_5;
		SELF.core_dist_5 := core_dist_5;
		SELF.core_aacd_6 := core_aacd_6;
		SELF.core_dist_6 := core_dist_6;
		SELF.core_aacd_7 := core_aacd_7;
		SELF.core_dist_7 := core_dist_7;
		SELF.core_aacd_8 := core_aacd_8;
		SELF.core_dist_8 := core_dist_8;
		SELF.core_aacd_9 := core_aacd_9;
		SELF.core_dist_9 := core_dist_9;
		SELF.core_aacd_10 := core_aacd_10;
		SELF.core_dist_10 := core_dist_10;
		SELF.core_aacd_11 := core_aacd_11;
		SELF.core_dist_11 := core_dist_11;
		SELF.core_rcvaluel79 := core_rcvaluel79;
		SELF.core_rcvaluea40 := core_rcvaluea40;
		SELF.core_rcvalued32 := core_rcvalued32;
		SELF.core_rcvalued33 := core_rcvalued33;
		SELF.core_rcvalued31 := core_rcvalued31;
		SELF.core_rcvaluea50 := core_rcvaluea50;
		SELF.core_rcvaluei60 := core_rcvaluei60;
		SELF.core_rcvaluef03 := core_rcvaluef03;
		SELF.core_rcvaluec13 := core_rcvaluec13;
		SELF.core_rcvalues66 := core_rcvalues66;
		SELF.core_rcvaluec14 := core_rcvaluec14;
		SELF.kmart_subscore0 := kmart_subscore0;
		SELF.kmart_subscore1 := kmart_subscore1;
		SELF.kmart_subscore2 := kmart_subscore2;
		SELF.kmart_subscore3 := kmart_subscore3;
		SELF.kmart_subscore4 := kmart_subscore4;
		SELF.kmart_subscore5 := kmart_subscore5;
		SELF.kmart_subscore6 := kmart_subscore6;
		SELF.kmart_subscore7 := kmart_subscore7;
		SELF.kmart_subscore8 := kmart_subscore8;
		SELF.kmart_subscore9 := kmart_subscore9;
		SELF.kmart_subscore10 := kmart_subscore10;
		SELF.kmart_rawscore := kmart_rawscore;
		SELF.kmart_lnoddsscore := kmart_lnoddsscore;
		SELF.kmart_probscore := kmart_probscore;
		SELF.kmart_aacd_0 := kmart_aacd_0;
		SELF.kmart_dist_0 := kmart_dist_0;
		SELF.kmart_aacd_1 := kmart_aacd_1;
		SELF.kmart_dist_1 := kmart_dist_1;
		SELF.kmart_aacd_2 := kmart_aacd_2;
		SELF.kmart_dist_2 := kmart_dist_2;
		SELF.kmart_aacd_3 := kmart_aacd_3;
		SELF.kmart_dist_3 := kmart_dist_3;
		SELF.kmart_aacd_4 := kmart_aacd_4;
		SELF.kmart_dist_4 := kmart_dist_4;
		SELF.kmart_aacd_5 := kmart_aacd_5;
		SELF.kmart_dist_5 := kmart_dist_5;
		SELF.kmart_aacd_6 := kmart_aacd_6;
		SELF.kmart_dist_6 := kmart_dist_6;
		SELF.kmart_aacd_7 := kmart_aacd_7;
		SELF.kmart_dist_7 := kmart_dist_7;
		SELF.kmart_aacd_8 := kmart_aacd_8;
		SELF.kmart_dist_8 := kmart_dist_8;
		SELF.kmart_aacd_9 := kmart_aacd_9;
		SELF.kmart_dist_9 := kmart_dist_9;
		SELF.kmart_aacd_10 := kmart_aacd_10;
		SELF.kmart_dist_10 := kmart_dist_10;
		SELF.kmart_rcvaluel79 := kmart_rcvaluel79;
		SELF.kmart_rcvalued32 := kmart_rcvalued32;
		SELF.kmart_rcvalued33 := kmart_rcvalued33;
		SELF.kmart_rcvalued31 := kmart_rcvalued31;
		SELF.kmart_rcvaluea50 := kmart_rcvaluea50;
		SELF.kmart_rcvaluec21 := kmart_rcvaluec21;
		SELF.kmart_rcvaluei60 := kmart_rcvaluei60;
		SELF.kmart_rcvaluef03 := kmart_rcvaluef03;
		SELF.kmart_rcvaluea41 := kmart_rcvaluea41;
		SELF.kmart_rcvaluec13 := kmart_rcvaluec13;
		SELF.kmart_rcvaluea42 := kmart_rcvaluea42;
		SELF.sears_subscore0 := sears_subscore0;
		SELF.sears_subscore1 := sears_subscore1;
		SELF.sears_subscore2 := sears_subscore2;
		SELF.sears_subscore3 := sears_subscore3;
		SELF.sears_subscore4 := sears_subscore4;
		SELF.sears_subscore5 := sears_subscore5;
		SELF.sears_subscore6 := sears_subscore6;
		SELF.sears_subscore7 := sears_subscore7;
		SELF.sears_subscore8 := sears_subscore8;
		SELF.sears_subscore9 := sears_subscore9;
		SELF.sears_subscore10 := sears_subscore10;
		SELF.sears_subscore11 := sears_subscore11;
		SELF.sears_subscore12 := sears_subscore12;
		SELF.sears_subscore13 := sears_subscore13;
		SELF.sears_rawscore := sears_rawscore;
		SELF.sears_lnoddsscore := sears_lnoddsscore;
		SELF.sears_probscore := sears_probscore;
		SELF.sears_aacd_0 := sears_aacd_0;
		SELF.sears_dist_0 := sears_dist_0;
		SELF.sears_aacd_1 := sears_aacd_1;
		SELF.sears_dist_1 := sears_dist_1;
		SELF.sears_aacd_2 := sears_aacd_2;
		SELF.sears_dist_2 := sears_dist_2;
		SELF.sears_aacd_3 := sears_aacd_3;
		SELF.sears_dist_3 := sears_dist_3;
		SELF.sears_aacd_4 := sears_aacd_4;
		SELF.sears_dist_4 := sears_dist_4;
		SELF.sears_aacd_5 := sears_aacd_5;
		SELF.sears_dist_5 := sears_dist_5;
		SELF.sears_aacd_6 := sears_aacd_6;
		SELF.sears_dist_6 := sears_dist_6;
		SELF.sears_aacd_7 := sears_aacd_7;
		SELF.sears_dist_7 := sears_dist_7;
		SELF.sears_aacd_8 := sears_aacd_8;
		SELF.sears_dist_8 := sears_dist_8;
		SELF.sears_aacd_9 := sears_aacd_9;
		SELF.sears_dist_9 := sears_dist_9;
		SELF.sears_aacd_10 := sears_aacd_10;
		SELF.sears_dist_10 := sears_dist_10;
		SELF.sears_aacd_11 := sears_aacd_11;
		SELF.sears_dist_11 := sears_dist_11;
		SELF.sears_aacd_12 := sears_aacd_12;
		SELF.sears_dist_12 := sears_dist_12;
		SELF.sears_aacd_13 := sears_aacd_13;
		SELF.sears_dist_13 := sears_dist_13;
		SELF.sears_rcvaluel79 := sears_rcvaluel79;
		SELF.sears_rcvaluei61 := sears_rcvaluei61;
		SELF.sears_rcvalued32 := sears_rcvalued32;
		SELF.sears_rcvalued33 := sears_rcvalued33;
		SELF.sears_rcvalued31 := sears_rcvalued31;
		SELF.sears_rcvaluea50 := sears_rcvaluea50;
		SELF.sears_rcvaluec21 := sears_rcvaluec21;
		SELF.sears_rcvaluei60 := sears_rcvaluei60;
		SELF.sears_rcvaluef00 := sears_rcvaluef00;
		SELF.sears_rcvaluef03 := sears_rcvaluef03;
		SELF.sears_rcvaluea41 := sears_rcvaluea41;
		SELF.sears_rcvaluec13 := sears_rcvaluec13;
		SELF.sears_rcvaluea42 := sears_rcvaluea42;
		SELF.sears_rcvaluec14 := sears_rcvaluec14;
		SELF.wnli_subscore0 := wnli_subscore0;
		SELF.wnli_subscore1 := wnli_subscore1;
		SELF.wnli_subscore2 := wnli_subscore2;
		SELF.wnli_subscore3 := wnli_subscore3;
		SELF.wnli_subscore4 := wnli_subscore4;
		SELF.wnli_subscore5 := wnli_subscore5;
		SELF.wnli_rawscore := wnli_rawscore;
		SELF.wnli_lnoddsscore := wnli_lnoddsscore;
		SELF.wnli_probscore := wnli_probscore;
		SELF.wnli_aacd_0 := wnli_aacd_0;
		SELF.wnli_dist_0 := wnli_dist_0;
		SELF.wnli_aacd_1 := wnli_aacd_1;
		SELF.wnli_dist_1 := wnli_dist_1;
		SELF.wnli_aacd_2 := wnli_aacd_2;
		SELF.wnli_dist_2 := wnli_dist_2;
		SELF.wnli_aacd_3 := wnli_aacd_3;
		SELF.wnli_dist_3 := wnli_dist_3;
		SELF.wnli_aacd_4 := wnli_aacd_4;
		SELF.wnli_dist_4 := wnli_dist_4;
		SELF.wnli_aacd_5 := wnli_aacd_5;
		SELF.wnli_dist_5 := wnli_dist_5;
		SELF.wnli_rcvaluec13 := wnli_rcvaluec13;
		SELF.wnli_rcvaluei60 := wnli_rcvaluei60;
		SELF.wnli_rcvaluea40 := wnli_rcvaluea40;
		SELF.wnli_rcvaluef03 := wnli_rcvaluef03;
		SELF.wnli_rcvalued31 := wnli_rcvalued31;
		SELF.wnli_segment := wnli_segment;
		SELF.iv_rv5_deceased := iv_rv5_deceased;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.base := base;
		SELF.pts := pts;
		SELF.odds := odds;
		SELF.probscore := probscore;
		SELF.rvg1601_1_0_score := rvg1601_1_0_score;
		// SELF.ds_layout := ds_layout;
		// SELF.rc_dataset_core := rc_dataset_core;
		// SELF.rc_dataset_core_sorted := rc_dataset_core_sorted;
		// SELF.rc_dataset_wnli := rc_dataset_wnli;
		// SELF.rc_dataset_wnli_sorted := rc_dataset_wnli_sorted;
		// SELF.rc_dataset_kmart := rc_dataset_kmart;
		// SELF.rc_dataset_kmart_sorted := rc_dataset_kmart_sorted;
		// SELF.rc_dataset_sears := rc_dataset_sears;
		// SELF.rc_dataset_sears_sorted := rc_dataset_sears_sorted;
		SELF.core_rc1 := core_rc1;			// Was commented out
		SELF.core_rc2 := core_rc2;
		SELF.core_rc3 := core_rc3;
		SELF.core_rc4 := core_rc4;
		SELF.wnli_rc1 := wnli_rc1;
		SELF.wnli_rc2 := wnli_rc2;
		SELF.wnli_rc3 := wnli_rc3;
		SELF.wnli_rc4 := wnli_rc4;
		SELF.kmart_rc1 := kmart_rc1;
		SELF.kmart_rc2 := kmart_rc2;
		SELF.kmart_rc3 := kmart_rc3;
		SELF.kmart_rc4 := kmart_rc4;
		SELF.sears_rc1 := sears_rc1;
		SELF.sears_rc2 := sears_rc2;
		SELF.sears_rc3 := sears_rc3;
		SELF.sears_rc4 := sears_rc4;
		SELF.rc1_2 := rc1_2;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF._rc_inq := _rc_inq;
		SELF.rc4_c122 := rc4_c122;
		SELF.rc1_c122 := rc1_c122;
		SELF.rc3_c122 := rc3_c122;
		SELF.rc5_c122 := rc5_c122;
		SELF.rc2_c122 := rc2_c122;
		SELF.rc5_1 := rc5_1;
		// SELF.rc3_1 := rc3_1;
		// SELF.rc4_1 := rc4_1;
		// SELF.rc1_1 := rc1_1;
		// SELF.rc2_1 := rc2_1;						// Was commented out
		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;
		SELF.clam := le;

		#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
									SELF.hri := if(LEFT.hri = '', '00', left.hri),
									SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
							));
		self.score := (string3)rvg1601_1_0_score;

		#end
		SELF.seq := le.seq;
	END;

	model := join(clam, channel_inputs, left.seq=right.seq, doModel(LEFT, right));

	RETURN(model);
END;

IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

export RVT1204_1( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN xmlPreScreenOptOut = FALSE) := FUNCTION

	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			unsigned seq;
			
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			BOOLEAN truedid;
			STRING out_addr_type;
			INTEGER nas_summary;
			INTEGER nap_summary;
			BOOLEAN rc_input_addr_not_most_recent;
			STRING rc_combo_sec_rangescore;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_bansflag;
			BOOLEAN rc_ssnmiskeyflag;
			INTEGER combo_ssnscore;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_count;
			STRING addrpop;
			integer ssnlength;
			BOOLEAN dobpop;
			STRING hphnpop;
			STRING age;
			BOOLEAN add1_isbestmatch;
			STRING add1_advo_address_vacancy;
			INTEGER add1_avm_automated_valuation;
			BOOLEAN add1_eda_sourced;
			INTEGER add1_naprop;
			STRING add1_date_first_seen;
			STRING add1_pop;
			INTEGER property_owned_total;
			INTEGER property_sold_total;
			STRING add2_avm_automated_valuation;
			STRING add2_naprop;
			STRING add3_avm_automated_valuation;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_ssn;
			INTEGER adls_per_addr_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER adls_per_phone_c6;
			STRING inq_count12;
			STRING paw_source_count;
			STRING infutor_nap;
			INTEGER impulse_count;
			STRING attr_num_aircraft;
			INTEGER attr_eviction_count;
			integer bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			STRING watercraft_count;
			STRING ams_age;
			STRING ams_college_code;
			STRING ams_college_type;
			STRING prof_license_flag;
			STRING wealth_index;
			integer input_dob_age;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER reported_dob;
			STRING estimated_income;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			STRING NULL;
			INTEGER sysdate;
			STRING ver_phn_inf;
			STRING ver_phn_nap;
			STRING inf_phn_ver_lvl;
			STRING nap_phn_ver_lvl;
			STRING iv_nap_phn_ver_x_inf_phn_ver;
			STRING f_subscore0;
			STRING iv_inp_addr_avm_auto_val;
			STRING f_subscore1;
			STRING iv_max_ids_per_addr_c6;
			STRING f_subscore2;
			STRING iv_criminal_x_felony;
			STRING f_subscore3;
			STRING inp_addr_date_first_seen;
			STRING iv_mos_since_inp_addr_fseen;
			STRING f_subscore4;
			STRING iv_bst_own_prop_x_addr_naprop_c14;
			STRING iv_bst_own_prop_x_addr_naprop_c15;
			STRING iv_bst_own_prop_x_addr_naprop;
			STRING f_subscore5;
			STRING iv_addrs_per_ssn;
			STRING f_subscore6;
			STRING iv_prv_addr_avm_auto_val;
			STRING f_subscore7;
			STRING _ams_college_code;
			STRING iv_ams_college_code_x_type;
			STRING f_subscore8;
			STRING iv_inp_own_prop_x_addr_naprop;
			STRING f_subscore9;
			STRING iv_impulse_count;
			STRING f_subscore10;
			STRING iv_src_liens_adl_count;
			STRING f_subscore11;
			STRING iv_adls_per_phone_c6;
			STRING f_subscore12;
			STRING iv_estimated_income;
			STRING f_subscore13;
			STRING iv_ssns_per_adl;
			STRING f_subscore14;
			STRING iv_prof_license_flag;
			STRING f_subscore15;
			STRING iv_inp_addr_vacant;
			STRING f_subscore16;
			STRING iv_inq_count12;
			STRING f_subscore17;
			STRING iv_input_addr_not_most_recent;
			STRING f_subscore18;
			STRING iv_paw_source_count;
			STRING f_subscore19;
			STRING iv_combo_sec_rangescore;
			STRING f_subscore20;
			STRING iv_ssn_score;
			STRING f_subscore21;
			STRING iv_rec_vehx_level;
			STRING f_subscore22;
			STRING iv_filing_count;
			STRING f_subscore23;
			STRING iv_eviction_count;
			STRING f_subscore24;
			STRING ver_src_ba;
			STRING bk_flag;
			STRING lien_rec_unrel_flag;
			STRING lien_hist_unrel_flag;
			STRING ver_src_l2;
			STRING ver_src_li;
			STRING lien_flag;
			STRING ver_src_ds;
			STRING ssn_deceased;
			STRING scored_222s;
			STRING base;
			STRING point;
			STRING odds;
			STRING f_rawscore;
			STRING f_lnoddsscore;
			STRING f_probscore;
			STRING rvt1204_1_2;
			STRING ssnpriordob;
			STRING ssninvalid;
			STRING rvt1204_1_1;
			STRING rvt1204_1;
			STRING glrc03;
			STRING glrc06;
			STRING glrc26;
			STRING glrc29;
			STRING glrc97;
			STRING glrc98;
			STRING glrc99;
			STRING glrc9a;
			STRING glrc9c;
			STRING glrc9d;
			STRING glrc9e;
			STRING glrc9h;
			STRING _reported_dob;
			STRING reported_age;
			STRING iv_combined_age;
			STRING glrc9i;
			STRING glrc9m;
			STRING glrc9o;
			STRING glrc9q;
			STRING glrc9r;
			STRING glrc9u;
			STRING glrc9w;
			STRING glrcev;
			STRING glrcms;
			STRING glrcpv;
			STRING glrcbl;
			STRING rcvalue03_1;
			STRING rcvalue03;
			STRING rcvalue06_1;
			STRING rcvalue06;
			STRING rcvalue26_1;
			STRING rcvalue26;
			STRING rcvalue29_1;
			STRING rcvalue29;
			STRING rcvalue97_1;
			STRING rcvalue97;
			STRING rcvalue98_1;
			STRING rcvalue98;
			STRING rcvalue99_1;
			STRING rcvalue99;
			STRING rcvalue9a_1;
			STRING rcvalue9a_2;
			STRING rcvalue9a;
			STRING rcvalue9c_1;
			STRING rcvalue9c;
			STRING rcvalue9d_1;
			STRING rcvalue9d;
			STRING rcvalue9e_1;
			STRING rcvalue9e;
			STRING rcvalue9h_1;
			STRING rcvalue9h;
			STRING rcvalue9i_1;
			STRING rcvalue9i;
			STRING rcvalue9m_1;
			STRING rcvalue9m_2;
			STRING rcvalue9m;
			STRING rcvalue9o_1;
			STRING rcvalue9o;
			STRING rcvalue9q_1;
			STRING rcvalue9q;
			STRING rcvalue9r_1;
			STRING rcvalue9r;
			STRING rcvalue9u_1;
			STRING rcvalue9u;
			STRING rcvalue9w_1;
			STRING rcvalue9w;
			STRING rcvalueev_1;
			STRING rcvalueev;
			STRING rcvaluems_1;
			STRING rcvaluems;
			STRING rcvaluepv_1;
			STRING rcvaluepv_2;
			STRING rcvaluepv;
			STRING rcvaluebl_1;
			STRING rcvaluebl_2;
			STRING rcvaluebl_3;
			STRING rcvaluebl;
			STRING rc1;
			STRING rc2;
			STRING rc3;
			STRING rc4;
			STRING rc5;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_combo_sec_rangescore          := le.iid.combo_sec_rangescore;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := (integer)le.iid.socsdobflag;
	rc_ssnvalflag                    := (integer)le.iid.socsvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (integer)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	paw_source_count                 := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := if(le.bjl.bankrupt, 1, 0);
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_age                          := (integer)le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := (integer)le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	sysdate := Common.SAS_Date((STRING)(archive_date));
	
	ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	inf_phn_ver_lvl := map(
	    ver_phn_inf     => 3,
	    infutor_nap = 1 => 1,
	    infutor_nap = 0 => 0,
	                       2);
	
	nap_phn_ver_lvl := map(
	    ver_phn_nap     => 3,
	    nap_summary = 1 => 1,
	    nap_summary = 0 => 0,
	                       2);
	
	iv_nap_phn_ver_x_inf_phn_ver := map(
	    not(addrpop or hphnpop) => '   ',
	    not(hphnpop)            => ' -1',
	       trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));
	
	f_subscore0 := map(
	    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', ' '])                                                            => 0.000000,
	    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '3-1', '3-3', '1-2', '0-2']) => -0.159388,
	    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-2'])                                                         => -0.095902,
	    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])                                                         => 0.215418,
	    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0', '3-2'])                                                         => 0.467924,
	                                                                                                                0.000000);
	
	iv_inp_addr_avm_auto_val := if(not(add1_pop), NULL, add1_avm_automated_valuation);
	
	f_subscore1 := map(
	    NULL < iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 1         => 0.000000,
	    1 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 63650       => -0.807782,
	    63650 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 125056  => -0.202658,
	    125056 <= iv_inp_addr_avm_auto_val AND iv_inp_addr_avm_auto_val < 238452 => 0.158825,
	    238452 <= iv_inp_addr_avm_auto_val                                       => 0.429232,
	                                                                                0.000000);
	
	iv_max_ids_per_addr_c6 := if(not(add1_pop), NULL, max(adls_per_addr_c6, ssns_per_addr_c6));
	
	f_subscore2 := map(
	    NULL < iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 1 => 0.139935,
	    1 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 2   => -0.179567,
	    2 <= iv_max_ids_per_addr_c6                                  => -0.412241,
	                                                                    -0.000000);
	
	iv_criminal_x_felony := if(not(truedid), '   ', 
		trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) 
		+ trim(' - ', LEFT, RIGHT) 
		+ trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));
	
	f_subscore3 := map(
	    (iv_criminal_x_felony in ['Other'])                                                                            => 0.000000,
	    (iv_criminal_x_felony in ['0-0'])                                                                              => 0.041485,
	    (iv_criminal_x_felony in ['1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => -1.480647,
	                                                                                                                      0.000000);
	
	inp_addr_date_first_seen := Common.SAS_Date((STRING)(add1_date_first_seen));
	
	iv_mos_since_inp_addr_fseen_calc := (sysdate - inp_addr_date_first_seen) / (365.25 / 12);
	
	iv_mos_since_inp_addr_fseen := map(
	    not(add1_pop)                   => NULL,
	    inp_addr_date_first_seen = NULL => -1,
	     if (iv_mos_since_inp_addr_fseen_calc >= 0, truncate(iv_mos_since_inp_addr_fseen_calc), roundup(iv_mos_since_inp_addr_fseen_calc)));
	
	f_subscore4 := map(
	    NULL < iv_mos_since_inp_addr_fseen AND iv_mos_since_inp_addr_fseen < 0 => -0.131777,
	    0 <= iv_mos_since_inp_addr_fseen AND iv_mos_since_inp_addr_fseen < 7   => -0.145861,
	    7 <= iv_mos_since_inp_addr_fseen AND iv_mos_since_inp_addr_fseen < 21  => -0.015280,
	    21 <= iv_mos_since_inp_addr_fseen AND iv_mos_since_inp_addr_fseen < 38 => 0.071104,
	    38 <= iv_mos_since_inp_addr_fseen                                      => 0.403892,
	                                                                              0.000000);
	
	iv_bst_own_prop_x_addr_naprop_c14 := if(property_owned_total > 0, (string)(add1_naprop + 10), (string)add1_naprop);
	
	iv_bst_own_prop_x_addr_naprop_c15 := if(property_owned_total > 0, (string)(add2_naprop + 10), (string)add2_naprop);
	
	iv_bst_own_prop_x_addr_naprop := map(
	    not(truedid)     => '  ',
	    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c14,
	                        iv_bst_own_prop_x_addr_naprop_c15);
	
	f_subscore5 := map(
	    (iv_bst_own_prop_x_addr_naprop in ['0'])                                    => -0.168870,
	    (iv_bst_own_prop_x_addr_naprop in ['1', '2'])                               => -0.071367,
	    (iv_bst_own_prop_x_addr_naprop in ['3', '4', '10', '11', '12', '13', '14']) =>  0.314446,
	                                                                                   -0.000000);
	
	iv_addrs_per_ssn := if(not(ssnlength > 0), NULL, addrs_per_ssn);
	
	f_subscore6 := map(
	    NULL < iv_addrs_per_ssn AND iv_addrs_per_ssn < 1 => -0.000000,
	    1 <= iv_addrs_per_ssn AND iv_addrs_per_ssn < 2   => 0.234458,
	    2 <= iv_addrs_per_ssn AND iv_addrs_per_ssn < 3   => -0.087201,
	    3 <= iv_addrs_per_ssn                            => -0.200536,
	                                                        -0.000000);
	
	iv_prv_addr_avm_auto_val := map(
	    not(truedid)     => NULL,
	    add1_isbestmatch => add2_avm_automated_valuation,
	                        add3_avm_automated_valuation);
	
	f_subscore7 := map(
	    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => -0.000000,
	    1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 79513       => -0.563995,
	    79513 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 118055  => -0.276004,
	    118055 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 154814 => 0.028435,
	    154814 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 236000 => 0.481022,
	    236000 <= iv_prv_addr_avm_auto_val                                       => 0.717112,
	                                                                                -0.000000);
	
	_ams_college_code := if(ams_college_code = '', ' ', ams_college_code);
	
	iv_ams_college_code_x_type := if(not(truedid), '   ', trim(_ams_college_code, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(ams_college_type, LEFT, RIGHT));
	
	f_subscore8 := map(
	    (iv_ams_college_code_x_type in [' '])                                                                                => 0.000000,
	    (iv_ams_college_code_x_type in ['-'])                                                                                => -0.046068,
	    (iv_ams_college_code_x_type in ['1-R', '1-P', '1-S', '1-U', '2-R', '2-P', '2-S', '2-U', '4-P', '4-R', '4-S', '4-U']) => 0.808658,
	                                                                                                                            0.000000);
	
	iv_inp_own_prop_x_addr_naprop := map(
	    not(add1_pop)            => '  ',
	    property_owned_total > 0 => (string)(add1_naprop + 10),
	                                (string)add1_naprop );
	
	f_subscore9 := map(
	    (iv_inp_own_prop_x_addr_naprop in ['0'])                                    => -0.163650,
	    (iv_inp_own_prop_x_addr_naprop in ['1', '2'])                               => -0.022096,
	    (iv_inp_own_prop_x_addr_naprop in ['3', '4', '10', '11', '12', '13', '14']) => 0.237323,
	                                                                                   0.000000);
	
	iv_impulse_count := if(not(truedid), NULL, impulse_count);
	
	f_subscore10 := map(
	    NULL < iv_impulse_count AND iv_impulse_count < 1 => 0.032535,
	    1 <= iv_impulse_count                            => -1.579211,
	                                                        0.000000);
	
	iv_src_liens_adl_count := 
	if(not(truedid), 
	NULL, 
	max( sum( (integer) Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'), ','),
						(integer) Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'), ',')	
					),
								
		0)  // end max
	);  // end if
	
	f_subscore11 := map(
	    NULL < iv_src_liens_adl_count AND iv_src_liens_adl_count < 1 => 0.035592,
	    1 <= iv_src_liens_adl_count                                  => -0.905449,
	                                                                    0.000000);
	
	iv_adls_per_phone_c6 := if(not(hphnpop), NULL, adls_per_phone_c6);
	
	f_subscore12 := map(
	    NULL < iv_adls_per_phone_c6 AND iv_adls_per_phone_c6 < 1 => 0.036594,
	    1 <= iv_adls_per_phone_c6                                => -0.454098,
	                                                                0.000000);
	
	iv_estimated_income := if(not(truedid), NULL, estimated_income);
	
	f_subscore13 := map(
	    NULL < iv_estimated_income AND iv_estimated_income < 1       => -0.000000,
	    1 <= iv_estimated_income AND iv_estimated_income < 21000     => -0.157560,
	    21000 <= iv_estimated_income AND iv_estimated_income < 25000 => -0.066163,
	    25000 <= iv_estimated_income AND iv_estimated_income < 27000 => 0.026264,
	    27000 <= iv_estimated_income                                 => 0.161306,
	                                                                    -0.000000);
	
	iv_ssns_per_adl := if(not(truedid), NULL, ssns_per_adl);
	
	f_subscore14 := map(
	    NULL < iv_ssns_per_adl AND iv_ssns_per_adl < 1 => 0.000000,
	    1 <= iv_ssns_per_adl AND iv_ssns_per_adl < 2   => 0.045363,
	    2 <= iv_ssns_per_adl                           => -0.420165,
	                                                      0.000000);
	
	iv_prof_license_flag := if(not(truedid), NULL, if(prof_license_flag, 1, 0));
	
	f_subscore15 := map(
	    (iv_prof_license_flag in [0]) => -0.011380,
	    (iv_prof_license_flag in [1]) => 1.176721,
	                                     0.000000);
	
	iv_inp_addr_vacant := map(
	    not(add1_pop)                    => '  ',
	    trim(add1_advo_address_vacancy) = '' => '-1',
	                                        add1_advo_address_vacancy);
	
	f_subscore16 := map(
	    (iv_inp_addr_vacant in [' '])  => 0.000000,
	    (iv_inp_addr_vacant in ['-1']) => 0.000000,
	    (iv_inp_addr_vacant in ['N'])  => 0.015401,
	    (iv_inp_addr_vacant in ['Y'])  => -0.868211,
	                                      0.000000);
	
	iv_inq_count12 := if(not(truedid), NULL, inq_count12);
	
	f_subscore17 := map(
	    NULL < iv_inq_count12 AND iv_inq_count12 < 1 => 0.017605,
	    1 <= iv_inq_count12                          => -0.873322,
	                                                    0.000000);
	
	iv_input_addr_not_most_recent := if(not(truedid), NULL, if(rc_input_addr_not_most_recent, 1, 0));
	
	f_subscore18 := map(
	    (iv_input_addr_not_most_recent in [0]) => 0.035313,
	    (iv_input_addr_not_most_recent in [1]) => -0.262108,
	                                              0.000000);
	
	iv_paw_source_count := if(not(truedid), NULL, paw_source_count);
	
	f_subscore19 := map(
	    NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.014464,
	    1 <= iv_paw_source_count                               => 0.618767,
	                                                              0.000000);
	
	iv_combo_sec_rangescore := if(not(truedid), NULL, rc_combo_sec_rangescore);
	
	f_subscore20 := map(
	    NULL < iv_combo_sec_rangescore AND iv_combo_sec_rangescore < 100 => -0.401440,
	    100 <= iv_combo_sec_rangescore AND iv_combo_sec_rangescore < 255 => 0.239883,
	    255 <= iv_combo_sec_rangescore                                   => 0.000000,
	                                                                        0.000000);
	
	iv_ssn_score := if(not(truedid and ssnlength > 0), NULL, combo_ssnscore);
	
	f_subscore21 := map(
	    NULL < iv_ssn_score AND iv_ssn_score < 100 => -0.282065,
	    100 <= iv_ssn_score AND iv_ssn_score < 255 => 0.029811,
	    255 <= iv_ssn_score                        => -0.000000,
	                                                  -0.000000);
	
	iv_rec_vehx_level := map(
	    not(truedid)                                   => ' ',
	    attr_num_aircraft > 0 and watercraft_count > 0 => 'B',
	    attr_num_aircraft > 0                          => 'A',
	    watercraft_count > 0                           => (string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3),
	                                                      '0');
	
	f_subscore22 := map(
	    (iv_rec_vehx_level in ['0'])                     => -0.005706,
	    (iv_rec_vehx_level in ['1', '2', '3', 'A', 'B']) => 0.923826,
	                                                        0.000000);
	
	iv_filing_count := if(not(truedid), NULL, filing_count);
	
	f_subscore23 := map(
	    NULL < iv_filing_count AND iv_filing_count < 1 => 0.006729,
	    1 <= iv_filing_count                           => -0.782524,
	                                                      0.000000);
	
	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);
	
	f_subscore24 := map(
	    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.009192,
	    1 <= iv_eviction_count                             => -0.378638,
	                                                          0.000000);
	
	// ver_src_ba := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',');
	ver_src_ba := stringlib.stringfind(ver_sources, 'BA', 1);
	
	bk_flag := (rc_bansflag in ['1', '2']) or 
		ver_src_ba > 0 or 
		bankrupt > 0 or 
		filing_count > 0 or 
		bk_recent_count > 0;
	
	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;
	
	// ver_src_l2 := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',');
	ver_src_l2 := stringlib.stringfind(ver_sources, 'L2', 1);
	
	// ver_src_li := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'Li', ',');
	ver_src_li := stringlib.stringfind(ver_sources, 'LI', 1);
	
	lien_flag := ver_src_l2 > 0 or 
							 ver_src_li > 0 or 
							 lien_rec_unrel_flag or 
							 lien_hist_unrel_flag;
	
	// ver_src_ds := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');
	ver_src_ds := stringlib.stringfind(ver_sources, 'DS', 1);
	
	ssn_deceased := (integer)rc_decsflag = 1 or ver_src_ds > 0;
	
	scored_222s := sum(property_owned_total,property_sold_total)>0
										or (90 <= combo_dobscore AND combo_dobscore <= 100) 
										or (integer)input_dob_match_level >= 7 
										or lien_flag 
										or criminal_count > 0 
										or bk_flag
										or ssn_deceased
										or truedid;
											
	base := 655;
	
	point := 40;
	
	odds := (1 - 0.410) / 0.410;
	
	f_rawscore := if(
	max(f_subscore0, f_subscore1, f_subscore2, f_subscore3, f_subscore4, f_subscore5, f_subscore6, f_subscore7, f_subscore8, f_subscore9, f_subscore10, f_subscore11, f_subscore12, f_subscore13, f_subscore14, f_subscore15, f_subscore16, f_subscore17, f_subscore18, f_subscore19, f_subscore20, f_subscore21, f_subscore22, f_subscore23, f_subscore24) = NULL,
	NULL, 
	sum(if(f_subscore0 = NULL, 0, f_subscore0), 
			if(f_subscore1 = NULL, 0, f_subscore1), 
			if(f_subscore2 = NULL, 0, f_subscore2), 
			if(f_subscore3 = NULL, 0, f_subscore3), 
			if(f_subscore4 = NULL, 0, f_subscore4), 
			if(f_subscore5 = NULL, 0, f_subscore5), 
			if(f_subscore6 = NULL, 0, f_subscore6), 
			if(f_subscore7 = NULL, 0, f_subscore7), 
			if(f_subscore8 = NULL, 0, f_subscore8), 
			if(f_subscore9 = NULL, 0, f_subscore9), 
			if(f_subscore10 = NULL, 0, f_subscore10), 
			if(f_subscore11 = NULL, 0, f_subscore11), 
			if(f_subscore12 = NULL, 0, f_subscore12), 
			if(f_subscore13 = NULL, 0, f_subscore13), 
			if(f_subscore14 = NULL, 0, f_subscore14), 
			if(f_subscore15 = NULL, 0, f_subscore15), 
			if(f_subscore16 = NULL, 0, f_subscore16), 
			if(f_subscore17 = NULL, 0, f_subscore17), 
			if(f_subscore18 = NULL, 0, f_subscore18), 
			if(f_subscore19 = NULL, 0, f_subscore19), 
			if(f_subscore20 = NULL, 0, f_subscore20), 
			if(f_subscore21 = NULL, 0, f_subscore21), 
			if(f_subscore22 = NULL, 0, f_subscore22), 
			if(f_subscore23 = NULL, 0, f_subscore23), 
			if(f_subscore24 = NULL, 0, f_subscore24)));
	
	f_lnoddsscore := f_rawscore + 0.285745;
	
	f_probscore := exp(f_lnoddsscore) / (1 + exp(f_lnoddsscore));
	
	rvt1204_1_2 := map(
	    ssn_deceased                                                                    => 200,
	    riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
	 max(
	 min(if(round(point * (ln(f_probscore / (1 - f_probscore)) - ln(odds)) / ln(2) + base) = NULL, 
	 -NULL, round(point * (ln(f_probscore / (1 - f_probscore)) - ln(odds)) / ln(2) + base)), 
						900), 
		501));
	
	ssnpriordob := rc_ssndobflag = 1;
	
	ssninvalid := rc_ssnvalflag = 1;
	
	rvt1204_1_1 := if(ssnpriordob and rvt1204_1_2 > 670, 670, rvt1204_1_2);
	
	rvt1204_1 := if(ssninvalid and rvt1204_1_1 > 660, 660, rvt1204_1_1);
	
	glrc03 := 1;
	
	glrc06 := 1;
	
	glrc26 := ssnlength > 0 and truedid;
	
	glrc29 := ssnlength > 0 and truedid;
	
	glrc97 := criminal_count > 0;
	
	glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
	
	glrc99 := not add1_isbestmatch;
	
	glrc9a := property_owned_total = 0 and not((add1_naprop in [3, 4]));
	
	glrc9c := addrpop and inp_addr_date_first_seen > 0;
	
	glrc9d := addrs_per_ssn > 0 and ssnlength > 0;
	
	glrc9e := addrpop and out_addr_type = 'H';
	
	glrc9h := impulse_count > 0;
	
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
	
	glrc9i := 18 <= iv_combined_age AND iv_combined_age <= 25;
	
	glrc9m := (integer)wealth_index < 6;
	
	glrc9o := not add1_eda_sourced;
	
	glrc9q := inq_count12 > 0;
	
	glrc9r := truedid;
	
	glrc9u := add1_pop and add1_advo_address_vacancy != ' ';
	
	glrc9w := bankrupt > 0;
	
	glrcev := attr_eviction_count > 0;
	
	glrcms := ssns_per_adl >= 2;
	
	glrcpv := add1_avm_automated_valuation > 0;
	
	glrcbl := 0;
	
	rcvalue03_1 := 998 * (integer)(rc_ssndobflag = 1);
	
	rcvalue03 := glrc03 * if(max(rcvalue03_1) = NULL, NULL, sum(if(rcvalue03_1 = NULL, 0, rcvalue03_1)));
	
	rcvalue06_1 := 999 * (integer)(rc_ssnvalflag = 1);
	
	rcvalue06 := glrc06 * if(max(rcvalue06_1) = NULL, NULL, sum(if(rcvalue06_1 = NULL, 0, rcvalue06_1)));
	
	rcvalue26_1 := (integer)(not rc_ssnmiskeyflag) * (0.029811 - f_subscore21);
	
	rcvalue26 := (integer)glrc26 * if(max(rcvalue26_1) = NULL, NULL, sum(if(rcvalue26_1 = NULL, 0, rcvalue26_1)));
	
	rcvalue29_1 := (integer)(rc_ssnmiskeyflag) * (0.029811 - f_subscore21);
	
	rcvalue29 := (integer)glrc29 * if(max(rcvalue29_1) = NULL, NULL, sum(if(rcvalue29_1 = NULL, 0, rcvalue29_1)));
	
	rcvalue97_1 := 0.041485 - f_subscore3;
	
	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));
	
	rcvalue98_1 := 0.035592 - f_subscore11;
	
	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));
	
	rcvalue99_1 := 0.035313 - f_subscore18;
	
	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));
	
	rcvalue9a_1 := 0.314446 - f_subscore5;
	
	rcvalue9a_2 := 0.237323 - f_subscore9;
	
	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2)));
	
	rcvalue9c_1 := 0.403892 - f_subscore4;
	
	rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1)));
	
	rcvalue9d_1 := 0.234458 - f_subscore6;
	
	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));
	
	rcvalue9e_1 := 0.239883 - f_subscore20;
	
	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));
	
	rcvalue9h_1 := 0.032535 - f_subscore10;
	
	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));
	
	rcvalue9i_1 := 0.808658 - f_subscore8;
	
	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));
	
	rcvalue9m_1 := 0.161306 - f_subscore13;
	
	rcvalue9m_2 := 0.923826 - f_subscore22;
	
	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2)));
	
	rcvalue9o_1 := 0.467924 - f_subscore0;
	
	rcvalue9o := (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1)));
	
	rcvalue9q_1 := 0.017605 - f_subscore17;
	
	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));
	
	rcvalue9r_1 := 0.618767 - f_subscore19;
	
	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));
	
	rcvalue9u_1 := 0.015401 - f_subscore16;
	
	rcvalue9u := (integer)glrc9r * if(max(rcvalue9u_1) = NULL, NULL, sum(if(rcvalue9u_1 = NULL, 0, rcvalue9u_1)));
	
	rcvalue9w_1 := 0.006729 - f_subscore23;
	
	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));
	
	rcvalueev_1 := 0.009192 - f_subscore24;
	
	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));
	
	rcvaluems_1 := 0.045363 - f_subscore14;
	
	rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));
	
	rcvaluepv_1 := 0.429232 - f_subscore1;
	
	rcvaluepv_2 := 0.717112 - f_subscore7;
	
	rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1, rcvaluepv_2) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2)));
	
	rcvaluebl_1 := 0.139935 - f_subscore2;
	
	rcvaluebl_2 := 0.036594 - f_subscore12;
	
	rcvaluebl_3 := 1.176721 - f_subscore15;
	
	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3)));
	
	//######################################################################################
	// The flagship RV Reason Code logic can be adapted to construct Reason Codes from
	// the above logic and the dataset created below...I think.
	//######################################################################################
	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
	    {'03', rcvalue03},
	    {'06', rcvalue06},
	    {'26', rcvalue26},
	    {'29', rcvalue29},
	    {'97', rcvalue97},
	    {'98', rcvalue98},
	    {'99', rcvalue99},
	    {'9A', rcvalue9a},
	    {'9C', rcvalue9c},
	    {'9D', rcvalue9d},
	    {'9E', rcvalue9e},
	    {'9H', rcvalue9h},
	    {'9I', rcvalue9i},
	    {'9M', rcvalue9m},
	    {'9O', rcvalue9o},
	    {'9Q', rcvalue9q},
	    {'9R', rcvalue9r},
	    {'9U', rcvalue9u},
	    {'9W', rcvalue9w},
	    {'EV', rcvalueev},
	    {'MS', rcvaluems},
	    {'PV', rcvaluepv},
			{'BL', rcvaluebl}
		], ds_layout)(value > 0); // Keep all the reason codes that actually have a value
		
	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	rcs_9q := rcs_top4 &
		IF((INTEGER)GLRC9Q > 0 AND NOT EXISTS(rcs_top4 (rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
				 inq_count12 > 0,
			DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.

	rcs_override := MAP(
											rvt1204_1 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvt1204_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
											NOT EXISTS(rcs_9q) => DATASET([{'36', NULL}], ds_layout),
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
						
	// zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	zeros := DATASET([], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes
	
	final_score := MAP(
											riTemp[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)riTemp[1].hri + 10),
											Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => '222',
											reasons[1].hri='35' => '100',
											(STRING3)rvt1204_1
										);
	
	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.out_addr_type := out_addr_type;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_combo_sec_rangescore := (string)rc_combo_sec_rangescore;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := (string)rc_ssndobflag;
		SELF.rc_ssnvalflag := (string)rc_ssnvalflag;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
		SELF.combo_ssnscore := combo_ssnscore;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_count := ver_sources_count;
		SELF.addrpop := if(addrpop, '1', '0');
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := if(hphnpop, '1', '0');
		SELF.age := (string)age;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_advo_address_vacancy := add1_advo_address_vacancy;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_eda_sourced := add1_eda_sourced;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_date_first_seen := (string)add1_date_first_seen;
		SELF.add1_pop := if(add1_pop, '1','0');
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_total := property_sold_total;
		SELF.add2_avm_automated_valuation := (string)add2_avm_automated_valuation;
		SELF.add2_naprop := (string)add2_naprop;
		SELF.add3_avm_automated_valuation := (string)add3_avm_automated_valuation;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.adls_per_phone_c6 := adls_per_phone_c6;
		SELF.inq_count12 := (string)inq_count12;
		SELF.paw_source_count := (string)paw_source_count;
		SELF.infutor_nap := (string)infutor_nap;
		SELF.impulse_count := impulse_count;
		SELF.attr_num_aircraft := (string)attr_num_aircraft;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.watercraft_count := (string)watercraft_count;
		SELF.ams_age := (string)ams_age;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.prof_license_flag := if(prof_license_flag, '1', '0');
		SELF.wealth_index := wealth_index;
		SELF.input_dob_age := input_dob_age;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;
		SELF.estimated_income := (string)estimated_income;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.NULL := (string)NULL;
		SELF.sysdate := sysdate;
		SELF.ver_phn_inf := if(ver_phn_inf, '1','0');
		SELF.ver_phn_nap := if(ver_phn_nap, '1','0');
		SELF.inf_phn_ver_lvl := (string)inf_phn_ver_lvl;
		SELF.nap_phn_ver_lvl := (string)nap_phn_ver_lvl;
		SELF.iv_nap_phn_ver_x_inf_phn_ver := iv_nap_phn_ver_x_inf_phn_ver;
		SELF.f_subscore0 := (string)f_subscore0;
		SELF.iv_inp_addr_avm_auto_val := (string)iv_inp_addr_avm_auto_val;
		SELF.f_subscore1 := (string)f_subscore1;
		SELF.iv_max_ids_per_addr_c6 := (string)iv_max_ids_per_addr_c6;
		SELF.f_subscore2 := (string)f_subscore2;
		SELF.iv_criminal_x_felony := (string)iv_criminal_x_felony;
		SELF.f_subscore3 := (string)f_subscore3;
		SELF.inp_addr_date_first_seen := (string)inp_addr_date_first_seen;
		SELF.iv_mos_since_inp_addr_fseen := (string)iv_mos_since_inp_addr_fseen;
		SELF.f_subscore4 := (string)f_subscore4;
		SELF.iv_bst_own_prop_x_addr_naprop_c14 := (string)iv_bst_own_prop_x_addr_naprop_c14;
		SELF.iv_bst_own_prop_x_addr_naprop_c15 := (string)iv_bst_own_prop_x_addr_naprop_c15;
		SELF.iv_bst_own_prop_x_addr_naprop := (string)iv_bst_own_prop_x_addr_naprop;
		SELF.f_subscore5 := (string)f_subscore5;
		SELF.iv_addrs_per_ssn := (string)iv_addrs_per_ssn;
		SELF.f_subscore6 := (string)f_subscore6;
		SELF.iv_prv_addr_avm_auto_val := (string)iv_prv_addr_avm_auto_val;
		SELF.f_subscore7 := (string)f_subscore7;
		SELF._ams_college_code := _ams_college_code;
		SELF.iv_ams_college_code_x_type := iv_ams_college_code_x_type;
		SELF.f_subscore8 := (string)f_subscore8;
		SELF.iv_inp_own_prop_x_addr_naprop := iv_inp_own_prop_x_addr_naprop;
		SELF.f_subscore9 := (string)f_subscore9;
		SELF.iv_impulse_count := (string)iv_impulse_count;
		SELF.f_subscore10 := (string)f_subscore10;
		SELF.iv_src_liens_adl_count := (string)iv_src_liens_adl_count;
		SELF.f_subscore11 := (string)f_subscore11;
		SELF.iv_adls_per_phone_c6 := (string)iv_adls_per_phone_c6;
		SELF.f_subscore12 := (string)f_subscore12;
		SELF.iv_estimated_income := (string)iv_estimated_income;
		SELF.f_subscore13 := (string)f_subscore13;
		SELF.iv_ssns_per_adl := (string)iv_ssns_per_adl;
		SELF.f_subscore14 := (string)f_subscore14;
		SELF.iv_prof_license_flag := (string)iv_prof_license_flag;
		SELF.f_subscore15 := (string)f_subscore15;
		SELF.iv_inp_addr_vacant := iv_inp_addr_vacant;
		SELF.f_subscore16 := (string)f_subscore16;
		SELF.iv_inq_count12 := (string)iv_inq_count12;
		SELF.f_subscore17 := (string)f_subscore17;
		SELF.iv_input_addr_not_most_recent := (string)iv_input_addr_not_most_recent;
		SELF.f_subscore18 := (string)f_subscore18;
		SELF.iv_paw_source_count := (string)iv_paw_source_count;
		SELF.f_subscore19 := (string)f_subscore19;
		SELF.iv_combo_sec_rangescore := (string)iv_combo_sec_rangescore;
		SELF.f_subscore20 := (string)f_subscore20;
		SELF.iv_ssn_score := (string)iv_ssn_score;
		SELF.f_subscore21 := (string)f_subscore21;
		SELF.iv_rec_vehx_level := iv_rec_vehx_level;
		SELF.f_subscore22 := (string)f_subscore22;
		SELF.iv_filing_count := (string)iv_filing_count;
		SELF.f_subscore23 := (string)f_subscore23;
		SELF.iv_eviction_count := (string)iv_eviction_count;
		SELF.f_subscore24 := (string)f_subscore24;
		SELF.ver_src_ba := (string)ver_src_ba;
		SELF.bk_flag := if(bk_flag, '1','0');
		SELF.lien_rec_unrel_flag := if(lien_rec_unrel_flag, '1','0');
		SELF.lien_hist_unrel_flag := if(lien_hist_unrel_flag, '1','0');
		SELF.ver_src_l2 := (string)ver_src_l2;
		SELF.ver_src_li := (string)ver_src_li;
		SELF.lien_flag := if(lien_flag, '1','0');
		SELF.ver_src_ds := (string)ver_src_ds;
		SELF.ssn_deceased := if(ssn_deceased, '1','0');
		SELF.scored_222s := if(scored_222s, '1','0');
		SELF.base := (string)base;
		SELF.point := (string)point;
		SELF.odds := (string)odds;
		SELF.f_rawscore := (string)f_rawscore;
		SELF.f_lnoddsscore := (string)f_lnoddsscore;
		SELF.f_probscore := (string)f_probscore;
		SELF.rvt1204_1_2 := (string)rvt1204_1_2;
		SELF.ssnpriordob := if(ssnpriordob, '1','0');
		SELF.ssninvalid := if(ssninvalid, '1','0');
		SELF.rvt1204_1_1 := (string)rvt1204_1_1;
		SELF.rvt1204_1 := (string)rvt1204_1;
		SELF.glrc03 := (string)glrc03;
		SELF.glrc06 := (string)glrc06;
		SELF.glrc26 := (string)glrc26;
		SELF.glrc29 := (string)glrc29;
		SELF.glrc97 := (string)glrc97;
		SELF.glrc98 := (string)glrc98;
		SELF.glrc99 := (string)glrc99;
		SELF.glrc9a := (string)glrc9a;
		SELF.glrc9c := (string)glrc9c;
		SELF.glrc9d := (string)glrc9d;
		SELF.glrc9e := (string)glrc9e;
		SELF.glrc9h := (string)glrc9h;
		SELF._reported_dob := (string)_reported_dob;
		SELF.reported_age := (string)reported_age;
		SELF.iv_combined_age := (string)iv_combined_age;
		SELF.glrc9i := (string)glrc9i;
		SELF.glrc9m := (string)glrc9m;
		SELF.glrc9o := (string)glrc9o;
		SELF.glrc9q := (string)glrc9q;
		SELF.glrc9r := (string)glrc9r;
		SELF.glrc9u := (string)glrc9u;
		SELF.glrc9w := (string)glrc9w;
		SELF.glrcev := (string)glrcev;
		SELF.glrcms := (string)glrcms;
		SELF.glrcpv := (string)glrcpv;
		SELF.glrcbl := (string)glrcbl;
		SELF.rcvalue03_1 := (string)rcvalue03_1;
		SELF.rcvalue03 := (string)rcvalue03;
		SELF.rcvalue06_1 := (string)rcvalue06_1;
		SELF.rcvalue06 := (string)rcvalue06;
		SELF.rcvalue26_1 := (string)rcvalue26_1;
		SELF.rcvalue26 := (string)rcvalue26;
		SELF.rcvalue29_1 := (string)rcvalue29_1;
		SELF.rcvalue29 := (string)rcvalue29;
		SELF.rcvalue97_1 := (string)rcvalue97_1;
		SELF.rcvalue97 := (string)rcvalue97;
		SELF.rcvalue98_1 := (string)rcvalue98_1;
		SELF.rcvalue98 := (string)rcvalue98;
		SELF.rcvalue99_1 := (string)rcvalue99_1;
		SELF.rcvalue99 := (string)rcvalue99;
		SELF.rcvalue9a_1 := (string)rcvalue9a_1;
		SELF.rcvalue9a_2 := (string)rcvalue9a_2;
		SELF.rcvalue9a := (string)rcvalue9a;
		SELF.rcvalue9c_1 := (string)rcvalue9c_1;
		SELF.rcvalue9c := (string)rcvalue9c;
		SELF.rcvalue9d_1 := (string)rcvalue9d_1;
		SELF.rcvalue9d := (string)rcvalue9d;
		SELF.rcvalue9e_1 := (string)rcvalue9e_1;
		SELF.rcvalue9e := (string)rcvalue9e;
		SELF.rcvalue9h_1 := (string)rcvalue9h_1;
		SELF.rcvalue9h := (string)rcvalue9h;
		SELF.rcvalue9i_1 := (string)rcvalue9i_1;
		SELF.rcvalue9i := (string)rcvalue9i;
		SELF.rcvalue9m_1 := (string)rcvalue9m_1;
		SELF.rcvalue9m_2 := (string)rcvalue9m_2;
		SELF.rcvalue9m := (string)rcvalue9m;
		SELF.rcvalue9o_1 := (string)rcvalue9o_1;
		SELF.rcvalue9o := (string)rcvalue9o;
		SELF.rcvalue9q_1 := (string)rcvalue9q_1;
		SELF.rcvalue9q := (string)rcvalue9q;
		SELF.rcvalue9r_1 := (string)rcvalue9r_1;
		SELF.rcvalue9r := (string)rcvalue9r;
		SELF.rcvalue9u_1 := (string)rcvalue9u_1;
		SELF.rcvalue9u := (string)rcvalue9u;
		SELF.rcvalue9w_1 := (string)rcvalue9w_1;
		SELF.rcvalue9w := (string)rcvalue9w;
		SELF.rcvalueev_1 := (string)rcvalueev_1;
		SELF.rcvalueev := (string)rcvalueev;
		SELF.rcvaluems_1 := (string)rcvaluems_1;
		SELF.rcvaluems := (string)rcvaluems;
		SELF.rcvaluepv_1 := (string)rcvaluepv_1;
		SELF.rcvaluepv_2 := (string)rcvaluepv_2;
		SELF.rcvaluepv := (string)rcvaluepv;
		SELF.rcvaluebl_1 := (string)rcvaluebl_1;
		SELF.rcvaluebl_2 := (string)rcvaluebl_2;
		SELF.rcvaluebl_3 := (string)rcvaluebl_3;
		SELF.rcvaluebl := (string)rcvaluebl;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;
		SELF.rc5 := reasons[5].hri;

		SELF.clam := le;
		self.seq := le.seq;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)final_score;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
	
END;

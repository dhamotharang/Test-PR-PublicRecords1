//DM Services 4359	- ADL FCRA 4.1 Modeling Shell 
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVP1401_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  RVP_DEBUG := FALSE;	
	
	#if(RVP_DEBUG)
		layout_debug := record
			integer sysdate;                                              
			string iv_vp002_phn_disconnected;                            
			integer _header_first_seen;                                   
			integer iv_sr001_m_hdr_fs;                                    
			integer iv_ms001_ssns_per_adl;                                
			integer iv_pv001_bst_avm_autoval;                             
			integer iv_pl002_addrs_15yr;                                  
			string iv_bst_own_prop_x_addr_naprop;                        
			integer iv_property_sold_total;                               
			integer iv_dist_inp_addr_to_prv_addr;                         
			integer _gong_did_first_seen;                                 
			integer iv_mos_since_gong_did_fst_seen;                       
			integer iv_ssns_per_addr;                                     
			integer iv_inq_recency;                                       
			integer iv_paw_source_count;                                  
			boolean ver_phn_inf;                                          
			boolean ver_phn_nap;                                          
			integer inf_phn_ver_lvl;                                      
			integer nap_phn_ver_lvl;                                      
			string iv_nap_phn_ver_x_inf_phn_ver;                         
			integer iv_liens_unrel_cj_ct;                                 
			integer sum_dols;                                             
			real pct_offline_dols;                                     
			real pct_retail_dols;                                      
			real pct_online_dols;                                      
			string iv_pb_profile;                                        
			real rsk_subscore0;                                        
			real rsk_subscore1;                                        
			real rsk_subscore2;                                        
			real rsk_subscore3;                                        
			real rsk_subscore4;                                        
			real rsk_subscore5;                                        
			real rsk_subscore6;                                        
			real rsk_subscore7;                                        
			real rsk_subscore8;                                        
			real rsk_subscore9;                                        
			real rsk_subscore10;                                       
			real rsk_subscore11;                                       
			real rsk_subscore12;                                       
			real rsk_subscore13;                                       
			real rsk_subscore14;                                       
			real rsk_subscore15;                                       
			real rsk_rawscore;                                         
			real rsk_lnoddsscore;                                      
			real rsk_probscore;                                        
			boolean ssn_deceased;                                         
			boolean rv_20_content;                                        
			boolean eda_sourced;                                          
			boolean eq_only;                                              
			boolean rv_prescreen_content;                                 
			integer base;                                                 
			integer pts;                                                  
			real odds;                                                 
			integer rvp1401_2_0;                                          
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end	
	
	adl_addr                         := le.adl_shell_flags.adl_addr;
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	paw_source_count                 := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_file_type                    := le.student.file_type2;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;	
	
	NULL := -999999999;


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_vp002_phn_disconnected := map(
			not(hphnpop)                                                             => ' ',
			rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
																																									'0');

	_header_first_seen := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

	iv_bst_own_prop_x_addr_naprop_c7 := if(property_owned_total > 0, (string) (add1_naprop + 10), ('0'+(string) add1_naprop)[-2..]); 
	iv_bst_own_prop_x_addr_naprop_c8 := if(property_owned_total > 0, (string) (add2_naprop + 10), ('0'+(string) add2_naprop)[-2..]);

	iv_bst_own_prop_x_addr_naprop := map(
			not(truedid)     => '  ',
			add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c7,
													iv_bst_own_prop_x_addr_naprop_c8);

	iv_property_sold_total := if(not(truedid or add1_pop), NULL, property_sold_total);

	iv_dist_inp_addr_to_prv_addr := map(
			not(truedid)     => NULL,
			add1_isbestmatch => dist_a1toa2,
													dist_a1toa3);

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

	iv_ssns_per_addr := if(not(add1_pop), NULL, ssns_per_addr);

	iv_inq_recency := map(
			not(truedid) => NULL,
			inq_count01  >0 => 1,
			inq_count03  >0 => 3,
		  inq_count06  >0 => 6,
			inq_count12  >0 => 12,
			inq_count24  >0 => 24,
			inq_count    >0 => 99,
											0);

	iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

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
																 trim((string) nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) inf_phn_ver_lvl, LEFT, RIGHT));

	iv_liens_unrel_cj_ct := if(not(truedid), NULL, liens_unrel_CJ_ct);
//set '' to NULL and leave values that are 0 to still be 0
	pb_offline_dollars_tmp := if(pb_offline_dollars = '', NULL, (real) pb_offline_dollars);
	pb_online_dollars_tmp := if(pb_online_dollars = '', NULL, (real) pb_online_dollars);
	pb_retail_dollars_tmp := if(pb_retail_dollars = '', NULL, (real) pb_retail_dollars);

	sum_dols := (integer) if(max(pb_offline_dollars_tmp, pb_online_dollars_tmp, pb_retail_dollars_tmp) = NULL, 
				NULL, 
				sum(if(pb_offline_dollars_tmp = NULL, 0, pb_offline_dollars_tmp), 
						if(pb_online_dollars_tmp = NULL, 0, pb_online_dollars_tmp), 
						if(pb_retail_dollars_tmp = NULL, 0, pb_retail_dollars_tmp)
				));
				
	pct_offline_dols := if(sum_dols > 0, (real) pb_offline_dollars_tmp / sum_dols, -1);

	pct_retail_dols := if(sum_dols > 0, (real) pb_retail_dollars_tmp / sum_dols, -1);

	pct_online_dols := if(sum_dols > 0, (real) pb_online_dollars_tmp / sum_dols, -1);
	
	iv_pb_profile := map(
			not(truedid)                => '                 ',
			pb_number_of_sources = '' => '0 No Purch Data  ',
			pct_offline_dols > .50      => '1 Offline Shopper',
			pct_online_dols > .50       => '2 Online Shopper ',
			pct_retail_dols > .50       => '3 Retail Shopper ',
																		 '4 Other');

	rsk_subscore0 := map(
			(iv_bst_own_prop_x_addr_naprop in [' '])                    => -0.000000,
			(iv_bst_own_prop_x_addr_naprop in ['01'])                   => -0.267877,
			(iv_bst_own_prop_x_addr_naprop in ['00'])                   => -0.287039,
			(iv_bst_own_prop_x_addr_naprop in ['02', '03'])             => 0.009914,
			(iv_bst_own_prop_x_addr_naprop in ['10', '11', '12', '13']) => 0.521543,
			(iv_bst_own_prop_x_addr_naprop in ['04', '14'])             => 0.559161,
																																		 -0.000000);

	rsk_subscore1 := map(
			NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 1   => -0.000000,
			1 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 238   => -0.388213,
			238 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 260 => -0.250363,
			260 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 276 => -0.092590,
			276 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 283 => -0.038239,
			283 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 302 => 0.004747,
			302 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 326 => 0.065354,
			326 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 382 => 0.315907,
			382 <= iv_sr001_m_hdr_fs                             => 0.565674,
																															-0.000000);

	rsk_subscore2 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in [' '])                                                    => -0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                                   => -0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['1-0', '1-1', '1-3'])                                    => -0.285518,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '0-3', '2-0', '2-1', '2-3', '3-1', '3-3']) => -0.127978,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                  => 0.566981,
																																																		-0.000000);

	rsk_subscore3 := map(
			NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.407617,
			2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3   => 0.332262,
			3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 4   => 0.191200,
			4 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => 0.041142,
			6 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 7   => -0.207521,
			7 <= iv_pl002_addrs_15yr                               => -0.311419,
																																-0.000000);

	rsk_subscore4 := map(
			(iv_pb_profile in [' '])                           => -0.000000,
			(iv_pb_profile in ['0 No Purch Data'])             => -0.475302,
			(iv_pb_profile in ['1 Offline Shopper'])           => 0.133096,
			(iv_pb_profile in ['2 Online Shopper'])            => 0.149830,
			(iv_pb_profile in ['3 Retail Shopper', '4 Other']) => 0.048857,
																														-0.000000);

	rsk_subscore5 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0  => 0.218828,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 61   => -0.302762,
			61 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 78  => -0.194490,
			78 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 120 => 0.016818,
			120 <= iv_mos_since_gong_did_fst_seen                                         => 0.444999,
																																											 0.000000);

	rsk_subscore6 := map(
			NULL < iv_inq_recency AND iv_inq_recency < 1 => 0.076813,
			1 <= iv_inq_recency AND iv_inq_recency < 12  => -0.712111,
			12 <= iv_inq_recency                         => -0.485755,
																											0.000000);

	rsk_subscore7 := map(
			NULL < iv_ssns_per_addr AND iv_ssns_per_addr < 1 => 0.053550,
			1 <= iv_ssns_per_addr AND iv_ssns_per_addr < 2   => 0.249608,
			2 <= iv_ssns_per_addr AND iv_ssns_per_addr < 3   => 0.385434,
			3 <= iv_ssns_per_addr AND iv_ssns_per_addr < 5   => 0.240707,
			5 <= iv_ssns_per_addr AND iv_ssns_per_addr < 7   => 0.165859,
			7 <= iv_ssns_per_addr AND iv_ssns_per_addr < 9   => 0.005559,
			9 <= iv_ssns_per_addr AND iv_ssns_per_addr < 13  => -0.199007,
			13 <= iv_ssns_per_addr                           => -0.232214,
																													-0.000000);

	rsk_subscore8 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.027045,
			1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 62087       => -0.373780,
			62087 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 76641   => -0.193602,
			76641 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 103032  => 0.100456,
			103032 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 260242 => 0.384391,
			260242 <= iv_pv001_bst_avm_autoval                                       => 0.616194,
																																									0.000000);

	rsk_subscore9 := map(
			NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 1   => -0.088953,
			1 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 7     => -0.141174,
			7 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 353   => -0.011351,
			353 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 881 => 0.309282,
			881 <= iv_dist_inp_addr_to_prv_addr                                        => 0.592612,
																																										-0.000000);

	rsk_subscore10 := map(
			NULL < iv_property_sold_total AND iv_property_sold_total < 1 => -0.075093,
			1 <= iv_property_sold_total                                  => 0.557018,
																																			0.000000);

	rsk_subscore11 := map(
			NULL < iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 1 => 0.040588,
			1 <= iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 2   => -0.550669,
			2 <= iv_liens_unrel_cj_ct                                => -1.066430,
																																	0.000000);

	rsk_subscore12 := map(
			NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.045103,
			1 <= iv_paw_source_count                               => 0.637202,
																																0.000000);

	rsk_subscore13 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.067390,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.108498,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.211171,
			4 <= iv_ms001_ssns_per_adl                                 => -0.731953,
																																		-0.000000);

	rsk_subscore14 := map(
			(iv_vp002_phn_disconnected in [' ']) => 0.000000,
			(iv_vp002_phn_disconnected in ['0']) => 0.041956,
			(iv_vp002_phn_disconnected in ['1']) => -0.345368,
																							0.000000);

	rsk_subscore15 := map(
			(adl_addr in [0]) => -0.000000,
			(adl_addr in [2]) => 0.097699,
			(adl_addr in [3]) => -0.121814,
														 -0.000000);

	rsk_rawscore := rsk_subscore0 +
			rsk_subscore1 +
			rsk_subscore2 +
			rsk_subscore3 +
			rsk_subscore4 +
			rsk_subscore5 +
			rsk_subscore6 +
			rsk_subscore7 +
			rsk_subscore8 +
			rsk_subscore9 +
			rsk_subscore10 +
			rsk_subscore11 +
			rsk_subscore12 +
			rsk_subscore13 +
			rsk_subscore14 +
			rsk_subscore15;

	rsk_lnoddsscore := rsk_rawscore + 0.626786;

	rsk_probscore := exp(rsk_lnoddsscore) / (1 + exp(rsk_lnoddsscore));

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	rv_20_content := nas_summary > 4 or nap_summary > 4 or add1_naprop > 2;

	eda_sourced := (nap_summary in [2, 3, 5, 6, 7, 8, 9, 10, 11, 12]);

	eq_only := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EQ', ',') and Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') = 1 and not(eda_sourced);

	rv_prescreen_content := (rv_20_content or eda_sourced or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EM', ',') or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'VO', ',') or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',')  or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'V', ',') or 
	add1_naprop > 2 or prof_license_flag or add1_avm_land_use != '' or 
	trim(ams_file_type, LEFT, RIGHT) != '' or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EB', ',') or
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'W', ',')  or
	watercraft_count > 0 or if(max(property_owned_total, property_sold_total) = NULL, NULL, 
	sum(if(property_owned_total = NULL, 0, property_owned_total), 
	if(property_sold_total = NULL, 0, property_sold_total))) > 0 or
	90 <= combo_dobscore AND combo_dobscore <= 100 or 
	input_dob_match_level >= '7' or 
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') or
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') or
	liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or 
	criminal_count > 0 or (rc_bansflag in ['1', '2']) or
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') or
	bankrupt or filing_count > 0 or bk_recent_count > 0 or rc_decsflag = '1' or
	indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or
	truedid) and not(eq_only)
	and truedid;

	base := 680;

	pts := 40;

	odds := (1 - .3539) / .3539;
		
	rvp1401_2_0 := map(
			ssn_deceased             => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																	min(if(max(round(pts * (ln(rsk_probscore / (1 - rsk_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(rsk_probscore / (1 - rsk_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));


//Intermediate variables
	#if(RVP_DEBUG)
		 self.clam														 := le;
	   self.sysdate                          := sysdate;                                                  
		 self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;                                
		 self._header_first_seen               := _header_first_seen;                                       
		 self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;                                        
		 self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                                    
		 self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;                                 
		 self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;                                      
		 self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;                            
		 self.iv_property_sold_total           := iv_property_sold_total;                                   
		 self.iv_dist_inp_addr_to_prv_addr     := iv_dist_inp_addr_to_prv_addr;                             
		 self._gong_did_first_seen             := _gong_did_first_seen;                                     
		 self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;                           
		 self.iv_ssns_per_addr                 := iv_ssns_per_addr;                                         
		 self.iv_inq_recency                   := iv_inq_recency;                                           
		 self.iv_paw_source_count              := iv_paw_source_count;                                      
		 self.ver_phn_inf                      := ver_phn_inf;                                              
		 self.ver_phn_nap                      := ver_phn_nap;                                              
		 self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                                          
		 self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                                          
		 self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;                             
		 self.iv_liens_unrel_cj_ct             := iv_liens_unrel_cj_ct;                                     
		 self.sum_dols                         := sum_dols;                                                 
		 self.pct_offline_dols                 := pct_offline_dols;                                         
		 self.pct_retail_dols                  := pct_retail_dols;                                          
		 self.pct_online_dols                  := pct_online_dols;                                          
		 self.iv_pb_profile                    := iv_pb_profile;                                            
		 self.rsk_subscore0                    := rsk_subscore0;                                            
		 self.rsk_subscore1                    := rsk_subscore1;                                            
		 self.rsk_subscore2                    := rsk_subscore2;                                            
		 self.rsk_subscore3                    := rsk_subscore3;                                            
		 self.rsk_subscore4                    := rsk_subscore4;                                            
		 self.rsk_subscore5                    := rsk_subscore5;                                            
		 self.rsk_subscore6                    := rsk_subscore6;                                            
		 self.rsk_subscore7                    := rsk_subscore7;                                            
		 self.rsk_subscore8                    := rsk_subscore8;                                            
		 self.rsk_subscore9                    := rsk_subscore9;                                            
		 self.rsk_subscore10                   := rsk_subscore10;                                           
		 self.rsk_subscore11                   := rsk_subscore11;                                           
		 self.rsk_subscore12                   := rsk_subscore12;                                           
		 self.rsk_subscore13                   := rsk_subscore13;                                           
		 self.rsk_subscore14                   := rsk_subscore14;                                           
		 self.rsk_subscore15                   := rsk_subscore15;                                           
		 self.rsk_rawscore                     := rsk_rawscore;                                             
		 self.rsk_lnoddsscore                  := rsk_lnoddsscore;                                          
		 self.rsk_probscore                    := rsk_probscore;                                            
		 self.ssn_deceased                     := ssn_deceased;                                             
		 self.rv_20_content                    := rv_20_content;                                            
		 self.eda_sourced                      := eda_sourced;                                              
		 self.eq_only                          := eq_only;                                                  
		 self.rv_prescreen_content             := rv_prescreen_content;                                     
		 self.base                             := base;                                                     
		 self.pts                              := pts;                                                      
		 self.odds                             := odds;       
		 self.rvp1401_2_0                      := rvp1401_2_0;

	#end
	self.seq := le.seq;
	PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
	self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1401_2_0 );
	self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );

	END;

	model := project( clam, doModel(left) );

	return model;
END;
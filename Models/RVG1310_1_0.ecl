import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;
//4.1 FCRA Modeling Shell  
export RVG1310_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := FALSE;

  #if(RVG_DEBUG)
    layout_debug := record
			integer sysdate;                                    
			string iv_rv5_unscorable;                          
			boolean email_src_im;                               
			integer iv_ds001_impulse_count;                     
			integer lien_adl_li_lseen_pos;                      
			string lien_adl_lseen_li;                          
			integer _lien_adl_lseen_li;                         
			integer lien_adl_l2_lseen_pos;                      
			string lien_adl_lseen_l2;                          
			integer _lien_adl_lseen_l2;                         
			integer _src_lien_adl_lseen;                        
			integer iv_dl001_lien_last_seen;                    
			integer _in_dob;                                    
			real yr_in_dob;                                  
			integer yr_in_dob_int;                              
			integer age_estimate;                               
			integer iv_ag001_age;                               
			integer iv_pv001_inp_avm_autoval;                   
			integer iv_pl002_addrs_15yr;                        
			integer iv_iq001_inq_count12;                       
			integer bureau_adl_tn_count_pos;                    
			integer bureau_adl_count_tn;                        
			integer bureau_adl_ts_count_pos;                    
			integer bureau_adl_count_ts;                        
			integer bureau_adl_tu_count_pos;                    
			integer bureau_adl_count_tu;                        
			integer bureau_adl_en_count_pos;                    
			integer bureau_adl_count_en;                        
			integer bureau_adl_eq_count_pos;                    
			integer bureau_adl_count_eq;                        
			integer _src_bureau_adl_count;                      
			integer iv_src_bureau_adl_count;                    
			integer iv_avg_lres;                                
			integer iv_addrs_5yr;                               
			integer iv_hist_addr_match;                         
			integer iv_gong_did_addr_ct;                        
			boolean ver_phn_inf;                                
			boolean ver_phn_nap;                                
			integer inf_phn_ver_lvl;                            
			integer nap_phn_ver_lvl;                            
			string iv_nap_phn_ver_x_inf_phn_ver;               
			string iv_criminal_x_felony;                       
			integer iv_pb_total_dollars;                        
			real genf_subscore0;                             
			real genf_subscore1;                             
			real genf_subscore2;                             
			real genf_subscore3;                             
			real genf_subscore4;                             
			real genf_subscore5;                             
			real genf_subscore6;                             
			real genf_subscore7;                             
			real genf_subscore8;                             
			real genf_subscore9;                             
			real genf_subscore10;                            
			real genf_subscore11;                            
			real genf_subscore12;                            
			real genf_subscore13;                            
			real genf_rawscore;                              
			real genf_lnoddsscore;                           
			string genf_aacd_0;                                
			real genf_dist_0;                                
			string genf_aacd_1;                                
			real genf_dist_1;                                
			string genf_aacd_2;                                
			real genf_dist_2;                                
			string genf_aacd_3;                                
			real genf_dist_3;                                
			string genf_aacd_4;                                
			real genf_dist_4;                                
			string genf_aacd_5;                                
			real genf_dist_5;                                
			string genf_aacd_6;                                
			real genf_dist_6;                                
			string genf_aacd_7;                                
			real genf_dist_7;                                
			string genf_aacd_8;                                
			real genf_dist_8;                                
			string genf_aacd_9;                                
			real genf_dist_9;                                
			string genf_aacd_10;                               
			real genf_dist_10;                               
			string genf_aacd_11;                               
			real genf_dist_11;                               
			string genf_aacd_12;                               
			real genf_dist_12;                               
			string genf_aacd_13;                               
			real genf_dist_13;                               
			real rcvalue9q;                                  
			real rcvalue98;                                  
			real rcvalue9y;                                  
			real rcvalue9r;                                  
			real rcvalue9d;                                  
			real rcvalue9e;                                  
			real rcvalue36;                                  
			real rcvalue9f;                                  
			real rcvalue97;                                  
			real rcvalue9h;                                  
			real rcvaluepv;                                  
			real rcvalue25;                                  
			boolean ssn_deceased;                               
			integer base;                                       
			integer pts;                                        
			real lgt;                                        
			integer rvg1310_1_0;                                
			string genf_rc2;                                   
			string genf_rc4;                                   
			string genf_rc3;                                   
			string genf_rc1;                                   
			string genf_rc5;                                   
			string rc1;                                        
			string rc2;                                        
			string rc3;                                        
			string rc4;                                        
			string rc5;                                                                                                                     
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
	inq_count12                      := le.acc_logs.inquiries.count12;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	inferred_age                     := le.inferred_age;

	NULL := -999999999;


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im => 1,
																								impulse_count);

	lien_adl_li_lseen_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E');

	lien_adl_lseen_li := if(lien_adl_li_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_li_lseen_pos, ','));

	_lien_adl_lseen_li := common.sas_date((string)(lien_adl_lseen_li));

	lien_adl_l2_lseen_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E');

	lien_adl_lseen_l2 := if(lien_adl_l2_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_l2_lseen_pos, ','));

	_lien_adl_lseen_l2 := common.sas_date((string)(lien_adl_lseen_l2));

	_src_lien_adl_lseen := max(_lien_adl_lseen_li, _lien_adl_lseen_l2, -1);

	iv_dl001_lien_last_seen := map(
			not(truedid)             => NULL,
			_src_lien_adl_lseen = -1 => -1,
																	if ((sysdate - _src_lien_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_lien_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_lien_adl_lseen) / (365.25 / 12))));

	_in_dob := common.sas_date((string)(in_dob));

	yr_in_dob := map(in_dob = '' => -1, in_dob = '0' => 0, _in_dob = NULL => 0, (sysdate - _in_dob) / 365.25);

	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

	age_estimate := map(
			yr_in_dob_int > 0 => yr_in_dob_int,
			inferred_age > 0  => inferred_age,
													 -1);

	iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = 0, -NULL, age_estimate)));

	iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

	iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

	iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

	bureau_adl_tn_count_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');

	bureau_adl_count_tn := if(bureau_adl_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bureau_adl_tn_count_pos, ','));

	bureau_adl_ts_count_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');

	bureau_adl_count_ts := if(bureau_adl_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bureau_adl_ts_count_pos, ','));

	bureau_adl_tu_count_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');

	bureau_adl_count_tu := if(bureau_adl_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bureau_adl_tu_count_pos, ','));

	bureau_adl_en_count_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');

	bureau_adl_count_en := if(bureau_adl_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bureau_adl_en_count_pos, ','));

	bureau_adl_eq_count_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

	bureau_adl_count_eq := if(bureau_adl_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, bureau_adl_eq_count_pos, ','));

	_src_bureau_adl_count := max(if(max(bureau_adl_count_tn, bureau_adl_count_ts, bureau_adl_count_tu, bureau_adl_count_en, bureau_adl_count_eq) = NULL, NULL, sum(if(bureau_adl_count_tn = NULL, 0, bureau_adl_count_tn), if(bureau_adl_count_ts = NULL, 0, bureau_adl_count_ts), if(bureau_adl_count_tu = NULL, 0, bureau_adl_count_tu), if(bureau_adl_count_en = NULL, 0, bureau_adl_count_en), if(bureau_adl_count_eq = NULL, 0, bureau_adl_count_eq))), (real)0);

	iv_src_bureau_adl_count := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_count = NULL => -1,
																			_src_bureau_adl_count);

	iv_avg_lres := if(not(truedid), NULL, avg_lres);

	iv_addrs_5yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_5yr);

	iv_hist_addr_match := map(
			not(truedid)            => NULL,
			hist_addr_match = -9999 => -1,
																 hist_addr_match);

	iv_gong_did_addr_ct := if(not(truedid), NULL, gong_did_addr_ct);

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

	criminal_count_var := min(if((Integer)criminal_count = 0, 0, criminal_count), 3);
	felony_count_var := min(if(felony_count = 0, 0, felony_count), 3);
	iv_criminal_x_felony := if(not(truedid), '', (String)criminal_count_var + '-' + (String)felony_count_var);

	iv_pb_total_dollars := map(
			not(truedid)            => NULL,
			pb_total_dollars = '' => -1,
			(integer) pb_total_dollars);

	genf_subscore0 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.086183,
			1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.167018,
			2 <= iv_ds001_impulse_count                                  => -0.418228,
																																			0);

	genf_subscore1 := map(
			NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen < 0 => 0.07999,
			0 <= iv_dl001_lien_last_seen                                   => -0.216019,
																																				0);

	genf_subscore2 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => 0,
			18 <= iv_ag001_age AND iv_ag001_age < 23  => -0.546141,
			23 <= iv_ag001_age AND iv_ag001_age < 27  => -0.152422,
			27 <= iv_ag001_age AND iv_ag001_age < 31  => 0.020257,
			31 <= iv_ag001_age AND iv_ag001_age < 33  => 0.083083,
			33 <= iv_ag001_age AND iv_ag001_age < 35  => 0.188143,
			35 <= iv_ag001_age AND iv_ag001_age < 41  => 0.236658,
			41 <= iv_ag001_age                        => 0.38238,
																									 0);
	genf_subscore3 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 8527     => -0.041481,
			8527 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 91000   => -0.133648,
			91000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 134491 => 0.158454,
			134491 <= iv_pv001_inp_avm_autoval                                      => 0.228449,
																																								 0);

	genf_subscore4 := map(
			NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3 => -0.178742,
			3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 9   => -0.040886,
			9 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 19  => 0.039483,
			19 <= iv_pl002_addrs_15yr                              => 0.442257,
																																0);

	genf_subscore5 := map(
			NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => 0.12244,
			1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => -0.036346,
			2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 6   => -0.171752,
			6 <= iv_iq001_inq_count12                                => -0.389586,
																																	0);

	genf_subscore6 := map(
			NULL < iv_src_bureau_adl_count AND iv_src_bureau_adl_count < 24 => -0.025941,
			24 <= iv_src_bureau_adl_count                                   => 0.107536,
																																				 0);

	genf_subscore7 := map(
			NULL < iv_avg_lres AND iv_avg_lres < 12 => -0.14711,
			12 <= iv_avg_lres                       => 0.039287,
																								 0);

	genf_subscore8 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => 0,
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.130925,
			4 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => -0.041427,
			8 <= iv_addrs_5yr                        => -0.445808,
																									0);

	genf_subscore9 := map(
			NULL < iv_hist_addr_match AND iv_hist_addr_match < 1 => -0.09616,
			1 <= iv_hist_addr_match AND iv_hist_addr_match < 2   => 0.107375,
			2 <= iv_hist_addr_match                              => -0.115188,
																															0);

	genf_subscore10 := map(
			NULL < iv_gong_did_addr_ct AND iv_gong_did_addr_ct < 2 => -0.032421,
			2 <= iv_gong_did_addr_ct                               => 0.10981,
																																0);

	genf_subscore11 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0'])                => 0.067456,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0'])               => -0.10411,
			(iv_nap_phn_ver_x_inf_phn_ver in ['1-1', '1-3', '2-0', '2-1']) => -0.326112,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])               => 0.086335,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0', '3-1', '3-3'])        => 0.195859,
																																				0);

	genf_subscore12 := map(
			(iv_criminal_x_felony in [''])				                        => 0,
			(iv_criminal_x_felony in ['0-0'])                             => 0.01436,
			(iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '3-0']) => -0.449405,
																																			 0);

	genf_subscore13 := map(
			NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 21 => -0.103383,
			21 <= iv_pb_total_dollars                               => 0.109806,
																																 0);

	genf_rawscore := genf_subscore0 +
			genf_subscore1 +
			genf_subscore2 +
			genf_subscore3 +
			genf_subscore4 +
			genf_subscore5 +
			genf_subscore6 +
			genf_subscore7 +
			genf_subscore8 +
			genf_subscore9 +
			genf_subscore10 +
			genf_subscore11 +
			genf_subscore12 +
			genf_subscore13;

	genf_lnoddsscore := genf_rawscore + 1.595590;

	genf_aacd_0 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => '9H',
			1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => '9H',
			2 <= iv_ds001_impulse_count                                  => '9H',
			'');
																																			
	genf_dist_0 := if(1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2, 0 ,genf_subscore0 - 0.086183);

	genf_aacd_1 := map(
			NULL < iv_dl001_lien_last_seen AND iv_dl001_lien_last_seen < 0 => '98',
			0 <= iv_dl001_lien_last_seen                                   => '98',
																																				'');

	genf_dist_1 := genf_subscore1 - 0.07999;

	genf_aacd_2 := map(
			NULL < iv_ag001_age AND iv_ag001_age < 18 => '9R',
			18 <= iv_ag001_age AND iv_ag001_age < 23  => '9R',
			23 <= iv_ag001_age AND iv_ag001_age < 27  => '9R',
			27 <= iv_ag001_age AND iv_ag001_age < 31  => '9R',
			31 <= iv_ag001_age AND iv_ag001_age < 33  => '9R',
			33 <= iv_ag001_age AND iv_ag001_age < 35  => '9R',
			35 <= iv_ag001_age AND iv_ag001_age < 41  => '9R',
			41 <= iv_ag001_age                        => '',
																									 '');
	genf_dist_2 := if(31 <= iv_ag001_age, 0, genf_subscore2 - 0.38238); 

	genf_aacd_3 := map(
			NULL < iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 8527     => 'PV',
			8527 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 91000   => 'PV',
			91000 <= iv_pv001_inp_avm_autoval AND iv_pv001_inp_avm_autoval < 134491 => 'PV',
			134491 <= iv_pv001_inp_avm_autoval                                      => 'PV',
																																								 '');

	genf_dist_3 := genf_subscore3 - 0.228449;

	genf_aacd_4 := map(
			NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3 => '9D',
			3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 9   => '9D',
			9 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 19  => '9D',
			19 <= iv_pl002_addrs_15yr                              => '9D',
																																'');

	genf_dist_4 := genf_subscore4 - 0.442257;

	genf_aacd_5 := map(
			NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => '',
			1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => '9Q',
			2 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 6   => '9Q',
			6 <= iv_iq001_inq_count12                                => '9Q',
																																	'');

	genf_dist_5 := genf_subscore5 - 0.12244;

	genf_aacd_6 := map(
			NULL < iv_src_bureau_adl_count AND iv_src_bureau_adl_count < 24 => '9E',
			24 <= iv_src_bureau_adl_count                                   => '9E',
																																				 '');

	genf_dist_6 := if(iv_src_bureau_adl_count = 0, 0, genf_subscore6 - 0.107536);

	genf_aacd_7 := map(
			NULL < iv_avg_lres AND iv_avg_lres < 12 => '9D',
			12 <= iv_avg_lres                       => '9D',
																								 '');

	genf_dist_7 := genf_subscore7 - 0.039287;

	genf_aacd_8 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => '9D',
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => '9D',
			4 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => '9D',
			8 <= iv_addrs_5yr                        => '9D',
																									'');

	genf_dist_8 := genf_subscore8 - 0.130925;

	genf_aacd_9 := map(
			NULL < iv_hist_addr_match AND iv_hist_addr_match < 1 => '25',
			1 <= iv_hist_addr_match AND iv_hist_addr_match < 2   => '25',
			2 <= iv_hist_addr_match                              => '25',
																															'');

	genf_dist_9 := genf_subscore9 - 0.107375;

	genf_aacd_10 := map(
			NULL < iv_gong_did_addr_ct AND iv_gong_did_addr_ct < 2 => '9F',
			2 <= iv_gong_did_addr_ct                               => '9F',
																																'');

	genf_dist_10 := genf_subscore10 - 0.10981;

	genf_aacd_11 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0'])                => '36',
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0'])               => '36',
			(iv_nap_phn_ver_x_inf_phn_ver in ['1-1', '1-3', '2-0', '2-1']) => '36',
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])               => '36',
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0', '3-1', '3-3'])        => '36',
																																				'');

	genf_dist_11 := genf_subscore11 - 0.195859;
	

	genf_aacd_12 := map(
			(iv_criminal_x_felony in ['']) 	                              => '97',
			(iv_criminal_x_felony in ['0-0'])                             => '97',
			(iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '3-0']) => '97',
																																			 '');

	genf_dist_12 := if(genf_subscore12 = 0 and trim(iv_criminal_x_felony) ='', 0, genf_subscore12 - 0.01436);

	genf_aacd_13 := map(
			NULL < iv_pb_total_dollars AND iv_pb_total_dollars < 21 => '9Y',
			21 <= iv_pb_total_dollars                               => '9Y',
																																 '');

	// genf_dist_13 := genf_subscore13 - 0.109806;
	genf_dist_13 := 0;

	rcvalue9q := if(inq_count12 < 1 , 0,
			(integer)(genf_aacd_0 = '9Q') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9Q') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9Q') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9Q') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9Q') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9Q') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9Q') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9Q') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9Q') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9Q') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9Q') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9Q') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9Q') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9Q') * genf_dist_13);

	rcvalue98 := if(iv_DL001_Lien_Last_Seen < 0, 0,
			(integer)(genf_aacd_0 = '98') * genf_dist_0 +
			(integer)(genf_aacd_1 = '98') * genf_dist_1 +
			(integer)(genf_aacd_2 = '98') * genf_dist_2 +
			(integer)(genf_aacd_3 = '98') * genf_dist_3 +
			(integer)(genf_aacd_4 = '98') * genf_dist_4 +
			(integer)(genf_aacd_5 = '98') * genf_dist_5 +
			(integer)(genf_aacd_6 = '98') * genf_dist_6 +
			(integer)(genf_aacd_7 = '98') * genf_dist_7 +
			(integer)(genf_aacd_8 = '98') * genf_dist_8 +
			(integer)(genf_aacd_9 = '98') * genf_dist_9 +
			(integer)(genf_aacd_10 = '98') * genf_dist_10 +
			(integer)(genf_aacd_11 = '98') * genf_dist_11 +
			(integer)(genf_aacd_12 = '98') * genf_dist_12 +
			(integer)(genf_aacd_13 = '98') * genf_dist_13);

	rcvalue9y := (integer)(genf_aacd_0 = '9Y') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9Y') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9Y') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9Y') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9Y') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9Y') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9Y') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9Y') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9Y') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9Y') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9Y') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9Y') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9Y') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9Y') * genf_dist_13;

	rcvalue9r := if(iv_AG001_Age > 30, 0, 
			(integer)(genf_aacd_0 = '9R') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9R') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9R') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9R') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9R') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9R') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9R') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9R') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9R') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9R') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9R') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9R') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9R') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9R') * genf_dist_13);

	rcvalue9d := (integer)(genf_aacd_0 = '9D') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9D') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9D') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9D') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9D') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9D') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9D') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9D') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9D') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9D') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9D') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9D') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9D') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9D') * genf_dist_13;

	rcvalue9e := if(iv_src_bureau_adl_count  < 1, 0,
			(integer)(genf_aacd_0 = '9E') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9E') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9E') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9E') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9E') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9E') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9E') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9E') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9E') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9E') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9E') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9E') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9E') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9E') * genf_dist_13);

	rcvalue36 := (integer)(genf_aacd_0 = '36') * genf_dist_0 +
			(integer)(genf_aacd_1 = '36') * genf_dist_1 +
			(integer)(genf_aacd_2 = '36') * genf_dist_2 +
			(integer)(genf_aacd_3 = '36') * genf_dist_3 +
			(integer)(genf_aacd_4 = '36') * genf_dist_4 +
			(integer)(genf_aacd_5 = '36') * genf_dist_5 +
			(integer)(genf_aacd_6 = '36') * genf_dist_6 +
			(integer)(genf_aacd_7 = '36') * genf_dist_7 +
			(integer)(genf_aacd_8 = '36') * genf_dist_8 +
			(integer)(genf_aacd_9 = '36') * genf_dist_9 +
			(integer)(genf_aacd_10 = '36') * genf_dist_10 +
			(integer)(genf_aacd_11 = '36') * genf_dist_11 +
			(integer)(genf_aacd_12 = '36') * genf_dist_12 +
			(integer)(genf_aacd_13 = '36') * genf_dist_13;

	rcvalue9f := (integer)(genf_aacd_0 = '9F') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9F') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9F') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9F') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9F') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9F') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9F') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9F') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9F') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9F') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9F') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9F') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9F') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9F') * genf_dist_13;

	rcvalue97 := if(criminal_count = 0 and felony_count = 0, 0,
			(integer)(genf_aacd_0 = '97') * genf_dist_0 +
			(integer)(genf_aacd_1 = '97') * genf_dist_1 +
			(integer)(genf_aacd_2 = '97') * genf_dist_2 +
			(integer)(genf_aacd_3 = '97') * genf_dist_3 +
			(integer)(genf_aacd_4 = '97') * genf_dist_4 +
			(integer)(genf_aacd_5 = '97') * genf_dist_5 +
			(integer)(genf_aacd_6 = '97') * genf_dist_6 +
			(integer)(genf_aacd_7 = '97') * genf_dist_7 +
			(integer)(genf_aacd_8 = '97') * genf_dist_8 +
			(integer)(genf_aacd_9 = '97') * genf_dist_9 +
			(integer)(genf_aacd_10 = '97') * genf_dist_10 +
			(integer)(genf_aacd_11 = '97') * genf_dist_11 +
			(integer)(genf_aacd_12 = '97') * genf_dist_12 +
			(integer)(genf_aacd_13 = '97') * genf_dist_13);

	rcvalue9h := if(impulse_count <= 1, 0, 
			(integer)(genf_aacd_0 = '9H') * genf_dist_0 +
			(integer)(genf_aacd_1 = '9H') * genf_dist_1 +
			(integer)(genf_aacd_2 = '9H') * genf_dist_2 +
			(integer)(genf_aacd_3 = '9H') * genf_dist_3 +
			(integer)(genf_aacd_4 = '9H') * genf_dist_4 +
			(integer)(genf_aacd_5 = '9H') * genf_dist_5 +
			(integer)(genf_aacd_6 = '9H') * genf_dist_6 +
			(integer)(genf_aacd_7 = '9H') * genf_dist_7 +
			(integer)(genf_aacd_8 = '9H') * genf_dist_8 +
			(integer)(genf_aacd_9 = '9H') * genf_dist_9 +
			(integer)(genf_aacd_10 = '9H') * genf_dist_10 +
			(integer)(genf_aacd_11 = '9H') * genf_dist_11 +
			(integer)(genf_aacd_12 = '9H') * genf_dist_12 +
			(integer)(genf_aacd_13 = '9H') * genf_dist_13);

	rcvaluepv := if(iv_PV001_Inp_AVM_AutoVal > 200000, 0,
			(integer)(genf_aacd_0 = 'PV') * genf_dist_0 +
			(integer)(genf_aacd_1 = 'PV') * genf_dist_1 +
			(integer)(genf_aacd_2 = 'PV') * genf_dist_2 +
			(integer)(genf_aacd_3 = 'PV') * genf_dist_3 +
			(integer)(genf_aacd_4 = 'PV') * genf_dist_4 +
			(integer)(genf_aacd_5 = 'PV') * genf_dist_5 +
			(integer)(genf_aacd_6 = 'PV') * genf_dist_6 +
			(integer)(genf_aacd_7 = 'PV') * genf_dist_7 +
			(integer)(genf_aacd_8 = 'PV') * genf_dist_8 +
			(integer)(genf_aacd_9 = 'PV') * genf_dist_9 +
			(integer)(genf_aacd_10 = 'PV') * genf_dist_10 +
			(integer)(genf_aacd_11 = 'PV') * genf_dist_11 +
			(integer)(genf_aacd_12 = 'PV') * genf_dist_12 +
			(integer)(genf_aacd_13 = 'PV') * genf_dist_13);

	rcvalue25 := (integer)(genf_aacd_0 = '25') * genf_dist_0 +
			(integer)(genf_aacd_1 = '25') * genf_dist_1 +
			(integer)(genf_aacd_2 = '25') * genf_dist_2 +
			(integer)(genf_aacd_3 = '25') * genf_dist_3 +
			(integer)(genf_aacd_4 = '25') * genf_dist_4 +
			(integer)(genf_aacd_5 = '25') * genf_dist_5 +
			(integer)(genf_aacd_6 = '25') * genf_dist_6 +
			(integer)(genf_aacd_7 = '25') * genf_dist_7 +
			(integer)(genf_aacd_8 = '25') * genf_dist_8 +
			(integer)(genf_aacd_9 = '25') * genf_dist_9 +
			(integer)(genf_aacd_10 = '25') * genf_dist_10 +
			(integer)(genf_aacd_11 = '25') * genf_dist_11 +
			(integer)(genf_aacd_12 = '25') * genf_dist_12 +
			(integer)(genf_aacd_13 = '25') * genf_dist_13;

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

	base := 700;

	pts := 40;

	lgt := ln(4.9);

	rvg1310_1_0 := map(
			ssn_deceased 		        => 200,
			iv_rv5_unscorable = '1'   => 222,
																 round(min(if(max(base + pts * (genf_lnoddsscore - lgt) / ln(2), (real)501) = NULL, -NULL, max(base + pts * (genf_lnoddsscore - lgt) / ln(2), (real)501)), 900)));


	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//

	ds_layout := {STRING rc, INTEGER value};

		RCValue9Q_abs := (integer) (abs(RCValue9Q*100000));
		RCValue98_abs := (integer) (abs(RCValue98*100000));
		RCValue9Y_abs := (integer) (abs(RCValue9Y*100000));
		RCValue9R_abs := (integer) (abs(RCValue9R*100000));
		RCValue9D_abs := (integer) (abs(RCValue9D*100000));
		RCValue9E_abs := (integer) (abs(RCValue9E*100000));
		RCValue36_abs := (integer) (abs(RCValue36*100000));
		RCValue9F_abs := (integer) (abs(RCValue9F*100000));
		RCValue97_abs := (integer) (abs(RCValue97*100000));
		RCValue9H_abs := (integer) (abs(RCValue9H*100000));
		RCValuePV_abs := (integer) (abs(RCValuePV*100000));
		RCValue25_abs := (integer) (abs(RCValue25*100000));

		rc_dataset := DATASET([   
			{'9Q', RCValue9Q_abs},  
			{'98', RCValue98_abs},  
			{'9Y', RCValue9Y_abs},  
			{'9R', RCValue9R_abs},  
			{'9D', RCValue9D_abs},  
			{'9E', RCValue9E_abs},  
			{'36', RCValue36_abs},  
			{'9F', RCValue9F_abs},  
			{'97', RCValue97_abs},  
			{'9H', RCValue9H_abs},  
			{'PV', RCValuePV_abs},  
			{'25', RCValue25_abs}  
			], ds_layout)(value > 0);
	//*************************************************************************************//
	// IMPORTANT NOTE:  Only select reason codes when their associated value is > 0.
	// I'll leave the implementation details to the Engineers.
	//*************************************************************************************//

	rc_dataset_sorted_tmp := sort(rc_dataset, -value);
	rc_dataset_sorted := choosen(rc_dataset_sorted_tmp, 5);

	rc1_3 := rc_dataset_sorted[1].rc;
	rc2_3 := rc_dataset_sorted[2].rc;
	rc3_2 := rc_dataset_sorted[3].rc;
	rc4_2 := rc_dataset_sorted[4].rc;
	rc5_2 := if((INTEGER) inq_count12 > 0 AND rc1_3 != '9Q' AND rc2_3 != '9Q' 
		AND rc3_2 != '9Q' AND rc4_2 != '9Q', '9Q', '');
	
	rc1_2 := map(
	    rvg1310_1_0 = 200 => '02',
	    rvg1310_1_0 = 222 => '9X',
	                         rc1_3);
	
	rc4_1 := map(
	    rvg1310_1_0 = 200 => '',
	    rvg1310_1_0 = 222 => '',
	                         rc4_2);
	
	rc2_2 := map(
	    rvg1310_1_0 = 200 => '',
	    rvg1310_1_0 = 222 => '',
	                         rc2_3);
	
	rc3_1 := map(
	    rvg1310_1_0 = 200 => '',
	    rvg1310_1_0 = 222 => '',
	                         rc3_2);
	
	rc5_1 := map(
	    rvg1310_1_0 = 200 => '',
	    rvg1310_1_0 = 222 => '',
	                         rc5_2);
	
	rc1_1 := if(rc1_2 = '', '36', rc1_2);
	
	rc2_1 := if(not((rc1_1 in ['', '36'])) and rc2_2 = '' and 500 < rvg1310_1_0 AND rvg1310_1_0 <= 720, '36', rc2_2);
	
	rc1 := if(rvg1310_1_0 = 900, '', rc1_1);
	rc2 := if(rvg1310_1_0 = 900, '', rc2_1);
	rc3 := if(rvg1310_1_0 = 900, '', rc3_1);
	rc4 := if(rvg1310_1_0 = 900, '', rc4_1);	
	rc5 := if(rvg1310_1_0 = 900, '', rc5_1);

	genf_rc1 := rc1;
	genf_rc2 := rc2;
	genf_rc3 := rc3;
	genf_rc4 := rc4;
	genf_rc5 := map(rc5 = '9Q' => '9Q',
				(rc5 = '' AND (genf_rc1 = '02' OR genf_rc1 = '9X' OR (genf_rc1 = '36' AND genf_rc2 = ''))) => '',
				rc_dataset_sorted[5].rc);
	
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
													rvg1310_1_0 = 200 =>	DATASET([{'02'}], HRILayout),
													rvg1310_1_0 = 222 =>	DATASET([{'9X'}], HRILayout),
													rvg1310_1_0 = 900 =>	DATASET([{' '}], HRILayout),
													rvg1310_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] 
														AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp)	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides)	=> reasonsOverrides, 
																													 reasons) (HRI <> '');
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
			
//Intermediate variables
	#if(RVG_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;                           
		self.iv_rv5_unscorable                := iv_rv5_unscorable;                 
		self.email_src_im                     := email_src_im;                      
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;            
		self.lien_adl_li_lseen_pos            := lien_adl_li_lseen_pos;             
		self.lien_adl_lseen_li                := lien_adl_lseen_li;                 
		self._lien_adl_lseen_li               := _lien_adl_lseen_li;                
		self.lien_adl_l2_lseen_pos            := lien_adl_l2_lseen_pos;             
		self.lien_adl_lseen_l2                := lien_adl_lseen_l2;                 
		self._lien_adl_lseen_l2               := _lien_adl_lseen_l2;                
		self._src_lien_adl_lseen              := _src_lien_adl_lseen;               
		self.iv_dl001_lien_last_seen          := iv_dl001_lien_last_seen;           
		self._in_dob                          := _in_dob;                           
		self.yr_in_dob                        := yr_in_dob;                         
		self.yr_in_dob_int                    := yr_in_dob_int;                     
		self.age_estimate                     := age_estimate;                      
		self.iv_ag001_age                     := iv_ag001_age;                      
		self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;          
		self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;               
		self.iv_iq001_inq_count12             := iv_iq001_inq_count12;              
		self.bureau_adl_tn_count_pos          := bureau_adl_tn_count_pos;           
		self.bureau_adl_count_tn              := bureau_adl_count_tn;               
		self.bureau_adl_ts_count_pos          := bureau_adl_ts_count_pos;           
		self.bureau_adl_count_ts              := bureau_adl_count_ts;               
		self.bureau_adl_tu_count_pos          := bureau_adl_tu_count_pos;           
		self.bureau_adl_count_tu              := bureau_adl_count_tu;               
		self.bureau_adl_en_count_pos          := bureau_adl_en_count_pos;           
		self.bureau_adl_count_en              := bureau_adl_count_en;               
		self.bureau_adl_eq_count_pos          := bureau_adl_eq_count_pos;           
		self.bureau_adl_count_eq              := bureau_adl_count_eq;               
		self._src_bureau_adl_count            := _src_bureau_adl_count;             
		self.iv_src_bureau_adl_count          := iv_src_bureau_adl_count;           
		self.iv_avg_lres                      := iv_avg_lres;                       
		self.iv_addrs_5yr                     := iv_addrs_5yr;                      
		self.iv_hist_addr_match               := iv_hist_addr_match;                
		self.iv_gong_did_addr_ct              := iv_gong_did_addr_ct;               
		self.ver_phn_inf                      := ver_phn_inf;                       
		self.ver_phn_nap                      := ver_phn_nap;                       
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                   
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                   
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;      
		self.iv_criminal_x_felony             := iv_criminal_x_felony;              
		self.iv_pb_total_dollars              := iv_pb_total_dollars;               
		self.genf_subscore0                   := genf_subscore0;                    
		self.genf_subscore1                   := genf_subscore1;                    
		self.genf_subscore2                   := genf_subscore2;                    
		self.genf_subscore3                   := genf_subscore3;                    
		self.genf_subscore4                   := genf_subscore4;                    
		self.genf_subscore5                   := genf_subscore5;                    
		self.genf_subscore6                   := genf_subscore6;                    
		self.genf_subscore7                   := genf_subscore7;                    
		self.genf_subscore8                   := genf_subscore8;                    
		self.genf_subscore9                   := genf_subscore9;                    
		self.genf_subscore10                  := genf_subscore10;                   
		self.genf_subscore11                  := genf_subscore11;                   
		self.genf_subscore12                  := genf_subscore12;                   
		self.genf_subscore13                  := genf_subscore13;                   
		self.genf_rawscore                    := genf_rawscore;                     
		self.genf_lnoddsscore                 := genf_lnoddsscore;                  
		self.genf_aacd_0                      := genf_aacd_0;
		self.genf_dist_0                      := genf_dist_0;
		self.genf_aacd_1                      := genf_aacd_1;
		self.genf_dist_1                      := genf_dist_1;
		self.genf_aacd_2                      := genf_aacd_2;
		self.genf_dist_2                      := genf_dist_2;
		self.genf_aacd_3                      := genf_aacd_3;
		self.genf_dist_3                      := genf_dist_3;
		self.genf_aacd_4                      := genf_aacd_4;
		self.genf_dist_4                      := genf_dist_4;
		self.genf_aacd_5                      := genf_aacd_5;
		self.genf_dist_5                      := genf_dist_5;
		self.genf_aacd_6                      := genf_aacd_6;
		self.genf_dist_6                      := genf_dist_6;
		self.genf_aacd_7                      := genf_aacd_7;
		self.genf_dist_7                      := genf_dist_7;
		self.genf_aacd_8                      := genf_aacd_8;
		self.genf_dist_8                      := genf_dist_8;
		self.genf_aacd_9                      := genf_aacd_9;
		self.genf_dist_9                      := genf_dist_9;
		self.genf_aacd_10                     := genf_aacd_10;
		self.genf_dist_10                     := genf_dist_10;
		self.genf_aacd_11                     := genf_aacd_11;
		self.genf_dist_11                     := genf_dist_11;
		self.genf_aacd_12                     := genf_aacd_12;
		self.genf_dist_12                     := genf_dist_12;
		self.genf_aacd_13                     := genf_aacd_13;
		self.genf_dist_13                     := genf_dist_13;
		self.rcvalue9q                        := rcvalue9q;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9y                        := rcvalue9y;
		self.rcvalue9r                        := rcvalue9r;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue36                        := rcvalue36;
		self.rcvalue9f                        := rcvalue9f;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvaluepv                        := rcvaluepv;
		self.rcvalue25                        := rcvalue25;
		self.ssn_deceased                     := ssn_deceased;
		self.base                             := base;
		self.pts                              := pts;
		self.lgt                              := lgt;
		self.rvg1310_1_0                      := rvg1310_1_0;
		self.genf_rc1                         := if(genf_rc1 ='00', '', genf_rc1);
		self.genf_rc2                         := if(genf_rc2 ='00', '', genf_rc2);
		self.genf_rc3                         := if(genf_rc3 ='00', '', genf_rc3);
		self.genf_rc4                         := if(genf_rc4 ='00', '', genf_rc4);
		self.genf_rc5                         := if(genf_rc5 ='00', '', genf_rc5);
		self.rc1                              := if(reasonCodes[1].hri ='00', '', reasonCodes[1].hri);
		self.rc2                              := if(reasonCodes[2].hri ='00', '', reasonCodes[2].hri);
		self.rc3                              := if(reasonCodes[3].hri ='00', '', reasonCodes[3].hri);
		self.rc4                              := if(reasonCodes[4].hri ='00', '', reasonCodes[4].hri);
		self.rc5                              := if(reasonCodes[5].hri ='00', '', reasonCodes[5].hri);
	#end
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
											(string3) RVG1310_1_0
										);
		END;

		model := project( clam, doModel(left) );

		return model;
END;
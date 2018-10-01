// RVA1310_1 Automobile Acceptance Corporation

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVA1310_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
				INTEGER sysdate;
				STRING iv_db001_bankruptcy;
				INTEGER iv_de001_eviction_recency;
				BOOLEAN email_src_im;
				INTEGER iv_ds001_impulse_count;
				INTEGER iv_mi001_adlperssn_count;
				INTEGER _reported_dob;
				INTEGER reported_age;
				INTEGER iv_combined_age;
				INTEGER iv_inp_addr_source_count;
				INTEGER iv_addrs_5yr;
				INTEGER iv_inq_highriskcredit_count12;
				INTEGER iv_non_derog_count;
				INTEGER iv_liens_unrel_sc_ct;
				REAL d_subscore0;
				REAL d_subscore1;
				REAL d_subscore2;
				REAL d_subscore3;
				REAL d_subscore4;
				REAL d_subscore5;
				REAL d_subscore6;
				REAL d_subscore7;
				REAL d_subscore8;
				REAL d_subscore9;
				REAL d_rawscore;
				REAL d_lnoddsscore;
				REAL d_probscore;
				INTEGER base;
				REAL odds;
				INTEGER point;
				BOOLEAN ssn_deceased;
				BOOLEAN iv_riskview_222s;
				INTEGER rva1310_1;
				BOOLEAN glrc9d;
				BOOLEAN glrc9e;
				BOOLEAN glrc9h;
				BOOLEAN glrc9g;
				BOOLEAN glrcev;
				BOOLEAN glrc9w;
				BOOLEAN glrcmi;
				BOOLEAN glrc98;
				BOOLEAN glrc9p;
				REAL rcvalue9d_1;
				REAL rcvalue9d;
				REAL rcvalue9e_1;
				REAL rcvalue9e_2;
				REAL rcvalue9e;
				REAL rcvalue9h_1;
				REAL rcvalue9h;
				REAL rcvalue9g_1;
				REAL rcvalue9g;
				REAL rcvalueev_1;
				REAL rcvalueev;
				REAL rcvalue9w_1;
				REAL rcvalue9w;
				REAL rcvaluemi_1;
				REAL rcvaluemi;
				REAL rcvalue98_1;
				REAL rcvalue98;
				REAL rcvalue9p_1;
				REAL rcvalue9p;
				STRING rc1;
				STRING rc4;
				STRING rc2;
				STRING rc3;
				STRING rc5;
				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
				truedid                          := le.truedid;
				nas_summary                      := le.iid.nas_summary;
				nap_summary                      := le.iid.nap_summary;
				rc_decsflag                      := le.iid.decsflag;
				rc_bansflag                      := le.iid.bansflag;
				combo_dobscore                   := le.iid.combo_dobscore;
				ver_sources                      := le.header_summary.ver_sources;
				ssnlength                        := le.input_validation.ssn_length;
				dobpop                           := le.input_validation.dateofbirth;
				age                              := le.name_verification.age;
				add1_source_count                := le.address_verification.input_address_information.source_count;
				add1_naprop                      := le.address_verification.input_address_information.naprop;
				add1_pop                         := le.addrpop;
				property_owned_total             := le.address_verification.owned.property_total;
				property_sold_total              := le.address_verification.sold.property_total;
				addrs_5yr                        := le.other_address_info.addrs_last_5years;
				unique_addr_count                := le.address_history_summary.unique_addr_cnt;
				adlperssn_count                  := le.ssn_verification.adlperssn_count;
				inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
				impulse_count                    := le.impulse.count;
				email_source_list                := le.email_summary.email_source_list;
				attr_eviction_count              := le.bjl.eviction_count;
				attr_eviction_count90            := le.bjl.eviction_count90;
				attr_eviction_count180           := le.bjl.eviction_count180;
				attr_eviction_count12            := le.bjl.eviction_count12;
				attr_eviction_count24            := le.bjl.eviction_count24;
				attr_eviction_count36            := le.bjl.eviction_count36;
				attr_eviction_count60            := le.bjl.eviction_count60;
				attr_num_nonderogs               := le.source_verification.num_nonderogs;
				bankrupt                         := le.bjl.bankrupt;
				disposition                      := le.bjl.disposition;
				filing_count                     := le.bjl.filing_count;
				bk_recent_count                  := le.bjl.bk_recent_count;
				liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
				liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
				liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
				criminal_count                   := le.bjl.criminal_count;
				ams_age                          := le.student.age;
				input_dob_age                    := le.shell_input.age;
				inferred_age                     := le.inferred_age;
				reported_dob                     := le.reported_dob;

				NULL := -999999999;


				INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


				BOOLEAN indexw(string source, string target, string delim) :=
					(source = target) OR
					(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
					(source[1..length(target)+1] = target + delim) OR
					(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

				sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

				iv_db001_bankruptcy := map(
						not(truedid or (integer)ssnlength > 0)                                                                                      => '                 ',
						(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
						(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
						(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 		=> '3 - BK Other     ',
																																																																					 '0 - No BK        ');

				iv_de001_eviction_recency := map(
						not(truedid)                                                => NULL,
						attr_eviction_count90  > 0                                  => 3,
						attr_eviction_count180 > 0                                  => 6,
						attr_eviction_count12 > 0                                   => 12,
						(boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
						attr_eviction_count24 > 0                                   => 25,
						(boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
						attr_eviction_count36 > 0                                   => 37,
						(boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
						attr_eviction_count60 > 0                                   => 61,
						attr_eviction_count >= 2                                    => 98,
						attr_eviction_count >= 1                                    => 99,
																																					 0);

				email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

				iv_ds001_impulse_count := map(
						not(truedid)                           => NULL,
						impulse_count = 0 and email_src_im 	 		 	 => 1,
																											impulse_count);

				iv_mi001_adlperssn_count := map(
						not((integer)ssnlength > 0)  => NULL,
						adlperssn_count = 0 => 1,
																	 adlperssn_count);

				_reported_dob := common.sas_date((string)(reported_dob));

				reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

				iv_combined_age := map(
						not(truedid or dobpop) 			=> NULL,
						age > 0                			=> age,
						(integer)input_dob_age > 0  => (integer)input_dob_age,
						inferred_age > 0       => inferred_age,
						reported_age > 0       => reported_age,
						(integer)ams_age > 0            => (integer)ams_age,
																			-1);

				iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

				iv_addrs_5yr := map(
						not(truedid)          => NULL,
						unique_addr_count = 0 => -1,
																		 addrs_5yr);

				iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

				iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

				iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

				d_subscore0 := map(
						NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => 0.000000,
						0 <= iv_addrs_5yr AND iv_addrs_5yr < 1   => 0.710954,
						1 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.413158,
						2 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.102810,
						3 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.085000,
						4 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => 0.052730,
						5 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.071906,
						6 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.233838,
						7 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => -0.280478,
						8 <= iv_addrs_5yr AND iv_addrs_5yr < 10  => -0.501547,
						10 <= iv_addrs_5yr                       => -0.914004,
																												0.000000);

				d_subscore1 := map(
						NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.231524,
						1 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 2   => 0.061803,
						2 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 3   => 0.113671,
						3 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 4   => 0.175794,
						4 <= iv_inp_addr_source_count                                    => 0.209082,
																																								-0.000000);

				d_subscore2 := map(
						NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.062946,
						1 <= iv_ds001_impulse_count                                  => -0.433297,
																																						-0.000000);

				d_subscore3 := map(
						NULL < iv_combined_age AND iv_combined_age < 18 => 0.000000,
						18 <= iv_combined_age AND iv_combined_age < 25  => -0.235822,
						25 <= iv_combined_age AND iv_combined_age < 40  => -0.032280,
						40 <= iv_combined_age AND iv_combined_age < 53  => 0.030570,
						53 <= iv_combined_age                           => 0.345787,
																															 0.000000);

				d_subscore4 := map(
						(iv_de001_eviction_recency in [3])                              => -0.303531,
						(iv_de001_eviction_recency in [6, 12])                          => -0.206535,
						(iv_de001_eviction_recency in [24, 25, 36, 37, 60, 61, 98, 99]) => -0.031240,
						(iv_de001_eviction_recency in [0])                              => 0.095106,
																																							 0.000000);

				d_subscore5 := map(
						NULL < iv_non_derog_count AND iv_non_derog_count < 2 => -0.166915,
						2 <= iv_non_derog_count AND iv_non_derog_count < 3   => -0.021903,
						3 <= iv_non_derog_count                              => 0.120521,
																																		-0.000000);

				d_subscore6 := map(
						(iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.264588,
						(iv_db001_bankruptcy in ['0 - No BK'])         => -0.012197,
						(iv_db001_bankruptcy in ['3 - BK Other'])      => -0.051662,
						(iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.187377,
																															-0.000000);

				d_subscore7 := map(
						NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.088299,
						2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => -0.041006,
						3 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 4   => -0.082236,
						4 <= iv_mi001_adlperssn_count                                    => -0.229861,
																																								0.000000);

				d_subscore8 := map(
						NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.041343,
						1 <= iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 2   => -0.130349,
						2 <= iv_liens_unrel_sc_ct                                => -0.304106,
																																				-0.000000);

				d_subscore9 := map(
						NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.017377,
						1 <= iv_inq_highriskcredit_count12                                         => -0.239568,
																																													-0.000000);

				d_rawscore := d_subscore0 +
						d_subscore1 +
						d_subscore2 +
						d_subscore3 +
						d_subscore4 +
						d_subscore5 +
						d_subscore6 +
						d_subscore7 +
						d_subscore8 +
						d_subscore9;

				d_lnoddsscore := d_rawscore + 0.657020;

				d_probscore := exp(d_lnoddsscore) / (1 + exp(d_lnoddsscore));

				base := 700;

				odds := (1 - 0.34) / 0.34;

				point := 40;

				ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

				iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
											
				rva1310_1 := map(
						ssn_deceased     => 200,
						iv_riskview_222s => 222,
																min(if(max(round(point * (d_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (d_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

				glrc9d := truedid and addrs_5yr > 3;

				glrc9e := truedid and add1_pop and add1_source_count < 2;

				glrc9h := truedid and impulse_count > 0;

				glrc9g := truedid and 18 <= iv_combined_age AND iv_combined_age <= 35;

				glrcev := truedid and attr_eviction_count > 0;

				glrc9w := truedid and filing_count > 0;

				glrcmi := truedid and (integer)ssnlength > 0 and adlperssn_count > 2;

				glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

				glrc9p := truedid and inq_highRiskCredit_count12 > 0;

				rcvalue9d_1 := 0.710954 - d_subscore0;

				rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

				rcvalue9e_1 := 0.209082 - d_subscore1;

				rcvalue9e_2 := 0.120521 - d_subscore5;

				rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));

				rcvalue9h_1 := 0.062946 - d_subscore2;

				rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

				rcvalue9g_1 := 0.345787 - d_subscore3;

				rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

				rcvalueev_1 := 0.095106 - d_subscore4;

				rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

				rcvalue9w_1 := 0.264588 - d_subscore6;

				rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

				rcvaluemi_1 := 0.088299 - d_subscore7;

				rcvaluemi := (integer)glrcmi * if(max(rcvaluemi_1) = NULL, NULL, sum(if(rcvaluemi_1 = NULL, 0, rcvaluemi_1)));

				rcvalue98_1 := 0.041343 - d_subscore8;

				rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

				rcvalue9p_1 := 0.017377 - d_subscore9;

				rcvalue9p := (integer)glrc9p * if(max(rcvalue9p_1) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1)));

				//*************************************************************************************//
				// I have no idea how the reason code logic gets implemented in ECL, so everything below 
				// probably needs to get changed or replaced.  The methodology for creating the reason codes is
				// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
				// that model code for guidance on implementing reason codes. 
				//*************************************************************************************//

				ds_layout := {STRING rc, REAL value};

				rc_dataset := DATASET([
						{'9D', RCValue9D},
						{'9E', RCValue9E},
						{'9H', RCValue9H},
						{'9G', RCValue9G},
						{'EV', RCValueEV},
						{'9W', RCValue9W},
						{'MI', RCValueMI},
						{'98', RCValue98},
						{'9P', RCValue9P}
						], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
	
	rcs_9p := rcs_top & if(glrc9p AND (count(rcs_top4(rc='9P')) =0) AND inq_highRiskCredit_count12 > 0, ROW({'9P', NULL}, ds_layout));

	rcs_override := MAP(
											rva1310_1 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1310_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1310_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
											(500 < rva1310_1) and (rva1310_1 <= 700) and 
													(rcs_9p[1].rc!='9E') and (rcs_9p[1].rc!='') and (rcs_9p[2].rc='') => DATASET([{rcs_9p[1].rc, NULL}, {'9E', NULL}], ds_layout),
											rcs_9p
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

//Intermediate variables
	#if(RVA_DEBUG)
				self.clam															:= le;
				self.sysdate                          := sysdate;
				self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
				self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
				self.email_src_im                     := email_src_im;
				self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
				self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
				self._reported_dob                    := _reported_dob;
				self.reported_age                     := reported_age;
				self.iv_combined_age                  := iv_combined_age;
				self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
				self.iv_addrs_5yr                     := iv_addrs_5yr;
				self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
				self.iv_non_derog_count               := iv_non_derog_count;
				self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
				self.d_subscore0                      := d_subscore0;
				self.d_subscore1                      := d_subscore1;
				self.d_subscore2                      := d_subscore2;
				self.d_subscore3                      := d_subscore3;
				self.d_subscore4                      := d_subscore4;
				self.d_subscore5                      := d_subscore5;
				self.d_subscore6                      := d_subscore6;
				self.d_subscore7                      := d_subscore7;
				self.d_subscore8                      := d_subscore8;
				self.d_subscore9                      := d_subscore9;
				self.d_rawscore                       := d_rawscore;
				self.d_lnoddsscore                    := d_lnoddsscore;
				self.d_probscore                      := d_probscore;
				self.base                             := base;
				self.odds                             := odds;
				self.point                            := point;
				self.ssn_deceased                     := ssn_deceased;
				self.iv_riskview_222s                 := iv_riskview_222s;
				self.rva1310_1                        := rva1310_1;
				self.glrc9d                           := glrc9d;
				self.glrc9e                           := glrc9e;
				self.glrc9h                           := glrc9h;
				self.glrc9g                           := glrc9g;
				self.glrcev                           := glrcev;
				self.glrc9w                           := glrc9w;
				self.glrcmi                           := glrcmi;
				self.glrc98                           := glrc98;
				self.glrc9p                           := glrc9p;
				self.rcvalue9d_1                      := rcvalue9d_1;
				self.rcvalue9d                        := rcvalue9d;
				self.rcvalue9e_1                      := rcvalue9e_1;
				self.rcvalue9e_2                      := rcvalue9e_2;
				self.rcvalue9e                        := rcvalue9e;
				self.rcvalue9h_1                      := rcvalue9h_1;
				self.rcvalue9h                        := rcvalue9h;
				self.rcvalue9g_1                      := rcvalue9g_1;
				self.rcvalue9g                        := rcvalue9g;
				self.rcvalueev_1                      := rcvalueev_1;
				self.rcvalueev                        := rcvalueev;
				self.rcvalue9w_1                      := rcvalue9w_1;
				self.rcvalue9w                        := rcvalue9w;
				self.rcvaluemi_1                      := rcvaluemi_1;
				self.rcvaluemi                        := rcvaluemi;
				self.rcvalue98_1                      := rcvalue98_1;
				self.rcvalue98                        := rcvalue98;
				self.rcvalue9p_1                      := rcvalue9p_1;
				self.rcvalue9p                        := rcvalue9p;
				self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
				self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
				self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
				self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
				self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rva1310_1
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;
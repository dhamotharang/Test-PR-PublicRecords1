// RVA1310_3 Automobile Acceptance Corporation

import risk_indicators, riskwise, RiskWiseFCRA, ut, std, riskview;

export RVA1310_3_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
				INTEGER sysdate                          ;
				BOOLEAN email_src_im                     ;
				INTEGER iv_ds001_impulse_count           ;
				INTEGER _in_dob                          ;
				INTEGER yr_in_dob                        ;
				INTEGER yr_in_dob_int                    ;
				INTEGER age_estimate                     ;
				INTEGER iv_ag001_age                     ;
				INTEGER iv_pv001_bst_avm_autoval         ;
				STRING iv_add_apt                       ;
				INTEGER iv_nas_summary                   ;
				INTEGER iv_inq_recency                   ;
				INTEGER iv_attr_addrs_recency            ;
				INTEGER iv_attr_purchase_recency         ;
				INTEGER iv_eviction_count                ;
				INTEGER iv_liens_unrel_sc_ct             ;
				REAL c_subscore0                      ;
				REAL c_subscore1                      ;
				REAL c_subscore2                      ;
				REAL c_subscore3                      ;
				REAL c_subscore4                      ;
				REAL c_subscore5                      ;
				REAL c_subscore6                      ;
				REAL c_subscore7                      ;
				REAL c_subscore8                      ;
				REAL c_subscore9                      ;
				REAL c_rawscore                       ;
				REAL c_lnoddsscore                    ;
				REAL c_probscore                      ;
				INTEGER base                             ;
				REAL odds                             ;
				INTEGER point                            ;
				BOOLEAN ssn_deceased                     ;
				BOOLEAN iv_riskview_222s                 ;
				INTEGER rva1310_3                        ;
				BOOLEAN glrc36                           ;
				BOOLEAN glrc9d                           ;
				BOOLEAN glrc9g                           ;
				BOOLEAN glrcbl                           ;
				BOOLEAN glrcev                           ;
				BOOLEAN glrc9h                           ;
				BOOLEAN glrc98                           ;
				BOOLEAN glrc9q                           ;
				BOOLEAN glrcpv                           ;
				BOOLEAN propsrc                          ;
				BOOLEAN glrc9a                           ;
				BOOLEAN glrc9b                           ;
				REAL rcvalue36_1                      ;
				REAL rcvalue36                        ;
				REAL rcvalue9d_1                      ;
				REAL rcvalue9d                        ;
				REAL rcvalue9g_1                      ;
				REAL rcvalue9g                        ;
				REAL rcvalueev_1                      ;
				REAL rcvalueev                        ;
				REAL rcvalue9h_1                      ;
				REAL rcvalue9h                        ;
				REAL rcvalue98_1                      ;
				REAL rcvalue98                        ;
				REAL rcvalue9q_1                      ;
				REAL rcvalue9q                        ;
				REAL rcvaluepv_1                      ;
				REAL rcvaluepv                        ;
				REAL rcvalue9a_1                      ;
				REAL rcvalue9a                        ;
				REAL rcvalue9b_1                      ;
				REAL rcvalue9b                        ;
				REAL rcvaluebl_1                      ;
				REAL rcvaluebl                        ;
				STRING rc1                              ;
				STRING rc4                              ;
				STRING rc2                              ;
				STRING rc3                              ;
				STRING rc5                              ;

				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
			
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
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
				combo_dobscore                   := le.iid.combo_dobscore;
				ver_sources                      := le.header_summary.ver_sources;
				ssnlength                        := le.input_validation.ssn_length;
				dobpop                           := le.input_validation.dateofbirth;
				add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
				add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
				add1_naprop                      := le.address_verification.input_address_information.naprop;
				add1_pop                         := le.addrpop;
				property_owned_total             := le.address_verification.owned.property_total;
				property_sold_total              := le.address_verification.sold.property_total;
				add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
				addrs_5yr                        := le.other_address_info.addrs_last_5years;
				addrs_10yr                       := le.other_address_info.addrs_last_10years;
				addrs_15yr                       := le.other_address_info.addrs_last_15years;
				addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
				inq_count01                      := le.acc_logs.inquiries.count01;
				inq_count03                      := le.acc_logs.inquiries.count03;
				inq_count06                      := le.acc_logs.inquiries.count06;
				inq_count12                      := le.acc_logs.inquiries.count12;
				impulse_count                    := le.impulse.count;
				email_source_list                := le.email_summary.email_source_list;
				attr_addrs_last30                := le.other_address_info.addrs_last30;
				attr_addrs_last90                := le.other_address_info.addrs_last90;
				attr_addrs_last12                := le.other_address_info.addrs_last12;
				attr_addrs_last24                := le.other_address_info.addrs_last24;
				attr_addrs_last36                := le.other_address_info.addrs_last36;
				attr_date_first_purchase         := le.other_address_info.date_first_purchase;
				attr_num_purchase30              := le.other_address_info.num_purchase30;
				attr_num_purchase90              := le.other_address_info.num_purchase90;
				attr_num_purchase180             := le.other_address_info.num_purchase180;
				attr_num_purchase12              := le.other_address_info.num_purchase12;
				attr_num_purchase24              := le.other_address_info.num_purchase24;
				attr_num_purchase36              := le.other_address_info.num_purchase36;
				attr_num_purchase60              := le.other_address_info.num_purchase60;
				attr_eviction_count              := le.bjl.eviction_count;
				bankrupt                         := le.bjl.bankrupt;
				filing_count                     := le.bjl.filing_count;
				bk_recent_count                  := le.bjl.bk_recent_count;
				liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
				liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
				liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
				criminal_count                   := le.bjl.criminal_count;
				inferred_age                     := le.inferred_age;


				NULL := -999999999;


				BOOLEAN indexw(string source, string target, string delim) :=
					(source = target) OR
					(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
					(source[1..length(target)+1] = target + delim) OR
					(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

				sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

				email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

				iv_ds001_impulse_count := map(
						not(truedid)                           => NULL,
						impulse_count = 0 and email_src_im 		 => 1,
																											impulse_count);

				_in_dob := common.sas_date((string)(in_dob));

//				yr_in_dob := if(in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);
				yr_in_dob := map(
						in_dob = '' 	=> -1, 
						in_dob = '0' 	=> NULL, 
						in_dob[1..2] = '18' => NULL,
														 (sysdate - _in_dob) / 365.25);   

				yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

				age_estimate := map(
						yr_in_dob_int > 0 => yr_in_dob_int,
						inferred_age > 0  => inferred_age,
																 -1);

				iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

				iv_pv001_bst_avm_autoval := map(
						not(truedid)     => NULL,
						add1_isbestmatch => add1_avm_automated_valuation,
																add2_avm_automated_valuation);

				iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

				iv_nas_summary := if(not(truedid or (integer)ssnlength > 0), NULL, nas_summary);

				iv_inq_recency := map(
						not(truedid) => NULL,
						inq_count01 >0  => 1,
						inq_count03 >0  => 3,
						inq_count06 >0  => 6,
						inq_count12 >0  => 12,
														0);

				iv_attr_addrs_recency := map(
						not(truedid)      => NULL,
						attr_addrs_last30 >0 => 1,
						attr_addrs_last90 >0 => 3,
						attr_addrs_last12 >0 => 12,
						attr_addrs_last24 >0 => 24,
						attr_addrs_last36 >0 => 36,
						addrs_5yr         >0 => 60,
						addrs_10yr        >0 => 120,
						addrs_15yr        >0 => 180,
						addrs_per_adl > 0 => 999,
																 0);

				iv_attr_purchase_recency := map(
						not(truedid)                 => NULL,
						attr_num_purchase30 >0          => 1,
						attr_num_purchase90 >0          => 3,
						attr_num_purchase180 >0         => 6,
						attr_num_purchase12 >0          => 12,
						attr_num_purchase24 >0          => 24,
						attr_num_purchase36 >0          => 36,
						attr_num_purchase60 >0          => 60,
						attr_date_first_purchase > 0 => 99,
																						0);

				iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

				iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

				c_subscore0 := map(
						(iv_nas_summary in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]) => -0.453927,
						(iv_nas_summary in [12])                                   => 0.227563,
																																				  0.000000);

				c_subscore1 := map(
						(iv_attr_addrs_recency in [1, 3])                  => -0.241353,
						(iv_attr_addrs_recency in [12])                    => -0.072142,
						(iv_attr_addrs_recency in [24])                    => 0.017355,
						(iv_attr_addrs_recency in [36, 60, 120, 180, 999]) => 0.446414,
																																	-0.000000);

				c_subscore2 := map(
						NULL < iv_ag001_age AND iv_ag001_age < 18 => -0.000000,
						18 <= iv_ag001_age AND iv_ag001_age < 23  => -0.391267,
						23 <= iv_ag001_age AND iv_ag001_age < 46  => -0.159859,
						46 <= iv_ag001_age AND iv_ag001_age < 55  => 0.087869,
						55 <= iv_ag001_age AND iv_ag001_age < 60  => 0.332452,
						60 <= iv_ag001_age                        => 0.374967,
																												 -0.000000);

				c_subscore3 := map(
						(iv_add_apt in ['0']) => -0.085180,
						(iv_add_apt in ['1']) => 0.406204,
																		 0.000000);

				c_subscore4 := map(
						NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.104483,
						1 <= iv_eviction_count AND iv_eviction_count < 2   => -0.175189,
						2 <= iv_eviction_count AND iv_eviction_count < 3   => -0.202836,
						3 <= iv_eviction_count                             => -0.203337,
																																	0.000000);

				c_subscore5 := map(
						NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.052181,
						1 <= iv_ds001_impulse_count                                  => -0.302045,
																																						0.000000);

				c_subscore6 := map(
						NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.054643,
						1 <= iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 2   => -0.170323,
						2 <= iv_liens_unrel_sc_ct                                => -0.424602,
																																				-0.000000);

				c_subscore7 := map(
						(iv_inq_recency in [1, 3])  => -0.352688,
						(iv_inq_recency in [6, 12]) => -0.012559,
						(iv_inq_recency in [0])     => 0.043723,
																					 0.000000);

				c_subscore8 := map(
						NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1        => -0.012522,
						1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 74930      => -0.112335,
						74930 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 159645 => 0.061797,
						159645 <= iv_pv001_bst_avm_autoval                                      => 0.366018,
																																											 -0.000000);

				c_subscore9 := map(
						(iv_attr_purchase_recency in [1, 3, 6, 12, 24, 36, 60]) => 0.239078,
						(iv_attr_purchase_recency in [99])                      => 0.092219,
						(iv_attr_purchase_recency in [0])                       => -0.062360,
																																			 -0.000000);

				c_rawscore := c_subscore0 +
						c_subscore1 +
						c_subscore2 +
						c_subscore3 +
						c_subscore4 +
						c_subscore5 +
						c_subscore6 +
						c_subscore7 +
						c_subscore8 +
						c_subscore9;

				c_lnoddsscore := c_rawscore + 2.082507;

				c_probscore := exp(c_lnoddsscore) / (1 + exp(c_lnoddsscore));

				base := 700;

				odds := (1 - 0.11) / 0.11;

				point := 40;

				ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

				iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
				rva1310_3 := map(
						ssn_deceased     => 200,
						iv_riskview_222s => 222,
																min(if(max(round(point * (c_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (c_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

				glrc36 := truedid or (integer)ssnlength > 0;

				glrc9d := truedid and attr_addrs_last12 > 0;

				glrc9g := truedid and 18 <= iv_ag001_age AND iv_ag001_age <= 35;

				glrcbl := 0;

				glrcev := truedid and attr_eviction_count > 0;

				glrc9h := truedid and impulse_count > 0;

				glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

				glrc9q := truedid and inq_count12 > 0;

				glrcpv := truedid and add1_pop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 120000;

				propsrc := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',');

				glrc9a := truedid and property_owned_total = 0 and propsrc = false;

				glrc9b := truedid and property_owned_total = 0 and propsrc = true;

				rcvalue36_1 := 0.227563 - c_subscore0;

				rcvalue36 := (integer)glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

				rcvalue9d_1 := 0.446414 - c_subscore1;

				rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

				rcvalue9g_1 := 0.374967 - c_subscore2;

				rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1)));

				rcvalueev_1 := 0.104483 - c_subscore4;

				rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

				rcvalue9h_1 := 0.052181 - c_subscore5;

				rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

				rcvalue98_1 := 0.054643 - c_subscore6;

				rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

				rcvalue9q_1 := 0.043723 - c_subscore7;

				rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1)));

				rcvaluepv_1 := 0.366018 - c_subscore8;

				rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

				rcvalue9a_1 := 0.239078 - c_subscore9;

				rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

				rcvalue9b_1 := 0.239078 - c_subscore9;

				rcvalue9b := (integer)glrc9b * if(max(rcvalue9b_1) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1)));

				rcvaluebl_1 := 0.406204 - c_subscore3;

				rcvaluebl := glrcbl * if(max(rcvaluebl_1) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1)));

				//*************************************************************************************//
				// I have no idea how the reason code logic gets implemented in ECL, so everything below 
				// probably needs to get changed or replaced.  The methodology for creating the reason codes is
				// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
				// that model code for guidance on implementing reason codes. 
				//*************************************************************************************//

				ds_layout := {STRING rc, REAL value};

				rc_dataset := DATASET([
						{'36', RCValue36},
						{'9D', RCValue9D},
						{'9G', RCValue9G},
						{'EV', RCValueEV},
						{'9H', RCValue9H},
						{'98', RCValue98},
						{'9Q', RCValue9Q},
						{'PV', RCValuePV},
						{'9A', RCValue9A},
						{'9B', RCValue9B},
						{'BL', RCValueBL}
						], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
	
	rcs_9q := rcs_top & if(glrc9q AND (count(rcs_top4(rc='9Q')) =0) AND inq_count12 > 0, ROW({'9Q', NULL}, ds_layout));

	rcs_override := MAP(
											rva1310_3 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1310_3 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1310_3 = 900 => DATASET([{'  ', NULL}], ds_layout),
											(500 < rva1310_3) and (rva1310_3 <= 710) and 
													(rcs_9q[1].rc!='9E') and (rcs_9q[1].rc!='') and (rcs_9q[2].rc='') => DATASET([{rcs_9q[1].rc, NULL}, {'9E', NULL}], ds_layout),
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

//Intermediate variables
	#if(RVA_DEBUG)
				self.clam															:= le;
				self.sysdate                          := sysdate;
				self.email_src_im                     := email_src_im;
				self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
				self._in_dob                          := _in_dob;
				self.yr_in_dob                        := yr_in_dob;
				self.yr_in_dob_int                    := yr_in_dob_int;
				self.age_estimate                     := age_estimate;
				self.iv_ag001_age                     := iv_ag001_age;
				self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
				self.iv_add_apt                       := iv_add_apt;
				self.iv_nas_summary                   := iv_nas_summary;
				self.iv_inq_recency                   := iv_inq_recency;
				self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
				self.iv_attr_purchase_recency         := iv_attr_purchase_recency;
				self.iv_eviction_count                := iv_eviction_count;
				self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
				self.c_subscore0                      := c_subscore0;
				self.c_subscore1                      := c_subscore1;
				self.c_subscore2                      := c_subscore2;
				self.c_subscore3                      := c_subscore3;
				self.c_subscore4                      := c_subscore4;
				self.c_subscore5                      := c_subscore5;
				self.c_subscore6                      := c_subscore6;
				self.c_subscore7                      := c_subscore7;
				self.c_subscore8                      := c_subscore8;
				self.c_subscore9                      := c_subscore9;
				self.c_rawscore                       := c_rawscore;
				self.c_lnoddsscore                    := c_lnoddsscore;
				self.c_probscore                      := c_probscore;
				self.base                             := base;
				self.odds                             := odds;
				self.point                            := point;
				self.ssn_deceased                     := ssn_deceased;
				self.iv_riskview_222s                 := iv_riskview_222s;
				self.rva1310_3                        := rva1310_3;
				self.glrc36                           := glrc36;
				self.glrc9d                           := glrc9d;
				self.glrc9g                           := glrc9g;
				self.glrcbl                           := glrcbl;
				self.glrcev                           := glrcev;
				self.glrc9h                           := glrc9h;
				self.glrc98                           := glrc98;
				self.glrc9q                           := glrc9q;
				self.glrcpv                           := glrcpv;
				self.propsrc                          := propsrc;
				self.glrc9a                           := glrc9a;
				self.glrc9b                           := glrc9b;
				self.rcvalue36_1                      := rcvalue36_1;
				self.rcvalue36                        := rcvalue36;
				self.rcvalue9d_1                      := rcvalue9d_1;
				self.rcvalue9d                        := rcvalue9d;
				self.rcvalue9g_1                      := rcvalue9g_1;
				self.rcvalue9g                        := rcvalue9g;
				self.rcvalueev_1                      := rcvalueev_1;
				self.rcvalueev                        := rcvalueev;
				self.rcvalue9h_1                      := rcvalue9h_1;
				self.rcvalue9h                        := rcvalue9h;
				self.rcvalue98_1                      := rcvalue98_1;
				self.rcvalue98                        := rcvalue98;
				self.rcvalue9q_1                      := rcvalue9q_1;
				self.rcvalue9q                        := rcvalue9q;
				self.rcvaluepv_1                      := rcvaluepv_1;
				self.rcvaluepv                        := rcvaluepv;
				self.rcvalue9a_1                      := rcvalue9a_1;
				self.rcvalue9a                        := rcvalue9a;
				self.rcvalue9b_1                      := rcvalue9b_1;
				self.rcvalue9b                        := rcvalue9b;
				self.rcvaluebl_1                      := rcvaluebl_1;
				self.rcvaluebl                        := rcvaluebl;
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
											(string3)rva1310_3
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;
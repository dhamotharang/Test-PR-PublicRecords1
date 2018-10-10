// RVA1310_2 Automobile Acceptance Corporation

import risk_indicators, riskwise, RiskWiseFCRA, ut, riskview;

export RVA1310_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record
				STRING iv_db001_bankruptcy              ;
				INTEGER iv_de001_eviction_recency        ;
				BOOLEAN email_src_im                     ;
				INTEGER iv_ds001_impulse_count           ;
				INTEGER iv_ms001_ssns_per_adl            ;
				STRING iv_in001_wealth_index            ;
				STRING iv_ed001_college_ind             ;
				INTEGER iv_cvi                           ;
				STRING mortgage_type                    ;
				BOOLEAN mortgage_present                 ;
				STRING iv_inp_addr_mortgage_type        ;
				INTEGER iv_property_sold_total           ;
				INTEGER iv_addrs_5yr                     ;
				INTEGER iv_attr_addrs_recency            ;
				INTEGER iv_liens_unrel_sc_ct             ;
				INTEGER iv_criminal_count                ;
				REAL i_subscore0                      ;
				REAL i_subscore1                      ;
				REAL i_subscore2                      ;
				REAL i_subscore3                      ;
				REAL i_subscore4                      ;
				REAL i_subscore5                      ;
				REAL i_subscore6                      ;
				REAL i_subscore7                      ;
				REAL i_subscore8                      ;
				REAL i_subscore9                      ;
				REAL i_subscore10                     ;
				REAL i_subscore11                     ;
				REAL i_subscore12                     ;
				REAL i_rawscore                       ;
				REAL i_lnoddsscore                    ;
				REAL i_probscore                      ;
				INTEGER base                             ;
				REAL odds                             ;
				INTEGER point                            ;
				BOOLEAN ssn_deceased                     ;
				BOOLEAN iv_riskview_222s                 ;
				INTEGER rva1310_2                        ;
				BOOLEAN glrcev                           ;
				BOOLEAN glrc98                           ;
				BOOLEAN glrc9h                           ;
				BOOLEAN glrcbl                           ;
				BOOLEAN glrc9d                           ;
				BOOLEAN glrc9w                           ;
				BOOLEAN glrcpv                           ;
				BOOLEAN glrc97                           ;
				BOOLEAN propsrc                          ;
				BOOLEAN glrc9b                           ;
				BOOLEAN glrcms                           ;
				BOOLEAN glrc9i                           ;
				BOOLEAN glrc36                           ;
				REAL rcvalueev_1                      ;
				REAL rcvalueev                        ;
				REAL rcvalue98_1                      ;
				REAL rcvalue98                        ;
				REAL rcvalue9h_1                      ;
				REAL rcvalue9h                        ;
				REAL rcvalue9d_1                      ;
				REAL rcvalue9d_2                      ;
				REAL rcvalue9d                        ;
				REAL rcvalue9w_1                      ;
				REAL rcvalue9w                        ;
				REAL rcvaluepv_1                      ;
				REAL rcvaluepv                        ;
				REAL rcvalue36_1                      ;
				REAL rcvalue36                        ;
				REAL rcvalue97_1                      ;
				REAL rcvalue97                        ;
				REAL rcvalue9b_1                      ;
				REAL rcvalue9b                        ;
				REAL rcvaluems_1                      ;
				REAL rcvaluems                        ;
				REAL rcvalue9i_1                      ;
				REAL rcvalue9i                        ;
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
				nas_summary                      := le.iid.nas_summary;
				nap_summary                      := le.iid.nap_summary;
				cvi                              := le.iid.cvi;
				rc_decsflag                      := le.iid.decsflag;
				rc_bansflag                      := le.iid.bansflag;
				combo_dobscore                   := le.iid.combo_dobscore;
				ver_sources                      := le.header_summary.ver_sources;
				addrpop                          := le.input_validation.address;
				ssnlength                        := le.input_validation.ssn_length;
				hphnpop                          := le.input_validation.homephone;
				age                              := le.name_verification.age;
				add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
				add1_naprop                      := le.address_verification.input_address_information.naprop;
				add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
				add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
				add1_pop                         := le.addrpop;
				property_owned_total             := le.address_verification.owned.property_total;
				property_sold_total              := le.address_verification.sold.property_total;
				addrs_5yr                        := le.other_address_info.addrs_last_5years;
				addrs_10yr                       := le.other_address_info.addrs_last_10years;
				addrs_15yr                       := le.other_address_info.addrs_last_15years;
				unique_addr_count                := le.address_history_summary.unique_addr_cnt;
				ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
				addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
				impulse_count                    := le.impulse.count;
				email_source_list                := le.email_summary.email_source_list;
				attr_addrs_last30                := le.other_address_info.addrs_last30;
				attr_addrs_last90                := le.other_address_info.addrs_last90;
				attr_addrs_last12                := le.other_address_info.addrs_last12;
				attr_addrs_last24                := le.other_address_info.addrs_last24;
				attr_addrs_last36                := le.other_address_info.addrs_last36;
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
				bk_recent_count                  := le.bjl.bk_recent_count;
				liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
				liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
				liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
				criminal_count                   := le.bjl.criminal_count;
				ams_class                        := le.student.class;
				ams_college_code                 := le.student.college_code;
				ams_college_type                 := le.student.college_type;
				ams_income_level_code            := le.student.income_level_code;
				ams_file_type                    := le.student.file_type2;
				ams_college_tier                 := le.student.college_tier;
				ams_college_major                := le.student.college_major;
				wealth_index                     := le.wealth_indicator;

				NULL := -999999999;


				INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


				BOOLEAN indexw(string source, string target, string delim) :=
					(source = target) OR
					(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
					(source[1..length(target)+1] = target + delim) OR
					(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

				iv_db001_bankruptcy := map(
						not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
						(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
						(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
						(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																																																					 '0 - No BK        ');

				iv_de001_eviction_recency := map(
						not(truedid)                                                => NULL,
						attr_eviction_count90 >0                                      => 3,
						attr_eviction_count180 >0                                     => 6,
						attr_eviction_count12  >0                                     => 12,
						(boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
						attr_eviction_count24 >0                                      => 25,
						(boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
						attr_eviction_count36 >0                                      => 37,
						(boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
						attr_eviction_count60 >0                                      => 61,
						attr_eviction_count >= 2                                    => 98,
						attr_eviction_count >= 1                                    => 99,
																																					 0);

				email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

				iv_ds001_impulse_count := map(
						not(truedid)                           => NULL,
						impulse_count = 0 and email_src_im 	   => 1,
																											impulse_count);

				iv_ms001_ssns_per_adl := map(
						not(truedid)     => NULL,
						ssns_per_adl = 0 => 1,
																ssns_per_adl);

				iv_in001_wealth_index := if(not(truedid), ' ', (string)wealth_index);

				iv_ed001_college_ind := map(
						not(truedid)                                                                                                                                                          => ' ',
						not(ams_college_code = '') or not(ams_college_type = '') or ams_college_tier >= '0' or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
						ams_file_type = 'M'                                                                                                                                                   => '0',
						not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																																																																										 '0');

				iv_cvi := if(not(truedid or (integer)ssnlength > 0) and not(hphnpop or addrpop), NULL, cvi);

				mortgage_type := add1_mortgage_type;

				mortgage_present := not((add1_mortgage_date in [0]));

				iv_inp_addr_mortgage_type := map(
						not(add1_pop)                                         => '               ',
						(mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
						(mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
						(mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
						(mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
						(mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
						(mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
						(mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
						(mortgage_type in ['U'])                              => 'Unknown        ',
						not(mortgage_type = '')                             => 'Other          ',
						mortgage_present                                      => 'Unknown        ',
																																		 'No Mortgage');

				iv_property_sold_total := if(not(truedid or add1_pop), NULL, property_sold_total);

				iv_addrs_5yr := map(
						not(truedid)          => NULL,
						unique_addr_count = 0 => -1,
																		 addrs_5yr);

				iv_attr_addrs_recency := map(
						not(truedid)      => NULL,
						attr_addrs_last30 >0 => 1,
						attr_addrs_last90 >0 => 3,
						attr_addrs_last12 >0 => 12,
						attr_addrs_last24 >0 => 24,
						attr_addrs_last36 >0 => 36,
						addrs_5yr >0         => 60,
						addrs_10yr >0        => 120,
						addrs_15yr >0        => 180,
						addrs_per_adl > 0 => 999,
																 0);

				iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

				iv_criminal_count := if(not(truedid), NULL, criminal_count);

				i_subscore0 := map(
						(iv_de001_eviction_recency in [3, 6])                          => -0.688478,
						(iv_de001_eviction_recency in [12])                            => -0.156413,
						(iv_de001_eviction_recency in [24])                            => -0.081837,
						(iv_de001_eviction_recency in [0, 25, 36, 37, 60, 61, 98, 99]) => 0.064565,
																																							-0.000000);

				i_subscore1 := map(
						NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.093168,
						1 <= iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 2   => -0.282231,
						2 <= iv_liens_unrel_sc_ct                                => -0.387707,
																																				-0.000000);

				i_subscore2 := map(
						NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.057439,
						1 <= iv_ds001_impulse_count                                  => -0.401893,
																																						0.000000);

				i_subscore3 := map(
						(iv_inp_addr_mortgage_type in [' '])                                                                           => -0.000000,
						(iv_inp_addr_mortgage_type in ['Commercial', 'High-Risk', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.118669,
						(iv_inp_addr_mortgage_type in ['No Mortgage'])                                                                 => -0.030515,
						(iv_inp_addr_mortgage_type in ['Equity Loan'])                                                                 => 0.178180,
						(iv_inp_addr_mortgage_type in ['Conventional', 'Government'])                                                  => 0.487164,
																																																															-0.000000);

				i_subscore4 := map(
						NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.000000,
						0 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.152019,
						3 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.032791,
						7 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => -0.176962,
						8 <= iv_addrs_5yr                        => -0.428709,
																												-0.000000);

				i_subscore5 := map(
						(iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged']) => 0.060276,
						(iv_db001_bankruptcy in ['3 - BK Other'])                   => -0.244821,
						(iv_db001_bankruptcy in ['2 - BK Dismissed'])               => -0.393377,
																																					 0.000000);

				i_subscore6 := map(
						(iv_attr_addrs_recency in [1, 3])                      => -0.176132,
						(iv_attr_addrs_recency in [12])                        => -0.002727,
						(iv_attr_addrs_recency in [24, 36, 60, 120, 180, 999]) => 0.135889,
																																			0.000000);

				i_subscore7 := map(
						(iv_in001_wealth_index in [' '])           => 0.000000,
						(iv_in001_wealth_index in ['0'])           => 0.049554,
						(iv_in001_wealth_index in ['1'])           => -0.266022,
						(iv_in001_wealth_index in ['2'])           => -0.153834,
						(iv_in001_wealth_index in ['3'])           => -0.012571,
						(iv_in001_wealth_index in ['4', '5', '6']) => 0.207149,
																													0.000000);

				i_subscore8 := map(
						(iv_cvi in [0, 10, 20]) => -0.173329,
						(iv_cvi in [30, 40])       => -0.008718,
						(iv_cvi in [50])             => 0.119797,
																							0.000000);

				i_subscore9 := map(
						NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.016037,
						1 <= iv_criminal_count                             => -0.605654,
																																	-0.000000);

				i_subscore10 := map(
						NULL < iv_property_sold_total AND iv_property_sold_total < 1 => -0.030763,
						1 <= iv_property_sold_total                                  => 0.288281,
																																						-0.000000);

				i_subscore11 := map(
						NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3 => 0.029759,
						3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.021246,
						4 <= iv_ms001_ssns_per_adl                                 => -0.322833,
																																					-0.000000);

				i_subscore12 := map(
						(iv_ed001_college_ind in [' ']) => 0.000000,
						(iv_ed001_college_ind in ['0']) => -0.019307,
						(iv_ed001_college_ind in ['1']) => 0.356669,
																							 0.000000);

				i_rawscore := i_subscore0 +
						i_subscore1 +
						i_subscore2 +
						i_subscore3 +
						i_subscore4 +
						i_subscore5 +
						i_subscore6 +
						i_subscore7 +
						i_subscore8 +
						i_subscore9 +
						i_subscore10 +
						i_subscore11 +
						i_subscore12;

				i_lnoddsscore := i_rawscore + 1.318618;

				i_probscore := exp(i_lnoddsscore) / (1 + exp(i_lnoddsscore));

				base := 700;

				odds := (1 - 0.21) / 0.21;

				point := 40;

				ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

				iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

				rva1310_2 := map(
						ssn_deceased     => 200,
						iv_riskview_222s => 222,
																min(if(max(round(point * (i_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (i_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

				glrcev := truedid and attr_eviction_count > 0;

				glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

				glrc9h := truedid and impulse_count > 0;

				glrcbl := 0;

				glrc9d := truedid and (addrs_5yr > 4 or attr_addrs_last12 > 0);

				glrc9w := truedid and filing_count > 0;

				glrcpv := truedid and add1_pop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 150000;

				glrc97 := truedid and criminal_count > 0;

				propsrc := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',');

				glrc9b := truedid and property_owned_total = 0 and propsrc;

				glrcms := truedid and ssns_per_adl > 2;

				glrc9i := truedid and 18 <= age AND age <= 35;

				glrc36 := truedid and cvi < 40;

				rcvalueev_1 := 0.064565 - i_subscore0;

				rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

				rcvalue98_1 := 0.093168 - i_subscore1;

				rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

				rcvalue9h_1 := 0.057439 - i_subscore2;

				rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

				rcvalue9d_1 := 0.152019 - i_subscore4;

				rcvalue9d_2 := 0.135889 - i_subscore6;

				rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

				rcvalue9w_1 := 0.060276 - i_subscore5;

				rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

				rcvaluepv_1 := 0.207149 - i_subscore7;

				rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1)));

				rcvalue36_1 := 0.119797 - i_subscore8;

				rcvalue36 := (integer)glrc36 * if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

				rcvalue97_1 := 0.016037 - i_subscore9;

				rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

				rcvalue9b_1 := 0.288281 - i_subscore10;

				rcvalue9b := (integer)glrc9b * if(max(rcvalue9b_1) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1)));

				rcvaluems_1 := 0.029759 - i_subscore11;

				rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

				rcvalue9i_1 := 0.356669 - i_subscore12;

				rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

				rcvaluebl_1 := 0.487164 - i_subscore3;

				rcvaluebl := glrcbl * if(max(rcvaluebl_1) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1)));

				//*************************************************************************************//
				// I have no idea how the reason code logic gets implemented in ECL, so everything below 
				// probably needs to get changed or replaced.  The methodology for creating the reason codes is
				// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
				// that model code for guidance on implementing reason codes. 
				//*************************************************************************************//

				ds_layout := {STRING rc, REAL value};

				rc_dataset := DATASET([
						{'EV', RCValueEV},
						{'98', RCValue98},
						{'9H', RCValue9H},
						{'9D', RCValue9D},
						{'9W', RCValue9W},
						{'PV', RCValuePV},
						{'36', RCValue36},
						{'97', RCValue97},
						{'9B', RCValue9B},
						{'MS', RCValueMS},
						{'9I', RCValue9I},
						{'BL', RCValueBL}
						], ds_layout)(value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
	
	rcs_override := MAP(
											rva1310_2 = 200 => DATASET([{'02', NULL}], ds_layout),
											rva1310_2 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rva1310_2 = 900 => DATASET([{'  ', NULL}], ds_layout),
											(500 < rva1310_2) and (rva1310_2 <= 700) and 
													(rcs_top[1].rc!='9E') and (rcs_top[1].rc!='') and (rcs_top[2].rc='') => DATASET([{rcs_top[1].rc, NULL}, {'9E', NULL}], ds_layout),
											rcs_top
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
				self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
				self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
				self.email_src_im                     := email_src_im;
				self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
				self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
				self.iv_in001_wealth_index            := iv_in001_wealth_index;
				self.iv_ed001_college_ind             := iv_ed001_college_ind;
				self.iv_cvi                           := iv_cvi;
				self.mortgage_type                    := mortgage_type;
				self.mortgage_present                 := mortgage_present;
				self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
				self.iv_property_sold_total           := iv_property_sold_total;
				self.iv_addrs_5yr                     := iv_addrs_5yr;
				self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
				self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
				self.iv_criminal_count                := iv_criminal_count;
				self.i_subscore0                      := i_subscore0;
				self.i_subscore1                      := i_subscore1;
				self.i_subscore2                      := i_subscore2;
				self.i_subscore3                      := i_subscore3;
				self.i_subscore4                      := i_subscore4;
				self.i_subscore5                      := i_subscore5;
				self.i_subscore6                      := i_subscore6;
				self.i_subscore7                      := i_subscore7;
				self.i_subscore8                      := i_subscore8;
				self.i_subscore9                      := i_subscore9;
				self.i_subscore10                     := i_subscore10;
				self.i_subscore11                     := i_subscore11;
				self.i_subscore12                     := i_subscore12;
				self.i_rawscore                       := i_rawscore;
				self.i_lnoddsscore                    := i_lnoddsscore;
				self.i_probscore                      := i_probscore;
				self.base                             := base;
				self.odds                             := odds;
				self.point                            := point;
				self.ssn_deceased                     := ssn_deceased;
				self.iv_riskview_222s                 := iv_riskview_222s;
				self.rva1310_2                        := rva1310_2;
				self.glrcev                           := glrcev;
				self.glrc98                           := glrc98;
				self.glrc9h                           := glrc9h;
				self.glrcbl                           := glrcbl;
				self.glrc9d                           := glrc9d;
				self.glrc9w                           := glrc9w;
				self.glrcpv                           := glrcpv;
				self.glrc97                           := glrc97;
				self.propsrc                          := propsrc;
				self.glrc9b                           := glrc9b;
				self.glrcms                           := glrcms;
				self.glrc9i                           := glrc9i;
				self.glrc36                           := glrc36;
				self.rcvalueev_1                      := rcvalueev_1;
				self.rcvalueev                        := rcvalueev;
				self.rcvalue98_1                      := rcvalue98_1;
				self.rcvalue98                        := rcvalue98;
				self.rcvalue9h_1                      := rcvalue9h_1;
				self.rcvalue9h                        := rcvalue9h;
				self.rcvalue9d_1                      := rcvalue9d_1;
				self.rcvalue9d_2                      := rcvalue9d_2;
				self.rcvalue9d                        := rcvalue9d;
				self.rcvalue9w_1                      := rcvalue9w_1;
				self.rcvalue9w                        := rcvalue9w;
				self.rcvaluepv_1                      := rcvaluepv_1;
				self.rcvaluepv                        := rcvaluepv;
				self.rcvalue36_1                      := rcvalue36_1;
				self.rcvalue36                        := rcvalue36;
				self.rcvalue97_1                      := rcvalue97_1;
				self.rcvalue97                        := rcvalue97;
				self.rcvalue9b_1                      := rcvalue9b_1;
				self.rcvalue9b                        := rcvalue9b;
				self.rcvaluems_1                      := rcvaluems_1;
				self.rcvaluems                        := rcvaluems;
				self.rcvalue9i_1                      := rcvalue9i_1;
				self.rcvalue9i                        := rcvalue9i;
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
											(string3)rva1310_2
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;;


import easi, ut, address, riskwise, risk_indicators, std;

export CDN806_1_0(
	grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
		dataset(RiskWise.Layout_CD2I) indata,
		boolean IBICID,
		boolean WantstoSeeBillToShipToDifferenceFlag
		) := FUNCTION

//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi; //census
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.easi := ri;	
		self.cd2i.county := le.bill_to_out.shell_input.county;
		self.cd2i.state := le.bill_to_out.shell_input.st;
		self.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.cd2i.seq := le.bill_to_out.shell_input.seq;
		self.cd2i := le;		
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi2 := ri;
		self.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.cd2i := le;
		self := le;
	END;

	clam_with_easi := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));
	with_census := join(indata, clam_with_easi,
		(left.seq*2) = right.bs.bill_to_out.seq,
		transform(layout_model_in, 
			self.cd2i.seq 			 := left.seq,
			self.cd2i.pymtmethod := left.pymtmethod,
			self.cd2i.avscode    := left.avscode ,
			self.cd2i.cidcode    := left.cidcode ,
			self.cd2i.shipmode   := left.shipmode,
			self.cd2i.orderamt   := left.orderamt,
			self.cd2i.channel    := left.channel,
			self := right));

	ineasi := project(with_census, transform(layout_ineasi,
			self := left, self := []));

	Layout_ModelOut doModel( clam le, ineasi ri ) := TRANSFORM


		nas_summary           :=  le.bill_to_out.iid.nas_summary;
		nap_summary           :=  le.bill_to_out.iid.nap_summary;
		rc_phonezipflag       :=  le.bill_to_out.iid.phonezipflag;
		rc_hriskaddrflag      :=  (INTEGER)le.bill_to_out.iid.hriskaddrflag;
		rc_addrvalflag        :=  le.bill_to_out.iid.addrvalflag;
		rc_dwelltype          :=  trim(le.bill_to_out.address_validation.dwelling_type);
		rc_sources            :=  le.bill_to_out.iid.sources;
		rc_ziptypeflag        :=  (INTEGER)le.bill_to_out.address_validation.zip_type;
		lname_credit_sourced  :=  le.bill_to_out.name_verification.lname_credit_sourced;
		fname_tu_sourced      :=  le.bill_to_out.name_verification.fname_tu_sourced;
		lname_tu_sourced      :=  le.bill_to_out.name_verification.lname_tu_sourced;
		add1_naprop           :=  le.bill_to_out.address_verification.input_address_information.naprop;
		add1_date_first_seen  :=  le.bill_to_out.address_verification.input_address_information.date_first_seen;
		add2_naprop           :=  le.bill_to_out.address_verification.address_history_1.naprop;
		add3_naprop           :=  le.bill_to_out.address_verification.address_history_2.naprop;
		telcordia_type        :=  le.bill_to_out.phone_verification.telcordia_type;
		ssns_per_adl          :=  le.bill_to_out.velocity_counters.ssns_per_adl;
		adls_per_addr_c6      :=  le.bill_to_out.velocity_counters.adls_per_addr_created_6months;
		wealth_index          :=  le.bill_to_out.wealth_indicator;
		archive_date          :=  if(le.bill_to_out.historydate <> 999999, (string)le.bill_to_out.historydate, (STRING)Std.Date.Today()); // same value as used in cdn606_1_0
		in_state              :=  le.Bill_to_Out.shell_input.in_state;





		nap_summary_s         :=  le.ship_to_out.iid.nap_summary;
		nas_summary_s         :=  le.ship_to_out.iid.nas_summary;
		add1_naprop_s         :=  le.ship_to_out.address_verification.input_address_information.naprop;
		add2_naprop_s         :=  le.ship_to_out.address_verification.address_history_1.naprop;
		add3_naprop_s         :=  le.ship_to_out.address_verification.address_history_2.naprop;
		add1_date_first_seen_s:=  le.ship_to_out.address_verification.input_address_information.date_first_seen;
		telcordia_type_s      :=  le.ship_to_out.phone_verification.telcordia_type;
		rc_phonezipflag_s     :=  le.ship_to_out.iid.phonezipflag;
		in_state_s            :=  le.ship_to_out.shell_input.in_state;
		wealth_index_s        :=  le.ship_to_out.wealth_indicator;
		rc_sources_s          :=  le.ship_to_out.iid.sources;
		rc_dwelltype_s        :=  trim(le.ship_to_out.address_validation.dwelling_type);
		adls_per_addr_s       :=  le.ship_to_out.velocity_counters.adls_per_addr;
		ssns_per_adl_s        :=  le.ship_to_out.velocity_counters.ssns_per_adl;
		archive_date_s        :=  archive_date;


		C_MED_HHINC           :=  trim(ri.easi.MED_HHINC);
		C_FAMMAR_P            :=  trim(ri.easi.FAMMAR_P);
		C_ROBBERY             :=  trim(ri.easi.ROBBERY);
		C_SPAN_LANG           :=  trim(ri.easi.SPAN_LANG);
                                
		C_LOW_ED_s            :=  trim(ri.easi2.LOW_ED);
		C_FAMMAR_P_s          :=  trim(ri.easi2.FAMMAR_P);
		C_ROBBERY_s           :=  trim(ri.easi2.ROBBERY);
		C_SPAN_LANG_s         :=  trim(ri.easi2.SPAN_LANG);
                                

		IP_topleveldomain      := le.ip2o.topleveldomain;
		IP_continent           := le.ip2o.continent;
		IP_countrycode         := le.ip2o.countrycode;
		IP_state               := le.ip2o.state;
		IP_region              := le.ip2o.ipregion;
		IP_connection          := StringLib.StringtoUppercase(trim(le.ip2o.ipconnection));

		IST_addrscore          := (INTEGER)le.eddo.addrscore;
		IST_firstscore        := (INTEGER)le.eddo.firstscore;

		cus_ORDAMT             := trim(ri.cd2i.orderamt);
		cus_pmttype            := ri.cd2i.pymtmethod;
		cus_avs                := ri.cd2i.avscode;
		cus_CID                := ri.cd2i.cidcode;
		cus_ACQ_CHANNE         := ri.cd2i.channel;
		cus_SHIPMODE           := ri.cd2i.shipmode;








		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		scoring_year := (real)((string)trim(archive_date, LEFT))[1..4];
		scoring_year_s := (real)((string)trim(archive_date_s, LEFT))[1..4];
		uv_billto := (ist_addrscore = 100);
		shp_mode := stringlib.stringtouppercase(cus_SHIPMODE);
		
		uv_instore := (trim(trim(shp_mode, LEFT), LEFT, RIGHT) = '');
		uv_dataset :=  map(uv_instore => 'instore',
						   uv_billto  => 'billto',
										 'shipto');

		vs_offset := ln((((1 - .0157150) * .1377) / (.0157150 * (1 - .1377))));
		vb_offset := ln((((1 - .0037024) * .03582) / (.0037024 * (1 - .03582))));
		vi_offset := ln((((1 - .000786) * .0078) / (.000786 * (1 - .0078))));
		v_in_avs_x := StringLib.StringToUpperCase(trim(trim(cus_avs, LEFT), LEFT, RIGHT));
		v_in_pmt := StringLib.StringToUpperCase(trim(trim(cus_pmttype, LEFT), LEFT, RIGHT));


		amex_lst_b1 := (integer)(v_in_avs_x in ['1', '2', '3', '4']);
		amex_add_b1 := (integer)(v_in_avs_x in ['2', '3', '8', '9']);
		amex_zip_b1 := (integer)(v_in_avs_x in ['1', '2', '7', '8']);

		amex_lst_c4_b2 := -10;
		amex_add_c4_b2 := -10;
		amex_zip_c4_b2 := -10;

		amex_add_2 := if(v_in_avs_x in ['0', '1', '2', '3', '4', '5', '7', '8', '9'], amex_add_b1, amex_add_c4_b2);
		amex_zip_2 := if(v_in_avs_x in ['0', '1', '2', '3', '4', '5', '7', '8', '9'], amex_zip_b1, amex_zip_c4_b2);
		amex_lst_2 := if(v_in_avs_x in ['0', '1', '2', '3', '4', '5', '7', '8', '9'], amex_lst_b1, amex_lst_c4_b2);
		amex_sum := sum(amex_lst_2, amex_add_2, amex_zip_2);

		in_avs_x :=  map(amex_sum = 3             => 'AMEX-FULLVER',
						 amex_sum = 2             => 'AMEX-PARTIALVER',
						 amex_sum in [0, 1]       => 'AMEX-BADVER',
						 v_in_avs_x in ['M', 'V'] => 'INTERNATIONAL',
						 v_in_avs_x in ['B', 'G'] => 'CC-GIFT CARD',
						 v_in_avs_x = 'Y'         => 'ZIP_ADD',
						 v_in_avs_x = 'Z'         => 'ZIP_ONLY',
						 v_in_avs_x = ''          => 'SYSTEM ERROR',
						 v_in_avs_x = 'N'         => 'NO MATCH',
						 v_in_avs_x = 'A'         => 'ADD_ONLY',
													 'MISC');

		vs_avs_x :=  map(v_in_pmt = 'G'                                                                               => 15,
						 (v_in_pmt = 'B') and (in_avs_x = 'ZIP_ADD')                                                  => 14,
						 (v_in_pmt in ['D', 'M', 'V']) and (in_avs_x = 'ZIP_ADD')                                     => 13,
						 (in_avs_x in ['ZIP_ADD', 'AMEX-FULLVER']) or ((v_in_pmt = 'B') and (in_avs_x != 'NO MATCH')) => 12,
						 in_avs_x in ['ADD_ONLY', 'ZIP_ONLY']                                                         => 11,
						 in_avs_x = 'AMEX_PARTIALVER'                                                                 => 10,
						 in_avs_x in ['MISC', 'CC-GIFT CARD']                                                         => 10,
						 in_avs_x in ['NO MATCH', 'AMEX-BADVER']                                                      => 9,
						 in_avs_x = 'INTERNATIONAL'                                                                   => 7,
																														 9);

		vs_avs_x_2 :=  if(v_in_pmt = 'P', 13, vs_avs_x);

		vs_avs_x_m :=  map(vs_avs_x_2 = 7  => 0.8072463768,
						   vs_avs_x_2 = 9  => 0.3752953088,
						   vs_avs_x_2 = 10 => 0.2016754189,
						   vs_avs_x_2 = 11 => 0.1694648478,
						   vs_avs_x_2 = 12 => 0.1391200951,
						   vs_avs_x_2 = 13 => 0.1064337891,
						   vs_avs_x_2 = 14 => 0.0743388134,
											  0);

		vb_avsx :=  map(v_in_pmt = 'G'                                          => 13,
						in_avs_x = 'ZIP_ADD'                                    => 11,
						in_avs_x = 'AMEX-FULLVER'                               => 9,
						in_avs_x in ['ADD_ONLY', 'ZIP_ONLY', 'AMEX-PARTIALVER'] => 7,
						in_avs_x = 'CC-GIFT CARD'                               => 5,
						in_avs_x in ['SYSTEM ERROR', 'MISC']                    => 3,
						in_avs_x in ['NO MATCH', 'AMEX-BADVER']                 => 1,
																				   0);

		vb_avsx_2 :=  if(v_in_pmt = 'P', 11, vb_avsx);

		vb_avsx_m :=  map(vb_avsx_2 = 0  => 0.7318324309,
						  vb_avsx_2 = 1  => 0.3237832654,
						  vb_avsx_2 = 3  => 0.2869565217,
						  vb_avsx_2 = 5  => 0.199339207,
						  vb_avsx_2 = 7  => 0.0410677618,
						  vb_avsx_2 = 9  => 0.0133504299,
						  vb_avsx_2 = 11 => 0.0070889863,
											0.0005741187);

		vi_avsx :=  map((in_avs_x = 'ZIP_ADD') and (v_in_pmt in ['M', 'V', 'D'])                                => 12,
						v_in_pmt = 'G'                                                                          => 11,
						in_avs_x = 'AMEX-FULLVER'                                                               => 10,
						(in_avs_x = 'ZIP_ADD') or ((v_in_pmt = 'B') and (in_avs_x in ['ADD_ONLY', 'ZIP_ONLY'])) => 9.5,
						in_avs_x in ['ADD_ONLY', 'ZIP_ONLY', 'AMEX-PARTIALVER']                                 => 7,
						(in_avs_x = 'AMEX-BADVER') or ((in_avs_x = 'NO_MATCH') and (v_in_pmt = 'B'))            => 4.5,
						in_avs_x = 'NO MATCH'                                                                   => 5,
						in_avs_x = 'INTERNATIONAL'                                                              => 4,
																												   4.5);

		vi_avsx_2 :=  if(v_in_pmt = 'P', 11, vi_avsx);

		vi_avsx_m :=  map(vi_avsx_2 = 4   => 0.3309222423,
						  vi_avsx_2 = 4.5 => 0.0880149813,
						  vi_avsx_2 = 5   => 0.0679569892,
						  vi_avsx_2 = 7   => 0.0113605626,
						  vi_avsx_2 = 9.5 => 0.0057675244,
						  vi_avsx_2 = 10  => 0.0051103368,
						  vi_avsx_2 = 11  => 0.0039405881,
											 0.0030541142);

		v_in_avs := StringLib.StringToUpperCase(trim(trim(cus_avs, LEFT), LEFT, RIGHT));

		v_in_avs_2 :=  map(v_in_avs = '0'  => 'N',
						   v_in_avs = '1'  => 'Z',
						   v_in_avs = '2'  => 'Y',
						   v_in_avs = '3'  => 'A',
						   v_in_avs = '4'  => 'N',
						   v_in_avs = '7'  => 'Z',
						   v_in_avs = '8'  => 'Y',
						   v_in_avs = '9'  => 'A',
						   // per 5Sept08 phone discussion with Eric and Darrin, we do not expect to receive the following 'V#' values
						   // from the customer, so they have been removed here and elsewhere. -- AES, 11Sept08
						   // v_in_avs = 'V0' => 'N',
						   // v_in_avs = 'V1' => 'Z',
						   // v_in_avs = 'V2' => 'Y',
						   // v_in_avs = 'V3' => 'A',
						   // v_in_avs = 'V4' => 'N',
						   // v_in_avs = 'V7' => 'Z',
						   // v_in_avs = 'V8' => 'Y',
											  v_in_avs);

		v_in_avs_bad := (integer)(v_in_avs_2 in ['N', 'M', 'V', '6', 'D', 'U']);

		v_in_cid := trim(trim(cus_cid, LEFT), LEFT, RIGHT);

		v_in_cid_match :=  map(v_in_cid = '1'                        => 1,
							   v_in_cid in ['2', '3', '4', '5', '6'] => -1,
																		0);

		v_in_cid_match_2 :=  if(v_in_pmt = 'P', 1, v_in_cid_match);
		vs_in_cid_match_m :=  map(v_in_cid_match_2 = 1  => 0.31126,
								  v_in_cid_match_2 = -1 => 0.10277,
														   0.13886);

		vi_in_cid_match_m :=  map(v_in_cid_match_2 = -1 => 0.0496948561,
								  v_in_cid_match_2 = 0  => 0.0101309227,
														   0.0068462058);

		v_in_shipmode := StringLib.StringToUpperCase(trim(trim(cus_shipmode, LEFT), LEFT, RIGHT));
		vs_in_shipmode_m :=  map(v_in_shipmode = '2' => 0.5447418221,
								 v_in_shipmode = '7' => 0.2112449799,
								 v_in_shipmode = 'G' => 0.0663542082,
								 v_in_shipmode = 'R' => 0.2287037037,
								 						0.13765);
		vb_in_shipmode_m :=  map(v_in_shipmode = '2' => 0.2095165004,
								 v_in_shipmode = '7' => 0.0726325467,
								 v_in_shipmode = 'G' => 0.023839305,
								 v_in_shipmode = 'R' => 0.0783650091,
														0.03582);

		vs_in_ordAmt := ln(((real)cus_ordamt + 0.01));
		vb_in_ordamt :=  if(''=cus_ordamt, 0, ln((min((real)cus_ordamt, 2500) + 0.01)));
		vi_in_ordAmt := min(2000, abs(((real)cus_ordamt - 20)));
		vs_s_nap :=  map(nap_summary_s in [0, 1, 2, 3]           => 1,
						 nap_summary_s in [4, 5, 6, 7, 8, 9, 10] => 2,
																	3);
		vs_s_nas :=  map(nas_summary_s in [0, 13]      => 1,
						 nas_summary_s in [2, 3, 4, 5] => 2,
														  3);
		vs_add_lst_napver := (nap_summary in [7, 9, 10, 11, 12]);

		vs_verx_combo_b1 := map((vs_s_nap = 3) and (vs_s_nas = 3)  => 11,
								vs_s_nap = 3                       => 10,
								(vs_s_nap = 2) and (vs_s_nas != 1) => 10,
								(vs_s_nap = 2) or (vs_s_nas = 3)   => 9,
								vs_s_nas = 2                       => 8,
																	  7);

		vs_verx_combo_c2_b2 := map(vs_s_nap = 3                      => 9.5,
								   (vs_s_nap = 2) and (vs_s_nas = 3) => 8.5,
								   (vs_s_nap = 2) and (vs_s_nas = 2) =>   8,
								   vs_s_nas = 3                      =>   8,
								   (vs_s_nap = 2) or (vs_s_nas = 2)  =>   7,
																		  6);
                                                                
		vs_verx_combo := if(vs_add_lst_napver, vs_verx_combo_b1, vs_verx_combo_c2_b2);

		vs_verx_combo_m :=  map(vs_verx_combo = 6   => 0.3000657833,
								vs_verx_combo = 7   => 0.1911194237,
								vs_verx_combo = 8   => 0.1219751472,
								vs_verx_combo = 8.5 => 0.0991044189,
								vs_verx_combo = 9   => 0.0651824034,
								vs_verx_combo = 9.5 => 0.0464666021,
								vs_verx_combo = 10  => 0.0373003506,
													   0.0173446862);

		vb_ver_name_tu_sourced := max((integer)fname_tu_sourced, (integer)lname_tu_sourced);

		vb_ver_name_credit_sourced := sum(vb_ver_name_tu_sourced, (integer)lname_credit_sourced);

		vb_nas :=  map(nas_summary in [2, 3, 5] => 2,
					   nas_summary in [8]       => 3,
												   1);

		vb_nap :=  map(nap_summary in [0, 1, 2]                 => 1,
					   nap_summary in [3, 4, 5, 6, 7, 8, 9, 10] => 2,
					   nap_summary in [11, 12]                  => 3,
																   1);

		vb_verx :=  map((vb_nap = 1) and (vb_nas = 1)                                        => 1,
						((vb_nap = 1) and (vb_nas = 2)) or ((vb_nap = 2) and (vb_nas = 1))   => 3,
						vb_nap = 1                                                           => 7,
						(vb_nap = 2) and (vb_nas = 2)                                        => 5,
						((vb_nap = 2) or (vb_nas < 3)) and (vb_ver_name_credit_sourced = 2)  => 10,
						(vb_nap = 2) or (vb_nas < 3)                                         => 9,
						((vb_nap = 3) and (vb_nas = 3)) and (vb_ver_name_credit_sourced = 2) => 11,
						(vb_nap = 3) and (vb_nas = 3)                                        => 10,
																								1);

		vb_verx_m :=  map(vb_verx = 1  => 0.3740152396,
						  vb_verx = 3  => 0.1772329536,
						  vb_verx = 5  => 0.0819863356,
						  vb_verx = 7  => 0.0238942552,
						  vb_verx = 9  => 0.0181363057,
						  vb_verx = 10 => 0.0087897322,
										  0.0029958245);

		vi_nas :=  map(nas_summary in [2, 3, 5] => 2,
					   nas_summary in [8]       => 3,
												   1);

		vi_nap :=  map(nap_summary in [0, 1]              => 1,
					   nap_summary in [2, 3, 4]           => 2,
					   nap_summary in [5, 6, 7, 8, 9, 10] => 3,
					   nap_summary in [11, 12]            => 4,
															 2);

		vi_verx :=  map((vi_nap = 1) and (vi_nas = 1)   => 1,
						(vi_nap <= 2) and (vi_nas <= 2) => 3,
						(vi_nap = 3) and (vi_nas = 1)   => 3,
						(vi_nap = 3) and (vi_nas = 2)   => 5,
						vi_nap = 1                      => 7,
						vi_nap = 2                      => 9,
						vi_nap = 3                      => 11,
						vi_nap = 4                      => 13,
														   1);

		vi_verx_m :=  map(vi_verx = 1  => 0.1136235161,
						  vi_verx = 3  => 0.0412962432,
						  vi_verx = 5  => 0.0125120308,
						  vi_verx = 7  => 0.0073732719,
						  vi_verx = 9  => 0.0060763889,
						  vi_verx = 11 => 0.004759362,
										  0.0026346604);

		vs_s_prop_tree :=  map((add1_naprop_s = 4) or ((add2_naprop_s = 4) or (add3_naprop_s = 4)) => 3,
							   (add1_naprop_s = 3) or ((add2_naprop_s = 3) or (add3_naprop_s = 3)) => 2,
																									  1);

		add_name_matchflag := (nap_summary in [5, 6, 8, 10, 11, 12]);

		vs_nap_prop_ver :=  map(add_name_matchflag and (vs_s_prop_tree > 1) => 4,
								vs_s_prop_tree > 1                          => 3,
								add_name_matchflag                          => 2,
																			   1);

		vs_nap_prop_ver_m :=  map(vs_nap_prop_ver = 1 => 0.2669632925,
								  vs_nap_prop_ver = 2 => 0.1872125575,
								  vs_nap_prop_ver = 3 => 0.105553328,
														 0.0512337934);

		vb_prop_tree_b1 := map((add1_naprop = 4) or ((add2_naprop = 4) or (add3_naprop = 4)) => 11,
							   (add1_naprop = 3) or ((add2_naprop = 3) or (add3_naprop = 3)) => 9,
																								7);

		vb_prop_tree_c2_b2 := map((add1_naprop = 4) or ((add2_naprop = 4) or (add3_naprop = 4)) => 5,
								  (add1_naprop = 3) or ((add2_naprop = 3) or (add3_naprop = 3)) => 5,
																								   1);
		vb_prop_tree := if(nas_summary in [5, 6, 8, 10, 11, 12], vb_prop_tree_b1, vb_prop_tree_c2_b2);
		vb_prop_tree_m :=  map(vb_prop_tree = 1 => 0.2741041321,
							   vb_prop_tree = 5 => 0.0634844102,
							   vb_prop_tree = 7 => 0.0203080792,
							   vb_prop_tree = 9 => 0.0079606263,
												   0.006031216);
		v_s_add1_year_firstSeen := (integer)(((STRING)add1_date_first_seen_s)[1..4]);
		v_s_lres_years :=  if(v_s_add1_year_firstseen in [0], -999, (scoring_year_s - v_s_add1_year_firstseen));
		vs_s_lres_i :=  map(v_s_lres_years < 0   => 0,
							v_s_lres_years <= 2  => 1,
							v_s_lres_years <= 10 => 2,
													3);
		vs_s_lres_i_m :=  map(vs_s_lres_i = 0 => 0.1878637872,
							  vs_s_lres_i = 1 => 0.0975489714,
							  vs_s_lres_i = 2 => 0.0638974647,
												 0.045583239);
		v_add1_year_firstSeen := (integer)(((STRING)add1_date_first_seen)[1..4]);
		v_lres_years :=  if(v_add1_year_firstseen in [0], -999, (scoring_year - v_add1_year_firstseen));
		vb_lres_i :=  map(v_lres_years < 0  => 0,
						  v_lres_years <= 0 => 1,
						  v_lres_years <= 2 => 2,
						  v_lres_years <= 5 => 3,
											   4);
		vb_lres_i_m :=  map(vb_lres_i = 0 => 0.2045521836,
							vb_lres_i = 1 => 0.0328077623,
							vb_lres_i = 2 => 0.0111337572,
							vb_lres_i = 3 => 0.007329129,
											 0.004870652);

		v_add_apt_f := (StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A');
		v_add_mil_f := (rc_ziptypeflag = 3);

		v_addval_b1 := map((rc_hriskaddrflag != 4) and  v_add_mil_f => '1 LR-NONAPT-MIL',
						   (rc_hriskaddrflag != 4) and ~v_add_mil_f => '2 LR-NONAPT',
																	   '3 HR-NONAPT');
		v_addval_c2_b2 := if(rc_hriskaddrflag != 4, '4 LR-APT', '5 HR-APT');
		v_addval := map((rc_addrvalflag = 'V') and ~v_add_apt_f => v_addval_b1,
						(rc_addrvalflag = 'V') and  v_add_apt_f => v_addval_c2_b2,
																		'6 INVALID');

		vi_addval_m :=  map(v_addval = '1 LR-NONAPT-MIL' => 0,
							v_addval = '2 LR-NONAPT'     => 0.0057770801,
							v_addval = '3 HR-NONAPT'     => 0.066518847,
							v_addval = '4 LR-APT'        => 0.0132167688,
							v_addval = '5 HR-APT'        => 0.0670103093,
															0.0744047619);

		v_phn_notpots :=  if(trim(trim(telcordia_type, LEFT), LEFT, RIGHT) in ['00', '50', '51', '52', '54'], 0, 1);

		v_phn_probx2 :=  map((v_phn_notpots = 0) and (rc_phonezipflag != '1') => 'POTS-ZIPMATCH',
							 (v_phn_notpots = 0) and (rc_phonezipflag  = '1') => 'POTS-ZIPNOMATCH',
							 (v_phn_notpots = 1) and (rc_phonezipflag != '1') => 'NOTPOTS-ZIPMATCH',
							 (v_phn_notpots = 1) and (rc_phonezipflag  = '1') => 'NOTPOTS-ZIPNOMATCH',
																			   'WRONG');

		vs_phn_probx2_m :=  map(v_phn_probx2 = 'NOTPOTS-ZIPMATCH'   => 0.1515231989,
								v_phn_probx2 = 'NOTPOTS-ZIPNOMATCH' => 0.125,
								v_phn_probx2 = 'POTS-ZIPMATCH'      => 0.1011457214,
																	   0.3178668906);

		v_s_phn_notpots :=  if(trim(trim(telcordia_type_s, LEFT), LEFT, RIGHT) in ['00', '50', '51', '52', '54'], 0, 1);

		v_s_phn_probx2 :=  map((v_s_phn_notpots = 0) and (rc_phonezipflag_s != '1') => 'POTS-ZIPMATCH',
							   (v_s_phn_notpots = 0) and (rc_phonezipflag_s  = '1') => 'POTS-ZIPNOMATCH',
							   (v_s_phn_notpots = 1) and (rc_phonezipflag_s != '1') => 'NOTPOTS-ZIPMATCH',
							   (v_s_phn_notpots = 1) and (rc_phonezipflag_s  = '1') => 'NOTPOTS-ZIPNOMATCH',
																					 'WRONG');

		v_s_phn_probx2_m :=  map(v_s_phn_probx2 = 'NOTPOTS-ZIPMATCH'   => 0.1608414886,
								 v_s_phn_probx2 = 'NOTPOTS-ZIPNOMATCH' => 0.1904761905,
								 v_s_phn_probx2 = 'POTS-ZIPMATCH'      => 0.092175338,
																		  0.1780243519);

		v_phn_probx2_m :=  map(v_phn_probx2 = 'NOTPOTS-ZIPMATCH'   => 0.0555999106,
							   v_phn_probx2 = 'NOTPOTS-ZIPNOMATCH' => 0.043956044,
							   v_phn_probx2 = 'POTS-ZIPMATCH'      => 0.0208938479,
																	  0.1574490149);

		vi_phn_probx2_m :=  map(v_phn_probx2 = 'NOTPOTS-ZIPMATCH'   => 0.0108418184,
								v_phn_probx2 = 'NOTPOTS-ZIPNOMATCH' => 0.0175438596,
								v_phn_probx2 = 'POTS-ZIPMATCH'      => 0.0047048163,
																	   0.0302457467);

		v_ip_topDomain := StringLib.StringToUpperCase(trim(trim(ip_topleveldomain, LEFT), LEFT, RIGHT));
		v_in_AcqChannel := trim(trim(cus_acq_channe, LEFT), LEFT, RIGHT);
		v_ip_continent := trim(ip_continent, LEFT, RIGHT);
		v_ip_countrycode := StringLib.StringToUpperCase(trim(ip_countrycode, LEFT, RIGHT));
		v_ip_state := StringLib.StringToUpperCase(trim(ip_state, LEFT, RIGHT));
		vs_ip_domain_GovMil := (v_ip_topdomain in ['GOV', 'MIL']);
		vs_ip_domain_govmil_m :=  map(~vs_ip_domain_govmil => 0.1390298134,
																 0.0294840295);

		vs_IPMatchCode := map( 
			v_in_AcqChannel = '02' AND in_state=in_state_s     => 's11-telstatematch',
			v_in_AcqChannel = '02'                             => 's12-telstatediff',
			v_in_AcqChannel = '03' and in_state=in_state_s     => 's21-kioskstatematch',
			v_in_AcqChannel = '03'                             => 's22-kioskstatediff',
			v_IP_continent in ['1','7']                        => 's32-badIP',
			v_IP_countrycode not in ['US']                     => if( 1=contains_i(v_ip_topDomain,'.'), 's31.5-foreignIP-DOT', 's31-foreignIP' ),
			v_ip_state = 'AOL' and v_IP_countrycode = 'US'     => 's40-AOL',
			in_state = in_state_s and v_ip_state = in_state    => 's51-ipmatch',
			in_state = in_state_s and v_IP_countrycode = 'US'  => 's52-usIP',
			in_state = in_state_s and v_ip_state = in_state    => 's51-ipmatch',
                                                             
			in_state != in_state_s and v_ip_state = in_state   => 's61-ipbtstate',
			in_state != in_state_s and v_ip_state = in_state_s => 's62-ipststate',
			in_state != in_state_s and v_IP_countrycode='US'   => 's63-usIP',
			in_state != in_state_s                             => 'uncaught condition', // !
			's70-other'                                           // this one shouldn't ever be hit
		);


		vs_IPMatchCode_m := case( vs_IPMatchCode,
			's11-telstatematch'    => 0.2608974359,
			's12-telstatediff'     => 0.3433441558,
			's21-kioskstatematch'  => 0.0276338515,
			's22-kioskstatediff'   => 0.0085106383,
			's31-foreignIP'        => 0.2986010613,
			's31.5-foreignIP-DOT'  => 0.4914285714,
			's32-badIP'            => 0.7726638773,
			's40-AOL'              => 0.1463790447,
			's51-ipmatch'          => 0.090207463,
			's52-usIP'             => 0.0856675155,
			's61-ipbtstate'        => 0.0715864193,
			's62-ipststate'        => 0.3301587302,
			's63-usIP'             => 0.2650227932,
			-999999
		);


		vb_ipmatchcode :=  map(v_in_acqchannel = '02'                             => 'b1-tel',
							   v_in_acqchannel = '03'                             => 'b2-kio',
							   (v_ip_state = 'AOL') and (v_ip_countrycode = 'US') => 'b3-aol',
							   v_ip_state = in_state                              => 'b4-sta',
							   v_ip_countrycode = 'US'                            => 'b5-us',
							   v_ip_countrycode = 'CA'                            => 'b6-can',
							   v_ip_continent in ['1', '7']                       => 'b8-bad',
							   contains_i(v_ip_topdomain, '.') = 0                => 'b7-oth',
																					 'b7.5-D');

		vb_ipmatchcode_m :=  map(vb_ipmatchcode = 'b1-tel' => 0.1033548656,
								 vb_ipmatchcode = 'b2-kio' => 0.0021224985,
								 vb_ipmatchcode = 'b3-aol' => 0.0152560843,
								 vb_ipmatchcode = 'b4-sta' => 0.0213282516,
								 vb_ipmatchcode = 'b5-us'  => 0.0283758029,
								 vb_ipmatchcode = 'b6-can' => 0.1957295374,
								 vb_ipmatchcode = 'b7-oth' => 0.2580167736,
								 vb_ipmatchcode = 'b7.5-D' => 0.4712460064,
															  0.7688787185);


		vb_ip_domain_b1 := map(v_ip_topdomain in ['COM', 'NET', 'EDU', 'MIL', 'ORG'] => 'commondomain',
							   v_ip_topdomain = 'GOV'                                => 'govdomain',
																						'uncommondomain');
                                                                               
		vb_ip_domain := map(v_in_acqchannel = '01' => vb_ip_domain_b1,
							v_in_acqchannel = '02' => 'telorder',
													  'kioskorder');

		vb_ip_domain_m :=  map(vb_ip_domain = 'commondomain' => 0.0280196895,
							   vb_ip_domain = 'govdomain'    => 0.0190217391,
							   vb_ip_domain = 'kioskorder'   => 0.0021224985,
							   vb_ip_domain = 'telorder'     => 0.1033548656,
																0.1537728493);

		vb_ip_connection_i_b1 := if(StringLib.StringToUpperCase(trim(trim(ip_connection, LEFT), LEFT, RIGHT)) in ['SATELLITE', 'WIRELESS'], 1, 2);
		vb_ip_connection_i := map(v_in_acqchannel = '01' => vb_ip_connection_i_b1,
								  v_in_acqchannel = '02' => 0,
															3);
		vb_ip_connection_i_m :=  map(vb_ip_connection_i = 0 => 0.1033548656,
									 vb_ip_connection_i = 1 => 0.0404656319,
									 vb_ip_connection_i = 2 => 0.0357832047,
															   0.0021224985);

		uc_ip_connection := StringLib.StringToUpperCase(trim(trim(ip_connection, LEFT), LEFT, RIGHT));
		vi_ip_connection_i_b1 := map(uc_ip_connection in ['SATELLITE', 'WIRELESS']      => 1,
									 uc_ip_connection in ['DIALUP']                     => 2,
									 uc_ip_connection in ['BROADBAND', 'CABLE', 'XDSL'] => 3,
									 uc_ip_connection in ['T1', 'T3']                   => 4,
																						   1);


		vi_ip_connection_i := map(trim(v_in_acqchannel, LEFT, RIGHT) = '01' => vi_ip_connection_i_b1,
								  trim(v_in_acqchannel, LEFT, RIGHT) = '02' => 0,
																			   5);

		vi_ip_connection_i_2 :=  map(vi_ip_connection_i in [0, 5] => 0,
									 vi_ip_connection_i = 1       => 1,
																	 2);

		vi_ip_connection_i_m :=  map(vi_ip_connection_i_2 = 0 => 0.0235485181,
									 vi_ip_connection_i_2 = 1 => 0.0153846154,
																 0.0072547691);

		vi_ipmatchcode :=  map(v_in_acqchannel = '02'              => 'b1-tel',
							   v_in_acqchannel = '03'              => 'b2-kio',
							   v_ip_countrycode = 'CA'             => 'b6-can',
							   contains_i(v_ip_topdomain, '.') > 0 => 'b7.5-D',
							   v_ip_continent in ['1', '7']        => 'b8-bad',
							   v_ip_countrycode != 'US'            => 'b7-oth',
							   v_ip_state = 'AOL'                  => 'b3-aol',
							   v_ip_state = in_state               => 'b4-sta',
																	  'b5-sta');

		vi_ipmatchcode_m :=  map(vi_ipmatchcode = 'b1-tel' => 0.0300710771,
								 vi_ipmatchcode = 'b2-kio' => 0.0047318612,
								 vi_ipmatchcode = 'b3-aol' => 0.0038809832,
								 vi_ipmatchcode = 'b4-sta' => 0.0052460719,
								 vi_ipmatchcode = 'b5-sta' => 0.0116879587,
								 vi_ipmatchcode = 'b6-can' => 0.1196581197,
								 vi_ipmatchcode = 'b7-oth' => 0.080952381,
								 vi_ipmatchcode = 'b7.5-D' => 0.2678571429,
															  0.5662650602);

		vs_s_c_lowed :=  map(c_low_ed_s='' => 0,
							(real)c_low_ed_s = -1     => 50,
							(real)c_low_ed_s = 100    => 60,
							(if ((((real)c_low_ed_s / 10) - truncate(((real)c_low_ed_s / 10))) < 0.000000000001, truncate(((real)c_low_ed_s / 10)), truncate(((real)c_low_ed_s / 10) + 1)) * 10));

		vs_s_c_lowed_i :=  map(vs_s_c_lowed <= 20 => 1,
							   vs_s_c_lowed <= 30 => 2,
							   vs_s_c_lowed <= 40 => 3,
							   vs_s_c_lowed <= 50 => 4,
							   vs_s_c_lowed <= 60 => 5,
							   vs_s_c_lowed <= 70 => 6,
							   vs_s_c_lowed <= 90 => 7,
													 8);

		vs_s_c_lowed_i_m :=  map(vs_s_c_lowed_i = 1 => 0.088928678,
								 vs_s_c_lowed_i = 2 => 0.1042258685,
								 vs_s_c_lowed_i = 3 => 0.1140403096,
								 vs_s_c_lowed_i = 4 => 0.1279670667,
								 vs_s_c_lowed_i = 5 => 0.1702793055,
								 vs_s_c_lowed_i = 6 => 0.2306818182,
								 vs_s_c_lowed_i = 7 => 0.3684627575,
													   0.4017857143);

		vs_s_c_robbery :=  map(c_robbery_s='' => 0,
							   (integer)c_robbery_s <= 20    => 1,
							   (integer)c_robbery_s <= 120   => 2,
							   (integer)c_robbery_s <= 140   => 3,
							   (integer)c_robbery_s <= 160   => 4,
													   5);

		vs_s_c_robbery_m :=  map(vs_s_c_robbery = 1 => 0.0650595809,
								 vs_s_c_robbery = 2 => 0.0924513782,
								 vs_s_c_robbery = 3 => 0.1349462366,
								 vs_s_c_robbery = 4 => 0.1712976225,
								 vs_s_c_robbery = 5 => 0.2495301733,
													   0.13765);

		vs_c_span_lang :=  map((integer)c_span_lang <= 100 => 1,
							   (integer)c_span_lang <= 120 => 2,
							   (integer)c_span_lang <= 140 => 3,
							   (integer)c_span_lang <= 160 => 4,
							   (integer)c_span_lang <= 180 => 5,
													 6);

		vs_c_span_lang_m :=  map(vs_c_span_lang = 1 => 0.1072273417,
								 vs_c_span_lang = 2 => 0.1186289501,
								 vs_c_span_lang = 3 => 0.135144884,
								 vs_c_span_lang = 4 => 0.1488899614,
								 vs_c_span_lang = 5 => 0.1655782905,
													   0.286569547);

		vs_s_c_span_lang :=  map(c_span_lang_s='' => 1,
								 (integer)c_span_lang_s <= 125   => 1,
								 (integer)c_span_lang_s <= 140   => 2,
								 (integer)c_span_lang_s <= 160   => 3,
								 (integer)c_span_lang_s <= 180   => 4,
														   5);

		vs_s_c_span_lang_m :=  map(vs_s_c_span_lang = 1 => 0.0908675308,
								   vs_s_c_span_lang = 2 => 0.1170343137,
								   vs_s_c_span_lang = 3 => 0.1366764995,
								   vs_s_c_span_lang = 4 => 0.2028676888,
														   0.3836445367);

		vs_s_c_fammar_p :=  map(c_fammar_p_s='' => 95,
								(real)c_fammar_p_s = -1     => 65,
								(real)c_fammar_p_s = 100    => 75,
								(real)c_fammar_p_s);

		vb_c_fammar_p2 :=  if(((real)c_fammar_p < 0) or (c_fammar_p=''), 25, min(85, max(20, (if (round(((real)c_fammar_p / 10)) >= ((real)c_fammar_p / 10) AND (round(((real)c_fammar_p / 10)) - ((real)c_fammar_p / 10)) < 0.000000000001, round(((real)c_fammar_p / 10)), truncate(((real)c_fammar_p / 10))) * 10))));

		vb_c_fammar_p2_m :=  map(vb_c_fammar_p2 = 20 => 0.3510565781,
								 vb_c_fammar_p2 = 25 => 0.2383900929,
								 vb_c_fammar_p2 = 30 => 0.1121673004,
								 vb_c_fammar_p2 = 40 => 0.0992342055,
								 vb_c_fammar_p2 = 50 => 0.0638243226,
								 vb_c_fammar_p2 = 60 => 0.0459271615,
								 vb_c_fammar_p2 = 70 => 0.0396011796,
								 vb_c_fammar_p2 = 80 => 0.0268999176,
														0.0200884877);

		vb_c_robbery :=  if(c_robbery='', -1, (if ((((real)c_robbery / 20) - truncate(((real)c_robbery / 20))) < 0.000000000001, truncate(((real)c_robbery / 20)), truncate(((real)c_robbery / 20) + 1)) * 20));

		vb_c_robbery2 :=  map(vb_c_robbery <= 20  => vb_c_robbery,
							  vb_c_robbery <= 120 => 120,
							  vb_c_robbery <= 160 => vb_c_robbery,
													 180);

		vb_c_robbery2_m :=  map(vb_c_robbery2 = 20  => 0.0160097239,
								vb_c_robbery2 = 120 => 0.0176691804,
								vb_c_robbery2 = 140 => 0.0304032293,
								vb_c_robbery2 = 160 => 0.0463481541,
								vb_c_robbery2 = 180 => 0.1177171285,
													   0.03582);

		vi_c_med_hhinc :=  map(c_med_hhinc='' or ((integer)c_med_hhinc <= 37000) => 37000,
							   (integer)c_med_hhinc <= 56000   => 56000,
							   (integer)c_med_hhinc <= 60000   => 60000,
							   (integer)c_med_hhinc <= 90000   => 90000,
																  90001);

		vi_c_med_hhinc_m :=  map(vi_c_med_hhinc = 37000 => 0.0169641867,
								 vi_c_med_hhinc = 56000 => 0.0087848329,
								 vi_c_med_hhinc = 60000 => 0.0075679395,
								 vi_c_med_hhinc = 90000 => 0.0060848018,
														   0.0056403283);

		vi_c_robbery :=  map(c_robbery='' => -1,
							 (real)c_robbery = 0      => 0,
							 (if ((((real)c_robbery / 10) - truncate(((real)c_robbery / 10))) < 0.000000000001, truncate(((real)c_robbery / 10)), truncate(((real)c_robbery / 10) + 1)) * 10));

		vi_c_robbery2 :=  map(vi_c_robbery <= 0   => 0,
							  vi_c_robbery <= 10  => 2,
							  vi_c_robbery <= 140 => 1,
													 0);

		vi_c_robbery2_m :=  map(vi_c_robbery2 = 0 => 0.0121854305,
								vi_c_robbery2 = 1 => 0.0062386442,
													 0.0050975823);

		wealth_index_s_5 := min((integer)wealth_index_s, 5);

		wealth_index_s_5_m :=  map(wealth_index_s_5 = 1 => 0.2051580699,
								   wealth_index_s_5 = 2 => 0.1781077891,
								   wealth_index_s_5 = 3 => 0.1554970301,
								   wealth_index_s_5 = 4 => 0.1204931139,
														   0.0663885684);

		sources_upcase := StringLib.StringToUpperCase(rc_sources);
		sources_s_upcase := StringLib.StringToUpperCase(rc_sources_s);
		_source_tot_AM   := contains_i(sources_upcase, 'AM');
		_source_tot_AR   := contains_i(sources_upcase, 'AR');
		_source_tot_CG   := contains_i(sources_upcase, 'CG');
		_source_tot_D    := contains_i(sources_upcase, 'D ');
		_source_tot_EB   := contains_i(sources_upcase, 'EB');
		_source_tot_EM   := contains_i(sources_upcase, 'EM');
		_source_tot_VO   := contains_i(sources_upcase, 'VO');
		_source_tot_EM_VO := if(_source_tot_EM=1 or _source_tot_VO=1, 1, 0);// check for either vo or em as they are seperate now
		_source_tot_EQ   := contains_i(sources_upcase, 'EQ');
		_source_tot_MW   := contains_i(sources_upcase, 'MW');
		_source_tot_P    := contains_i(sources_upcase, 'P ');
		_source_tot_PL   := contains_i(sources_upcase, 'PL');
		_source_tot_TU   := contains_i(sources_upcase, 'TU');
		_source_tot_V    := contains_i(sources_upcase, 'V ');
		_source_tot_W    := contains_i(sources_upcase, 'W ');
		_source_tot_WP   := contains_i(sources_upcase, 'WP');
		_s_source_tot_AM := contains_i(sources_s_upcase, 'AM');
		_s_source_tot_AR := contains_i(sources_s_upcase, 'AR');
		_s_source_tot_CG := contains_i(sources_s_upcase, 'CG');
		_s_source_tot_D  := contains_i(sources_s_upcase, 'D ');
		_s_source_tot_EB := contains_i(sources_s_upcase, 'EB');
		_s_source_tot_EM := contains_i(sources_s_upcase, 'EM');
		_s_source_tot_VO := contains_i(sources_s_upcase, 'VO');
		_s_source_tot_EM_VO := if(_s_source_tot_EM=1 or _s_source_tot_VO=1, 1, 0);// check for either vo or em as they are seperate now
		_s_source_tot_EQ := contains_i(sources_s_upcase, 'EQ');
		_s_source_tot_MW := contains_i(sources_s_upcase, 'MW');
		_s_source_tot_P  := contains_i(sources_s_upcase, 'P ');
		_s_source_tot_PL := contains_i(sources_s_upcase, 'PL');
		_s_source_tot_TU := contains_i(sources_s_upcase, 'TU');
		_s_source_tot_V  := contains_i(sources_s_upcase, 'V ');
		_s_source_tot_W  := contains_i(sources_s_upcase, 'W ');
		_s_source_tot_WP := contains_i(sources_s_upcase, 'WP');

		_pos_source_tot := sum(_source_tot_am, _source_tot_ar, _source_tot_cg, _source_tot_d, _source_tot_eb, _source_tot_em_vo, _source_tot_eq, _source_tot_mw, _source_tot_p, _source_tot_pl, _source_tot_tu, _source_tot_v, _source_tot_w, _source_tot_wp);

		_s_pos_source_tot := sum(_s_source_tot_am, _s_source_tot_ar, _s_source_tot_cg, _s_source_tot_d, _s_source_tot_eb, _s_source_tot_em_vo, _s_source_tot_eq, _s_source_tot_mw, _s_source_tot_p, _s_source_tot_pl, _s_source_tot_tu, _s_source_tot_v, _s_source_tot_w, _s_source_tot_wp);

		num_pos_sources_tot_5 := min(_pos_source_tot, 5);

		num_pos_sources_tot_s_5 := min(_s_pos_source_tot, 5);

		vs_pos_sources_combo :=  map((num_pos_sources_tot_5 = 0) and (num_pos_sources_tot_s_5 = 0) => 1,
									 num_pos_sources_tot_5 = 0                                     => 3,
									 num_pos_sources_tot_s_5 = 0                                   => 5,
									 (num_pos_sources_tot_5 > 4) and (num_pos_sources_tot_s_5 > 4) => 9,
																									  7);

		pos_sources_combo_m :=  map(vs_pos_sources_combo = 1 => 0.4599406528,
									vs_pos_sources_combo = 3 => 0.3359407163,
									vs_pos_sources_combo = 5 => 0.1843058785,
									vs_pos_sources_combo = 7 => 0.0936519885,
																0.0493571584);


		vs_s_adls_per_addr := if( rc_dwelltype_s != 'A',
			map(
			   adls_per_addr_s > 25   => 9,
			   adls_per_addr_s > 15   => 7,
			   adls_per_addr_s > 10   => 3,
			   adls_per_addr_s >  0   => 1,
			   //adls_per_addr_s = 0  => 5,
			   5
			),
			map(
			   adls_per_addr_s = 0 => 5,
			   adls_per_addr_s = 1 => 1,
			   10< adls_per_addr_s AND adls_per_addr_s < 26 => 7,
			   3
			)
		);
		vs_s_adls_per_addr_m :=  map(vs_s_adls_per_addr = 1 => 0.083908936,
									 vs_s_adls_per_addr = 3 => 0.1541532028,
									 vs_s_adls_per_addr = 5 => 0.1931347252,
									 vs_s_adls_per_addr = 7 => 0.2184181328,
															   0.2610890732);

		vs_ssns_per_adl_combo :=  map((ssns_per_adl > 0) and (ssns_per_adl_s > 0) => 4,
									  ssns_per_adl > 0                            => 3,
									  ssns_per_adl_s > 0                          => 2,
																					 1);

		vs_ssns_per_adl_combo_m :=  map(vs_ssns_per_adl_combo = 1 => 0.4176802136,
										vs_ssns_per_adl_combo = 2 => 0.3031468531,
										vs_ssns_per_adl_combo = 3 => 0.1706885792,
																	 0.0853157908);

		adls_per_addr_c6_8 := min(adls_per_addr_c6, 8);
		vb_adls_per_addr_c6_8_m :=  map(adls_per_addr_c6_8 = 0 => 0.0298569548,
										adls_per_addr_c6_8 = 1 => 0.0432734993,
										adls_per_addr_c6_8 = 2 => 0.0627525553,
										adls_per_addr_c6_8 = 3 => 0.1356886841,
										adls_per_addr_c6_8 = 4 => 0.183074266,
										adls_per_addr_c6_8 = 5 => 0.2628865979,
										adls_per_addr_c6_8 = 6 => 0.3152173913,
										adls_per_addr_c6_8 = 7 => 0.3970588235,
																  0.4945054945);

		vi_adls_per_addr_c6_4 := min(adls_per_addr_c6, 4);
		vi_adls_per_addr_c6_4_m :=  map(vi_adls_per_addr_c6_4 = 0 => 0.0070625466,
										vi_adls_per_addr_c6_4 = 1 => 0.0095763675,
										vi_adls_per_addr_c6_4 = 2 => 0.0119804401,
										vi_adls_per_addr_c6_4 = 3 => 0.0130576714,
																	 0.0405727924);

		vi_wealth_index_5 := min((integer)wealth_index, 5);
		vi_wealth_index_5_m :=  map(vi_wealth_index_5 = 1 => 0.0193485972,
									vi_wealth_index_5 = 2 => 0.0120161633,
									vi_wealth_index_5 = 3 => 0.0092234454,
									vi_wealth_index_5 = 4 => 0.0084045483,
															 0.0037579495);

		vs_IST_firstScorelt100 := (integer)((integer)ist_firstscore < 100);

		bb_shipto := -18.93005144 +
			(vs_s_lres_i_m * 2.652186124) +
			(vs_phn_probx2_m * 3.7224383407) +
			(v_s_phn_probx2_m * 5.9814386322) +
			(vs_s_c_lowed_i_m * 3.0874011951) +
			(vs_s_c_robbery_m * 1.0600897469) +
			(vs_c_span_lang_m * 1.1031986497) +
			(vs_s_c_span_lang_m * 1.8202313881) +
			(vs_ist_firstscorelt100 * 0.834231035) +
			(vs_ip_domain_govmil_m * 17.759612819) +
			(vs_in_cid_match_m * 1.1586666311) +
			(vs_in_shipmode_m * 4.5776975286) +
			(v_in_avs_bad * 0.9540998675) +
			(vs_nap_prop_ver_m * 2.3805483886) +
			(vs_ipmatchcode_m * 3.7598677646) +
			(wealth_index_s_5_m * 1.27810059) +
			(pos_sources_combo_m * 1.3967701936) +
			(vs_s_adls_per_addr_m * 2.7681003012) +
			(vs_ssns_per_adl_combo_m * 1.2281917008) +
			(vs_verx_combo_m * 2.6542516474) +
			(vs_avs_x_m * 1.9062410688) +
			(vs_s_c_fammar_p * -0.011927717) +
			(vs_in_ordamt * 1.0697319882) +
			(real)vs_offset;

		bb_billto := -14.79458815 +
			(vb_ipmatchcode_m * 1.4192735537) +
			(vb_verx_m * 2.6160565247) +
			(vb_adls_per_addr_c6_8_m * 3.6160350897) +
			(vb_prop_tree_m * 1.107523149) +
			(vb_avsx_m * 0.9816151281) +
			(v_in_avs_bad * 2.4101873014) +
			(vb_in_shipmode_m * 9.4752765272) +
			(vb_ip_domain_m * 2.0209619287) +
			(vb_ip_connection_i_m * 5.7658304558) +
			(vb_lres_i_m * 4.9765466402) +
			(v_phn_probx2_m * 6.7339199136) +
			(vb_c_fammar_p2_m * 2.7425690687) +
			(vb_c_robbery2_m * 7.7249742937) +
			(vb_in_ordamt * 1.0717375785) +
			(real)vb_offset;

		bb_instore := -10.50272206 +
			(vi_in_cid_match_m * 28.430853308) +
			(vi_avsx_m * 3.0713579407) +
			(vi_ip_connection_i_m * 6.0205603944) +
			(vi_verx_m * 13.97729004) +
			(vi_phn_probx2_m * 42.296359452) +
			(vi_addval_m * 15.401445581) +
			(vi_c_med_hhinc_m * 20.38878659) +
			(vi_c_robbery2_m * 27.551540287) +
			(vi_in_ordamt * 0.0020134551) +
			(v_in_avs_bad * 2.023669107) +
			(vi_adls_per_addr_c6_4_m * 28.562451226) +
			(vi_ipmatchcode_m * 3.6081945273) +
			(vi_wealth_index_5_m * 32.29512419) +
			(real)vi_offset;

		
		bb_model := map(
			uv_dataset = 'shipto' => bb_shipto,
			uv_dataset = 'billto' => bb_billto,
			bb_instore
		);


		phat := (exp(bb_model) / (1 + exp(bb_model)));
		base := 660;
		point := -25;
		odds := 0.0059373;
		cdn806_1_0 := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));
		cdn806_1_0_2 := max(250, min(999,(cdn806_1_0 + 80)));

		self.seq := le.bill_to_out.seq;
		self.score := (string3)cdn806_1_0_2;
		self.ri := [];
		

		
	end;

	model := join(clam, ineasi, 
		left.bill_to_out.seq=(right.cd2i.seq*2), 
		doModel(left,right), left outer);

	// need to project billto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
		self.seq := le.Bill_To_Out.seq;
		self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
		self.nxx_type := le.Bill_To_Out.phone_verification.telcordia_type;
		self := le.Bill_To_Out.iid;
		self := le.Bill_To_Out.shell_input;
		self := le.bill_to_out;
	END;
	iidBT := project(clam, into_layout_output(left));

	RiskWise.Layout_IP2O fill_ip(clam le) := TRANSFORM
		self.countrycode := le.ip2o.countrycode[1..2];
		self := le.ip2o;
	END;
	ipInfo := PROJECT(clam, fill_ip(left));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, true, IBICID, WantstoSeeBillToShipToDifferenceFlag);
		self := [];
	END;
	BTReasons := join(iidBT, ipInfo, left.seq = right.seq, addBTReasons(left, right), left outer);

	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
		self.ri := rt.ri;
		self := le;
	END;
	BTrecord := JOIN(model, BTReasons, left.seq = right.seq, fillReasons(left,right), left outer);


	// need to project the shipto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output2(clam le) := TRANSFORM
		self.seq := le.Ship_To_Out.seq;
		self.socllowissue := (string)le.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.Ship_To_Out.iid.NAS_summary;
		self := le.Ship_To_Out.iid;
		self := le.Ship_To_Out.shell_input;
		self := le.ship_to_out;
	END;
	iidST := project(clam, into_layout_output2(left));


	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, false, IBICID, false);
		self := [];
	END;
	STReasons := join(iidST, ipInfo, left.seq=((right.seq*2)-1), addSTReasons(left, right), left outer);

	Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		self.ri := le.ri + rt.ri;
		self := le;
	END;
	STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(left,right), left outer);

	RETURN (STRecord);

END;
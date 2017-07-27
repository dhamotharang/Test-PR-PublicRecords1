import risk_indicators, easi, riskwise, ut;

export CDN908_1_0(
	grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
	dataset(RiskWise.Layout_CD2I) indata,
	boolean IBICID,
	boolean WantstoSeeBillToShipToDifferenceFlag
) := FUNCTION

	// build easi data
	layout_ineasi := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out;
		Easi.layout_census easi;
		Easi.layout_census easi2;
	END;

	layout_ineasi join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		self := le;
		self.easi := ri;
		self	:= [];
	END;				 
	results := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),RiskWise.max_atmost),keep(1));
				
	layout_ineasi joinEm(results le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi2 := ri;
		self := le;
	END;
	ineasi := join(results, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.ship_to_out.shell_input.st+left.ship_to_out.shell_input.county+left.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				 left outer,ATMOST(keyed(right.geolink=left.ship_to_out.shell_input.st+left.ship_to_out.shell_input.county+left.ship_to_out.shell_input.geo_blk),RiskWise.max_atmost),keep(1));
	//

#if(Risk_Indicators.iid_constants.validation_debug)
	layout_debug := record
		models.layout_modelout.seq;
		models.layout_modelout.score;
		string12 geolink;
		string12 geolink_s;
		Boolean trueDID;
		String in_state;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		String in_email_address;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_dwelltype;
		String rc_addrcommflag;
		String rc_phonetype;
		Boolean hphnpop;
		Boolean add1_isbestmatch;
		Integer add1_naprop;
		Boolean add2_isbestmatch;
		String telcordia_type;
		Integer adls_per_addr;
		Integer adls_per_addr_c6;
		Integer rel_count;
		Integer rel_criminal_count;
		Integer rel_prop_owned_count;
		Integer rel_within25miles_count;
		Integer rel_incomeunder25_count;
		Integer rel_incomeunder100_count;
		Integer rel_incomeover100_count;
		Integer rel_homeunder500_count;
		Integer rel_homeover500_count;
		Integer rel_educationover12_count;
		Integer inferred_dob;
		Integer archive_date;
		String C_FAMMAR_P;
		String c_assault;
		String c_burglary;
		String c_cartheft;
		String c_larceny;
		String c_robbery;
		String AVS_CODE;
		String channel;
		String CID_RESPONSE;
		Integer dist_addraddr2;
		String IP_topleveldomain;
		String IP_continent;
		String IP_countrycode;
		String IP_state;
		String IP_region;
		String IST_addrscore;
		String IST_efirstscore;
		String IST_elastscore;
		String IST_lastscore;
		String ORD_TOT;
		String PAY_TYPE;
		String SHP_MODE;
		Integer next_day;
		Integer second_day;
		Integer phn_cell;
		Boolean truedid_s;
		String in_state_s;
		String out_unit_desig_s;
		String out_sec_range_s;
		String out_addr_type_s;
		Integer nas_summary_s;
		Integer nap_summary_s;
		String rc_hriskphoneflag_s;
		String rc_hphonetypeflag_s;
		String rc_phonevalflag_s;
		String rc_hphonevalflag_s;
		String rc_phonezipflag_s;
		String rc_pwphonezipflag_s;
		String rc_dwelltype_s;
		String rc_phonetype_s;
		Boolean hphnpop_s;
		String telcordia_type_s;
		Integer adls_per_addr_s;
		Integer ssns_per_addr_c6_s;
		Integer inferred_dob_s;
		Integer archive_date_s;
		String C_FAMMAR_P_s;
		String C_LOW_ED_s;
		String C_ROBBERY_s;
		String C_SPAN_LANG_s;
		String cus_ORDAMT;
		String cus_pmttype;
		String cus_avs;
		String cus_CID;
		String cus_ACQ_CHANNE;
		String cus_SHIPMODE;
		String new_ship;
		String cus_shipmode_2;
		Real shipto_population_rate;
		Real shipto_sample_rate;
		Real shipto_offset;
		Real instore_population_rate;
		Real instore_sample_rate;
		Real instore_offset;
		Real billto_population_rate;
		Real billto_sample_rate;
		Real billto_offset;
		String v_in_avs_x;
		String v_in_pmt;
		String v_in_avs;
		Integer amex_lst;
		Integer amex_add;
		Integer amex_zip;
		Integer amex_lst_b1;
		Integer amex_add_b1;
		Integer amex_zip_b1;
		Integer amex_add_2;
		Integer amex_zip_2;
		Integer amex_lst_2;
		Integer amex_sum;
		String in_avs_x;
		String v_in_avs_2;
		Integer vs_avs_x2;
		Real vs_avs_x2_m;
		Boolean vs_in_avs_bad;
		Integer vb_avsx2;
		Real vb_avsx2_m;
		Boolean vb_in_avs_bad;
		Integer vi_avsx2;
		Real vi_avsx2_m;
		Boolean v_in_avs_bad;
		Real v_in_avs_bad_m;
		String v_in_cid;
		Integer v_in_cid_match;
		Real vs_in_cid_match_m;
		Real vb_in_cid_match_m;
		Real v_in_cid_match_m;
		String v_in_shipmode;
		Real vs_in_shipmode_m;
		Real vb_in_shipmode_m;
		Real vs_in_ordAmt;
		Real vb_in_ordamt;
		Real vi_in_ordAmt;
		Integer vs_nap;
		Integer vs_nas;
		Integer vs_verx2;
		Real vs_verx2_m;
		Integer vs_s_nap;
		Integer vs_s_nas;
		Integer vs_s_verx2;
		Real vs_s_verx2_m;
		Integer vb_verx2;
		Real vb_verx2_m;
		Integer vi_verx2;
		Real vi_verx2_m;
		Boolean phn_inval;
		Boolean phn_nonUs;
		Boolean phn_notpots;
		Boolean phn_zipmismatch;
		Boolean phn_residential;
		Boolean phn_highrisk;
		Boolean s_phn_inval;
		Boolean s_phn_nonUs;
		Boolean s_phn_notpots;
		Boolean s_phn_cell;
		Boolean s_phn_zipmismatch;
		Boolean s_phn_residential;
		Integer v_phn_prob;
		Integer v_s_phn_prob;
		Integer vs_phn_prob_combo_b1;
		Integer vs_phn_prob_combo;
		Real vs_phn_prob_combo_m;
		Integer v_phn_prob_2;
		Real vb_phn_prob_m;
		Integer vi_phn_prob;
		Real vi_phn_prob_m;
		Integer best_match_lvl;
		Integer vb_proptree;
		Real vb_proptree_m;
		Integer scoring_date;
		Integer scoring_date_s;
		Integer inferred_date;
		Integer inferred_date_s;
		Integer inferred_age_b2;
		Integer inferred_age;
		Integer inferred_age_s_b2;
		Integer inferred_age_s;
		Integer inferred_age_rnd;
		Integer inferred_age_rnd_s;
		Integer vs_combo_age_b1;
		Integer vs_combo_age_b2;
		Integer vs_combo_age;
		Real vs_combo_age_m;
		Boolean add_apt;
		Boolean add_apt_s;
		Integer ssns_per_addr_c6_5_s;
		Real vs_s_ssns_per_addr_c6_b2;
		Real vs_s_ssns_per_addr_c6;
		Real vs_s_ssns_per_addr_c6_m;
		Integer vs_s_adls_per_addr_b1;
		Integer vs_s_adls_per_addr_b2;
		Integer vs_s_adls_per_addr;


		Real vs_s_adls_per_addr_m;
		Integer adls_per_addr_c6_5;
		Real vb_adls_per_addr_c6_5_m;
		Integer vb_adls_per_addr_b1;
		Integer vb_adls_per_addr_b2;
		Integer vb_adls_per_addr;
		Real vb_adls_per_addr_m;
		String v_ip_topDomain;
		String v_in_AcqChannel;
		String v_ip_continent;
		String v_ip_countrycode;
		String v_ip_state;
		String vs_ipmatchcode_b1;
		String vs_ipmatchcode_b2;
		String vs_ipmatchcode_b6;
		String vs_ipmatchcode_b7;
		String vs_ipmatchcode;
		String vs_ipmatchcode_2;
		Real vs_ipmatchcode_m;
		Boolean vs_ip_domain_GovMil;
		String vb_ipmatchcode;
		Real vb_ipmatchcode_m;
		String vb_ip_domain_b1;
		String vb_ip_domain;
		Real vb_ip_domain_m;
		String email_provider;
		String email_provider2;
		Integer ist_bill_escore;
		Integer vs_email_score;
		Real vs_email_score_m;
		Integer ist_bill_escore_2;
		Integer vb_email_escore;
		Real vb_email_escore_m;
		Integer vs_s_c_lowed;
		Integer vs_s_c_lowed_i;
		Real vs_s_c_lowed_i_m;
		Integer vs_s_c_robbery;
		Real vs_s_c_robbery_m;
		Integer vs_s_c_span_lang;
		Real vs_s_c_span_lang_m;
		Real vs_s_c_fammar_p;
		Boolean hi_robbery;
		Boolean hi_assault;
		Boolean hi_burglary;
		Boolean hi_larceny;
		Boolean hi_cartheft;
		Integer vb_c_hi_crime;
		Real vb_c_hi_crime_m;
		Integer vb_c_fammar_p;
		Real vb_C_FAMMAR_P_lg;
		Real rel_incomeunder25_count_pct;
		Real rel_incomeover75_pct;
		Real rel_educationover12_pct;
		Real rel_homeover300_pct;
		Real rel_prop_owned_count_pct;
		Boolean rich_rel;
		Boolean rel_nice_house;
		Boolean no_rel_crims;
		Boolean close_rels;
		Boolean rel_prop;
		Boolean poor_rels;
		Boolean smart_rels;
		Boolean no_rels;
		Integer vi_rels;
		Real vi_rels_m;
		Boolean vs_lname_match;
		Real vs_Dist_addraddr2;
		Real vs_Dist_addraddr2_lg;
		Boolean uv_billto;
		Boolean uv_instore;
		String uv_dataset;
		Integer Base;
		Integer point;
		Real odds;
		Real shipto_log;
		Real s_phat;
		Integer Shipto_Score_a;
		Integer shipto_score;
		Real billto_log;
		Real b_phat;
		Integer Billto_Score_a;
		Integer billto_score;
		Real instore_log;
		Real i_phat;
		Integer Instore_Score_a;
		Integer instore_score;
		Integer CDN908_1_0;
	end;
	layout_debug doModel( ineasi le, indata ri ) := TRANSFORM
#else
	Layout_ModelOut doModel( ineasi le, indata ri ) := TRANSFORM
#end


		truedid                          := le.bill_to_out.truedid;
		in_state                         := le.bill_to_out.shell_input.in_state;
		out_unit_desig                   := le.bill_to_out.shell_input.unit_desig;
		out_sec_range                    := le.bill_to_out.shell_input.sec_range;
		out_addr_type                    := le.bill_to_out.shell_input.addr_type;
		in_email_address                 := le.bill_to_out.shell_input.email_address;
		nas_summary                      := le.bill_to_out.iid.nas_summary;
		nap_summary                      := le.bill_to_out.iid.nap_summary;
		rc_hriskphoneflag                := le.bill_to_out.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.bill_to_out.iid.hphonetypeflag;
		rc_phonevalflag                  := le.bill_to_out.iid.phonevalflag;
		rc_hphonevalflag                 := le.bill_to_out.iid.hphonevalflag;
		rc_phonezipflag                  := le.bill_to_out.iid.phonezipflag;
		rc_pwphonezipflag                := le.bill_to_out.iid.pwphonezipflag;
		rc_dwelltype                     := le.bill_to_out.iid.dwelltype;
		rc_addrcommflag                  := le.bill_to_out.iid.addrcommflag;
		rc_phonetype                     := le.bill_to_out.iid.phonetype;
		hphnpop                          := le.bill_to_out.input_validation.homephone;
		add1_isbestmatch                 := le.bill_to_out.address_verification.input_address_information.isbestmatch;
		add1_naprop                      := le.bill_to_out.address_verification.input_address_information.naprop;
		add2_isbestmatch                 := le.bill_to_out.address_verification.address_history_1.isbestmatch;
		telcordia_type                   := le.bill_to_out.phone_verification.telcordia_type;
		adls_per_addr                    := le.bill_to_out.velocity_counters.adls_per_addr;
		adls_per_addr_c6                 := le.bill_to_out.velocity_counters.adls_per_addr_created_6months;
		rel_count                        := le.bill_to_out.relatives.relative_count;
		rel_criminal_count               := le.bill_to_out.relatives.relative_criminal_count;
		rel_prop_owned_count             := le.bill_to_out.relatives.owned.relatives_property_count;
		rel_within25miles_count          := le.bill_to_out.relatives.relative_within25miles_count;
		rel_incomeunder25_count          := le.bill_to_out.relatives.relative_incomeunder25_count;
		rel_incomeunder100_count         := le.bill_to_out.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.bill_to_out.relatives.relative_incomeover100_count;
		rel_homeunder500_count           := le.bill_to_out.relatives.relative_homeunder500_count;
		rel_homeover500_count            := le.bill_to_out.relatives.relative_homeover500_count;
		rel_educationover12_count        := le.bill_to_out.relatives.relative_educationover12_count;
		inferred_dob                     := le.bill_to_out.reported_dob;
		archive_date                     := if(le.bill_to_out.historydate=999999, (unsigned)ut.getdate, le.bill_to_out.historydate);
		C_FAMMAR_P                       := le.easi.fammar_p;
		c_assault                        := le.easi.assault;
		c_burglary                       := le.easi.burglary;
		c_cartheft                       := le.easi.cartheft;
		c_larceny                        := le.easi.larceny;
		c_robbery                        := le.easi.robbery;
		AVS_CODE                         := ri.avscode;
		CHANNEL                          := ri.channel;
		CID_RESPONSE                     := ri.cidcode;
		dist_addraddr2                   := (INTEGER)le.eddo.distaddraddr2;


		IP_topleveldomain                := le.ip2o.topleveldomain;
		IP_continent                     := le.ip2o.continent;
		IP_countrycode                   := le.ip2o.countrycode;
		IP_state                         := le.ip2o.state;
		IP_region                        := le.ip2o.ipregion;



		IST_addrscore                    := le.eddo.addrscore;
		IST_efirstscore                  := le.eddo.efirstscore;
		IST_elastscore                   := le.eddo.elastscore;
		IST_lastscore                    := le.eddo.lastscore;
		ORD_TOT                          := trim(ri.orderamt);
		PAY_TYPE                         := ri.pymtmethod;
		SHP_MODE                         := ri.shipmode;

		// copied from CDN606_2_0
		next_day                         := if(trim(ri.shipmode) in ['','2'], 1, 0);
		second_day                       := if(trim(ri.shipmode) = '7', 1, 0);


		truedid_s                        := le.ship_to_out.truedid;
		in_state_s                       := le.ship_to_out.shell_input.in_state;
		out_unit_desig_s                 := le.ship_to_out.shell_input.unit_desig;
		out_sec_range_s                  := le.ship_to_out.shell_input.sec_range;
		out_addr_type_s                  := le.ship_to_out.shell_input.addr_type;
		nas_summary_s                    := le.ship_to_out.iid.nas_summary;
		nap_summary_s                    := le.ship_to_out.iid.nap_summary;
		rc_hriskphoneflag_s              := le.ship_to_out.iid.hriskphoneflag;
		rc_hphonetypeflag_s              := le.ship_to_out.iid.hphonetypeflag;
		rc_phonevalflag_s                := le.ship_to_out.iid.phonevalflag;
		rc_hphonevalflag_s               := le.ship_to_out.iid.hphonevalflag;
		rc_phonezipflag_s                := le.ship_to_out.iid.phonezipflag;
		rc_pwphonezipflag_s              := le.ship_to_out.iid.pwphonezipflag;
		rc_dwelltype_s                   := le.ship_to_out.iid.dwelltype;
		rc_phonetype_s                   := le.ship_to_out.iid.phonetype;
		hphnpop_s                        := le.ship_to_out.input_validation.homephone;
		telcordia_type_s                 := le.ship_to_out.phone_verification.telcordia_type;
		adls_per_addr_s                  := le.ship_to_out.velocity_counters.adls_per_addr;
		ssns_per_addr_c6_s               := le.ship_to_out.velocity_counters.ssns_per_addr_created_6months;
		inferred_dob_s                   := le.ship_to_out.reported_dob;
		archive_date_s                   := if(le.ship_to_out.historydate=999999, (unsigned)ut.getdate, le.ship_to_out.historydate);
		C_FAMMAR_P_s                     := le.easi2.fammar_p;
		C_LOW_ED_s                       := le.easi2.low_ed;
		C_ROBBERY_s                      := le.easi2.robbery;
		C_SPAN_LANG_s                    := le.easi2.span_lang;










	NULL := -999999999;


	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

	cus_ORDAMT := ord_tot;
	cus_pmttype := pay_type;
	cus_avs := avs_code;
	cus_CID := cid_response;
	cus_ACQ_CHANNE := channel;
	cus_SHIPMODE := shp_mode;
	new_ship :=  map((string)cus_SHIPMODE = ' ' => ' ',
									 (string)cus_SHIPMODE = 'R' => 'R',
									 (string)next_day = 'Y'     => '2',
									 (string)second_day = 'Y'   => '7',
									 (string)cus_SHIPMODE = 'G' => 'G',
																								 'X');
	cus_shipmode_2 := new_ship;
	shipto_population_rate := (8231 / 522311);
	shipto_sample_rate := (8231 / 33935);
	shipto_offset := ln((((1 - shipto_population_rate) * shipto_sample_rate) / (shipto_population_rate * (1 - shipto_sample_rate))));
	instore_population_rate := (375 / 1158602);
	instore_sample_rate := (375 / 58307);
	instore_offset := ln((((1 - instore_population_rate) * instore_sample_rate) / (instore_population_rate * (1 - instore_sample_rate))));
	billto_population_rate := (4238 / 1891639);
	billto_sample_rate := (4238 / 98609);
	billto_offset := ln((((1 - billto_population_rate) * billto_sample_rate) / (billto_population_rate * (1 - billto_sample_rate))));
	v_in_avs_x := StringLib.StringToUpperCase(trim(trim((string)cus_avs, LEFT), LEFT, RIGHT));
	v_in_pmt := StringLib.StringToUpperCase(trim(trim((string)cus_pmttype, LEFT), LEFT, RIGHT));
	v_in_avs := StringLib.StringToUpperCase(trim(trim((string)cus_avs, LEFT), LEFT, RIGHT));
	amex_lst := 0;
	amex_add := 0;
	amex_zip := 0;
	amex_lst_b1 := if(v_in_avs_x in ['V1', 'V2', 'V3', 'V4'], 1, amex_lst);
	amex_add_b1 := if(v_in_avs_x in ['V2', 'V3', 'V8', 'V9'], 1, amex_add);
	amex_zip_b1 := if(v_in_avs_x in ['V1', 'V2', 'V7', 'V8'], 1, amex_zip);
	amex_add_2 := if(v_in_avs_x in ['V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9'], amex_add_b1, NULL);
	amex_zip_2 := if(v_in_avs_x in ['V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9'], amex_zip_b1, NULL);
	amex_lst_2 := if(v_in_avs_x in ['V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9'], amex_lst_b1, NULL);
	amex_sum := if(max(amex_lst_2, amex_add_2, amex_zip_2) = NULL, NULL, sum(if(amex_lst_2 = NULL, 0, amex_lst_2), if(amex_add_2 = NULL, 0, amex_add_2), if(amex_zip_2 = NULL, 0, amex_zip_2)));

	in_avs_x :=  map((integer)amex_sum = 3    => 'AMEX-FULLVER',
									 (integer)amex_sum = 2    => 'AMEX-PARTIALVER',
									 amex_sum in [0, 1]       => 'AMEX-BADVER',
									 v_in_avs_x in ['M', 'V'] => 'INTERNATIONAL',
									 v_in_avs_x in ['B', 'G'] => 'CC-GIFT CARD',
									 v_in_avs_x = 'Y'         => 'ZIP_ADD',
									 v_in_avs_x = 'Z'         => 'ZIP_ONLY',
									 v_in_avs_x = ' '         => 'SYSTEM ERROR',
									 v_in_avs_x = 'N'         => 'NO MATCH',
									 v_in_avs_x = 'A'         => 'ADD_ONLY',
																							 'MISC');

	v_in_avs_2 :=  map(v_in_avs = '0'  => 'N',
										 v_in_avs = '1'  => 'Z',
										 v_in_avs = '2'  => 'Y',
										 v_in_avs = '3'  => 'A',
										 v_in_avs = '4'  => 'N',
										 v_in_avs = '7'  => 'Z',
										 v_in_avs = '8'  => 'Y',
										 v_in_avs = '9'  => 'A',
										 v_in_avs = 'V0' => 'N',
										 v_in_avs = 'V1' => 'Z',
										 v_in_avs = 'V2' => 'Y',
										 v_in_avs = 'V3' => 'A',
										 v_in_avs = 'V4' => 'N',
										 v_in_avs = 'V7' => 'Z',
										 v_in_avs = 'V8' => 'Y',
										 v_in_avs = 'V9' => 'A',
																				v_in_avs);

	vs_avs_x2 :=  map(v_in_pmt = 'P'                                                                                  => 13,
										v_in_pmt = 'G'                                                                                  => 15,
										(v_in_pmt = 'B') and (in_avs_x != 'NO MATCH')                                                   => 14,
										(v_in_pmt in ['M', 'V']) and (in_avs_x in ['ZIP_ADD', 'ZIP_ONLY', 'ADD_ONLY'])                  => 13,
										(in_avs_x = 'AMEX-FULLVER') or ((v_in_pmt = 'A') and (in_avs_x = 'ZIP_ADD'))                    => 12,
										((v_in_pmt = 'D') and (in_avs_x = 'ZIP_ADD')) or ((v_in_pmt = 'B') and (in_avs_x = 'NO MATCH')) => 11,
										in_avs_x in ['ADD_ONLY', 'AMEX-PARTIALVER', 'ZIP_ONLY']                                         => 10,
										in_avs_x in ['INTERNATIONAL', 'SYSTEM ERROR']                                                   => 7,
										v_in_pmt in ['M', 'V']                                                                          => 9,
										in_avs_x in ['CC-GIFT CARD', 'AMEX-BADVER', 'MISC', 'NO MATCH']                                 => 8,
																																																											 -1);

	vs_avs_x2_m :=  map(vs_avs_x2 = 7  => 0.8165137615,
											vs_avs_x2 = 8  => 0.7315634218,
											vs_avs_x2 = 9  => 0.5574468085,
											vs_avs_x2 = 10 => 0.4557522124,
											vs_avs_x2 = 11 => 0.3324968632,
											vs_avs_x2 = 12 => 0.2569181474,
											vs_avs_x2 = 13 => 0.2112805278,
											vs_avs_x2 = 14 => 0.1299542683,
																				0.0063291139);

	vs_in_avs_bad := (v_in_avs_2 in ['N', 'M', 'V', '6', 'D', 'U']);

	vb_avsx2 :=  map(v_in_pmt = 'G'                                          => 10,
									 in_avs_x in ['ADD_ONLY', 'ZIP_ONLY', 'AMEX-PARTIALVER'] => 8,
									 (v_in_pmt = 'A') and (in_avs_x = 'ZIP_ADD')             => 8,
									 in_avs_x in ['AMEX-FULLVER', 'ZIP_ADD']                 => 9,
									 (v_in_pmt = 'B') or (in_avs_x = 'CC-GIFT CARD')         => 7,
									 in_avs_x in ['MISC', 'NO MATCH', 'SYSTEM ERROR']        => 6,
									 in_avs_x = 'AMEX-BADVER'                                => 5,
									 in_avs_x = 'INTERNATIONAL'                              => 4,
																																							-1);

	vb_avsx2_m :=  map(vb_avsx2 = 4 => 0.6997690531,
										 vb_avsx2 = 5 => 0.5858585859,
										 vb_avsx2 = 6 => 0.4058121432,
										 vb_avsx2 = 7 => 0.2881040892,
										 vb_avsx2 = 8 => 0.0458661417,
										 vb_avsx2 = 9 => 0.0123215137,
																		 0.001110186);

	vb_in_avs_bad := (v_in_avs_2 in ['N', 'M', 'V', '6', 'D', 'U']);

	vi_avsx2 :=  map(v_in_pmt = 'G'                                                                  => 5,
									 in_avs_x in ['ZIP_ADD', 'AMEX-FULLVER']                                         => 4,
									 in_avs_x in ['AMEX-BADVER', 'CC-GIFT CARD', 'MISC', 'NO MATCH', 'SYSTEM ERROR'] => 1,
									 in_avs_x in ['INTERNATIONAL']                                                   => 0,
									 v_in_pmt in ['M', 'V']                                                          => 3,
																																																			2);

	vi_avsx2_m :=  map(vi_avsx2 = 0 => 0.1714285714,
										 vi_avsx2 = 1 => 0.0879056047,
										 vi_avsx2 = 2 => 0.0208574739,
										 vi_avsx2 = 3 => 0.0070537168,
										 vi_avsx2 = 4 => 0.0032588365,
																		 0.0010487677);

	v_in_avs_bad := (v_in_avs_2 in ['N', 'M', 'V', '6', 'D', 'U']);

	v_in_avs_bad_m :=  if((integer)v_in_avs_bad = 0, 0.0038977072, 0.0958307405);

	v_in_cid := trim(trim((string)cus_CID, LEFT), LEFT, RIGHT);

	v_in_cid_match :=  map(v_in_cid in ['1', 'P']                => 1,
												 v_in_cid in ['2', '3', '4', '5', '6'] => -1,
																																	0);

	vs_in_cid_match_m :=  map(v_in_cid_match = -1 => 0.4082474227,
														v_in_cid_match = 0  => 0.1607700312,
																									 0.2504559887);

	vb_in_cid_match_m :=  map(v_in_cid_match = -1 => 0.1735657226,
														v_in_cid_match = 0  => 0.0259473485,
																									 0.0446953628);

	v_in_cid_match_m :=  map(v_in_cid_match = -1 => 0.039017341,
													 v_in_cid_match = 0  => 0.0132013201,
																									0.0047513722);

	v_in_shipmode := StringLib.StringToUpperCase(trim(trim(cus_shipmode_2, LEFT), LEFT, RIGHT));

	vs_in_shipmode_m :=  map(v_in_shipmode = '2' => 0.7408604322,
													 v_in_shipmode = '7' => 0.3924901186,
													 v_in_shipmode = 'G' => 0.1262634239,
																									0.3303730018);

	vb_in_shipmode_m :=  map(v_in_shipmode = '2' => 0.3034115654,
													 v_in_shipmode = '7' => 0.0774331044,
													 v_in_shipmode = 'G' => 0.0287524644,
																									0.053514377);

	vs_in_ordAmt := if(trim(cus_ordamt)='', 0, min(ln((real)cus_ordamt+0.01), 5000));
		




	vb_in_ordamt :=  if(''=cus_ORDAMT, 0, ln((min(if((real)cus_ORDAMT = NULL, -NULL, (real)cus_ORDAMT), 3000) + 0.01)));
 
	vi_in_ordAmt := if(''=trim(cus_ordamt), 0, min(2000, if(abs(((real)cus_ORDAMT - 40)) = NULL, -NULL, abs(((real)cus_ORDAMT - 40)))));

	vs_nap :=  map(nap_summary in [9, 10, 11, 12] => 3,
								nap_summary in [5, 6, 7, 8]    => 2,
								1);

	vs_nas :=  map(nas_summary in [8]                => 3,
								nas_summary in [2, 3, 4, 5, 6, 7] => 2,
								1);

	vs_verx2 :=  map((vs_nap = 3) and (vs_nas = 3) => 4,
									(vs_nap + vs_nas) = 5         => 3,
									vs_nas = 3                    => 3,
									(vs_nap + vs_nas) = 4         => 2,
									(vs_nap + vs_nas) = 3         => 1,
									0);

	vs_verx2_m :=  map(vs_verx2 = 0 => 0.5665665666,
										 vs_verx2 = 1 => 0.4041411043,
										 vs_verx2 = 2 => 0.2921074044,
										 vs_verx2 = 3 => 0.2136604092,
																		 0.139275104);

	vs_s_nap :=  map(nap_summary_s in [0, 1, 2, 3]           => 1,
									 nap_summary_s in [4, 5, 6, 7, 8, 9, 10] => 2,
																															3);

	vs_s_nas :=  map(nas_summary_s in [0, 1]       => 1,
									 nas_summary_s in [2, 3, 4, 5] => 2,
																										3);

	vs_s_verx2 :=  map(vs_s_nap = 3                      => 4,
										 (vs_s_nap = 2) and (vs_s_nas > 1) => 3,
										 (vs_s_nap = 1) and (vs_s_nas = 3) => 2,
										 (vs_s_nap + vs_s_nas) = 3         => 1,
																													0);

	vs_s_verx2_m :=  map(vs_s_verx2 = 0 => 0.3717801648,
											 vs_s_verx2 = 1 => 0.2659451992,
											 vs_s_verx2 = 2 => 0.1913606911,
											 vs_s_verx2 = 3 => 0.1539708266,
																				 0.0479078229);

	vb_verx2 :=  map((nap_summary in [9, 10, 11, 12]) and (nas_summary in [5, 8])                                                             => 6,
									 (nap_summary in [5, 6, 7, 8]) and (nas_summary in [5, 8])                                                                => 5,
									 nas_summary in [5, 8]                                                                                                    => 4,
									 nap_summary in [11, 12]                                                                                                  => 4,
									 (nap_summary in [5, 6, 7, 8, 9, 10]) and ((nas_summary in [0, 2, 3]) and not(((nap_summary = 6) and (nas_summary = 0)))) => 3,
									 (nap_summary in [0, 1, 2, 3, 4]) and (nas_summary in [2, 3])                                                             => 2,
									 nap_summary in [1, 2, 3, 4, 6]                                                                                           => 1,
									 (nap_summary = 0) and (nas_summary = 0)                                                                                  => 0,
																																																																							 -1);

	vb_verx2_m :=  map(vb_verx2 = 0 => 0.4338709677,
										 vb_verx2 = 1 => 0.3776493256,
										 vb_verx2 = 2 => 0.2375342466,
										 vb_verx2 = 3 => 0.0744941072,
										 vb_verx2 = 4 => 0.0247566852,
										 vb_verx2 = 5 => 0.0134602278,
																		 0.0063166554);

	vi_verx2 :=  map((nas_summary in [3, 5, 8]) and (nap_summary in [9, 10, 11, 12]) => 3,
									 (nas_summary in [3, 5, 8]) or (nap_summary in [6, 7, 8])        => 2,
									 (nas_summary = 0) and (nap_summary = 0)                         => 0,
																																											1);

	vi_verx2_m :=  map(vi_verx2 = 0 => 0.1043010753,
										 vi_verx2 = 1 => 0.0233009709,
										 vi_verx2 = 2 => 0.0044624411,
																		 0.0024466192);

	phn_inval := (integer)rc_phonevalflag = 0 or (integer)rc_hphonevalflag = 0 or rc_phonetype in ['5'];
	phn_nonUs := rc_phonetype in ['3', '4'];
	phn_notpots := telcordia_type not in ['00', '50', '51', '52', '54'];
	phn_zipmismatch := (integer)rc_phonezipflag = 1 or (integer)rc_pwphonezipflag = 1;
	phn_residential := (integer)rc_hphonevalflag = 2;

	phn_highrisk := (integer)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (integer)rc_hphonevalflag = 3 or (integer)rc_addrcommflag = 1;
	s_phn_inval  := (integer)rc_phonevalflag_s = 0 or (integer)rc_hphonevalflag_s = 0 or (integer)rc_phonetype_s in [5];
	s_phn_nonUs  := (integer)rc_phonetype_s in [3, 4];
	s_phn_notpots := not((telcordia_type_s in ['00', '50', '51', '52', '54']));


	phn_cell := (integer)( rc_hriskphoneflag in ['1','3'] or rc_hphonetypeflag in ['1','3'] );
	s_phn_cell := (integer)rc_hriskphoneflag_s in [1, 3] or rc_hphonetypeflag_s in ['1', '3'];
	s_phn_zipmismatch := (integer)rc_phonezipflag_s = 1 or (integer)rc_pwphonezipflag_s = 1;
	s_phn_residential := (integer)rc_hphonevalflag_s = 2;
	
	v_phn_prob :=  map(phn_inval or phn_nonUs => 3,
										 (phn_notpots and not((boolean)(integer)phn_cell)) => 2,
										 phn_zipmismatch        => 2,
										 phn_residential        => 0,
																							 1);

	v_s_phn_prob :=  map(s_phn_inval or s_phn_nonUs        => 3,
											 s_phn_notpots and not(s_phn_cell) => 2,
											 s_phn_zipmismatch                 => 2,
											 s_phn_residential                 => 0,
																														1);

	vs_phn_prob_combo_b1 := NULL;
	vs_phn_prob_combo := map(
		not hphnpop or not hphnpop_s     => 0,
		v_phn_prob = 3 or v_s_phn_prob=3 => 5,
		sum(v_phn_prob,v_s_phn_prob)
	);




	vs_phn_prob_combo_m :=  map(
		vs_phn_prob_combo = 0 => 0.0649327354,
		vs_phn_prob_combo = 1 => 0.1847942755,
		vs_phn_prob_combo = 2 => 0.2140721097,
		vs_phn_prob_combo = 3 => 0.4769749158,
		vs_phn_prob_combo = 4 => 0.6349047141,
		0.8230601885
	);

	v_phn_prob_2 :=  map(
		not(hphnpop)              => 0,
		phn_nonUs                 => 4,
		phn_inval or phn_highrisk => 3,
		(phn_notpots and not((boolean)(integer)phn_cell)) => 2,
		phn_zipmismatch           => 2,
		phn_residential           => 0,
		1
	);

	vb_phn_prob_m :=  map(
		v_phn_prob_2 = 0 => 0.0122032861,
		v_phn_prob_2 = 1 => 0.0603147875,
		v_phn_prob_2 = 2 => 0.2050861362,
		v_phn_prob_2 = 3 => 0.3537906137,
		0.7566666667
	);

	vi_phn_prob :=  map(not(hphnpop)                                                  => -1,
											phn_zipmismatch or (phn_inval or (phn_nonUs or phn_highrisk)) => 5,
											phn_residential                                               => 0,
																																											 1);

	vi_phn_prob_m :=  map(vi_phn_prob = -1 => 0.0012746348,
												vi_phn_prob = 0  => 0.0035429142,
												vi_phn_prob = 1  => 0.0089881675,
																						0.0317647059);

	best_match_lvl :=  map(add1_isbestmatch => 1,
												 add2_isbestmatch => 2,
																						 3);

	vb_proptree :=  map((add1_naprop in [3, 4]) and (best_match_lvl = 1)                           => 4,
											((add1_naprop in [3, 4]) and (best_match_lvl = 2)) or (best_match_lvl = 1) => 3,
											add1_naprop in [3, 4]                                                      => 2,
											best_match_lvl = 2                                                         => 1,
											best_match_lvl = 3                                                         => 0,
																																																		-1);

	vb_proptree_m :=  map(vb_proptree = 0 => 0.3408410773,
												vb_proptree = 1 => 0.1398410009,
												vb_proptree = 2 => 0.0310047096,
												vb_proptree = 3 => 0.0179956444,
																	 0.0080728887);


	
	inferred_dob2 := map(
		length((string)inferred_dob)=8 and (integer)((string)inferred_dob[1..4])>=1800 =>
	    ut.DaysSince1900((string)inferred_dob[1..4], (string)min(12,max(1,(integer)((string)inferred_dob[5..6]))), '01') +min(31,max(1, (integer)((string)(inferred_dob)[7..8])))-1,
		length((string)inferred_dob)=6 and (integer)((string)inferred_dob[1..4])>=1800 =>
			ut.DaysSince1900((string)inferred_dob[1..4], (string)min(12,max(1,(integer)((string)inferred_dob[5..6]))), '01'),
		NULL
	);
		
	inferred_dob_s2 := map(
		length((string)inferred_dob_s)=8 and (integer)((string)inferred_dob_s[1..4])>=1800 =>
	    ut.DaysSince1900((string)inferred_dob_s[1..4], (string)min(12,max(1,(integer)((string)inferred_dob_s[5..6]))), '01') +min(31,max(1, (integer)inferred_dob_s[7..8]))-1,
		length((string)inferred_dob_s)=6 and (integer)((string)inferred_dob_s[1..4])>=1800 =>
			ut.DaysSince1900((string)inferred_dob_s[1..4], (string)min(12,max(1,(integer)((string)inferred_dob_s[5..6]))), '01'),
		NULL
	);
	
	inferred_date := inferred_dob2;
	inferred_date_s := inferred_dob_s2;


	scoring_date    := ut.DaysSince1900(archive_date[1..4],   archive_date[5..6],   '01');
	scoring_date_s  := ut.DaysSince1900(archive_date_s[1..4], archive_date_s[5..6], '01');


	inferred_age := map(
		inferred_dob != 0 and inferred_date!=NULL => (integer)((scoring_date-inferred_date)/365.25),
		truedid           => -5,
		-10
	);
	inferred_age_b2 := NULL;
	inferred_age_s := map(
		inferred_dob_s != 0 and inferred_date_s != NULL => (integer)((scoring_date-inferred_date_s)/365.25),
		truedid_s           => -5,
		-10
	);
	inferred_age_s_b2 := NULL;


	inferred_age_rnd :=  if(inferred_age > 0, min(if((if ((inferred_age / 10) >= 0, roundup((inferred_age / 10)), truncate((inferred_age / 10))) * 10) = NULL, -NULL, (if ((inferred_age / 10) >= 0, roundup((inferred_age / 10)), truncate((inferred_age / 10))) * 10)), 80), inferred_age);

	inferred_age_rnd_s :=  if(inferred_age_s > 0, min(if((if ((inferred_age_s / 10) >= 0, roundup((inferred_age_s / 10)), truncate((inferred_age_s / 10))) * 10) = NULL, -NULL, (if ((inferred_age_s / 10) >= 0, roundup((inferred_age_s / 10)), truncate((inferred_age_s / 10))) * 10)), 80), inferred_age_s);

	vs_combo_age_b1 := map(((inferred_age_rnd = -10) and (inferred_age_rnd_s < 0)) or (((inferred_age_rnd = -10) and (inferred_age_rnd_s > 40)) or ((inferred_age_rnd > 70) and (inferred_age_rnd_s < 0))) => 0,
												 ((inferred_age_rnd = -10) and (inferred_age_rnd_s = 40)) or ((inferred_age_rnd = 70) and (inferred_age_rnd_s < 0))                                                              => 1,
												 ((inferred_age_rnd = -10) and (inferred_age_rnd_s = 30)) or ((inferred_age_rnd = 60) and (inferred_age_rnd_s < 0))                                                              => 2,
												 (inferred_age_rnd = 50) and (inferred_age_rnd_s < 0)                                                                                                                            => 4,
												 ((inferred_age_rnd = -10) and (inferred_age_rnd_s < 30)) or ((inferred_age_rnd = 40) and (inferred_age_rnd_s < 0))                                                              => 5,
												 (inferred_age_rnd in [20, 30]) and (inferred_age_rnd_s < 0)                                                                                                                     => 7,
												 inferred_age_rnd = -5                                                                                                                                                           => 6,
																																																																																																						-999);

	vs_combo_age_b2 := map((inferred_age_rnd in [20, 30]) and (inferred_age_rnd_s in [20, 30])                                                                => 13,
												 (inferred_age_rnd = 40) and (inferred_age_rnd_s = 40)                                                                              => 12,
												 (inferred_age_rnd = 50) and (inferred_age_rnd_s = 50)                                                                              => 11,
												 inferred_age_rnd = inferred_age_rnd_s                                                                                              => 10,
												 inferred_age_rnd_s > inferred_age_rnd                                                                                              => 9,
												 ((inferred_age_rnd > inferred_age_rnd_s) and (inferred_age_rnd_s > 40)) or ((inferred_age_rnd = 80) and (inferred_age_rnd_s > 20)) => 3,
												 inferred_age_rnd > inferred_age_rnd_s                                                                                              => 8,
																																																																															 -499);

	vs_combo_age := if((inferred_age_rnd < 0) or (inferred_age_rnd_s < 0), vs_combo_age_b1, vs_combo_age_b2);

	vs_combo_age_m :=  map(vs_combo_age = 0  => 0.5874305259,
												 vs_combo_age = 1  => 0.4836795252,
												 vs_combo_age = 2  => 0.4038657172,
												 vs_combo_age = 3  => 0.3765144455,
												 vs_combo_age = 4  => 0.3337520938,
												 vs_combo_age = 5  => 0.2843683084,
												 vs_combo_age = 6  => 0.2585692996,
												 vs_combo_age = 7  => 0.2165048544,
												 vs_combo_age = 8  => 0.2044025157,
												 vs_combo_age = 9  => 0.1739338764,
												 vs_combo_age = 10 => 0.1326963907,
												 vs_combo_age = 11 => 0.1025223759,
												 vs_combo_age = 12 => 0.086649312,
																							0.065917603);

	add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

	add_apt_s := ((StringLib.StringToUpperCase(trim((string)rc_dwelltype_s, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim((string)out_addr_type_s, LEFT, RIGHT)) = 'H') or (((string)out_unit_desig_s != ' ') or ((string)out_sec_range_s != ' '))));

	ssns_per_addr_c6_5_s := min(if(ssns_per_addr_c6_s = NULL, -NULL, ssns_per_addr_c6_s), 5);

	vs_s_ssns_per_addr_c6_b2 := if(ssns_per_addr_c6_5_s = 0, 1.5, 2.5);

	vs_s_ssns_per_addr_c6 := if(not(add_apt_s), ssns_per_addr_c6_5_s, vs_s_ssns_per_addr_c6_b2);
	
	vs_s_ssns_per_addr_c6_m := case( vs_s_ssns_per_addr_c6,
		0   => 0.1662947067,
		1   => 0.2864165589,
		1.5 => 0.3026951437,
		2   => 0.3307181654,
		2.5 => 0.3650145773,
		3   => 0.4112149533,
		4   => 0.4864864865,
					 0.5986842105
	);


	vs_s_adls_per_addr_b1 := map((integer)adls_per_addr_s > 25 => 9,
															 (integer)adls_per_addr_s > 15 => 7,
															 (integer)adls_per_addr_s > 10 => 3,
															 (integer)adls_per_addr_s > 0  => 1,
																																5);

	vs_s_adls_per_addr_b2 := map((integer)adls_per_addr_s = 0                                        => 5,
															 (integer)adls_per_addr_s = 1                                        => 1,
															 (10 < (integer)adls_per_addr_s) AND ((integer)adls_per_addr_s < 26) => 7,
																																																			3);

	vs_s_adls_per_addr := if((string)rc_dwelltype_s != 'A', vs_s_adls_per_addr_b1, vs_s_adls_per_addr_b2);

	vs_s_adls_per_addr_m :=  map(vs_s_adls_per_addr = 1 => 0.1513220168,
															 vs_s_adls_per_addr = 3 => 0.2753043478,
															 vs_s_adls_per_addr = 5 => 0.3065935651,
															 vs_s_adls_per_addr = 7 => 0.3837765957,
																												 0.4140862174);

	adls_per_addr_c6_5 := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 5);

	vb_adls_per_addr_c6_5_m :=  map(adls_per_addr_c6_5 = 0 => 0.0363142846,
																	adls_per_addr_c6_5 = 1 => 0.0438923671,
																	adls_per_addr_c6_5 = 2 => 0.0644153816,
																	adls_per_addr_c6_5 = 3 => 0.1118464593,
																	adls_per_addr_c6_5 = 4 => 0.1703703704,
																														0.4393939394);

	vb_adls_per_addr_b1 := map((adls_per_addr = 0) or (adls_per_addr > 40) => 8,
														 adls_per_addr > 20                          => 6,
														 adls_per_addr > 15                          => 4,
														 adls_per_addr >= 10                         => 2,
																																						0);

	vb_adls_per_addr_b2 := map(adls_per_addr > 40 => 8,
														 adls_per_addr = 0  => 7,
																									 6);

	vb_adls_per_addr := if(not(add_apt), vb_adls_per_addr_b1, vb_adls_per_addr_b2);

	vb_adls_per_addr_m :=  map(vb_adls_per_addr = 0 => 0.0176496135,
														 vb_adls_per_addr = 2 => 0.0312538681,
														 vb_adls_per_addr = 4 => 0.052878726,
														 vb_adls_per_addr = 6 => 0.0858531842,
														 vb_adls_per_addr = 7 => 0.1264655513,
																										 0.2911931818);

	v_ip_topDomain := StringLib.StringToUpperCase(trim(trim((string)ip_topleveldomain, LEFT), LEFT, RIGHT));

	v_in_AcqChannel := trim(trim((string)cus_ACQ_CHANNE, LEFT), LEFT, RIGHT);

	v_ip_continent := trim(ip_continent, LEFT, RIGHT);

	v_ip_countrycode := StringLib.StringToUpperCase(trim(ip_countrycode, LEFT, RIGHT));

	v_ip_state := StringLib.StringToUpperCase(trim(ip_state, LEFT, RIGHT));

	vs_ipmatchcode_b1 := if(in_state = in_state_s, 's11-telstatematch', 's12-telstatediff');

	vs_ipmatchcode_b2 := if(in_state = in_state_s, 's21-kioskstatematch', 's22-kioskstatediff');

	vs_ipmatchcode_b6 := map(v_ip_state = in_state => 's51-ipmatch',
																										's52-usIP');

	vs_ipmatchcode_b7 := map(v_ip_state = in_state   => 's61-ipbtstate',
													 v_ip_state = in_state_s => 's62-ipststate',
																											's63-usIP');

	vs_ipmatchcode := map(v_in_AcqChannel = '02'                             => vs_ipmatchcode_b1,
												v_in_AcqChannel = '03'                             => vs_ipmatchcode_b2,
												v_ip_continent in ['1', '7']                       => 's32-badIP',
												not((v_ip_countrycode in ['US']))                  => 's31-foreignIP',
												(v_ip_state = 'AOL') and (v_ip_countrycode = 'US') => 's40-AOL',
												in_state = in_state_s                              => vs_ipmatchcode_b6,
												in_state != in_state_s                             => vs_ipmatchcode_b7,
																																							's70-other');

	vs_ipmatchcode_2 :=  if((vs_ipmatchcode = 's31-foreignIP') and (contains_i(v_ip_topDomain, '.') > 0), 's31.5-foreignIP-DOT', vs_ipmatchcode);

	vs_ipmatchcode_m :=  map(vs_ipmatchcode_2 = 's11-telstatematch'   => 0.3005671078,
													 vs_ipmatchcode_2 = 's12-telstatediff'    => 0.4754901961,
													 vs_ipmatchcode_2 = 's21-kioskstatematch' => 0.0287539936,
													 vs_ipmatchcode_2 = 's22-kioskstatediff'  => 0.0084033613,
													 vs_ipmatchcode_2 = 's31-foreignIP'       => 0.4149253731,
													 vs_ipmatchcode_2 = 's31.5-foreignIP-DOT' => 0.6968838527,
													 vs_ipmatchcode_2 = 's32-badIP'           => 0.8149253731,
													 vs_ipmatchcode_2 = 's40-AOL'             => 0.408045977,
													 vs_ipmatchcode_2 = 's51-ipmatch'         => 0.1500993304,
													 vs_ipmatchcode_2 = 's52-usIP'            => 0.1424310216,
													 vs_ipmatchcode_2 = 's61-ipbtstate'       => 0.1460841336,
													 vs_ipmatchcode_2 = 's62-ipststate'       => 0.5025400547,
																																			 0.4937539038);

	vs_ip_domain_GovMil := (v_ip_topDomain in ['GOV', 'MIL']);

	vb_ipmatchcode :=  map(v_in_AcqChannel = '02'                             => 'b1-tel',
												 v_in_AcqChannel = '03'                             => 'b2-kio',
												 (v_ip_state = 'AOL') and (v_ip_countrycode = 'US') => 'b3-aol',
												 v_ip_state = in_state                              => 'b4-sta',
												 v_ip_countrycode = 'US'                            => 'b5-us',
												 v_ip_countrycode = 'CA'                            => 'b6-can',
												 v_ip_continent in ['1', '7']                       => 'b8-bad',
												 contains_i(v_ip_topDomain, '.') = 0       => 'b7-oth',
																																							 'b7.5-D');

	vb_ipmatchcode_m :=  map(vb_ipmatchcode = 'b1-tel' => 0.0886627907,
													 vb_ipmatchcode = 'b2-kio' => 0.0030094583,
													 vb_ipmatchcode = 'b3-aol' => 0.0222222222,
													 vb_ipmatchcode = 'b4-sta' => 0.0278834141,
													 vb_ipmatchcode = 'b5-us'  => 0.0421213596,
													 vb_ipmatchcode = 'b6-can' => 0.1566666667,
													 vb_ipmatchcode = 'b7-oth' => 0.3871527778,
													 vb_ipmatchcode = 'b7.5-D' => 0.6551724138,
																												0.6714285714);

	vb_ip_domain_b1 := map(v_ip_topDomain in ['COM', 'NET', 'EDU', 'MIL', 'ORG'] => 'commondomain',
												 v_ip_topDomain = 'GOV'                                => 'govdomain',
																																									'uncommondomain');

	vb_ip_domain := map(v_in_AcqChannel in ['01', '04'] => vb_ip_domain_b1,
											v_in_AcqChannel = '02'          => 'telorder',
																												 'kioskorder');

	vb_ip_domain_m :=  map(vb_ip_domain = 'commondomain' => 0.0335895975,
												 vb_ip_domain = 'govdomain'    => 0.0220994475,
												 vb_ip_domain = 'kioskorder'   => 0.0030094583,
												 vb_ip_domain = 'telorder'     => 0.0886627907,
																													0.2449712644);

	email_provider :=  if(StringLib.StringFind(in_email_address, '@', 1 ) > 0,
		StringLib.StringToUpperCase(in_email_address[ 1+StringLib.StringFind(in_email_address, '@', 1 ).. ]),
		'');

	// get "GMAIL" from "GMAIL.COM", etc
	tld := if(StringLib.StringFind(email_provider, '.', 1) > 0, email_provider[ 1..StringLib.StringFind(email_provider,'.',1)-1 ], '' );
	
	email_provider2 := map(
		tld in ['HOTMAIL', 'GMAIL', 'AOL', 'YAHOO', 'VERIZON', 'SBCGLOBAL', 'MSN', 'COMCAST'] => tld,
		trim(in_email_address) != '' => 'OTHER',
		'NO EMAIL'
	);

	ist_bill_escore :=  map(((integer)ist_efirstscore = 3) or ((integer)ist_elastscore = 3)   => 3,
													((integer)ist_efirstscore = -1) or ((integer)ist_elastscore = -1) => 0,
													((integer)ist_efirstscore = 0) and ((integer)ist_elastscore = 0)  => 0,
													(integer)ist_efirstscore in [1, 2]                                         => 1,
																																															 2);

	vs_email_score :=  map((email_provider2 in ['SBCGLOBAL', 'VERIZON']) and (ist_bill_escore > 0)                                                                                                          => 7,
												 (email_provider2 in ['SBCGLOBAL', 'VERIZON']) or (((email_provider2 in ['MSN', 'OTHER']) and (ist_bill_escore > 1)) or ((email_provider2 in ['AOL']) and (ist_bill_escore > 1))) => 6,
												 ist_bill_escore > 1                                                                                                                                                              => 4,
												 (email_provider2 in ['GMAIL', 'YAHOO']) and (ist_bill_escore = 0)                                                                                                                => 0,
												 (email_provider2 in ['HOTMAIL', 'OTHER']) and (ist_bill_escore = 0)                                                                                                              => 1,
												 (email_provider2 in ['GMAIL', 'HOTMAIL']) or ((email_provider2 in ['MSN']) and (ist_bill_escore = 0))                                                                            => 3,
												 ((email_provider2 in ['AOL']) and (ist_bill_escore = 0)) or (email_provider2 in ['YAHOO'])                                                                                       => 2,
																																																																																																						 5);

	vs_email_score_m :=  map(vs_email_score = 0 => 0.528466483,
													 vs_email_score = 1 => 0.3222680782,
													 vs_email_score = 2 => 0.2502004812,
													 vs_email_score = 3 => 0.1967329545,
													 vs_email_score = 4 => 0.1469194313,
													 vs_email_score = 5 => 0.105854524,
													 vs_email_score = 6 => 0.0669834457,
																								 0.020746888);

	ist_bill_escore_2 :=  map(((integer)ist_efirstscore = 3) and ((integer)ist_elastscore < 2)                                     => 3,
														((integer)ist_efirstscore = 3) or (((integer)ist_efirstscore = 0) and ((integer)ist_elastscore > 0)) => 2,
														((integer)ist_efirstscore in [1, 2]) and ((integer)ist_elastscore < 2)                                        => 1,
																																																																		0);

	vb_email_escore :=  map((email_provider2 = 'GMAIL') and (ist_bill_escore_2 = 0)                                                                                                             => 0,
													(email_provider2 in ['HOTMAIL', 'YAHOO']) and (ist_bill_escore_2 = 0)                                                                                               => 1,
													(email_provider2 = 'HOTMAIL') and (ist_bill_escore_2 = 1)                                                                                                           => 2,
													((email_provider2 in ['GMAIL', 'HOTMAIL']) and (ist_bill_escore_2 < 3)) or ((email_provider2 = 'YAHOO') and (ist_bill_escore_2 = 1))                                => 3,
													((email_provider2 = 'OTHER') and (ist_bill_escore_2 = 0)) or (email_provider2 = 'NO EMAIL')                                                                         => 4,
													((email_provider2 = 'AOL') and (ist_bill_escore_2 = 0)) or (((email_provider2 = 'OTHER') and (ist_bill_escore_2 = 1)) or (email_provider2 in ['GMAIL', 'HOTMAIL'])) => 5,
													(email_provider2 = 'YAHOO') or (((email_provider2 = 'MSN') and (ist_bill_escore_2 < 3)) or ((email_provider2 = 'OTHER') and (ist_bill_escore_2 < 3)))               => 6,
													(email_provider2 = 'OTHER') or (((email_provider2 = 'COMCAST') and (ist_bill_escore_2 = 0)) or ((email_provider2 = 'AOL') and (ist_bill_escore_2 < 3)))             => 7,
													(email_provider2 = 'VERIZON') and (ist_bill_escore_2 > 0)                                                                                                           => 9,
																																																																																																 8);

	vb_email_escore_m :=  map(vb_email_escore = 0 => 0.1400583576,
														vb_email_escore = 1 => 0.087848537,
														vb_email_escore = 2 => 0.0715162676,
														vb_email_escore = 3 => 0.0576268439,
														vb_email_escore = 4 => 0.0445668503,
														vb_email_escore = 5 => 0.0342540725,
														vb_email_escore = 6 => 0.0245402472,
														vb_email_escore = 7 => 0.017667304,
														vb_email_escore = 8 => 0.0070262674,
																				 0.0012033694);

	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	vs_s_c_lowed :=  map(''=trim(c_low_ed_s)       => 0,
											 (integer)c_low_ed_s = -1  => 50,
											 (integer)c_low_ed_s = 100 => 60,
											if (((real)c_low_ed_s / 10) >= 0, roundup(((real)c_low_ed_s / 10)), truncate(((real)c_low_ed_s / 10))) * 10
									  );

	vs_s_c_lowed_i :=  map(vs_s_c_lowed <= 20 => 1,
												 vs_s_c_lowed <= 30 => 2,
												 vs_s_c_lowed <= 40 => 3,
												 vs_s_c_lowed <= 50 => 4,
												 vs_s_c_lowed <= 60 => 5,
												 vs_s_c_lowed <= 70 => 6,
												 vs_s_c_lowed <= 90 => 7,
																		 8);

	vs_s_c_lowed_i_m :=  map(vs_s_c_lowed_i = 1 => 0.1307322754,
													 vs_s_c_lowed_i = 2 => 0.1920517209,
													 vs_s_c_lowed_i = 3 => 0.2146282974,
													 vs_s_c_lowed_i = 4 => 0.2260523125,
													 vs_s_c_lowed_i = 5 => 0.3076190476,
													 vs_s_c_lowed_i = 6 => 0.3885050251,
													 vs_s_c_lowed_i = 7 => 0.5187134503,
																		 0.5);

	vs_s_c_robbery :=  map(''=trim(c_robbery_s)        => 0,
												 (real)c_robbery_s <= 20  => 1,
												 (real)c_robbery_s <= 120 => 2,
												 (real)c_robbery_s <= 140 => 3,
												 (real)c_robbery_s <= 160 => 4,
																			5);

	vs_s_c_robbery_m :=  map(vs_s_c_robbery = 0 => 0.101551481,
							 vs_s_c_robbery = 1 => 0.1220405862,
							 vs_s_c_robbery = 2 => 0.1760112557,
							 vs_s_c_robbery = 3 => 0.2493053801,
							 vs_s_c_robbery = 4 => 0.2946938776,
													0.4028611572);

	vs_s_c_span_lang :=  map(''=trim(c_span_lang_s)        => 1,
													 (real)c_span_lang_s <= 125 => 1,
													 (real)c_span_lang_s <= 140 => 2,
													 (real)c_span_lang_s <= 160 => 3,
													 (real)c_span_lang_s <= 180 => 4,
																					5);

	vs_s_c_span_lang_m :=  map(vs_s_c_span_lang = 1 => 0.1690162665,
														 vs_s_c_span_lang = 2 => 0.2186046512,
														 vs_s_c_span_lang = 3 => 0.253170853,
														 vs_s_c_span_lang = 4 => 0.3530028849,
																				 0.5380233552);

	vs_s_c_fammar_p :=  map(''=trim(c_fammar_p_s)       => 95,
													(real)c_fammar_p_s = -1  => 65,
													(real)c_fammar_p_s = 100 => 75,
															(real)c_fammar_p_s);

	hi_robbery := ((integer)c_robbery >= 160);
	hi_assault := ((integer)c_assault >= 170);
	hi_burglary := ((integer)c_burglary >= 170);
	hi_larceny := ((integer)c_larceny >= 180);
	hi_cartheft := ((integer)c_cartheft >= 180);

	vb_c_hi_crime :=  map(hi_robbery and hi_assault and hi_burglary and hi_larceny and hi_cartheft => 2,
	                      hi_robbery or  hi_assault or  hi_burglary or  hi_larceny or hi_cartheft  => 1,
																									0);

	vb_c_hi_crime_m :=  map(vb_c_hi_crime = 0 => 0.0254268166,
							vb_c_hi_crime = 1 => 0.0711454311,
							                     0.386130137);

	vb_c_fammar_p :=  if(''=trim(c_fammar_p), 90, min(if(max((real)c_fammar_p, 1) = NULL, -NULL, max((real)c_fammar_p, 1)), 100));

	vb_C_FAMMAR_P_lg := ln(vb_c_fammar_p);

	rel_incomeunder25_count_pct :=  if(rel_count > 0, (rel_incomeunder25_count / (rel_count * 100)), NULL);
	rel_incomeover75_pct :=  if(rel_count > 0, ((rel_incomeunder100_count + rel_incomeover100_count) / (rel_count * 100)), NULL);
	rel_educationover12_pct :=  if(rel_count > 0, (rel_educationover12_count / (rel_count * 100)), NULL);
	rel_homeover300_pct :=  if(rel_count > 0, ((rel_homeunder500_count + rel_homeover500_count) / (rel_count * 100)), NULL);
	rel_prop_owned_count_pct :=  if(rel_count > 0, min(if((rel_prop_owned_count / (rel_count * 100)) = NULL, -NULL, (rel_prop_owned_count / (rel_count * 100))), 100), NULL);

	rich_rel := ((integer)rel_incomeover75_pct >= 75);
	rel_nice_house := ((integer)rel_homeover300_pct >= 75);
	no_rel_crims := (rel_criminal_count = 0);
	close_rels := (rel_within25miles_count > 0);
	rel_prop := (rel_prop_owned_count_pct >= 75);
	poor_rels := ((integer)rel_incomeunder25_count_pct >= 75);
	smart_rels := ((integer)rel_educationover12_pct >= 75);
	no_rels := (rel_count = 0);
	vi_rels :=  map(
		rel_count = 0               => -1,
		rel_nice_house              => 7,
		rich_rel                    => 6,
		rel_prop and smart_rels     => 5,
		rel_prop                    => 4,
		smart_rels and no_rel_crims => 4,
		smart_rels                  => 3,
		close_rels and no_rel_crims => 2,
		not(poor_rels)              => 1,
		0
	);

	vi_rels_m :=  map(
		vi_rels = -1 => 0.0442507543,
		vi_rels = 0  => 0.0171232877,
		vi_rels = 1  => 0.0060740568,
		vi_rels = 2  => 0.0051158032,
		vi_rels = 3  => 0.0041775457,
		vi_rels = 4  => 0.0038285714,
		vi_rels = 5  => 0.0027190964,
		vi_rels = 6  => 0.0018399264,
		0.0014306152
	);

	vs_lname_match := ((integer)ist_lastscore = 100);
	vs_Dist_addraddr2 := min(max(Dist_addraddr2,.01),3000);
	// vs_Dist_addraddr2 := min(if(max((real)dist_addraddr2, NULL) = NULL, -NULL, max((real)dist_addraddr2, NULL)), 3000);
	vs_Dist_addraddr2_lg := ln(vs_Dist_addraddr2);
	uv_billto := ((integer)ist_addrscore = 100);
	uv_instore := trim(shp_mode)='';
	uv_dataset :=  map((integer)uv_instore = 1 => 'instore',
					   (integer)uv_billto = 1  => 'billto',
												'shipto');

	base := 750;
	point := -25;
	odds := (12894 / 3592546);

	Shipto_log := -18.65222278
		+ vs_s_verx2_m  * 4.914004175
		+ vs_verx2_m  * 1.1523237482
		+ vs_avs_x2_m  * 2.1126402941
		+ vs_in_cid_match_m  * 5.0083221928
		+ vs_in_shipmode_m  * 3.6610640683
		+ vs_phn_prob_combo_m  * 3.8997610216
		+ vs_s_c_lowed_i_m  * 2.8278957362
		+ vs_s_C_ROBBERY_m  * 1.1457366457
		+ vs_s_C_SPAN_LANG_m  * 1.9905843818
		+ vs_combo_age_m  * 1.4756480277
		+ vs_s_ssns_per_addr_c6_m  * 1.6833283585
		+ vs_s_adls_per_addr_m  * 1.4341439075
		+ vs_IPMatchCode_m  * 2.7426954896
		+ vs_email_score_m  * 3.9950083458
		+ (integer)vs_in_avs_bad  * 0.7664173428
		+ vs_in_ordAmt  * 0.9694802525
		+ vs_s_c_FAMMAR_P  * -0.007824095
		+ (integer)vs_ip_domain_GovMil  * -3.232674507
		+ (integer)vs_lname_match  * -1.01503667
		+ vs_Dist_addraddr2_lg  * 0.090828974
		+ shipto_offset  * 1
	;
     
     s_phat := (exp(Shipto_log)) / (1+exp(Shipto_log));
     Shipto_Score_a := round(point*(log(s_phat/(1-s_phat)) - log(odds))/log(2) + base);
     Shipto_Score := max(250,min(999,Shipto_Score_a));

		Billto_log := -13.08232283
                + vb_avsx2_m  * 1.161716152
                + vb_in_cid_match_m  * 7.6928014019
                + vb_in_shipmode_m  * 7.2107629528
                + vb_verx2_m  * 3.5589085009
                + vb_proptree_m  * 1.4623090609
                + vb_phn_prob_m  * 2.0133615969
                + vb_IPMatchCode_m  * 0.5299703744
                + vb_ip_domain_m  * 1.7200467556
                + vb_c_hi_crime_m  * 3.1008521437
                + vb_adls_per_addr_c6_5_m  * 2.3388103962
                + vb_adls_per_addr_m  * 1.7902904791
                + (integer)vb_in_avs_bad  * 1.9662734389
                + vb_in_ordAmt  * 0.9686895044
                + vb_C_FAMMAR_P_lg  * -0.367691866
                + vb_email_escore_m  * 12.961402386
                + billto_offset  * 1
     ;
     
     b_phat := (exp(Billto_log)) / (1+exp(Billto_log));
     Billto_Score_a := round(point*(log(b_phat/(1-b_phat)) - log(odds))/log(2) + base);
     Billto_Score := max(250,min(999,Billto_Score_a));

	Instore_log := -10.76818181
                 + vi_avsx2_m  * 13.596680088
                 + v_in_avs_bad_m  * 15.265762968
                 + v_in_cid_match_m  * 70.784301155
                 + vi_verx2_m  * 12.665905558
                 + vi_phn_prob_m  * 45.859730111
                 + vi_rels_m  * 16.761249749
                 + vi_in_ordAmt  * 0.0021404098
                 + instore_offset  * 1
     ;

	i_phat := (exp(Instore_log)) / (1+exp(Instore_log));
     Instore_Score_a := round(point*(log(i_phat/(1-i_phat)) - log(odds))/log(2) + base);
     Instore_Score := max(250,min(999,Instore_Score_a));
	
	
	CDN908_1_0 := case( uv_dataset,
		'shipto' => Shipto_Score,
		'billto' => Billto_Score,
		instore_score
	);
	
	self.score := (string3)CDN908_1_0;
	self.seq := le.bill_to_out.seq;
	self.ri := [];

	#if(Risk_Indicators.iid_constants.validation_debug)
		self.geolink := le.easi.geolink;
		self.geolink_s := le.easi2.geolink;
		self.truedid := truedid;
		self.in_state := in_state;
		self.out_unit_desig := out_unit_desig;
		self.out_sec_range := out_sec_range;
		self.out_addr_type := out_addr_type;
		self.in_email_address := in_email_address;
		self.nas_summary := nas_summary;
		self.nap_summary := nap_summary;
		self.rc_hriskphoneflag := rc_hriskphoneflag;
		self.rc_hphonetypeflag := rc_hphonetypeflag;
		self.rc_phonevalflag := rc_phonevalflag;
		self.rc_hphonevalflag := rc_hphonevalflag;
		self.rc_phonezipflag := rc_phonezipflag;
		self.rc_pwphonezipflag := rc_pwphonezipflag;
		self.rc_dwelltype := rc_dwelltype;
		self.rc_addrcommflag := rc_addrcommflag;
		self.rc_phonetype := rc_phonetype;
		self.hphnpop := hphnpop;
		self.add1_isbestmatch := add1_isbestmatch;
		self.add1_naprop := add1_naprop;
		self.add2_isbestmatch := add2_isbestmatch;
		self.telcordia_type := telcordia_type;
		self.adls_per_addr := adls_per_addr;
		self.adls_per_addr_c6 := adls_per_addr_c6;
		self.rel_count := rel_count;
		self.rel_criminal_count := rel_criminal_count;
		self.rel_prop_owned_count := rel_prop_owned_count;
		self.rel_within25miles_count := rel_within25miles_count;
		self.rel_incomeunder25_count := rel_incomeunder25_count;
		self.rel_incomeunder100_count := rel_incomeunder100_count;
		self.rel_incomeover100_count := rel_incomeover100_count;
		self.rel_homeunder500_count := rel_homeunder500_count;
		self.rel_homeover500_count := rel_homeover500_count;
		self.rel_educationover12_count := rel_educationover12_count;
		self.inferred_dob := inferred_dob;
		self.archive_date := archive_date;
		self.C_FAMMAR_P := C_FAMMAR_P;
		self.c_assault := c_assault;
		self.c_burglary := c_burglary;
		self.c_cartheft := c_cartheft;
		self.c_larceny := c_larceny;
		self.c_robbery := c_robbery;
		self.AVS_CODE := AVS_CODE;
		self.CHANNEL := CHANNEL;
		self.CID_RESPONSE := CID_RESPONSE;
		self.dist_addraddr2 := dist_addraddr2;
		self.IP_topleveldomain := IP_topleveldomain;
		self.IP_continent := IP_continent;
		self.IP_countrycode := IP_countrycode;
		self.IP_state := IP_state;
		self.IP_region := IP_region;
		self.IST_addrscore := IST_addrscore;
		self.IST_efirstscore := IST_efirstscore;
		self.IST_elastscore := IST_elastscore;
		self.IST_lastscore := IST_lastscore;
		self.ORD_TOT := ORD_TOT;
		self.PAY_TYPE := PAY_TYPE;
		self.SHP_MODE := SHP_MODE;
		self.next_day := next_day;
		self.second_day := second_day;
		self.phn_cell := phn_cell;
		self.truedid_s := truedid_s;
		self.in_state_s := in_state_s;
		self.out_unit_desig_s := out_unit_desig_s;
		self.out_sec_range_s := out_sec_range_s;
		self.out_addr_type_s := out_addr_type_s;
		self.nas_summary_s := nas_summary_s;
		self.nap_summary_s := nap_summary_s;
		self.rc_hriskphoneflag_s := rc_hriskphoneflag_s;
		self.rc_hphonetypeflag_s := rc_hphonetypeflag_s;
		self.rc_phonevalflag_s := rc_phonevalflag_s;
		self.rc_hphonevalflag_s := rc_hphonevalflag_s;
		self.rc_phonezipflag_s := rc_phonezipflag_s;
		self.rc_pwphonezipflag_s := rc_pwphonezipflag_s;
		self.rc_dwelltype_s := rc_dwelltype_s;
		self.rc_phonetype_s := rc_phonetype_s;
		self.hphnpop_s := hphnpop_s;
		self.telcordia_type_s := telcordia_type_s;
		self.adls_per_addr_s := adls_per_addr_s;
		self.ssns_per_addr_c6_s := ssns_per_addr_c6_s;
		self.inferred_dob_s := inferred_dob_s;
		self.archive_date_s := archive_date_s;
		self.C_FAMMAR_P_s := C_FAMMAR_P_s;
		self.C_LOW_ED_s := C_LOW_ED_s;
		self.C_ROBBERY_s := C_ROBBERY_s;
		self.C_SPAN_LANG_s := C_SPAN_LANG_s;
		self.cus_ORDAMT := cus_ORDAMT;
		self.cus_pmttype := cus_pmttype;
		self.cus_avs := cus_avs;
		self.cus_CID := cus_CID;
		self.cus_ACQ_CHANNE := cus_ACQ_CHANNE;
		self.cus_SHIPMODE := cus_SHIPMODE;
		self.new_ship := new_ship;
		self.cus_shipmode_2 := cus_shipmode_2;
		self.shipto_population_rate := shipto_population_rate;
		self.shipto_sample_rate := shipto_sample_rate;
		self.shipto_offset := shipto_offset;
		self.instore_population_rate := instore_population_rate;
		self.instore_sample_rate := instore_sample_rate;
		self.instore_offset := instore_offset;
		self.billto_population_rate := billto_population_rate;
		self.billto_sample_rate := billto_sample_rate;
		self.billto_offset := billto_offset;
		self.v_in_avs_x := v_in_avs_x;
		self.v_in_pmt := v_in_pmt;
		self.v_in_avs := v_in_avs;
		self.amex_lst := amex_lst;
		self.amex_add := amex_add;
		self.amex_zip := amex_zip;
		self.amex_lst_b1 := amex_lst_b1;
		self.amex_add_b1 := amex_add_b1;
		self.amex_zip_b1 := amex_zip_b1;
		self.amex_add_2 := amex_add_2;
		self.amex_zip_2 := amex_zip_2;
		self.amex_lst_2 := amex_lst_2;
		self.amex_sum := amex_sum;
		self.in_avs_x := in_avs_x;
		self.v_in_avs_2 := v_in_avs_2;
		self.vs_avs_x2 := vs_avs_x2;
		self.vs_avs_x2_m := vs_avs_x2_m;
		self.vs_in_avs_bad := vs_in_avs_bad;
		self.vb_avsx2 := vb_avsx2;
		self.vb_avsx2_m := vb_avsx2_m;
		self.vb_in_avs_bad := vb_in_avs_bad;
		self.vi_avsx2 := vi_avsx2;
		self.vi_avsx2_m := vi_avsx2_m;
		self.v_in_avs_bad := v_in_avs_bad;
		self.v_in_avs_bad_m := v_in_avs_bad_m;
		self.v_in_cid := v_in_cid;
		self.v_in_cid_match := v_in_cid_match;
		self.vs_in_cid_match_m := vs_in_cid_match_m;
		self.vb_in_cid_match_m := vb_in_cid_match_m;
		self.v_in_cid_match_m := v_in_cid_match_m;
		self.v_in_shipmode := v_in_shipmode;
		self.vs_in_shipmode_m := vs_in_shipmode_m;
		self.vb_in_shipmode_m := vb_in_shipmode_m;
		self.vs_in_ordAmt := vs_in_ordAmt;
		self.vb_in_ordamt := vb_in_ordamt;
		self.vi_in_ordAmt := vi_in_ordAmt;
		self.vs_nap := vs_nap;
		self.vs_nas := vs_nas;
		self.vs_verx2 := vs_verx2;
		self.vs_verx2_m := vs_verx2_m;
		self.vs_s_nap := vs_s_nap;
		self.vs_s_nas := vs_s_nas;
		self.vs_s_verx2 := vs_s_verx2;
		self.vs_s_verx2_m := vs_s_verx2_m;
		self.vb_verx2 := vb_verx2;
		self.vb_verx2_m := vb_verx2_m;
		self.vi_verx2 := vi_verx2;
		self.vi_verx2_m := vi_verx2_m;
		self.phn_inval := phn_inval;
		self.phn_nonUs := phn_nonUs;
		self.phn_notpots := phn_notpots;
		self.phn_zipmismatch := phn_zipmismatch;
		self.phn_residential := phn_residential;
		self.phn_highrisk := phn_highrisk;
		self.s_phn_inval := s_phn_inval;
		self.s_phn_nonUs := s_phn_nonUs;
		self.s_phn_notpots := s_phn_notpots;
		self.s_phn_cell := s_phn_cell;
		self.s_phn_zipmismatch := s_phn_zipmismatch;
		self.s_phn_residential := s_phn_residential;
		self.v_phn_prob := v_phn_prob;
		self.v_s_phn_prob := v_s_phn_prob;
		self.vs_phn_prob_combo_b1 := vs_phn_prob_combo_b1;
		self.vs_phn_prob_combo := vs_phn_prob_combo;
		self.vs_phn_prob_combo_m := vs_phn_prob_combo_m;
		self.v_phn_prob_2 := v_phn_prob_2;
		self.vb_phn_prob_m := vb_phn_prob_m;
		self.vi_phn_prob := vi_phn_prob;
		self.vi_phn_prob_m := vi_phn_prob_m;
		self.best_match_lvl := best_match_lvl;
		self.vb_proptree := vb_proptree;
		self.vb_proptree_m := vb_proptree_m;
		self.scoring_date := scoring_date;
		self.scoring_date_s := scoring_date_s;
		self.inferred_date := inferred_date;
		self.inferred_date_s := inferred_date_s;
		self.inferred_age_b2 := inferred_age_b2;
		self.inferred_age := inferred_age;
		self.inferred_age_s_b2 := inferred_age_s_b2;
		self.inferred_age_s := inferred_age_s;
		self.inferred_age_rnd := inferred_age_rnd;
		self.inferred_age_rnd_s := inferred_age_rnd_s;
		self.vs_combo_age_b1 := vs_combo_age_b1;
		self.vs_combo_age_b2 := vs_combo_age_b2;
		self.vs_combo_age := vs_combo_age;
		self.vs_combo_age_m := vs_combo_age_m;
		self.add_apt := add_apt;
		self.add_apt_s := add_apt_s;
		self.ssns_per_addr_c6_5_s := ssns_per_addr_c6_5_s;
		self.vs_s_ssns_per_addr_c6_b2 := vs_s_ssns_per_addr_c6_b2;
		self.vs_s_ssns_per_addr_c6 := vs_s_ssns_per_addr_c6;
		self.vs_s_ssns_per_addr_c6_m := vs_s_ssns_per_addr_c6_m;
		self.vs_s_adls_per_addr_b1 := vs_s_adls_per_addr_b1;
		self.vs_s_adls_per_addr_b2 := vs_s_adls_per_addr_b2;
		self.vs_s_adls_per_addr := vs_s_adls_per_addr;
		self.vs_s_adls_per_addr_m := vs_s_adls_per_addr_m;
		self.adls_per_addr_c6_5 := adls_per_addr_c6_5;
		self.vb_adls_per_addr_c6_5_m := vb_adls_per_addr_c6_5_m;
		self.vb_adls_per_addr_b1 := vb_adls_per_addr_b1;
		self.vb_adls_per_addr_b2 := vb_adls_per_addr_b2;
		self.vb_adls_per_addr := vb_adls_per_addr;
		self.vb_adls_per_addr_m := vb_adls_per_addr_m;
		self.v_ip_topDomain := v_ip_topDomain;
		self.v_in_AcqChannel := v_in_AcqChannel;
		self.v_ip_continent := v_ip_continent;
		self.v_ip_countrycode := v_ip_countrycode;
		self.v_ip_state := v_ip_state;
		self.vs_ipmatchcode_b1 := vs_ipmatchcode_b1;
		self.vs_ipmatchcode_b2 := vs_ipmatchcode_b2;
		self.vs_ipmatchcode_b6 := vs_ipmatchcode_b6;
		self.vs_ipmatchcode_b7 := vs_ipmatchcode_b7;
		self.vs_ipmatchcode := vs_ipmatchcode;
		self.vs_ipmatchcode_2 := vs_ipmatchcode_2;
		self.vs_ipmatchcode_m := vs_ipmatchcode_m;
		self.vs_ip_domain_GovMil := vs_ip_domain_GovMil;
		self.vb_ipmatchcode := vb_ipmatchcode;
		self.vb_ipmatchcode_m := vb_ipmatchcode_m;
		self.vb_ip_domain_b1 := vb_ip_domain_b1;
		self.vb_ip_domain := vb_ip_domain;
		self.vb_ip_domain_m := vb_ip_domain_m;
		self.email_provider := email_provider;
		self.email_provider2 := email_provider2;
		self.ist_bill_escore := ist_bill_escore;
		self.vs_email_score := vs_email_score;
		self.vs_email_score_m := vs_email_score_m;
		self.ist_bill_escore_2 := ist_bill_escore_2;
		self.vb_email_escore := vb_email_escore;
		self.vb_email_escore_m := vb_email_escore_m;
		self.vs_s_c_lowed := vs_s_c_lowed;
		self.vs_s_c_lowed_i := vs_s_c_lowed_i;
		self.vs_s_c_lowed_i_m := vs_s_c_lowed_i_m;
		self.vs_s_c_robbery := vs_s_c_robbery;
		self.vs_s_c_robbery_m := vs_s_c_robbery_m;
		self.vs_s_c_span_lang := vs_s_c_span_lang;
		self.vs_s_c_span_lang_m := vs_s_c_span_lang_m;
		self.vs_s_c_fammar_p := vs_s_c_fammar_p;
		self.hi_robbery := hi_robbery;
		self.hi_assault := hi_assault;
		self.hi_burglary := hi_burglary;
		self.hi_larceny := hi_larceny;
		self.hi_cartheft := hi_cartheft;
		self.vb_c_hi_crime := vb_c_hi_crime;
		self.vb_c_hi_crime_m := vb_c_hi_crime_m;
		self.vb_c_fammar_p := vb_c_fammar_p;
		self.vb_C_FAMMAR_P_lg := vb_C_FAMMAR_P_lg;
		self.rel_incomeunder25_count_pct := rel_incomeunder25_count_pct;
		self.rel_incomeover75_pct := rel_incomeover75_pct;
		self.rel_educationover12_pct := rel_educationover12_pct;
		self.rel_homeover300_pct := rel_homeover300_pct;
		self.rel_prop_owned_count_pct := rel_prop_owned_count_pct;
		self.rich_rel := rich_rel;
		self.rel_nice_house := rel_nice_house;
		self.no_rel_crims := no_rel_crims;
		self.close_rels := close_rels;
		self.rel_prop := rel_prop;
		self.poor_rels := poor_rels;
		self.smart_rels := smart_rels;
		self.no_rels := no_rels;
		self.vi_rels := vi_rels;
		self.vi_rels_m := vi_rels_m;
		self.vs_lname_match := vs_lname_match;
		self.vs_Dist_addraddr2 := vs_Dist_addraddr2;
		self.vs_Dist_addraddr2_lg := vs_Dist_addraddr2_lg;
		self.uv_billto := uv_billto;
		self.uv_instore := uv_instore;
		self.uv_dataset := uv_dataset;
		self.base := base;
		self.point := point;
		self.odds := odds;
		self.Shipto_log := Shipto_log;
		self.s_phat := s_phat;
		self.Shipto_Score_a := Shipto_Score_a;
		self.Shipto_Score := Shipto_Score;
		self.Billto_log := Billto_log;
		self.b_phat := b_phat;
		self.Billto_Score_a := Billto_Score_a;
		self.Billto_Score := Billto_Score;
		self.Instore_log := Instore_log;
		self.i_phat := i_phat;
		self.Instore_Score_a := Instore_Score_a;
		self.Instore_Score := Instore_Score;
		self.CDN908_1_0 := CDN908_1_0;
	#end


	end;

	model := join(ineasi, indata, left.bill_to_out.seq=(right.seq*2), doModel(left,right), left outer);


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


	#if(Risk_Indicators.iid_constants.validation_debug)
	Layout_debug fillReasons(layout_debug le, BTreasons rt) := TRANSFORM
	#else
	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
	self.ri := rt.ri;
	#end
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

	#if(Risk_Indicators.iid_constants.validation_debug)
		layout_debug fillReasons2(layout_debug le, STreasons rt) := TRANSFORM
	#else
		Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		self.ri := le.ri + rt.ri;
	#end
		self := le;
	END;
	STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(left,right), left outer);

	RETURN (STRecord);

END;
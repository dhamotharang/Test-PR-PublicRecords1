import risk_indicators, riskwise, easi, lib_date, ut;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];
nugen := true;

export FP3904_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam, integer num_reasons=6 ) := FUNCTION

	Models.Layout_ModelOut doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
		out_unit_desig					:=  le.Shell_Input.unit_desig;
		out_sec_range					:=  le.shell_input.sec_range;
		out_addr_type					:=  le.shell_input.addr_type;
		in_dob                          :=  le.shell_input.dob;
		in_state                        :=  le.shell_input.in_state;
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_phonevalflag                 :=  le.iid.phonevalflag;
		rc_hphonevalflag                :=  le.iid.hphonevalflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_hriskaddrflag                :=  (INTEGER)le.iid.hriskaddrflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_ssnvalflag                   :=  le.iid.socsvalflag;
		rc_pwssnvalflag                 :=  le.iid.pwsocsvalflag;
		rc_ssnhighissue                 :=  le.iid.soclhighissue;
		rc_ssnstate                     :=  le.iid.soclstate;
		rc_addrvalflag                  :=  le.iid.addrvalflag;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		rc_sources                      :=  le.iid.sources;
		rc_addrcommflag                 :=  le.iid.addrcommflag;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_hrisksicphone                :=  le.iid.hrisksicphone;
		rc_cityzipflag                  :=  le.iid.cityzipflag;
		combo_dobscore                  :=  le.iid.combo_dobscore;
		rc_watchlist_flag               :=  le.iid.watchlistHit;
		ssnlength                       :=  le.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.input_validation.dateofbirth;
		age                             :=  le.Name_Verification.age;
		add1_house_number_match         :=  le.Address_Verification.Input_Address_Information.house_number_match;
		add1_isbestmatch                :=  le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation    :=  le.AVM.Input_Address_Information.avm_automated_valuation;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		property_owned_total            :=  le.address_verification.owned.property_total;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		addrs_per_adl                   :=  le.velocity_counters.addrs_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		addrs_per_ssn                   :=  le.velocity_counters.addrs_per_ssn;
		adls_per_addr                   :=  le.velocity_counters.adls_per_addr;
		ssns_per_addr                   :=  le.velocity_counters.ssns_per_addr;
		ssns_per_adl_c6                 :=  le.velocity_counters.ssns_per_adl_created_6months;
		disposition                     :=  le.bjl.disposition;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		current_count                   :=  le.vehicles.current_count;
		historical_count                :=  le.vehicles.historical_count;
		wealth_index                    :=  trim(le.wealth_indicator);
		inferred_dob                    :=  le.reported_dob;
		archive_date                    :=  if(le.historydate = 999999, ut.GetDate, (string)le.historydate);
		truedid 	 			        :=  le.truedid;

		c_cartheft                      :=  ri.cartheft;
		//

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));


		// original code:
		// ==============
		// extreme_activity10 := ((ssns_per_adl > 10) or ((addrs_per_adl > 10) or ((addrs_per_adl > 10) or ((adlperssn_count > 10) or ((addrs_per_ssn > 10) or (((adls_per_addr > 10) and not(add_apt)) or (((adls_per_addr > 50) and add_apt) or (((ssns_per_addr > 10) and not(add_apt)) or ((ssns_per_addr > 50) and add_apt)))))))));
		// extreme_activity15 := ((ssns_per_adl > 15) or ((addrs_per_adl > 15) or ((addrs_per_adl > 15) or ((adlperssn_count > 15) or ((addrs_per_ssn > 15) or (((adls_per_addr > 15) and not(add_apt)) or (((adls_per_addr > 75) and add_apt) or (((ssns_per_addr > 15) and not(add_apt)) or ((ssns_per_addr > 75) and add_apt)))))))));
		// extreme_activity20 := ((ssns_per_adl > 20) or ((addrs_per_adl > 20) or ((addrs_per_adl > 20) or ((adlperssn_count > 20) or ((addrs_per_ssn > 20) or (((adls_per_addr > 20) and not(add_apt)) or (((adls_per_addr > 100) and add_apt) or (((ssns_per_addr > 20) and not(add_apt)) or ((ssns_per_addr > 100) and add_apt)))))))));
		// extreme_activity25 := ((ssns_per_adl > 25) or ((addrs_per_adl > 25) or ((addrs_per_adl > 25) or ((adlperssn_count > 25) or ((addrs_per_ssn > 25) or (((adls_per_addr > 25) and not(add_apt)) or (((adls_per_addr > 125) and add_apt) or (((ssns_per_addr > 25) and not(add_apt)) or ((ssns_per_addr > 125) and add_apt)))))))));
		// ==============

		// altered code:
		// =============
		isExtreme(integer num) := (
			ssns_per_adl > num
			or addrs_per_adl > num
			or addrs_per_adl > num
			or adlperssn_count > num
			or addrs_per_ssn > num
			or (adls_per_addr > num   and not add_apt)
			or (adls_per_addr > 5*num and     add_apt)
			or (ssns_per_addr > num   and not add_apt)
			or (ssns_per_addr > 5*num and     add_apt)
			);

		extreme_activity10 := isExtreme(10);
		extreme_activity15 := isExtreme(15);
		extreme_activity20 := isExtreme(20);
		extreme_activity25 := isExtreme(25);
		// ==============
		
		
		
		av_extreme :=  map(extreme_activity25 => 4,
						   extreme_activity20 => 3,
						   extreme_activity15 => 2,
						   extreme_activity10 => 1,
												 0);

		contrary_ssn := (nas_summary in [1]);
		verfst_s     := (INTEGER)(nas_summary in [2, 3, 4, 8, 9, 10, 12]);
		verlst_s     := (INTEGER)(nas_summary in [2, 5, 7, 8, 9, 11, 12]);
		veradd_s     := (INTEGER)(nas_summary in [3, 5, 6, 8, 10, 11, 12]);
		verssn_s     := (INTEGER)(nas_summary in [4, 6, 7, 9, 10, 11, 12]);
		ver_nas479   := (INTEGER)(nas_summary in [4, 7, 9]);
		
		contrary_phn := (INTEGER)(nap_summary in [1]);
		verfst_p     := (INTEGER)(nap_summary in [2, 3, 4, 8, 9, 10, 12]);
		verlst_p     := (INTEGER)(nap_summary in [2, 5, 7, 8, 9, 11, 12]);
		veradd_p     := (INTEGER)(nap_summary in [3, 5, 6, 8, 10, 11, 12]);
		verphn_p     := (INTEGER)(nap_summary in [4, 6, 7, 9, 10, 11, 12]);
                  
		nas_sum := sum(verfst_s, verlst_s, veradd_s, verssn_s);
		nap_sum := sum(verfst_p, verlst_p, veradd_p, verphn_p);
		av_verx :=  map((nas_sum = 4) and (nap_sum = 4) => 3,
						(nas_sum = 4) or (nap_sum = 4)  => 2,
						(nas_sum = 3) or (nap_sum = 3)  => 1,
														   0);

		av_verx_2     :=  if(combo_dobscore = 100, (av_verx + 1), av_verx);
		source_tot_DS := (contains_i(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS') > 0);
		ssn_priordob  := (((INTEGER)rc_ssndobflag = 1) or ((INTEGER)rc_pwssndobflag = 1));
		ssn_inval     := (((INTEGER)rc_ssnvalflag = 1) or ((INTEGER)rc_pwssnvalflag in [1, 2, 3]));
		ssn_deceased  := (rc_decsflag or source_tot_ds);
		ssn_statediff := (StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT)));
		ssn_adl_prob  := ((ssns_per_adl = 0) or ((ssns_per_adl >= 3) or (ssns_per_adl_c6 >= 2)));
		av_ssn_prob   :=  map(ssn_priordob or (ssn_inval or ssn_deceased) => 2,
							ssn_statediff  or ssn_adl_prob                => 1,
																		   0);

		av_verx_3 :=  if(av_ssn_prob = 0, (av_verx_2 + 1), av_verx_2);

		current_date := Lib_Date.DaysSince1900((integer)archive_date[1..4], (integer)archive_date[5..6], 1)
		              - Lib_Date.DaysSince1900(1960, 1, 1);

		inferred_date :=  if(inferred_dob != 0,
				Lib_Date.DaysSince1900((integer)((string)inferred_dob)[1..4], 1, 1) - Lib_Date.DaysSince1900(1960, 1, 1),
				-9999 /* indicates missing */ );

		combo_age :=  map(
			age > 0                => age,
			inferred_date != -9999 => ((current_date - inferred_date) / 365.25),
			-1
		);

		av_combo_age :=  map(not(truedid)    => -1,
							 combo_age = -1  => 0,
							 combo_age <= 40 => 1,
												2);

		av_add1_naprop :=  map(add1_naprop = 4          => 4,
							   property_owned_total > 0 => 3,
							   add1_naprop in [2, 3]    => 2,
							   add1_naprop = 0          => 1,
														   0);

		av_add1_match :=  map(add1_isbestmatch and add1_house_number_match => 2,
							  add1_isbestmatch or add1_house_number_match  => 1,
																			  0);

		av_add1_sum := sum(av_add1_naprop, av_add1_match);

		lien_rec_unrel_flag  := (liens_recent_unreleased_count > 0);
		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

		av_lien_unrel :=  map(lien_rec_unrel_flag and lien_hist_unrel_flag => 2,
							  lien_rec_unrel_flag or lien_hist_unrel_flag  => 1,
																			  0);

		av_bk_status :=  map(contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARGE') > 0 => 1,
							 StringLib.StringToUpperCase(disposition) = 'DISMISSED'                => 2,
																				 0);

		av_wealth_index_5 := min((integer)wealth_index, 5);

		av_vehx :=  map((current_count > 0) and (historical_count > 0) => 2,
						(current_count > 0) or (historical_count > 0)  => 1,
																		  0);

		av_rich_house := (INTEGER)(add1_avm_automated_valuation >= 250000);

		av_c_cartheft_flag := (INTEGER)((integer)c_cartheft > 180);

		av_extreme_m :=  case(av_extreme,
			0 => 0.2293729373,
			1 => 0.2631578947,
			2 => 0.3080168776,
			3 => 0.3904761905,
			     0.462962963);

		av_verx_m :=  case(av_verx_3,
			0 => 0.6615384615,
			1 => 0.5692307692,
			2 => 0.3475609756,
			3 => 0.2892376682,
			4 => 0.2059748428,
			     0.1392405063);

		av_combo_age_m :=  case(av_combo_age,
			-1 => 0.6363636364,
			0  => 0.38,
			1  => 0.2990196078,
			      0.1880165289);

		av_add1_sum_m :=  case(av_add1_sum,
			0 => 0.5187969925,
			1 => 0.4466666667,
			2 => 0.3441558442,
			3 => 0.2448979592,
			4 => 0.2222222222,
			5 => 0.1818181818,
			     0.144092219);

		av_lien_unrel_m :=  case(av_lien_unrel,
			0 => 0.2398871119,
			1 => 0.3782051282,
			     0.4375);

		av_bk_status_m :=  case(av_bk_status,
			0 => 0.2850041425,
			1 => 0.2191780822,
			     0.5517241379);

		av_wealth_index_5_m :=  case(av_wealth_index_5,
			1 => 0.4736842105,
			2 => 0.3196202532,
			3 => 0.2962138085,
			4 => 0.2284866469,
			     0.1243781095);

		av_vehx_m :=  case(av_vehx,
			0 => 0.4430894309,
			1 => 0.3111111111,
			0.2248322148);

		score_log := -7.84530547 +
			(av_extreme_m * 3.2579501417) +
			(av_verx_m * 1.9198777159) +
			(av_combo_age_m * 2.1717804278) +
			(av_add1_sum_m * 1.8702261172) +
			(av_lien_unrel_m * 5.7150426961) +
			(av_bk_status_m * 4.0367209466) +
			(av_wealth_index_5_m * 2.5343605744) +
			(av_vehx_m * 2.6584981506) +
			(av_rich_house * -0.671337845) +
			(av_c_cartheft_flag * 0.638052856);

		base  := 700;
		point := -50;
		odds  := .28041;
		phat  := (exp(score_log) / (1 + exp(score_log)));
		fp3   := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));
		fp3_2 := max(250, min(999, fp3));

		ssnhighissue_yr :=  if(
			trim(rc_ssnhighissue) not in ['','0'], // not missing and not zero
			Lib_Date.DaysSince1900((integer)((string)rc_ssnhighissue)[1..4], (integer)((string)rc_ssnhighissue)[5..6], 1) - Lib_Date.DaysSince1900(1960, 1, 1),
			-9999
		);

		dob_yr :=  if( trim(in_dob) not in ['','0'], Lib_Date.DaysSince1900((integer)((string)in_dob)[1..4], (integer)((string)in_dob)[5..6], 1) - Lib_Date.DaysSince1900(1960, 1, 1), -9999);

		easy_cutoff     := 695;
		moderate_cutoff := 650;
		harsh_cutoff    := 695;

		cap_ssnver2           :=  if(nas_summary < 10, easy_cutoff, 999);
		cap_ssnver3           :=  if(verssn_s = 0, moderate_cutoff, 999);
		cap_disc              :=  if(verphn_p = 0 and (INTEGER)rc_hriskphoneflag = 5, moderate_cutoff, 999);
		cap_phninval          :=  if(verphn_p = 0 and ((INTEGER)rc_phonevalflag = 0 or (INTEGER)rc_hphonevalflag = 0), harsh_cutoff, 999);
		cap_hr_phn            :=  if((INTEGER)rc_hriskphoneflag = 6 or (INTEGER)rc_hphonevalflag = 3 or (INTEGER)rc_hrisksicphone = 2225, harsh_cutoff, 999);
		cap_busphone          :=  if(verphn_p = 0 and (INTEGER)rc_hphonevalflag = 1, moderate_cutoff, 999);      
		cap_pzipmis1          :=  if(verphn_p = 0 and (INTEGER)rc_phonezipflag  = 1, moderate_cutoff, 999);
		cap_pzipmis2          :=  if(verphn_p = 1 and (INTEGER)rc_phonezipflag  = 1, moderate_cutoff, 999);
		cap_notdeliverable    :=  if(rc_addrvalflag != 'V', harsh_cutoff, 999);
		cap_city_zip_mismatch :=  if((INTEGER)rc_cityzipflag = 1, moderate_cutoff, 999);
		cap_hr_addr           :=  if((INTEGER)rc_hriskaddrflag = 4 or (INTEGER)rc_addrcommflag in [1, 2], moderate_cutoff, 999);
		cap_corrections       :=  if(rc_hrisksic = 2225, harsh_cutoff, 999);
		
		
		cap_ssnprob := if( 
			(INTEGER)ssnlength>0 and
			(
				rc_decsflag
				or not ((INTEGER)rc_ssnvalflag in [0,3] or ((INTEGER)rc_ssnvalflag = 2 and (INTEGER)ssnlength = 4))
				or (INTEGER)rc_pwssnvalflag in [1, 2, 3]
				or ( dobpop=1 and rc_ssndobflag=1 )
			),
			harsh_cutoff,
			999
		);
		
		cap_velo_ssns_per_adl_c6 :=  if(ssns_per_adl_c6 >= 2, moderate_cutoff, 999);
		cap_velo_adls_per_addr :=  if((rc_dwelltype != 'A') and (adls_per_addr >= 25), moderate_cutoff, 999);
		cap_adlperssn :=  if(adlperssn_count >= 6, harsh_cutoff, 999);
		cap_watchlist :=  if(rc_watchlist_flag, moderate_cutoff, 999);

		// per Eric Graves, because dob_yr and/or ssnhighissue_yr could be missing (which have been translated to = -9999 in ECL),
		// this override "should only be tripped if all conditions are present and none of the variables are missing"
		cap_dobmismatch :=  if( dob_yr != -9999 and ssnhighissue_yr != -9999 and dob_yr - ssnhighissue_yr > 0, harsh_cutoff, 999 );

		fp3904_1_0 := min(fp3_2, cap_ssnver2, cap_ssnver3, cap_disc, cap_phninval, cap_hr_phn, cap_busphone, cap_pzipmis1, cap_pzipmis2, cap_notdeliverable, cap_city_zip_mismatch, cap_hr_addr, cap_corrections, cap_ssnprob, cap_velo_ssns_per_adl_c6, cap_velo_adls_per_addr, cap_adlperssn, cap_watchlist, cap_dobmismatch);

		ritmp := riskwise.bdReasonCodesConsumer2( le, blank_ip, num_reasons, nugen );

		// If no reason codes are triggered and the score being returned is less than 800, return RC 34 - Per Bug 92594.
		reasons := Models.Common.checkFraudPointRC34(fp3904_1_0, ritmp, num_reasons);

		self.seq   := le.seq;
		self.ri    := reasons;
		self.score := (string3)fp3904_1_0;
	END;

	model := join(clam, easi.Key_Easi_Census,
				keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(left,right),
				left outer);


	return model;
END;
import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVP1208_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION

  RVP_DEBUG := false;

  #if(RVP_DEBUG)
    layout_debug := record
				integer sysdate                          ; //sysdate;
				integer _reported_dob                    ; //_reported_dob;
				integer reported_age                     ; //reported_age;
				integer iv_combined_age                  ; //iv_combined_age;
				string iv_high_risk_phone               ; //iv_high_risk_phone;
				integer inp_addr_fips_fall               ; //inp_addr_fips_fall;
				integer inp_addr_avm_auto_val            ; //inp_addr_avm_auto_val;
				real iv_inp_addr_fips_ratio           ; //iv_inp_addr_fips_ratio;
				integer iv_bst_own_prop_x_addr_naprop    ; //iv_bst_own_prop_x_addr_naprop;
				integer iv_property_sold_total           ; //iv_property_sold_total;
				integer iv_addrs_per_adl                 ; //iv_addrs_per_adl;
				integer iv_phones_per_adl                ; //iv_phones_per_adl;
				integer iv_invalid_addrs_per_adl         ; //iv_invalid_addrs_per_adl;
				integer _infutor_first_seen              ; //_infutor_first_seen;
				integer iv_mos_since_infutor_first_seen  ; //iv_mos_since_infutor_first_seen;
				integer iv_impulse_count                 ; //iv_impulse_count;
				integer iv_attr_unrel_liens_recency      ; //iv_attr_unrel_liens_recency;
				integer iv_eviction_count                ; //iv_eviction_count;
				string iv_bk_disposition_lvl            ; //iv_bk_disposition_lvl;
				string iv_ams_college_type              ; //iv_ams_college_type;
				integer iv_prof_license_flag             ; //iv_prof_license_flag;
				integer iv_wealth_index                  ; //iv_wealth_index;
				real subscore0                        ; //subscore0;
				real subscore1                        ; //subscore1;
				real subscore2                        ; //subscore2;
				real subscore3                        ; //subscore3;
				real subscore4                        ; //subscore4;
				real subscore5                        ; //subscore5;
				real subscore6                        ; //subscore6;
				real subscore7                        ; //subscore7;
				real subscore8                        ; //subscore8;
				real subscore9                        ; //subscore9;
				real subscore10                       ; //subscore10;
				real subscore11                       ; //subscore11;
				real subscore12                       ; //subscore12;
				real subscore13                       ; //subscore13;
				real subscore14                       ; //subscore14;
				real subscore15                       ; //subscore15;
				real rawscore                         ; //rawscore;
				real lnoddsscore                      ; //lnoddsscore;
				real probscore                        ; //probscore;
				boolean ssn_deceased                     ; //ssn_deceased;
				boolean uv_rv20_content                  ; //uv_rv20_content;
				boolean uv_gong_sourced                  ; //uv_gong_sourced;
				boolean uv_eq_only                       ; //uv_eq_only;
				boolean uv_rvp1003_content               ; //uv_rvp1003_content;
				integer base                             ; //base;
				integer point                            ; //point;
				real odds                             ; //odds;
				integer rvp1208_1_0                      ; //rvp1208_1_0;
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
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ssnlength                        := (integer)le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		impulse_count                    := le.impulse.count;
		attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
		attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
		attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
		attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
		attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
		attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_eviction_count              := le.bjl.eviction_count;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := (integer)le.student.age;
		ams_college_type                 := le.student.college_type;
		ams_file_type                    := le.student.file_type;
		prof_license_flag                := le.professional_license.professional_license_flag;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := (integer)le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
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

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	iv_combined_age := map(
			not(truedid or dobpop) => NULL,
			age > 0                => age,
			input_dob_age > 0      => input_dob_age,
			inferred_age > 0       => inferred_age,
			reported_age > 0       => reported_age,
			ams_age > 0            => ams_age,
																-1);

	iv_high_risk_phone := map(
			not(hphnpop)                                                                                         => '             ',
			(rc_hriskphoneflag in ['5', '6']) or (rc_hphonetypeflag in ['5', '6', '7', '8', '9', 'A', 'B', 'U']) => 'Oth High Risk',
			(rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3'])                     => 'Cell/Mobile  ',
			rc_hriskphoneflag = '4' or rc_hphonetypeflag = '4'                                                     => 'Oth Non-POTS ',
			rc_hriskphoneflag = '0' or rc_hphonetypeflag = '0'                                                     => 'Not High Risk',
																																																							'             ');

	inp_addr_fips_fall := map(
			add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
			add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
			add1_avm_med_fips > 0  => add1_avm_med_fips,
																0);

	inp_addr_avm_auto_val := add1_avm_automated_valuation;

	iv_inp_addr_fips_ratio := map(
			not(add1_pop)          => NULL,
			inp_addr_fips_fall > 0 => inp_addr_avm_auto_val / inp_addr_fips_fall,
																-1);

	iv_bst_own_prop_x_addr_naprop_c6 := if(property_owned_total > 0, add1_naprop + 10, add1_naprop);

	iv_bst_own_prop_x_addr_naprop_c7 := if(property_owned_total > 0, add2_naprop + 10, add2_naprop);

	iv_bst_own_prop_x_addr_naprop := map(
			not(truedid)     => NULL,
			add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c6,
													iv_bst_own_prop_x_addr_naprop_c7);

	iv_property_sold_total := if(not(truedid or add1_pop), NULL, property_sold_total);

	iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

	iv_phones_per_adl := if(not(truedid), NULL, phones_per_adl);

	iv_invalid_addrs_per_adl := if(not(truedid), NULL, invalid_addrs_per_adl);

	_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.
	iv_mos_since_infutor_first_seen := map(
			not(hphnpop)                    => NULL,
			not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
																				 -1);

	iv_impulse_count := if(not(truedid), NULL, impulse_count);

	iv_attr_unrel_liens_recency := map(
			not(truedid)                          => NULL,
			attr_num_unrel_liens30 > 0            => 1,
			attr_num_unrel_liens90 > 0            => 3,
			attr_num_unrel_liens180 > 0           => 6,
			attr_num_unrel_liens12 > 0            => 12,
			attr_num_unrel_liens24 > 0            => 24,
			attr_num_unrel_liens36 > 0            => 36,
			attr_num_unrel_liens60 > 0            => 60,
			liens_historical_unreleased_ct > 0    => 99,
																						   0);

	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

	iv_bk_disposition_lvl := map(
			not(truedid or ssnlength > 0)                                                                                               => '          ',
			(disposition in ['Discharge NA', 'Discharged'])                                                                             => 'Discharged',
			(disposition in ['Dismissed'])                                                                                              => 'Dismissed ',
			(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => 'OtherBK  ',
																																																																		 'No BK');

	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.
	iv_ams_college_type := map(
			not(truedid)            => '  ',
			ams_college_type = ''   => '-1',
																 ams_college_type);

	iv_prof_license_flag := if(not(truedid), NULL, (integer)prof_license_flag);

	iv_wealth_index := if(not(truedid), NULL, (integer)wealth_index);

	subscore0 := map(
			NULL < iv_combined_age AND iv_combined_age < 13 => -0.000000,
			13 <= iv_combined_age AND iv_combined_age < 44  => -0.595203,
			44 <= iv_combined_age AND iv_combined_age < 56  => -0.104481,
			56 <= iv_combined_age AND iv_combined_age < 62  => 0.683752,
			62 <= iv_combined_age                           => 0.826601,
																												 -0.000000);

	subscore1 := map(
			NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 3 => 1.254465,
			3 <= iv_addrs_per_adl AND iv_addrs_per_adl < 5   => 0.367545,
			5 <= iv_addrs_per_adl AND iv_addrs_per_adl < 15  => -0.098667,
			15 <= iv_addrs_per_adl                           => -0.394195,
																													-0.000000);

	subscore2 := map(
			NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 0 => 0.394737,
			0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 36  => -0.413722,
			36 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 74 => -0.189253,
			74 <= iv_mos_since_infutor_first_seen                                          => 0.180615,
																																												0.000000);

	subscore3 := map(
			(iv_bst_own_prop_x_addr_naprop in [0])          => -0.257336,
			(iv_bst_own_prop_x_addr_naprop in [1, 11])      => 0.002368,
			(iv_bst_own_prop_x_addr_naprop in [2, 3, 4])    => 0.304968,
			(iv_bst_own_prop_x_addr_naprop in [10, 12, 13]) => 0.512111,
			(iv_bst_own_prop_x_addr_naprop in [14])         => 0.539274,
																												 0.000000);

	subscore4 := map(
			NULL < iv_impulse_count AND iv_impulse_count < 1 => 0.098668,
			1 <= iv_impulse_count                            => -1.021357,
																													-0.000000);

	subscore5 := map(
			NULL < iv_wealth_index AND iv_wealth_index < 1 => 0.083306,
			1 <= iv_wealth_index AND iv_wealth_index < 2   => -0.651214,
			2 <= iv_wealth_index AND iv_wealth_index < 3   => -0.454653,
			3 <= iv_wealth_index AND iv_wealth_index < 4   => 0.000274,
			4 <= iv_wealth_index AND iv_wealth_index < 5   => 0.127783,
			5 <= iv_wealth_index                           => 1.134029,
																												0.000000);

	subscore6 := map(
			(iv_high_risk_phone in ['Other'])                        => -0.000000,
			(iv_high_risk_phone in ['Cell/Mobile', 'Not High Risk']) => 0.119210,
			(iv_high_risk_phone in ['Oth High Risk'])                => -0.679859,
																																	-0.000000);

	subscore7 := map(
			NULL < iv_attr_unrel_liens_recency AND iv_attr_unrel_liens_recency < 1 => 0.125444,
			1 <= iv_attr_unrel_liens_recency AND iv_attr_unrel_liens_recency < 12  => -0.831541,
			12 <= iv_attr_unrel_liens_recency AND iv_attr_unrel_liens_recency < 60 => -0.416858,
			60 <= iv_attr_unrel_liens_recency                                      => -0.080634,
																																								0.000000);

	subscore8 := map(
			(iv_bk_disposition_lvl in ['Other'])            => -0.000000,
			(iv_bk_disposition_lvl in ['Discharged'])       => 0.632479,
			(iv_bk_disposition_lvl in ['No BK', 'OtherBK']) => -0.045223,
			(iv_bk_disposition_lvl in ['Dismissed'])        => -0.149757,
																												 -0.000000);

	subscore9 := map(
			NULL < iv_invalid_addrs_per_adl AND iv_invalid_addrs_per_adl < 3 => 0.066557,
			3 <= iv_invalid_addrs_per_adl AND iv_invalid_addrs_per_adl < 4   => -0.081670,
			4 <= iv_invalid_addrs_per_adl                                    => -0.382640,
																																					0.000000);

	subscore10 := map(
			NULL < iv_prof_license_flag AND iv_prof_license_flag < 1 => -0.030990,
			1 <= iv_prof_license_flag                                => 0.756574,
																																	0.000000);

	subscore11 := map(
			(iv_ams_college_type in ['Other'])            => -0.000000,
			(iv_ams_college_type in ['-1'])               => -0.025251,
			(iv_ams_college_type in ['P', 'R', 'S', 'U']) => 0.719295,
																											 -0.000000);

	subscore12 := map(
			NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.052450,
			1 <= iv_eviction_count                             => -0.429059,
																														0.000000);

	subscore13 := map(
			NULL < iv_phones_per_adl AND iv_phones_per_adl < 1 => -0.047062,
			1 <= iv_phones_per_adl AND iv_phones_per_adl < 2   => 0.158753,
			2 <= iv_phones_per_adl AND iv_phones_per_adl < 3   => -0.254336,
			3 <= iv_phones_per_adl                             => -0.410193,
																														0.000000);

	subscore14 := map(
			NULL < iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio < 0 => -0.180471,
			0 <= iv_inp_addr_fips_ratio AND iv_inp_addr_fips_ratio < 1   => 0.021437,
			1 <= iv_inp_addr_fips_ratio                                  => 0.245318,
																																			0.000000);

	subscore15 := map(
			NULL < iv_property_sold_total AND iv_property_sold_total < 1 => -0.029087,
			1 <= iv_property_sold_total                                  => 0.304960,
																																			-0.000000);

	rawscore := if(max(subscore0, subscore1, subscore2, subscore3, subscore4, subscore5, subscore6, subscore7, subscore8, subscore9, subscore10, subscore11, subscore12, subscore13, subscore14, subscore15) = NULL, NULL, sum(if(subscore0 = NULL, 0, subscore0), if(subscore1 = NULL, 0, subscore1), if(subscore2 = NULL, 0, subscore2), if(subscore3 = NULL, 0, subscore3), if(subscore4 = NULL, 0, subscore4), if(subscore5 = NULL, 0, subscore5), if(subscore6 = NULL, 0, subscore6), if(subscore7 = NULL, 0, subscore7), if(subscore8 = NULL, 0, subscore8), if(subscore9 = NULL, 0, subscore9), if(subscore10 = NULL, 0, subscore10), if(subscore11 = NULL, 0, subscore11), if(subscore12 = NULL, 0, subscore12), if(subscore13 = NULL, 0, subscore13), if(subscore14 = NULL, 0, subscore14), if(subscore15 = NULL, 0, subscore15)));

	lnoddsscore := rawscore + 0.128563;

	probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ','); // > 0;

	uv_rv20_content := nas_summary > 4 or nap_summary > 4 or add1_naprop > 2;

	uv_gong_sourced := (nap_summary in [2, 3, 5, 6, 7, 8, 9, 10, 11, 12]);

	uv_eq_only := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EQ', ',') and 
						Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') = 1 and 
						not uv_gong_sourced;

	uv_rvp1003_content := (uv_rv20_content or 
		uv_gong_sourced or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EM', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'VO', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'V', ',') or 
		add1_naprop > 2 or prof_license_flag or add1_avm_land_use != '' or 
		trim(ams_file_type, LEFT, RIGHT) != '' or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EB', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'W', ',') or 
		watercraft_count > 0 or 
		if(max(property_owned_total, property_sold_total) = NULL, NULL, 
		sum(if(property_owned_total = NULL, 0, property_owned_total), 
		if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 
		
		90 <= combo_dobscore AND combo_dobscore <= 100 or 
		(integer)input_dob_match_level >= 7 or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') or 
		liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or 
		criminal_count > 0 or (rc_bansflag in ['1', '2']) or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') or 
		bankrupt or 
		filing_count > 0 or 
		bk_recent_count > 0 or 
		rc_decsflag = '1' or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or 
		truedid)
		
		and not uv_eq_only
		and truedid;;

	base := 700;

	point := 40;

	odds := (1 - .4735) / .4735;

	rvp1208_1_0 := map(
			ssn_deceased           => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)     => 222,
																min(if(max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

	#if(RVP_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_high_risk_phone               := iv_high_risk_phone;
		self.inp_addr_fips_fall               := inp_addr_fips_fall;
		self.inp_addr_avm_auto_val            := inp_addr_avm_auto_val;
		self.iv_inp_addr_fips_ratio           := iv_inp_addr_fips_ratio;
		self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
		self.iv_property_sold_total           := iv_property_sold_total;
		self.iv_addrs_per_adl                 := iv_addrs_per_adl;
		self.iv_phones_per_adl                := iv_phones_per_adl;
		self.iv_invalid_addrs_per_adl         := iv_invalid_addrs_per_adl;
		self._infutor_first_seen              := _infutor_first_seen;
		self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;
		self.iv_impulse_count                 := iv_impulse_count;
		self.iv_attr_unrel_liens_recency      := iv_attr_unrel_liens_recency;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_bk_disposition_lvl            := iv_bk_disposition_lvl;
		self.iv_ams_college_type              := iv_ams_college_type;
		self.iv_prof_license_flag             := iv_prof_license_flag;
		self.iv_wealth_index                  := iv_wealth_index;
		self.subscore0                        := subscore0;
		self.subscore1                        := subscore1;
		self.subscore2                        := subscore2;
		self.subscore3                        := subscore3;
		self.subscore4                        := subscore4;
		self.subscore5                        := subscore5;
		self.subscore6                        := subscore6;
		self.subscore7                        := subscore7;
		self.subscore8                        := subscore8;
		self.subscore9                        := subscore9;
		self.subscore10                       := subscore10;
		self.subscore11                       := subscore11;
		self.subscore12                       := subscore12;
		self.subscore13                       := subscore13;
		self.subscore14                       := subscore14;
		self.subscore15                       := subscore15;
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.ssn_deceased                     := ssn_deceased;
		self.uv_rv20_content                  := uv_rv20_content;
		self.uv_gong_sourced                  := uv_gong_sourced;
		self.uv_eq_only                       := uv_eq_only;
		self.uv_rvp1003_content               := uv_rvp1003_content;
		self.base                             := base;
		self.point                            := point;
		self.odds                             := odds;
		self.rvp1208_1_0                      := rvp1208_1_0;
	#end

	self.seq := le.seq;
	PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
	self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1208_1_0 );
	self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );
END;


	model := project( clam, doModel(left) );
	return model;
END;
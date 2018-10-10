import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVR711_0_0(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	boolean isCalifornia,
	boolean useRcSetV1 = false
) := FUNCTION

temp := record
	layout_modelout;
	
	#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;
		real	ModRVR_vermod	;
		real	nap_ver_level_m	;
		real	_source_tot_P	;
		real	_source_tot_PL	;
		real	_source_lname_W	;
		real	_source_addr_WP	;
		real	_source_namefcraNeg_f	;
		real	ModRVR_fpmod	;
		real	standardization_level	;
		real	phone_zip_mismatch	;
		real	disconnect_level	;
		real	pnotpots	;
		real	ssnprior	;
		real	_ssns_per_adl_l	;
		real	_addrs_per_adl_l	;
		real	_adlperssn_count_l	;
		real	_ssns_per_addr_l	;
		real	_phones_per_addr_l	;
		real	_adls_per_phone_l	;
		real	age_dob2	;
		real	add1_naprop_level_m	;
		real	_avm1	;
		real	_add1_avm_med_fips_ratiobel	;
		real	_rc_phoneType_i_m	;
		real	_ssnlowissue_dob_diff_i_l	;
		real	_lienCriminalBK_i_l	;
		real	age_ssn_issue2	;
		real	_add1_avm_sales_price_m	;
	#end

end;

	temp doModel(clam le) := transform

		/* Input */
		out_addr_status                  := le.address_validation.error_codes;
		in_dob                          :=  trim(le.shell_input.dob);
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  trim(le.iid.hriskphoneflag);
		rc_hphonetypeflag               :=  StringLib.StringToUppercase(le.iid.hphonetypeflag);
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_ssnlowissue                  :=  (STRING)le.SSN_Verification.Validation.low_issue_date;
		rc_ssnhighissue                 :=  le.iid.soclhighissue;
		rc_dwelltype                    :=  StringLib.StringToUpperCase(trim(le.address_validation.dwelling_type));
		rc_sources                      :=  le.iid.sources;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_phonetype                    :=  trim(le.iid.phonetype);
		combo_hphonescore               :=  le.iid.combo_hphonescore;
		fname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.firstnamesources));
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.lastnamesources));
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
		addrpop                         :=  le.input_validation.address;
		ssnlength                       :=  le.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.input_validation.dateofbirth;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		add1_address_score              :=  le.address_verification.input_address_information.address_score;
		add1_isbestmatch                :=  le.address_verification.input_address_information.isbestmatch;
		add1_avm_sales_price            :=  (UNSIGNED)le.avm.input_address_information.avm_sales_price;
		add1_avm_automated_valuation    :=  le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips               :=  le.avm.input_address_information.avm_median_fips_level;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		property_owned_total            :=  le.address_verification.owned.property_total;
		property_sold_total             :=  le.address_verification.sold.property_total;
		property_ambig_total            :=  le.address_verification.ambiguous.property_total;
		add2_isbestmatch                :=  le.address_verification.address_history_1.isbestmatch;
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add3_naprop                     :=  le.address_verification.address_history_2.naprop;
		telcordia_type                  :=  le.phone_verification.telcordia_type;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		addrs_per_adl                   :=  le.velocity_counters.addrs_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		ssns_per_addr                   :=  le.velocity_counters.ssns_per_addr;
		phones_per_addr                 :=  le.velocity_counters.phones_per_addr;
		adls_per_phone                  :=  le.velocity_counters.adls_per_phone;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		archive_date                    :=  le.historydate;
		/******************************/


		/* HELPERS */
		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		/***********/



		arcdate := if( archive_date = 999999, (STRING8)Std.Date.Today(), (STRING)archive_date );
		year := (INTEGER)arcdate[1..4];

		ssn479 := nas_summary in [4,7,9];

		contrary_phone := (nap_summary=1);

		verfst_p := (nap_summary in [2,3,4,8,9,10,12]);
		verlst_p := (nap_summary in [2,5,7,8,9,11,12]);
		veradd_p := (nap_summary in [3,5,6,8,10,11,12]);
		verphn_p := (nap_summary in [4,6,7,9,10,11,12]);

		stolen_id_ap := (nap_summary = 6);

		nap_ver_level := map( 
			verphn_p and verlst_p and veradd_p and verfst_p =>  3,
			verphn_p and verlst_p                           =>  2,
			verphn_p and stolen_id_ap                       =>  1,
			contrary_phone                                  => -1,
			verphn_p                                        =>  2,
			0
		);

		_source_tot_P  := contains_i(rc_sources,'P ');
		_source_tot_PL := contains_i(rc_sources,'PL');

		_source_lname_W := contains_i(lname_sources, 'W ');
		_source_addr_WP := contains_i(addr_sources,  'WP');

		_source_fname_AK := contains_i(fname_sources, 'AK');
		_source_fname_BA := contains_i(fname_sources, 'BA');
		_source_fname_CO := contains_i(fname_sources, 'CO');
		_source_fname_DS := contains_i(fname_sources, 'DS');
		_source_fname_FF := contains_i(fname_sources, 'FF');
		_source_fname_L2 := contains_i(fname_sources, 'L2');
		_source_fname_LI := contains_i(fname_sources, 'LI');
		_source_lname_AK := contains_i(lname_sources, 'AK');
		_source_lname_BA := contains_i(lname_sources, 'BA');
		_source_lname_CO := contains_i(lname_sources, 'CO');
		_source_lname_DS := contains_i(lname_sources, 'DS');
		_source_lname_FF := contains_i(lname_sources, 'FF');
		_source_lname_L2 := contains_i(lname_sources, 'L2');
		_source_lname_LI := contains_i(lname_sources, 'LI');

		_source_fnamefcraNeg := _source_fname_AK+_source_fname_BA+_source_fname_CO+_source_fname_DS+
								_source_fname_FF+_source_fname_L2+_source_fname_LI;

		_source_lnamefcraNeg := _source_lname_AK+_source_lname_BA+_source_lname_CO+_source_lname_DS+
								_source_lname_FF+_source_lname_L2+_source_lname_LI;

		_source_fnamefcraNeg_f :=(INTEGER)(_source_fnamefcraNeg>0);

		_source_lnamefcraNeg_f :=(INTEGER)(_source_lnamefcraNeg>0);

		_source_namefcraNeg_f := mymax(_source_fnamefcraNeg_f,_source_lnamefcraNeg_f);


		add1_address100 := (add1_address_score >= 40 and add1_address_score <= 100);
		phone_score := combo_hphonescore;

		phone100 := (phone_score >= 80 and phone_score <= 100);

     
		if add1_isbestmatch then
			/* Declarations to suppress conditional assignment warning: */
			nap_ver_level_b  := -1;
			verx_b           := -1;
			verx_b_m         := -1;
			score_combo_b    := -1;
			score_combo_b_m  := -1;
			/************/
			

			nap_ver_level_m := map( 
				nap_ver_level = -1 => 0.1119592875,
				nap_ver_level = 0 => 0.0936495177,
				nap_ver_level = 1 => 0.0857306426,
				nap_ver_level = 2 => 0.0673460956,
				0.0543933054
			);


			ModRVR_vermod_a := -3.506553456
				+ nap_ver_level_m  * 13.481798192
				+ _source_tot_P  * -0.835117922
				+ _source_tot_PL  * -0.987115785
				+ _source_lname_W  * -0.769437926
				+ _source_addr_WP  * -0.276111423
				+ _source_namefcraNeg_f  * 0.8576008229
			;
			ModRVR_vermod := 100 * ( (exp(ModRVR_vermod_a)) / (1+exp(ModRVR_vermod_a)) );

		else
			/* Declarations to suppress conditional assignment warning: */
			nap_ver_level_m := -1;
			/************/


			nap_ver_level_b := map( 
				 verphn_p and verlst_p => 2,
				~verlst_p and veradd_p => 0,
				contrary_phone         => 0,
				1
			);

			verx_b := map( 
				nap_ver_level_b = 0 and ssn479 => 0,
				nap_ver_level_b = 1 and ssn479 => 1,
				nap_ver_level_b = 2 and ssn479 => 2,
				nap_ver_level_b = 0            => 2,
				nap_ver_level_b = 1            => 2,
				3
			);
                                   
			verx_b_m := map( 
				verx_b = 0 => 0.1585772508,
				verx_b = 1 => 0.1390512204,
				verx_b = 2 => 0.1032511611,
				0.0735502122
			);

			score_combo_b := map( 
				add1_address100 and phone100 => 2,
				add1_address100 or phone100 => 1,
				0
			);

			score_combo_b_m := map( 
				score_combo_b = 0 => 0.1335559265,
				score_combo_b = 1 => 0.1220300125,
				0.0975978498
			);


			ModRVR_vermod_a := -3.583482663
				+ verx_b_m  * 5.8394538238
				+ score_combo_b_m  * 5.8352553562
				+ (INTEGER)add2_isbestmatch  * 0.2328932304
				+ _source_tot_P  * -0.77050907
				+ _source_namefcraNeg_f  * 0.5540263514
			;
			ModRVR_vermod := 100 * ( (exp(ModRVR_vermod_a)) / (1+exp(ModRVR_vermod_a)) );

		end;

		error_codes := out_addr_status;

		ec1 := trim(error_codes)[1];
		ec3 := trim(error_codes)[3];
		ec4 := trim(error_codes)[4];
		
		addr_changed := addrpop and (ec1='S' AND ec3 != '0');
		unit_changed := addrpop and (ec1='S' AND ec4 != '0');

		standardization_level := map(
			not addrpop  => 0,
			unit_changed => 1,
			addr_changed => 2,
			0
		);

		phone_zip_mismatch := ((INTEGER)rc_phonezipflag=1);
		disconnected := ((INTEGER)rc_hriskphoneflag = 5);

		disconnect_level := map(
			hphnpop = 0      => 0,
			disconnected     => 2,
			nap_status = 'D' => 1,
			0
		);

		pnotpots := map(
			hphnpop = 0 => 0,
			telcordia_type in ['00','50','51','52','54'] => 0,
			1
		);
		
		
		ssnpop := ((INTEGER)ssnlength > 0);
		high_issue_date := (INTEGER)(rc_ssnhighissue);

		high_issue_dateyr := if(ssnpop, (INTEGER)(high_issue_date/10000), -1);
		
		dob_year  := if(ssnpop and (INTEGER)in_dob != 0, (INTEGER)in_dob[1..4], 0);
		year_diff := if(ssnpop, high_issue_dateyr - dob_year, 0 );

		ssnprior := ( ssnpop and high_issue_dateyr > 0 and dob_year > 0 and year_diff between -100 and 2);


		_ssns_per_adl := mymax(1,mymin(4,ssns_per_adl));

		_ssns_per_adl_l := map( 
			_ssns_per_adl = 1 => -2.32706341,
			_ssns_per_adl = 2 => -2.10101564,
			_ssns_per_adl = 3 => -2.002808308,
			_ssns_per_adl = 4 => -1.211635674,
			//_ssns_per_adl_l => -2.303893474
		   -2.303893474
		);

		_addrs_per_adl := if(addrs_per_adl=0, 1, mymin(3,addrs_per_adl));


		_addrs_per_adl_l := map( 
			_addrs_per_adl = 1 => -2.424008278,
			_addrs_per_adl = 2 => -2.207599761,
			_addrs_per_adl = 3 => -2.07251798,
		   -2.303893474
		);
		
		_adlperssn_count := mymin(4,adlperssn_count);

		_adlperssn_count_l := map( 
			_adlperssn_count = 0 => -2.670662655,
			_adlperssn_count = 1 => -2.395753933,
			_adlperssn_count = 2 => -2.119218206,
			_adlperssn_count = 3 => -2.046920814,
			_adlperssn_count = 4 => -1.994999752,
			-2.303893474
		);

		_ssns_per_addr := map(
			ssns_per_addr  =  0 => 3,
			ssns_per_addr <=  1 => 1,
			ssns_per_addr <=  4 => 0,
			ssns_per_addr <=  6 => 1,
			ssns_per_addr <= 10 => 2,
			4
		);

		_ssns_per_addr_l := map( 
			_ssns_per_addr = 0 => -2.721098166,
			_ssns_per_addr = 1 => -2.490165596,
			_ssns_per_addr = 2 => -2.360733805,
			_ssns_per_addr = 3 => -2.292391315,
			_ssns_per_addr = 4 => -2.128318117,
			-2.303893474
		);

		_phones_per_addr := map(
			phones_per_addr=0 => 1,
			phones_per_addr=1 => 0,
			phones_per_addr=2 => 1,
			2
		);

		_phones_per_addr_l := map( 
			_phones_per_addr = 0 => -2.409183363,
			_phones_per_addr = 1 => -2.262232198,
			_phones_per_addr = 2 => -2.232704747,
			-2.303893474
		);

		_adls_per_phone := map(
			adls_per_phone=0 => 2,
			adls_per_phone=1 => 1,
			0
		);

		_adls_per_phone_l := map( 
			_adls_per_phone = 0 => -2.494141864,
			_adls_per_phone = 1 => -2.418512327,
			_adls_per_phone = 2 => -2.15962363,
		   -2.303893474
		);

		ModRVR_fpmod_a := 7.8595460268
			+ standardization_level  * 0.0432227426
			+ (INTEGER)phone_zip_mismatch  * 0.2051615155
			+ disconnect_level  * 0.191947267
			+ pnotpots  * 0.1257754961
			+ (INTEGER)ssnprior  * 0.7285177358
			+ _ssns_per_adl_l  * 0.6095766419
			+ _addrs_per_adl_l  * 0.9680678841
			+ _adlperssn_count_l  * 0.7173955875
			+ _ssns_per_addr_l  * 0.9850888521
			+ _phones_per_addr_l  * 0.8429242591
			+ _adls_per_phone_l  * 0.4197514124
		;
		ModRVR_fpmod := 100 * ( (exp(ModRVR_fpmod_a )) / (1+exp(ModRVR_fpmod_a )) );


		/* Age */
		dob_y := (INTEGER)(in_dob[1..4]);
		low_issue_date := rc_ssnlowissue;
		low_issue_year := (INTEGER)(low_issue_date[1..4]);

		age_dob       := year - dob_y;
		age_ssn_issue := year - low_issue_year;

		age_dob2 := map(
			age_dob <= 21 => 21,
			age_dob >= 65 => 65,
			age_dob
		);

		age_ssn_issue2 := map(
			age_ssn_issue > 200 => 40,
			age_ssn_issue <= 33 => 33,
			age_ssn_issue >  41 => 41,
			age_ssn_issue
		);
			

		/* PROPERTY */
		property_owned_total_x := (property_owned_total > 0);
		property_sold_total_x  := (property_sold_total > 0);
		property_ambig_total_x := (property_ambig_total > 0);

		prop_owner := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			property_owned_total_x or property_sold_total_x or property_ambig_total_x => 1,
			0
		);

		add1_naprop_level := map(
			add1_naprop = 4 => 2,
			add1_naprop = 3 or prop_owner >= 1 => 1,
			0
		);

		add1_naprop_level_m := map( 
			add1_naprop_level = 0 => 0.0987272904,
			add1_naprop_level = 1 => 0.0661230421,
			0.051498847
		);

		/*********** avm **************/

		_apt := (rc_dwelltype='A');

		_avm1 := map( 
			_apt                             => 150000,
			add1_avm_automated_valuation = 0 => 160000,
		   mymin(1000000,add1_avm_automated_valuation)
		);

		_add1_avm_med_fips_ratio := map(
			add1_avm_automated_valuation != 0 and add1_avm_med_fips != 0 => add1_avm_automated_valuation/add1_avm_med_fips,
			-1
		);

		_add1_avm_med_fips_ratiobel := (_add1_avm_med_fips_ratio != -1 and _add1_avm_med_fips_ratio<1);

		_add1_avm_sales_price := map(
			add1_avm_sales_price =0      => 2,
			add1_avm_sales_price<=118447 => 1,
			add1_avm_sales_price<=142400 => 3,
			add1_avm_sales_price<=170000 => 4,
			add1_avm_sales_price<=212500 => 5,
			add1_avm_sales_price<=272000 => 6,
			add1_avm_sales_price<=398500 => 7,
			8
		);

		_add1_avm_sales_price_m := map( 
			_add1_avm_sales_price = 1 => 0.1134148016,
			_add1_avm_sales_price = 2 => 0.0919006345,
			_add1_avm_sales_price = 3 => 0.0860273973,
			_add1_avm_sales_price = 4 => 0.0795698925,
			_add1_avm_sales_price = 5 => 0.0758082497,
			_add1_avm_sales_price = 6 => 0.0668859649,
			_add1_avm_sales_price = 7 => 0.0604727872,
			_add1_avm_sales_price = 8 => 0.0565312843,
			0.0908010173
		);


		/*** phone ***/
		_rc_phoneType := map(
			rc_hphonetypeflag in ['0','U'] and rc_hriskphoneflag='0' => 'standard',
			rc_hphonetypeflag in ['2']     and rc_hriskphoneflag='2' => 'pager',
			rc_hphonetypeflag in ['1']                                      => 'cellular',
			'other'
		);

		_rc_phoneType_i := map(
			_rc_phoneType='standard' and (INTEGER)rc_phonezipflag !=1 => 0,
			_rc_phoneType='pager'                                  => 0,
			_rc_phoneType='standard'                               => 1,
			_rc_phoneType='cellular'                               => 1,
			_rc_phoneType='other'    and (INTEGER)rc_phonezipflag!=1 and rc_phonetype in ['','1'] => 2,
			3
		);

		_rc_phoneType_i_m := map( 
			_rc_phoneType_i = 0 => 0.0827955265,
			_rc_phoneType_i = 1 => 0.1052115987,
			_rc_phoneType_i = 2 => 0.1286832029,
			_rc_phoneType_i = 3 => 0.1627906977,
			0.0908010173
		);


		/*** derog ***/

		_source_tot_L2 := contains_i(rc_sources,'L2');

		_liens_unreleased_histor_f := (INTEGER)(liens_historical_unreleased_ct>0 or _source_tot_L2>0);
		_liens_unreleased_recent_f := (INTEGER)(liens_recent_unreleased_count  > 0);

		_lien_i := if(_liens_unreleased_recent_f=1, 2, _liens_unreleased_histor_f);

		_criminal_flag := (criminal_count>0);
		_liencriminal_i := if(_criminal_flag, 2, _lien_i);

		_source_addr_BA := contains_i(addr_sources, 'BA');
		
		_lienCriminalBK_i := if(_liencriminal_i=0 and _source_addr_ba=1, 1, _liencriminal_i);
     
		_lienCriminalBK_i_l := map( 
			_lienCriminalBK_i = 0 => -2.351693747,
			_lienCriminalBK_i = 1 => -1.718321621,
			_lienCriminalBK_i = 2 => -1.144901541,
		   -2.303893474
		);

		/*** ssn issue date ***/
		in_dob_x := map(
			length(in_dob)=0 => 'x',
			length(in_dob)=4 => in_dob+'0101',
			in_dob[5..6]='00' => in_dob[1..4]+'0101',
			in_dob[1..6]+'01'
		);

		rc_ssnlowissue_x := map(
			length(rc_ssnlowissue)=0 => 'x',
			length(rc_ssnlowissue)=4 => rc_ssnlowissue+'0101',
			rc_ssnlowissue[5..6]='00' => rc_ssnlowissue[1..4]+'0101',
			rc_ssnlowissue[1..6]+'01'
		);
		_in_dob := in_dob_x;
		_rc_ssnlowissue := rc_ssnlowissue_x;

		lowissuedot := length(in_dob)!= 8 or length(rc_ssnlowissue) != 8;

		days_dob := ut.DaysSince1900( _in_dob[1..4], _in_dob[5..6], _in_dob[7..8] );
		days_ssn := ut.DaysSince1900( _rc_ssnlowissue[1..4], _rc_ssnlowissue[5..6], _rc_ssnlowissue[7..8] );

		_ssnlowissue_dob_diff := if( not lowissuedot, round((days_dob-days_ssn)/365), 999999 );

		_ssnlowissue_dob_diff_i := map(
			lowissuedot                  => 999,
			_ssnlowissue_dob_diff <= -30 => -30,
			_ssnlowissue_dob_diff <= -18 => -18,
			_ssnlowissue_dob_diff <= -15 => -15,
			_ssnlowissue_dob_diff <= -12 => -12,
			_ssnlowissue_dob_diff <= - 1 =>  -1,
			_ssnlowissue_dob_diff <=   0 =>   0,
			_ssnlowissue_dob_diff <=   1 =>   1,
			999                     
		);
		
		_ssnlowissue_dob_diff_i_l := map( 
			_ssnlowissue_dob_diff_i = -30 => -3.494044837,
			_ssnlowissue_dob_diff_i = -18 => -2.914630654,
			_ssnlowissue_dob_diff_i = -15 => -2.560892544,
			_ssnlowissue_dob_diff_i = -12 => -2.309015973,
			_ssnlowissue_dob_diff_i =  -1 => -2.124727439,
			_ssnlowissue_dob_diff_i =   0 => -1.736339655,
			_ssnlowissue_dob_diff_i =   1 => -1.723876265,
			_ssnlowissue_dob_diff_i = 999 => -2.601972569,
			-2.303893474
		);


		logit := if(dobpop=1,
			-1.575762577
				+ ModRVR_vermod  * 0.0558154042
				+ ModRVR_fpmod  * 0.0374423993
				+ age_dob2  * -0.011728758
				+ add1_naprop_level_m  * 13.554883554
				+ _avm1  * -1.134353E-6
				+ (REAL)_add1_avm_med_fips_ratiobel  * 0.3115105104
				+ _rc_phoneType_i_m  * 1.8455600557
				+ _ssnlowissue_dob_diff_i_l  * 0.6727885049
				+ _lienCriminalBK_i_l  * 0.4319017713,
			-1.322227865
				+ ModRVR_vermod  * 0.0627002594
				+ ModRVR_fpmod  * 0.0773731649
				+ age_ssn_issue2  * -0.078099401
				+ add1_naprop_level_m  * 8.8267860055
				+ _avm1  * -1.173631E-6
				+ _add1_avm_sales_price_m  * 2.8250602163
				+ (REAL)_add1_avm_med_fips_ratiobel  * 0.2943895048
				+ _lienCriminalBK_i_l  * 0.2717373441
		);

		phat := (exp(logit )) / (1+exp(logit ));

		RVR711_0_0_a := round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);

		RVR711_0_0_b := mymin(900,mymax(501,RVR711_0_0_a));

		/* override */

		ssndead := ((INTEGER)ssnlength>0 and (INTEGER)rc_decsflag=1);
		ssnprior_x := ((INTEGER)rc_ssndobflag=1 or (INTEGER)rc_pwssndobflag=1);
		criminal_flag := (criminal_count>0);
		corrections := (rc_hrisksic=2225);

		rvr711_override := map(
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)  => 222,
			RVR711_0_0_b > 680 and (ssndead or ssnprior_x or criminal_flag or corrections ) => 680,
			rvr711_0_0_b
		);
     



		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		useBsV2Rc := if(useRcSetV1, false, true);
		
		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			rvr711_override = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rvReasonCodes(le, 4, inCalif, useBsV2Rc /*use BS v2 reason codes*/)
		);
		self.score := map(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			(STRING3)rvr711_override
		);
		self.seq := le.seq;
		
	#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
		self.ModRVR_vermod	:= 	ModRVR_vermod	;
		self.nap_ver_level_m	:= 	nap_ver_level_m	;
		self._source_tot_P	:= 	_source_tot_P	;
		self._source_tot_PL	:= 	_source_tot_PL	;
		self._source_lname_W	:= 	_source_lname_W	;
		self._source_addr_WP	:= 	_source_addr_WP	;
		self._source_namefcraNeg_f	:= 	_source_namefcraNeg_f	;
		self.ModRVR_fpmod	:= 	ModRVR_fpmod	;
		self.standardization_level	:= 	standardization_level	;
		self.phone_zip_mismatch	:= 	if(phone_zip_mismatch,1,0)	;
		self.disconnect_level	:= 	disconnect_level	;
		self.pnotpots	:= 	pnotpots	;
		self.ssnprior	:= 	if(ssnprior,1,0)	;
		self._ssns_per_adl_l	:= 	_ssns_per_adl_l	;
		self._addrs_per_adl_l	:= 	_addrs_per_adl_l	;
		self._adlperssn_count_l	:= 	_adlperssn_count_l	;
		self._ssns_per_addr_l	:= 	_ssns_per_addr_l	;
		self._phones_per_addr_l	:= 	_phones_per_addr_l	;
		self._adls_per_phone_l	:= 	_adls_per_phone_l	;
		self.age_dob2	:= 	age_dob2	;
		self.add1_naprop_level_m	:= 	add1_naprop_level_m	;
		self._avm1	:= 	_avm1	;
		self._add1_avm_med_fips_ratiobel	:= 	if(_add1_avm_med_fips_ratiobel,1,0)	;
		self._rc_phoneType_i_m	:= 	_rc_phoneType_i_m	;
		self._ssnlowissue_dob_diff_i_l	:= 	_ssnlowissue_dob_diff_i_l	;
		self._lienCriminalBK_i_l	:= 	_lienCriminalBK_i_l	;
		self.age_ssn_issue2	:= 	age_ssn_issue2	;
		self._add1_avm_sales_price_m	:= 	_add1_avm_sales_price_m	;
	#end

		
	end;


	final := project(clam, doModel(LEFT));
	RETURN final;
END;

import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVR803_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION



temp := record
	layout_modelout;
	
	#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;		
	#end
end;


	temp doModel( clam le ) := TRANSFORM

		out_addr_status                 :=  le.address_validation.error_codes;
		in_dob                          :=  trim(le.shell_input.dob);
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  trim(le.iid.hriskphoneflag);
		rc_hphonetypeflag               :=  StringLib.StringToUppercase(le.iid.hphonetypeflag);
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_pwssndobflag                 :=  (INTEGER)le.iid.PWsocsdobflag;
		rc_ssnlowissue                  :=  (STRING)le.SSN_Verification.Validation.low_issue_date;
		rc_ssnhighissue                 :=  le.iid.soclhighissue;
		rc_sources                      :=  le.iid.sources;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_phonetype                    :=  trim(le.iid.phonetype);
		combo_hphonescore               :=  le.iid.combo_hphonescore;
		fname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.firstnamesources));
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.lastnamesources));
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
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
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add3_naprop                     :=  le.address_verification.address_history_2.naprop;
		telcordia_type                  :=  le.phone_verification.telcordia_type;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		addrs_per_adl                   :=  le.velocity_counters.addrs_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		ssns_per_addr                   :=  le.velocity_counters.ssns_per_addr;
		phones_per_addr                 :=  le.velocity_counters.phones_per_addr;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		archive_date                    :=  le.historydate;
                                              
		// end input data                  
	    
		/* HELPERS */
		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		/***********/
		
		arcdate := if( archive_date = 999999, (STRING)Std.Date.Today(), (STRING)archive_date );
		year := (INTEGER)arcdate[1..4];		
	            
		// Process vermod code
		
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
			verphn_p and stolen_id_ap                       => -1,
			contrary_phone                                  => -1,
			verphn_p                                        =>  2,
			0
		);
		
		
		_source_tot_P  := contains_i(rc_sources,'P ');
		_source_tot_PL := contains_i(rc_sources,'PL');

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
			nap_ver_level_b  := -9999;
			verx_b           := -9999;
			verx_b_m         := -9999;
			score_combo_b    := -9999;
			score_combo_b_m  := -9999;
			/************/
			

			nap_ver_level_m := map( 
				nap_ver_level = -1 => 0.3120805369,
				nap_ver_level = 0 => 0.2306905371,
				0.1737132353
				);


			ModRVR_vermod_a := -2.344124498
				+ nap_ver_level_m  * 5.3466322916
				+ _source_tot_P  *  -0.336587046
				+ _source_tot_PL  * -0.39711978;

			ModRVR_vermod := 100 * ( (exp(ModRVR_vermod_a)) / (1+exp(ModRVR_vermod_a)) );		
		
		else
		
			/* Declarations to suppress conditional assignment warning: */
			nap_ver_level_m := -9999;
			/************/


			nap_ver_level_b := map( 
				 verphn_p and verlst_p => 1,
				~verlst_p and veradd_p => 0,
				contrary_phone         => 0,
				0
			);

			verx_b := map( 
				nap_ver_level_b = 1 and ~ssn479 => 2,
				nap_ver_level_b = 0 and ssn479 => 0,
				1
			);
                                   
			verx_b_m := map( 
				verx_b = 0 => 0.364983165,
				verx_b = 1 => 0.2962962963,
				0.2103174603
			);

			score_combo_b := map( 
				add1_address100 and phone100 => 2,
				add1_address100 or phone100 => 1,
				0
			);

			score_combo_b_m := map( 
				score_combo_b = 0 => 0.3759461733,
				score_combo_b = 1 => 0.3022648084,
				0.2392473118
			);


			ModRVR_vermod_a := -2.454642199
				+ verx_b_m  * 2.5222370303
				+ score_combo_b_m  * 2.6276468348
				+ _source_tot_P  * -0.398541747
				+ _source_namefcraNeg_f  * 0.2130517054
			;
			
			ModRVR_vermod := 100 * ( (exp(ModRVR_vermod_a)) / (1+exp(ModRVR_vermod_a)) );

		end;		
		
		
		disconnected := ((INTEGER)rc_hriskphoneflag = 5);

		disconnect_level := map(
			disconnected     => 1,
			nap_status = 'D' => 1,
			0
		);

		pnotpots := map(
			telcordia_type in ['00','50','51','52','54'] => 0,
			1
		);
			
		
		ssnprior := map( rc_pwssndobflag=1 or rc_ssndobflag=1 => 1, 
						0);
			
		ssnpop := ((INTEGER)ssnlength > 0);
		high_issue_date := (INTEGER)(rc_ssnhighissue);			
		
		_ssns_per_adl := mymax(1,mymin(2,ssns_per_adl));

		_ssns_per_adl_l := map( 
			_ssns_per_adl = 1 => -1.079468782,
			_ssns_per_adl = 2 => -0.749500115,
		   -1.067395757
		);
		
		
		_addrs_per_adl := if(addrs_per_adl=0, 1, mymin(3,addrs_per_adl));

		_addrs_per_adl_l := map( 
			_addrs_per_adl = 1 => -0.909409968,
			_addrs_per_adl = 2 => -1.011077303,
			_addrs_per_adl = 3 => -1.169006114,
		   -1.067395757
		);		

		_adlperssn_count := mymax(2, mymin(4,adlperssn_count));

		_adlperssn_count_l := map( 
			_adlperssn_count = 2 => -1.130155941,
			_adlperssn_count = 3 => -0.72960322,
			_adlperssn_count = 4 => -0.714424577,
			-1.067395757
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
			_ssns_per_addr = 0 => -1.502126172,
			_ssns_per_addr = 1 => -1.274040363,
			_ssns_per_addr = 2 => -1.233355065,
			_ssns_per_addr = 3 => -0.909701907,
			_ssns_per_addr = 4 => -0.83109868,
			-1.067395757
		);

		_phones_per_addr := map(
			phones_per_addr=0 => 1,
			phones_per_addr=1 => 0,
			phones_per_addr=2 => 1,
			2
		);

		_phones_per_addr_l := map( 
			_phones_per_addr = 0 => -1.226344257,
			_phones_per_addr = 1 => -1.092100635,
			_phones_per_addr = 2 => -0.721055967,
			-1.067395757
		);
		
		// phone
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
			_rc_phoneType_i = 0 => 0.2367060561,
			_rc_phoneType_i = 1 => 0.2803171642,
			_rc_phoneType_i = 2 => 0.3113772455,
			0.3448275862
		);

		phone_prob := map(
			_rc_PhoneType_i in [2,3] => 3,
			pnotpots = 1 => 2,
			1
		);
		
		phone_prob_m := map(
			phone_prob = 1 => 0.2326574173,
			phone_prob = 2 => 0.2880940715,
			0.3121869783
		);
		

        ModRVR_fpmod_a := 2.8894486736                              
                     + disconnect_level  * 0.2193762124
                     + phone_prob_m  * 3.262414047
                     + _ssns_per_adl_l  * 0.9989039169
                     + _addrs_per_adl_l  * 0.952793209
                     + _adlperssn_count_l  * 0.9789986576
                     + _ssns_per_addr_l  * 0.867402077
                     + _phones_per_addr_l  * 0.6917835114
                  ;
				  
        ModRVR_fpmod := 100 * ( (exp(ModRVR_fpmod_a )) / (1+exp(ModRVR_fpmod_a )) );  

		// Age
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
			
			
		// Property
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
			add1_naprop_level = 0 => 0.2835134514,
			add1_naprop_level = 1 => 0.2777179763,
			0.1619170984
		);


		// AVM
		_add1_avm_med_fips_ratio := map(
			add1_avm_automated_valuation != 0 and add1_avm_med_fips != 0 => add1_avm_automated_valuation/add1_avm_med_fips,
			-1
		);

		_add1_avm_med_fips_ratiobel := map(_add1_avm_med_fips_ratio != -1 and _add1_avm_med_fips_ratio<1 => 1,
											0);
		
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
			_add1_avm_sales_price = 1 => 0.2684331797,
			_add1_avm_sales_price = 2 => 0.2652476463,
			_add1_avm_sales_price = 3 => 0.2765957447,
			_add1_avm_sales_price = 4 => 0.2207792208,
			_add1_avm_sales_price = 5 => 0.2909090909,
			_add1_avm_sales_price = 6 => 0.3529411765,
			_add1_avm_sales_price = 7 => 0.3157894737,
			0.5882352941
		);		

		
		// DEROG
		_source_tot_L2 := contains_i(rc_sources,'L2');

		_liens_unreleased_histor_f := (INTEGER)(liens_historical_unreleased_ct>0 or _source_tot_L2>0);
		_liens_unreleased_recent_f := (INTEGER)(liens_recent_unreleased_count  > 0);

		_lien_i := if(_liens_unreleased_recent_f=1, 2, _liens_unreleased_histor_f);

		_criminal_flag := (criminal_count>0);
		_liencriminal_i := if(_criminal_flag, 2, _lien_i);

		_source_addr_BA := contains_i(addr_sources, 'BA');
		
		_lienCriminalBK_i := if(_liencriminal_i=0 and _source_addr_ba=1, 1, _liencriminal_i);
     
		_lienCriminalBK_i_l := map( 
			_lienCriminalBK_i = 0 => -1.206665538,
			_lienCriminalBK_i = 1 => -0.993848964,
			_lienCriminalBK_i = 2 => -0.643232787,
		   -1.067395757
		);		

		// SSN ISSUE DATE
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
			_ssnlowissue_dob_diff <= -30 => -2,
			_ssnlowissue_dob_diff <= -18 => -2,
			_ssnlowissue_dob_diff <= -15 => -2,
			_ssnlowissue_dob_diff <= -12 => -2,
			_ssnlowissue_dob_diff <= - 1 =>  -1,
			_ssnlowissue_dob_diff <=   0 =>   0,
			_ssnlowissue_dob_diff <=   1 =>   1,
			999                     
		);
		
		_ssnlowissue_dob_diff_i_l := map( 
			_ssnlowissue_dob_diff_i = -2 => -1.38949436,
			_ssnlowissue_dob_diff_i = -1 => -0.886062401,
			_ssnlowissue_dob_diff_i =  0 => -0.808458025,
			_ssnlowissue_dob_diff_i =  1 => -0.418710333,
			_ssnlowissue_dob_diff_i = 999 => -1.473305734,
			-1.067395757
		);


		logit := if(dobpop=1,
			-1.561762596
                       + ModRVR_vermod  * 0.0329192948
                       + ModRVR_fpmod  * 0.0381668395
                       + age_dob2  * -0.012990983
                       + add1_naprop_level_m  * 2.2259961008
                       + (real)_add1_avm_med_fips_ratiobel  * 0.4106836175
                       + _ssnlowissue_dob_diff_i_l  * 0.4707810459
                       + _lienCriminalBK_i_l  * 1.025762584,
			-1.521127156
                       + ModRVR_vermod  * 0.0358374778
                       + ModRVR_fpmod  * 0.0385824414
                       + age_ssn_issue2  * -0.076902351
                       + add1_naprop_level_m  * 2.8470437013
                       + _add1_avm_sales_price_m  * 4.4705255468
                       + (real)_add1_avm_med_fips_ratiobel  * 0.414563243
                       + _lienCriminalBK_i_l  * 0.8889867882
		);

		phat := (exp(logit )) / (1+exp(logit ));

        RVR803_1_0_a := round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);

        RVR803_1_0_b := min(900,max(501,RVR803_1_0_a));
		
		
		// OVERRIDE
		
		ssndead := ((INTEGER)ssnlength>0 and (INTEGER)rc_decsflag=1);
		ssnprior_x := (rc_ssndobflag=1 or rc_pwssndobflag=1);
		criminal_flag := (criminal_count>0);
		corrections := (rc_hrisksic=2225);
		
		RVR803_override := map(
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)  => 222,
			RVR803_1_0_b > 680 and (ssndead or ssnprior_x or criminal_flag or corrections ) => 680,
			RVR803_1_0_b
		);
     


		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RVR803_override = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rvReasonCodes(le, 4, inCalif, true /*use BS v2 reason codes*/)
		);
		self.score := map(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			(STRING3)RVR803_override
		);
		
		self.seq := le.seq;		
		
			
#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
#end


	END;
	
	
	final := project(clam, doModel(left));

	RETURN (final);

END;
IMPORT Risk_Indicators, ut, RiskWise;

EXPORT MX361006_1_0( DATASET(Risk_Indicators.Layout_Boca_Shell) clam ) := FUNCTION

	MX36_DEBUG := FALSE;

	#if(MX36_DEBUG)
	Layout_Debug := RECORD
		Risk_Indicators.Layout_Boca_Shell clam;
		
		INTEGER seq;
		REAL4 Score;
		/* Input Variables */
		INTEGER total_number_derogs;
		INTEGER crim_last_date;
		INTEGER addr_stability;
		INTEGER add2_date_last_seen;
		INTEGER add1_built_date;
		INTEGER add3_built_date;
		INTEGER dist_a1toa2;
		INTEGER dist_a1toa3;
		STRING add2_avm_recording_date;
		INTEGER adl_EQ_first_seen;
		INTEGER adl_TU_first_seen;
		INTEGER adl_DL_first_seen;
		INTEGER adl_PR_first_seen;
		INTEGER adl_V_first_seen;
		INTEGER adl_EM_first_seen;
		INTEGER adl_W_first_seen;
		INTEGER adl_EQ_last_seen;
		INTEGER adl_TU_last_seen;
		INTEGER adl_DL_last_seen;
		INTEGER adl_PR_last_seen;
		INTEGER adl_V_last_seen;
		INTEGER adl_EM_last_seen;
		INTEGER adl_W_last_seen;
		STRING history_date;
		BOOLEAN is_fcra;
		BOOLEAN truedid;
		INTEGER nas_summary;
		INTEGER nap_summary;
		INTEGER cvi;
		STRING rc_sources;
		STRING out_addr_status;
		INTEGER credit_sourced;
		STRING rc_decsflag;
		INTEGER combo_fnamecount;
		INTEGER combo_lnamecount;
		INTEGER combo_addrcount;
		INTEGER combo_ssncount;
		INTEGER add1_naprop;
		
		INTEGER add2_avm_recording_mn;
		INTEGER CALastSaleDate_mn;
		INTEGER cri_lst;
		INTEGER add1_built_date_yr;
		INTEGER add3_built_date_yr;
		INTEGER add2_date_last_seen_mn;
		
		/* Intermediate Variables */
		REAL total_number_derogs_w;
		REAL add1_avm_med_fips_w;
		REAL dist_a1toa3_w;
		REAL cri_lst_w;
		REAL addrs_10yr_w;
		REAL liens_recent_unreleased_count_w;
		REAL add1_built_date_yr_w;
		REAL dist_a1toa2_w;
		REAL add2_date_last_seen_mn_w;
		REAL add1_avm_sales_price_w;
		REAL add2_avm_recording_mn_w;
		REAL property_owned_total_w;
		REAL CALastSaleDate_mn_w;
		REAL add3_built_date_yr_w;
		REAL addr_stability_w;
		STRING ind;
		REAL xb;
	END;
	Layout_Debug doModel( clam le) := TRANSFORM
	#else
	
	Layout_MVR := record
		INTEGER seq;
		REAL4 score;
	END;
	Layout_MVR doModel( clam le) := TRANSFORM
	#end

    total_number_derogs              := le.total_number_derogs;
		crim_last_date                   := le.bjl.last_criminal_date;
		addr_stability                   := (INTEGER)le.mobility_indicator;
		add2_date_last_seen              := le.Address_Verification.Address_History_1.date_last_seen;
		add1_built_date                  := le.Address_Verification.Input_Address_Information.built_date;
		add3_built_date                  := le.Address_Verification.Address_History_2.built_date;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_avm_recording_date          := le.avm.address_history_1.avm_recording_date;
		adl_EQ_first_seen                := le.source_verification.adl_EQfs_first_seen;
		adl_TU_first_seen                := le.source_verification.adl_TU_first_seen;
		adl_DL_first_seen                := le.source_verification.adl_DL_first_seen;
		adl_PR_first_seen                := le.source_verification.adl_PR_first_seen;
		adl_V_first_seen                 := le.source_verification.adl_V_first_seen;
		adl_EM_first_seen                := le.source_verification.adl_EM_first_seen;
		adl_W_first_seen                 := le.source_verification.adl_W_first_seen;
		adl_EQ_last_seen                 := le.source_verification.adl_eqfs_last_seen;
		adl_TU_last_seen                 := le.source_verification.adl_TU_last_seen;
		adl_DL_last_seen                 := le.source_verification.adl_DL_last_seen;
		adl_PR_last_seen                 := le.source_verification.adl_PR_last_seen;
		adl_V_last_seen                  := le.source_verification.adl_V_last_seen;
		adl_EM_last_seen                 := le.source_verification.adl_EM_last_seen;
		adl_W_last_seen                  := le.source_verification.adl_W_last_seen;
		history_date                     := if( le.historydate=999999, ut.getdate[1..6], (STRING6)le.historydate );
		is_fcra                          := true; // this is an FCRA model. added this to keep the 'unscorable' section as close to original sas as possible.
		truedid                          := le.truedid;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		cvi                              := le.iid.cvi;
		rc_sources                       := le.iid.sources;
		out_addr_status                  := le.shell_input.addr_status;
		credit_sourced                   := (INTEGER)le.ssn_verification.credit_sourced;
		rc_decsflag                      := le.iid.decsflag;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_ssncount                   := le.iid.combo_ssncount;
		add1_naprop                      := le.address_verification.input_address_information.NAProp;
		
		/* RISKVIEW ATTRIBUTES */
			CAaddrChooser := map(
							   le.address_verification.input_address_information.isbestmatch => 1, // input is current
							   le.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
							   le.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
							   4 // don't know what the current address is
						);
			
			fulldate := (unsigned4)((STRING6)le.historyDate+'01');
			CALastSaleDate1 := map(
							CAaddrChooser=1 => le.address_verification.input_address_information.purchase_date,
							CAaddrChooser=2 => le.address_verification.address_history_1.purchase_date,
							CAaddrChooser=3 => le.address_verification.address_history_2.purchase_date,
							0 //just guessing here
			);
			CALastSaleDate := if(CALastSaleDate1>fullDate, 0, CALastSaleDate1);
			
		/* RISKVIEW ATTRIBUTES */

		/* ***************************************************************** */
		/* CREATE 'INPUT' VALUES USED BY THE MODEL */
		NULL := -999999999;
		
		getMonths( UNSIGNED date ) := if(date=0, NULL, max(0,((INTEGER)history_date[1..4] - (INTEGER)date[1..4])*12
		                           + (INTEGER)history_date[5..6] - (INTEGER)date[5..6]));
		getYears( UNSIGNED date ) := if(date=0, NULL, max(0,(INTEGER)history_date[1..4] - (INTEGER)date[1..4]));
				
		add2_avm_recording_mn            := getMonths((UNSIGNED)add2_avm_recording_date);
		CALastSaleDate_mn                := getMonths(CALastSaleDate);
		cri_lst                          := getMonths(crim_last_date);
		add1_built_date_yr               := getYears(add1_built_date);
		add3_built_date_yr               := getYears(add3_built_date);
		add2_date_last_seen_mn           := getMonths(add2_date_last_seen);
		/* ***************************************************************** */
		total_number_derogs_w := MAP(
			total_number_derogs = NULL	=> 0.282997,
			total_number_derogs  = 0		=> -0.107063,
			total_number_derogs <= 1		=> 0.242410,
			total_number_derogs <= 2		=> 0.424033,
			total_number_derogs <= 3		=> 0.561735,
			total_number_derogs <= 4		=> 0.584566,
			total_number_derogs <= 6		=> 0.720175,
																		 0.800064
			);
			
		add1_avm_med_fips_w := 0.282997;
			
		dist_a1toa3_w := MAP(
			dist_a1toa3 = NULL	=> 0.049640,
			dist_a1toa3 = 0			=> -0.086351,
			dist_a1toa3 <= 2		=> 0.074379,
			dist_a1toa3 <= 15		=> 0.088026,
			dist_a1toa3 <= 17		=> 0.102658,
			dist_a1toa3 <= 25		=> 0.181479,
			dist_a1toa3 <= 30		=> 0.147685,
			dist_a1toa3 <= 56		=> 0.141837,
			dist_a1toa3 <= 90		=> 0.117404,
			dist_a1toa3 <= 119	=> 0.059649,
			dist_a1toa3 <= 191	=> 0.017641,
			dist_a1toa3 <= 269	=> -0.025075,
			dist_a1toa3 <= 302	=> -0.041417,
			dist_a1toa3 <= 722	=> -0.137453,
			dist_a1toa3 <= 786	=> -0.262308,
			dist_a1toa3 <= 851	=> -0.362803,
			dist_a1toa3 <= 1000	=> -0.373972,
														 -0.411782
		);
			
		cri_lst_w := MAP(
			cri_lst = NULL	=> -0.047942,
			cri_lst <= 21		=> 0.986711,
			cri_lst <= 34		=> 0.926418,
			cri_lst <= 48		=> 0.751057,
												 0.560880
		);
		
		addrs_10yr_w := 0.282997;
		
		liens_recent_unreleased_count_w := 0.282997;
		
		add1_built_date_yr_w := MAP(
			add1_built_date_yr = NULL	=> 0.037090,
			add1_built_date_yr <= 2		=> -0.190614,
			add1_built_date_yr <= 15	=> -0.104377,
			add1_built_date_yr <= 42	=> -0.053520,
			add1_built_date_yr <= 48	=> -0.006274,
			add1_built_date_yr <= 59	=> 0.031762,
			add1_built_date_yr <= 77	=> 0.072384,
			add1_built_date_yr <= 81	=> 0.099858,
			add1_built_date_yr <= 128	=> 0.123996,
																	 0.166991
		);
		
		dist_a1toa2_w := MAP(
			dist_a1toa2 = NULL	=> 0.068642,
			dist_a1toa2 = 0			=> -0.088818,
			dist_a1toa2 <= 1		=> 0.065638,
			dist_a1toa2 <= 2		=> 0.073061,
			dist_a1toa2 <= 3		=> 0.077187,
			dist_a1toa2 <= 12		=> 0.089137,
			dist_a1toa2 <= 15		=> 0.101454,
			dist_a1toa2 <= 17		=> 0.129397,
			dist_a1toa2 <= 18		=> 0.150274,
			dist_a1toa2 <= 25		=> 0.168786,
			dist_a1toa2 <= 27		=> 0.201770,
			dist_a1toa2 <= 37		=> 0.259395,
			dist_a1toa2 <= 57		=> 0.197708,
			dist_a1toa2 <= 67		=> 0.190873,
			dist_a1toa2 <= 92		=> 0.160167,
			dist_a1toa2 <= 155	=> 0.117537,
			dist_a1toa2 <= 174	=> 0.074704,
			dist_a1toa2 <= 242	=> 0.007244,
			dist_a1toa2 <= 273	=> -0.047323,
			dist_a1toa2 <= 395	=> -0.093720,
			dist_a1toa2 <= 483	=> -0.138298,
			dist_a1toa2 <= 532	=> -0.160214,
			dist_a1toa2 <= 575	=> -0.161125,
			dist_a1toa2 <= 677	=> -0.238099,
			dist_a1toa2 <= 741	=> -0.249161,
			dist_a1toa2 <= 805	=> -0.325188,
			dist_a1toa2 <= 871	=> -0.341836,
														 -0.420664
		);
		
		add2_date_last_seen_mn_w := MAP(
			add2_date_last_seen_mn = NULL	=> 0.090609,
			add2_date_last_seen_mn <= 9		=> 0.104154,
			add2_date_last_seen_mn <= 11	=> 0.065825,
			add2_date_last_seen_mn <= 28	=> 0.000297,
			add2_date_last_seen_mn <= 36	=> -0.071863,
			add2_date_last_seen_mn <= 38	=> -0.109994,
			add2_date_last_seen_mn <= 39	=> -0.245185,
			add2_date_last_seen_mn <= 74	=> -0.303376,
			add2_date_last_seen_mn <= 142	=> -0.374369,
			add2_date_last_seen_mn <= 153	=> -0.512544,
			add2_date_last_seen_mn <= 192	=> -0.594699,
			add2_date_last_seen_mn <= 263	=> -0.643887,
																			 -0.895239
		);
		
		add1_avm_sales_price_w := -0.033003;
		
		add2_avm_recording_mn_w := MAP(
			add2_avm_recording_mn = NULL	=> -0.007361,
			add2_avm_recording_mn <= 3		=> -0.046157,
			add2_avm_recording_mn <= 304	=> 0.027900,
																			 0.169995
		);
		
		property_owned_total_w := 0.282997;
		
		CALastSaleDate_mn_w := MAP(
			CALastSaleDate_mn = NULL	=> 0.006464,
			CALastSaleDate_mn <= 2		=> -0.049826,
			CALastSaleDate_mn <= 4		=> -0.028849,
			CALastSaleDate_mn <= 11		=> 0.036711,
			CALastSaleDate_mn <= 13		=> 0.037039,
			CALastSaleDate_mn <= 16		=> 0.096262,
			CALastSaleDate_mn <= 17		=> 0.088737,
			CALastSaleDate_mn <= 29		=> -0.000096,
			CALastSaleDate_mn <= 33		=> -0.003252,
			CALastSaleDate_mn <= 44		=> -0.009620,
			CALastSaleDate_mn <= 83		=> -0.050994,
			CALastSaleDate_mn <= 108	=> -0.079476,
			CALastSaleDate_mn <= 132	=> -0.128747,
			CALastSaleDate_mn <= 161	=> -0.222642,
																	 -0.495834
		);
		
		add3_built_date_yr_w := MAP(
			add3_built_date_yr = NULL	=> 0.003298,
			add3_built_date_yr <= 8		=> 0.027205,
			add3_built_date_yr <= 12	=> 0.006538,
			add3_built_date_yr <= 22	=> -0.048784,
			add3_built_date_yr <= 24	=> -0.079723,
			add3_built_date_yr <= 28	=> -0.099034,
			add3_built_date_yr <= 30	=> -0.167662,
			add3_built_date_yr <= 41	=> -0.103400,
			add3_built_date_yr <= 43	=> -0.041603,
			add3_built_date_yr <= 49	=> -0.038852,
			add3_built_date_yr <= 51	=> -0.022809,
			add3_built_date_yr <= 53	=> -0.022210,
			add3_built_date_yr <= 66	=> 0.058491,
			add3_built_date_yr <= 87	=> 0.110327,
			add3_built_date_yr <= 107	=> 0.116335,
																	 0.202120
		);
			
		addr_stability_w := MAP(
			addr_stability = NULL	=> 0.282997,
			addr_stability <= 1		=> 0.187331,
			addr_stability <= 4		=> 0.057902,
			addr_stability <= 5		=> -0.152179,
															 -0.366553
		);
			
		ind := if( models.common.isRV3Unscorable(le), 'Un-scorable', 'Scorable' );

		xb := if( ind='Un-scorable', 999,
       total_number_derogs_w          * -0.63271208
     + add1_avm_med_fips_w            * -0.77616088
     + dist_a1toa3_w                  * -0.68883589
     + cri_lst_w                      * -0.87936267
     + addrs_10yr_w                   * -0.37820335
     + liens_recent_unreleased_count_w* -0.65594397
     + add1_built_date_yr_w           * -1.23013241
     + dist_a1toa2_w                  * -0.55330513
     + add2_date_last_seen_mn_w       * -0.37518609
     + add1_avm_sales_price_w         * -1.38743565
     + add2_avm_recording_mn_w        * -2.79808439
     + property_owned_total_w         * -0.29021097
     + CALastSaleDate_mn_w            * -0.62532052
     + add3_built_date_yr_w           * -0.69181872
     + addr_stability_w               * -0.19465362             
		);

		#if(MX36_DEBUG)			
			/* Input Variables */
			SELF.total_number_derogs := total_number_derogs;
			SELF.crim_last_date := crim_last_date;
			SELF.addr_stability := addr_stability;
			SELF.add2_date_last_seen := add2_date_last_seen;
			SELF.add1_built_date := add1_built_date;
			SELF.add3_built_date := add3_built_date;
			SELF.dist_a1toa2 := dist_a1toa2;
			SELF.dist_a1toa3 := dist_a1toa3;
			SELF.add2_avm_recording_date := add2_avm_recording_date;
			SELF.adl_EQ_first_seen := adl_EQ_first_seen;
			SELF.adl_TU_first_seen := adl_TU_first_seen;
			SELF.adl_DL_first_seen := adl_DL_first_seen;
			SELF.adl_PR_first_seen := adl_PR_first_seen;
			SELF.adl_V_first_seen := adl_V_first_seen;
			SELF.adl_EM_first_seen := adl_EM_first_seen;
			SELF.adl_W_first_seen := adl_W_first_seen;
			SELF.adl_EQ_last_seen := adl_EQ_last_seen;
			SELF.adl_TU_last_seen := adl_TU_last_seen;
			SELF.adl_DL_last_seen := adl_DL_last_seen;
			SELF.adl_PR_last_seen := adl_PR_last_seen;
			SELF.adl_V_last_seen := adl_V_last_seen;
			SELF.adl_EM_last_seen := adl_EM_last_seen;
			SELF.adl_W_last_seen := adl_W_last_seen;
			SELF.history_date := history_date;
			SELF.is_fcra := is_fcra;
			SELF.truedid := truedid;
			SELF.nas_summary := nas_summary;
			SELF.nap_summary := nap_summary;
			SELF.cvi := cvi;
			SELF.rc_sources := rc_sources;
			SELF.out_addr_status := out_addr_status;
			SELF.credit_sourced := credit_sourced;
			SELF.rc_decsflag := rc_decsflag;
			SELF.combo_fnamecount := combo_fnamecount;
			SELF.combo_lnamecount := combo_lnamecount;
			SELF.combo_addrcount := combo_addrcount;
			SELF.combo_ssncount := combo_ssncount;
			SELF.add1_naprop := add1_naprop;

			SELF.add2_avm_recording_mn := add2_avm_recording_mn;
			SELF.CALastSaleDate_mn := CALastSaleDate_mn;
			SELF.cri_lst := cri_lst;
			SELF.add1_built_date_yr := add1_built_date_yr;
			SELF.add3_built_date_yr := add3_built_date_yr;
			SELF.add2_date_last_seen_mn := add2_date_last_seen_mn;
			
			/* Intermediate Variables */
			SELF.total_number_derogs_w := total_number_derogs_w;
			SELF.add1_avm_med_fips_w := add1_avm_med_fips_w;
			SELF.dist_a1toa3_w := dist_a1toa3_w;
			SELF.cri_lst_w := cri_lst_w;
			SELF.addrs_10yr_w := addrs_10yr_w;
			SELF.liens_recent_unreleased_count_w := liens_recent_unreleased_count_w;
			SELF.add1_built_date_yr_w := add1_built_date_yr_w;
			SELF.dist_a1toa2_w := dist_a1toa2_w;
			SELF.add2_date_last_seen_mn_w := add2_date_last_seen_mn_w;
			SELF.add1_avm_sales_price_w := add1_avm_sales_price_w;
			SELF.add2_avm_recording_mn_w := add2_avm_recording_mn_w;
			SELF.property_owned_total_w := property_owned_total_w;
			SELF.CALastSaleDate_mn_w := CALastSaleDate_mn_w;
			SELF.add3_built_date_yr_w := add3_built_date_yr_w;
			SELF.addr_stability_w := addr_stability_w;
			SELF.ind := ind;
			SELF.xb := xb;
			
			SELF.clam := le;
		#end;
		SELF.seq := le.seq;
		SELF.score := xb;
	END;
		
	model := PROJECT( clam, doModel(LEFT) );
	
	RETURN model;
END;

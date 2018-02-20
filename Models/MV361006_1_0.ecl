IMPORT Risk_Indicators, ut, RiskWise, std;

EXPORT MV361006_1_0( DATASET(Risk_Indicators.Layout_Boca_Shell) clam ) := FUNCTION

	MV36_DEBUG := FALSE;

	#if(MV36_DEBUG)
	Layout_Debug := RECORD
		Risk_Indicators.Layout_Boca_Shell clam;
		
		INTEGER seq;
		REAL4 Score;
		/* Input Variables */
		INTEGER crim_last_date;
		INTEGER addr_stability;
		INTEGER add2_date_last_seen;
		INTEGER add1_built_date;
		INTEGER add2_built_date;
		INTEGER ssns_per_addr;
		INTEGER dist_a1toa2;
		INTEGER dist_a1toa3;
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
		
		STRING history_date;
		INTEGER is_Issued3;
		INTEGER date_derog;
		INTEGER date_last_derog;
		INTEGER mos_last_derog;
		INTEGER earliest_date_last_seen;
		INTEGER mos_last;
		INTEGER cri_lst;
		INTEGER add1_built_date_yr;
		INTEGER add2_built_date_yr;
		INTEGER add2_date_last_seen_mn;
		
		/* Intermediate Variables */
		REAL mos_last_derog_w;
		REAL add1_avm_med_fips_w;
		REAL mos_last_w;
		REAL addrs_10yr_w;
		REAL add1_built_date_yr_w;
		REAL cri_lst_w;
		REAL dist_a1toa2_w;
		REAL add2_avm_sales_price_w;
		REAL property_owned_total_w;
		REAL add1_purchase_amount_w;
		REAL addr_stability_w;
		REAL add2_built_date_yr_w;
		REAL dist_a1toa3_w;
		REAL ssns_per_addr_w;
		REAL isIssued3_w;
		REAL add2_date_last_seen_mn_w;
		STRING ind;
		REAL xb;
	END;
	
	Layout_Debug doModel( clam le) := TRANSFORM
	#else
	
	Layout_MVR := RECORD
		INTEGER seq;
		REAL4 score;
	END;
	Layout_MVR doModel( clam le) := TRANSFORM
	#end

		crim_last_date                   := le.bjl.last_criminal_date;
		addr_stability                   := (INTEGER)le.mobility_indicator;
		add2_date_last_seen              := le.Address_Verification.Address_History_1.date_last_seen;
		add1_built_date                  := le.Address_Verification.Input_Address_Information.built_date;		
		add2_built_date                  := le.Address_Verification.Address_History_1.built_date;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
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
				
		/* **************************************************************** */
		/* CREATE 'INPUT' VALUES USED BY THE MODEL */
		fulldate := (UNSIGNED4)((STRING6)le.historyDate+'01');
		history_date := if( le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (STRING6)le.historydate );
		NULL := -999999999;
		checkDt( UNSIGNED3 dls ) := if( dls=0, -NULL, dls );
		getMonths( UNSIGNED date ) := if(date=0, NULL, max(0,((INTEGER)history_date[1..4] - (INTEGER)((STRING)date)[1..4])*12
		                           + (INTEGER)history_date[5..6] - (INTEGER)((STRING)date)[5..6]));
		getYears( UNSIGNED date ) := if(date=0, NULL, max(0,(INTEGER)history_date[1..4] - (INTEGER)((STRING)date)[1..4]));
		
		/* RISKVIEW ATTRIBUTES */
		is_Issued3       := (INTEGER)(((INTEGER)history_date - (INTEGER)(le.iid.socllowissue[1..6])) < 300);

	  date_derog       := Max(Max(le.bjl.last_criminal_date, (INTEGER)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
	  date_last_derog  := if(date_derog>fullDate, 0, date_derog);	
		mos_last_derog   := getMonths(date_last_derog);
		earliest_date_last_seen := min(
			checkDt(adl_EQ_last_seen),
			checkDt(adl_TU_last_seen),
			checkDt(adl_DL_last_seen),
			checkDt(adl_PR_last_seen),
			checkDt(adl_V_last_seen ),
			checkDt(adl_EM_last_seen),
			checkDt(adl_W_last_seen )
		);
		mos_last := if( earliest_date_last_seen=-NULL, NULL, getMonths(earliest_date_last_seen));
		cri_lst                          := getMonths(crim_last_date);
		add1_built_date_yr               := getYears(add1_built_date);
		add2_built_date_yr               := getYears(add2_built_date);
		add2_date_last_seen_mn := getMonths(add2_date_last_seen);
		/* **************************************************************** */

		mos_last_derog_w := MAP(
			mos_last_derog = NULL	=> -0.090580,
			mos_last_derog <= 16	=> 0.366458,
			mos_last_derog <= 19	=> 0.305536,
			mos_last_derog <= 20	=> 0.285502,
			mos_last_derog <= 32	=> 0.253039,
			mos_last_derog <= 36	=> 0.220782,
			mos_last_derog <= 48	=> 0.185248,
			mos_last_derog <= 70	=> 0.117898,
			mos_last_derog <= 84	=> 0.068269,
			mos_last_derog <= 93	=> -0.188980,
			mos_last_derog <= 103	=> -0.213684,
															 -0.300735
		);
		
		add1_avm_med_fips_w := 0.187836;
		
		mos_last_w := MAP(
			mos_last = NULL	=> 0.187836,
			mos_last <= 6		=> 0.136163,
			mos_last <= 19	=> -0.033797,
			mos_last <= 38	=> -0.059581,
			mos_last <= 41	=> -0.129087,
			mos_last <= 42	=> -0.195255,
			mos_last <= 144	=> -0.255176,
			mos_last <= 154	=> -0.304879,
			mos_last <= 201	=> -0.530901,
			mos_last <= 238	=> -0.718394,
												 -0.755998
		);
		
		addrs_10yr_w := 0.187836;
		
		add1_built_date_yr_w := MAP(
			add1_built_date_yr = NULL	=> 0.044511,
			add1_built_date_yr <= 1		=> -0.086265,
			add1_built_date_yr <= 2		=> -0.107060,
			add1_built_date_yr <= 4		=> -0.120887,
			add1_built_date_yr <= 9		=> -0.109247,
			add1_built_date_yr <= 15	=> -0.103613,
			add1_built_date_yr <= 20	=> -0.091490,
			add1_built_date_yr <= 32	=> -0.079455,
			add1_built_date_yr <= 33	=> -0.051887,
			add1_built_date_yr <= 43	=> -0.028685,
			add1_built_date_yr <= 53	=> -0.004820,
			add1_built_date_yr <= 56	=> 0.003371,
			add1_built_date_yr <= 58	=> 0.004309,
			add1_built_date_yr <= 73	=> 0.021565,
			add1_built_date_yr <= 79	=> 0.102199,
			add1_built_date_yr <= 81	=> 0.117241,
																	 0.125657
		);
		
		cri_lst_w := MAP(
			cri_lst = NULL	=> -0.029277,
			cri_lst <= 20		=> 0.696082,
			cri_lst <= 27		=> 0.677940,
			cri_lst <= 35		=> 0.617647,
			cri_lst <= 43		=> 0.545001,
			cri_lst <= 52		=> 0.490834,
			cri_lst <= 61		=> 0.446288,
			cri_lst <= 71		=> 0.415019,
												 0.330564
		);
		
		dist_a1toa2_w := MAP(
			dist_a1toa2 = NULL	=> 0.102328,
			dist_a1toa2 = 0			=> -0.097609,
			dist_a1toa2 <= 5		=> 0.036263,
			dist_a1toa2 <= 16		=> 0.073101,
			dist_a1toa2 <= 38		=> 0.084068,
			dist_a1toa2 <= 41		=> 0.130892,
			dist_a1toa2 <= 60		=> 0.093794,
			dist_a1toa2 <= 126	=> 0.082445,
			dist_a1toa2 <= 159	=> 0.075130,
			dist_a1toa2 <= 187	=> 0.023793,
			dist_a1toa2 <= 217	=> 0.011640,
			dist_a1toa2 <= 664	=> -0.044877,
			dist_a1toa2 <= 713	=> -0.124818,
			dist_a1toa2 <= 1023	=> -0.198882,
														 -0.202488
		);
		
		add2_avm_sales_price_w := -0.013312;
		
		property_owned_total_w := 0.187836;
		
		add1_purchase_amount_w := 0.187836;
		
		addr_stability_w := MAP(
			addr_stability = NULL => 0.187836,
			addr_stability <= 1		=> 0.184200,
			addr_stability <= 4		=> 0.026694,
			addr_stability <= 5		=> -0.172563,
															 -0.352394
		);
		
		add2_built_date_yr_w := MAP(
			add2_built_date_yr = NULL	=> 0.005255,
			add2_built_date_yr <= 4		=> 0.048262,
			add2_built_date_yr <= 6		=> 0.027815,
			add2_built_date_yr <= 7		=> -0.032833,
			add2_built_date_yr <= 22	=> -0.049827,
			add2_built_date_yr <= 23	=> -0.092312,
			add2_built_date_yr <= 28	=> -0.110535,
			add2_built_date_yr <= 32	=> -0.080031,
			add2_built_date_yr <= 45	=> -0.040288,
			add2_built_date_yr <= 52	=> -0.005104,
			add2_built_date_yr <= 59	=> -0.003063,
			add2_built_date_yr <= 64	=> 0.038099,
			add2_built_date_yr <= 71	=> 0.066950,
			add2_built_date_yr <= 76	=> 0.071832,
																	 0.101579
		);
		
		dist_a1toa3_w := MAP(
			dist_a1toa3 = NULL	=> 0.093646,
			dist_a1toa3 = 0			=> -0.097351,
			dist_a1toa3 <= 3		=> 0.027128,
			dist_a1toa3 <= 9		=> 0.029172,
			dist_a1toa3 <= 15		=> 0.043227,
			dist_a1toa3 <= 41		=> 0.044258,
			dist_a1toa3 <= 49		=> 0.083826,
			dist_a1toa3 <= 124	=> 0.068777,
			dist_a1toa3 <= 155	=> 0.026809,
			dist_a1toa3 <= 207	=> 0.016687,
			dist_a1toa3 <= 223	=> -0.016344,
			dist_a1toa3 <= 688	=> -0.047541,
			dist_a1toa3 <= 785	=> -0.140524,
			dist_a1toa3 <= 914	=> -0.172603,
														 -0.190141
		);
		
		ssns_per_addr_w := MAP(
			ssns_per_addr = NULL	=> 0.187836,
			ssns_per_addr <= 6		=> -0.104378,
			ssns_per_addr <= 8		=> -0.075616,
			ssns_per_addr <= 9		=> 0.000900,
			ssns_per_addr <= 12		=> 0.020874,
			ssns_per_addr <= 16		=> 0.060958,
			ssns_per_addr <= 17		=> 0.097772,
			ssns_per_addr <= 19		=> 0.125263,
			ssns_per_addr <= 22		=> 0.148072,
			ssns_per_addr <= 30		=> 0.190564,
															 0.217204
		);
		
		isIssued3_w := MAP(
			is_Issued3 = NULL	=> 0.187836,
			is_Issued3 = 0		=> -0.001138,
													 -0.502536
		);
		
		add2_date_last_seen_mn_w := MAP(
			add2_date_last_seen_mn = NULL	=> 0.129658,
			add2_date_last_seen_mn <= 5		=> 0.087802,
			add2_date_last_seen_mn <= 9		=> 0.074897,
			add2_date_last_seen_mn <= 10	=> 0.026881,
			add2_date_last_seen_mn <= 18	=> -0.005088,
			add2_date_last_seen_mn <= 23	=> -0.025180,
			add2_date_last_seen_mn <= 27	=> -0.060578,
			add2_date_last_seen_mn <= 31	=> -0.083978,
			add2_date_last_seen_mn <= 37	=> -0.145890,
			add2_date_last_seen_mn <= 66	=> -0.279969,
			add2_date_last_seen_mn <= 102	=> -0.345466,
			add2_date_last_seen_mn <= 130	=> -0.379295,
			add2_date_last_seen_mn <= 146	=> -0.484273,
			add2_date_last_seen_mn <= 175	=> -0.532643,
			add2_date_last_seen_mn <= 201	=> -0.620686,
			add2_date_last_seen_mn <= 265	=> -0.778218,
																			 -0.860435
		);

		ind := if( models.common.isRV3Unscorable(le), 'Un-scorable', 'Scorable' );
			
		xb := if( ind='Un-scorable', 999,
			 mos_last_derog_w        * -1.17938161
     + add1_avm_med_fips_w     * -1.19866134
     + mos_last_w              * -0.44493393
     + addrs_10yr_w            * -0.51992718
     + add1_built_date_yr_w    * -1.29308637
     + cri_lst_w               * -0.86138849
     + dist_a1toa2_w           * -0.63534419
     + add2_avm_sales_price_w  * -1.49744073
     + property_owned_total_w  * -0.30784836
     + add1_purchase_amount_w  * -0.77972920
     + addr_stability_w        * -0.29459323
     + add2_built_date_yr_w    * -1.17991407
     + dist_a1toa3_w           * -0.45752085
     + ssns_per_addr_w         * -0.23664713
     + isIssued3_w             * -0.49118133
     + add2_date_last_seen_mn_w* -0.11281910
			);

		#if(MV36_DEBUG)
						/* Input Variables */
			SELF.crim_last_date := crim_last_date;
			SELF.addr_stability := addr_stability;
			SELF.add2_date_last_seen := add2_date_last_seen;
			SELF.add1_built_date := add1_built_date;
			SELF.add2_built_date := add2_built_date;
			SELF.ssns_per_addr := ssns_per_addr;
			SELF.dist_a1toa2 := dist_a1toa2;
			SELF.dist_a1toa3 := dist_a1toa3;
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
			
			SELF.history_date := history_date;
			SELF.is_Issued3 := is_Issued3;
			SELF.date_derog := date_derog;
			SELF.date_last_derog := date_last_derog;
			SELF.mos_last_derog := mos_last_derog;
			SELF.earliest_date_last_seen := earliest_date_last_seen;
			SELF.mos_last := mos_last;
			SELF.cri_lst := cri_lst;
			SELF.add1_built_date_yr := add1_built_date_yr;
			SELF.add2_built_date_yr := add2_built_date_yr;
			SELF.add2_date_last_seen_mn := add2_date_last_seen_mn;
			
			/* Intermediate Variables */
			SELF.mos_last_derog_w := mos_last_derog_w;
			SELF.add1_avm_med_fips_w := add1_avm_med_fips_w;
			SELF.mos_last_w := mos_last_w;
			SELF.addrs_10yr_w := addrs_10yr_w;
			SELF.add1_built_date_yr_w := add1_built_date_yr_w;
			SELF.cri_lst_w := cri_lst_w;
			SELF.dist_a1toa2_w := dist_a1toa2_w;
			SELF.add2_avm_sales_price_w := add2_avm_sales_price_w;
			SELF.property_owned_total_w := property_owned_total_w;
			SELF.add1_purchase_amount_w := add1_purchase_amount_w;
			SELF.addr_stability_w := addr_stability_w;
			SELF.add2_built_date_yr_w := add2_built_date_yr_w;
			SELF.dist_a1toa3_w := dist_a1toa3_w;
			SELF.ssns_per_addr_w := ssns_per_addr_w;
			SELF.isIssued3_w := isIssued3_w;
			SELF.add2_date_last_seen_mn_w := add2_date_last_seen_mn_w;
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

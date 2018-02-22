import ut, riskwise, risk_indicators, std;

export WOMV002_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	WOMV_DEBUG := false;

	#if(WOMV_DEBUG)
	layout_debug := record
		integer seq;
		real4 score;
		Integer crim_last_date;
		Integer cri_lst;
		Integer addr_stability;
		String wealth_indicator;
		Integer add1_date_last_seen_mn;
		Integer add3_date_last_seen_mn;
		Integer add1_built_date;
		Integer add2_built_date;
		Integer add3_built_date;
		Integer ssns_per_addr;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		String add1_avm_recording_date;
		Integer add1_avm_med_fips;
		String add2_avm_sales_price;
		Integer add2_mortgage_date;
		Integer adl_EQ_first_seen;
		Integer adl_TU_first_seen;
		Integer adl_DL_first_seen;
		Integer adl_PR_first_seen;
		Integer adl_V_first_seen;
		Integer adl_EM_first_seen;
		Integer adl_W_first_seen;
		Integer adl_EQ_last_seen;
		Integer adl_TU_last_seen;
		Integer adl_DL_last_seen;
		Integer adl_PR_last_seen;
		Integer adl_V_last_seen;
		Integer adl_EM_last_seen;
		Integer adl_W_last_seen;
		
		boolean is_fcra;
		boolean truedid;
		integer nas_summary;
		integer nap_summary;
		integer cvi;
		string rc_sources;
		string out_addr_status;
		integer credit_sourced;
		// boolean rc_decsflag;
		String rc_decsflag;
		Integer combo_fnamecount;
		Integer combo_lnamecount;
		Integer combo_addrcount;
		Integer combo_ssncount;
		integer add1_naprop;
		String history_date;
		Integer num_liens;
		Integer CAaddrChooser;
		Integer CALastSaleDate;
		String statusAddr1;
		Integer date_last_proflic;
		Integer earliest_date_last_seen;
		Integer mos_last;
		Integer add1_avm_recording_mn;
		Integer add2_mortgage_mn;
		Integer mos_last_proflic;
		Integer CALastSaleDate_mn;
		Integer add1_built_date_yr;
		Integer add2_built_date_yr;
		Integer add3_built_date_yr;
		Real num_liens_w;
		Real cri_lst_w;
		Real add1_avm_med_fips_w;
		Real add3_date_last_seen_mn_w;
		Real mos_last_w;
		Real ssns_per_addr_w;
		Real add2_avm_sales_price_w;
		Real dist_a1toa2_w;
		Real add1_date_last_seen_mn_w;
		Real add1_built_date_yr_w;
		Real addr_stability_w;
		Real dist_a1toa3_w;
		Real statusAddr_o_w;
		Real add2_mortgage_mn_w;
		Real add2_built_date_yr_w;
		Real add1_avm_recording_mn_w;
		Real add3_built_date_yr_w;
		Real mos_last_proflic_w;
		Real CALastSaleDate_mn_w;
		boolean first_seen;
		string ind;
		Real boca;
		
		Integer add1_date_last_seen;
		Integer add3_date_last_seen;
		boolean statusaddr_o;
		// String add1_built_date;
		// String add2_built_date;
		// String add3_built_date;
	end;
	layout_debug doModel( clam le) := TRANSFORM
	#else
	
	layout_mvr := record
		integer seq;
		real4 score;
	end;
	layout_mvr doModel( clam le) := TRANSFORM
	#end

		crim_last_date                   := le.bjl.last_criminal_date;
		addr_stability                   := (integer)le.mobility_indicator;
		wealth_indicator                 := le.wealth_indicator;
		add1_date_last_seen              := le.Address_Verification.Input_Address_Information.date_last_seen;
		add3_date_last_seen              := le.Address_Verification.Address_History_2.date_last_seen;
		add1_built_date                  := le.Address_Verification.Input_Address_Information.built_date;
		add2_built_date                  := le.Address_Verification.Address_History_1.built_date;
		add3_built_date                  := le.Address_Verification.Address_History_2.built_date;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add1_avm_recording_date          := le.AVM.Input_Address_Information.avm_recording_date;
		add1_avm_med_fips                := le.AVM.Input_Address_Information.avm_median_fips_level;
		add2_avm_sales_price             := le.AVM.Address_History_1.avm_sales_price;
		add2_mortgage_date               := le.Address_Verification.Address_History_1.mortgage_date;
		
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

		history_date                     := if( le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.historydate );

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
			num_liens := le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
			             le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count;
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
			
			statusAddr1 := map(le.address_verification.input_address_information.applicant_owned or 
														le.address_verification.input_address_information.applicant_sold or
														le.address_verification.input_address_information.family_owned or 
														le.address_verification.input_address_information.family_sold => 'O',// owned
										 ~le.address_verification.input_address_information.occupant_owned and
														le.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
			date_last_proflic := if(le.professional_license.date_most_recent>(unsigned4)(history_date+'01'), 0, le.professional_license.date_most_recent);
		/* RISKVIEW ATTRIBUTES */

		/******************************************************************/
		/* CREATE 'INPUT' VALUES USED BY THE MODEL */
		NULL := -999999999;
		checkDt( unsigned3 dls ) := if( dls=0, -NULL, dls );
		getMonths( unsigned date ) := if(date=0, NULL, max(0,((integer)history_date[1..4] - (integer)((STRING)date)[1..4])*12
		                           + (integer)history_date[5..6] - (integer)((STRING)date)[5..6]));
		getYears( unsigned date ) := if(date=0, NULL, max(0,(integer)history_date[1..4] - (integer)((STRING)date)[1..4]));
		
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
		add1_avm_recording_mn            := getMonths((unsigned)add1_avm_recording_date);
		add2_mortgage_mn                 := getMonths(add2_mortgage_date);
		mos_last_proflic                 := getMonths(date_last_proflic);
		CALastSaleDate_mn                := getMonths(CALastSaleDate);

		cri_lst                          := getMonths(crim_last_date);
		add1_built_date_yr               := getYears(add1_built_date);
		add2_built_date_yr               := getYears(add2_built_date);
		add3_built_date_yr               := getYears(add3_built_date);
		
		
		add1_date_last_seen_mn := getMonths(add1_date_last_seen);
		add3_date_last_seen_mn := getMonths(add3_date_last_seen);
		/******************************************************************/

		num_liens_w := map(
			num_liens = 0    => -0.154615,
			num_liens <= 1    => 0.448256,
			num_liens <= 2    => 0.479972,
			num_liens <= 3    => 0.593781,
			num_liens <= 6    => 0.636284,
			num_liens <= 7    => 0.728814,
			0.771148
		);

		cri_lst_w := map(
			cri_lst <   0    => -0.054009,
			cri_lst <= 13    =>  1.263474,
			cri_lst <= 18    =>  1.046515,
			cri_lst <= 28    =>  0.855720,
			cri_lst <= 49    =>  0.737123,
			cri_lst <= 62    =>  0.674594,
			cri_lst <= 74    =>  0.596584,
			cri_lst <= 81    =>  0.493136,
			0.576751
		);

		add1_avm_med_fips_w := map(
			add1_avm_med_fips <= 99762    => -0.290978,
			add1_avm_med_fips <= 100870   =>   -0.079821,
			add1_avm_med_fips <= 241093   =>    0.097120,
			add1_avm_med_fips <= 285529   =>    0.197613,
			add1_avm_med_fips <= 316932   =>    0.274522,
			0.337444
		);

		add3_date_last_seen_mn_w := map(
			add3_date_last_seen_mn <  0    =>    0.184110,
			add3_date_last_seen_mn <= 9    =>    0.254461,
			add3_date_last_seen_mn <= 19   =>    0.155281,
			add3_date_last_seen_mn <= 26   =>    0.073183,
			add3_date_last_seen_mn <= 36   =>    0.007708,
			add3_date_last_seen_mn <= 38   =>   -0.118103,
			add3_date_last_seen_mn <= 70   =>   -0.218221,
			add3_date_last_seen_mn <= 100  =>   -0.302055,
			add3_date_last_seen_mn <= 152  =>   -0.492725,
			add3_date_last_seen_mn <= 165  =>   -0.656077,
			add3_date_last_seen_mn <= 198  =>   -0.839888,
			add3_date_last_seen_mn <= 284  =>   -1.010549,
			-1.504666
		);

		mos_last_w := map(
			mos_last <= 6   =>    0.214843,
			mos_last <= 18  =>   -0.087148,
			mos_last <= 19  =>   -0.099274,
			mos_last <= 37  =>   -0.108282,
			mos_last <= 40  =>   -0.236786,
			mos_last <= 41  =>   -0.288279,
			mos_last <= 42  =>   -0.369205,
			mos_last <= 84  =>   -0.493585,
			-0.445377
		);

		ssns_per_addr_w := map(
			ssns_per_addr <= 6     =>   -0.208917,
			ssns_per_addr <= 8     =>   -0.142348,
			ssns_per_addr <= 11    =>   -0.007636,
			ssns_per_addr <= 15    =>    0.089389,
			ssns_per_addr <= 17    =>    0.168331,
			ssns_per_addr <= 22    =>    0.267250,
			ssns_per_addr <= 30    =>    0.351847,
			0.439286
		);

		add2_avm_sales_price_w := map(
			add2_avm_sales_price =  ''       => -0.023461,
			(integer)add2_avm_sales_price <= 42500    =>  0.346908,
			(integer)add2_avm_sales_price <= 88000    =>  0.194282,
			(integer)add2_avm_sales_price <= 106100   =>  0.117835,
			(integer)add2_avm_sales_price <= 128000   =>  0.059145,
			(integer)add2_avm_sales_price <= 211200   =>  0.016528,
			-0.090964
		);

		dist_a1toa2_w := map(
			dist_a1toa2 <  0 or dist_a1toa2 =9999   =>  0.204329,
			dist_a1toa2  = 0    => -0.134451,
			dist_a1toa2 <= 18   =>  0.088118,
			dist_a1toa2 <= 20   =>  0.092532,
			dist_a1toa2 <= 21   =>  0.096619,
			dist_a1toa2 <= 23   =>  0.110502,
			dist_a1toa2 <= 31   =>  0.118272,
			dist_a1toa2 <= 43   =>  0.123704,
			dist_a1toa2 <= 56   =>  0.215567,
			dist_a1toa2 <= 60   =>  0.164102,
			dist_a1toa2 <= 104  =>  0.080544,
			dist_a1toa2 <= 110  =>  0.053480,
			dist_a1toa2 <= 128  =>  0.043234,
			dist_a1toa2 <= 148  =>  0.018297,
			dist_a1toa2 <= 216  => -0.012605,
			dist_a1toa2 <= 227  => -0.047712,
			dist_a1toa2 <= 262  => -0.080922,
			dist_a1toa2 <= 437  => -0.167480,
			dist_a1toa2 <= 1007 => -0.254994,
			dist_a1toa2 <= 1042 => -0.267053,
			dist_a1toa2 <= 1165 => -0.334981,
			-0.379851
		);

		add1_date_last_seen_mn_w := map(
			add1_date_last_seen_mn <  0   =>    0.324572,
			add1_date_last_seen_mn  = 0   =>   -0.113111,
			add1_date_last_seen_mn <= 1   =>    0.280708,
			add1_date_last_seen_mn <= 2   =>    0.299866,
			add1_date_last_seen_mn <= 3   =>    0.446649,
			add1_date_last_seen_mn <= 10  =>    0.487225,
			add1_date_last_seen_mn <= 11  =>    0.319727,
			add1_date_last_seen_mn <= 34  =>    0.227341,
			add1_date_last_seen_mn <= 42  =>    0.136313,
			-0.199521
		);

		add1_built_date_yr_w := map(
			add1_built_date_yr  = NULL =>    0.048651,
			add1_built_date_yr  = 0    =>   -0.349306,
			add1_built_date_yr <= 13   =>   -0.222991,
			add1_built_date_yr <= 32   =>   -0.124633,
			add1_built_date_yr <= 58   =>    0.016947,
			add1_built_date_yr <= 72   =>    0.108895,
			0.247132
		);

		addr_stability_w := map(
			addr_stability <= 1   =>    0.293818,
			addr_stability <= 4   =>    0.038937,
			addr_stability <= 5   =>   -0.285675,
			-0.558574
		);

		dist_a1toa3_w := map(
			dist_a1toa3 <  0 or dist_a1toa3=9999    =>    0.161479,
			dist_a1toa3  = 0     =>   -0.143672,
			dist_a1toa3 <= 31    =>    0.063056,
			dist_a1toa3 <= 34    =>    0.090029,
			dist_a1toa3 <= 36    =>    0.134031,
			dist_a1toa3 <= 54    =>    0.082375,
			dist_a1toa3 <= 100   =>    0.051933,
			dist_a1toa3 <= 137   =>    0.017293,
			dist_a1toa3 <= 210   =>   -0.010511,
			dist_a1toa3 <= 220   =>   -0.038496,
			dist_a1toa3 <= 242   =>   -0.040597,
			dist_a1toa3 <= 254   =>   -0.156963,
			dist_a1toa3 <= 686   =>   -0.200649,
			dist_a1toa3 <= 975   =>   -0.248292,
			dist_a1toa3 <= 1148  =>   -0.291394,
			-0.366256
		);

		statusAddr_o := statusAddr1 = 'O';
		statusAddr_o_w := if( statusaddr_o, -0.296931, 0.158704 );

		add2_mortgage_mn_w := map(
			add2_mortgage_mn <  0     =>   -0.000566,
			add2_mortgage_mn <= 1     =>   -0.167471,
			add2_mortgage_mn <= 2     =>   -0.154756,
			add2_mortgage_mn <= 3     =>   -0.138453,
			add2_mortgage_mn <= 8     =>   -0.023949,
			add2_mortgage_mn <= 11    =>    0.033935,
			add2_mortgage_mn <= 14    =>    0.034871,
			add2_mortgage_mn <= 19    =>    0.097151,
			add2_mortgage_mn <= 22    =>    0.110456,
			add2_mortgage_mn <= 23    =>    0.282863,
			add2_mortgage_mn <= 24    =>    0.055289,
			add2_mortgage_mn <= 43    =>    0.019808,
			add2_mortgage_mn <= 46    =>   -0.057025,
			-0.086983
		);

		add2_built_date_yr_w := map(
			add2_built_date_yr = NULL =>    0.011369,
			add2_built_date_yr <= 3   =>   -0.004794,
			add2_built_date_yr <= 5   =>   -0.044704,
			add2_built_date_yr <= 7   =>   -0.051153,
			add2_built_date_yr <= 11  =>   -0.107201,
			add2_built_date_yr <= 21  =>   -0.149593,
			add2_built_date_yr <= 25  =>   -0.178417,
			add2_built_date_yr <= 30  =>   -0.133186,
			add2_built_date_yr <= 32  =>   -0.123878,
			add2_built_date_yr <= 45  =>   -0.036857,
			add2_built_date_yr <= 59  =>    0.016825,
			add2_built_date_yr <= 65  =>    0.041169,
			add2_built_date_yr <= 69  =>    0.093575,
			add2_built_date_yr <= 81  =>    0.145200,
			add2_built_date_yr <= 84  =>    0.182781,
			0.199561
		);

		add1_avm_recording_mn_w := map(
			add1_avm_recording_mn <  0    =>   -0.052997,
			add1_avm_recording_mn <= 28   =>    0.194349,
			add1_avm_recording_mn <= 34   =>    0.119672,
			0.065594
		);

		add3_built_date_yr_w := map(
			add3_built_date_yr = NULL =>    0.005818,
			add3_built_date_yr <= 3   =>    0.085169,
			add3_built_date_yr <= 6   =>    0.071682,
			add3_built_date_yr <= 7   =>    0.040504,
			add3_built_date_yr <= 8   =>   -0.017132,
			add3_built_date_yr <= 21  =>   -0.087601,
			add3_built_date_yr <= 22  =>   -0.091358,
			add3_built_date_yr <= 23  =>   -0.137385,
			add3_built_date_yr <= 24  =>   -0.141533,
			add3_built_date_yr <= 27  =>   -0.182991,
			add3_built_date_yr <= 29  =>   -0.202914,
			add3_built_date_yr <= 33  =>   -0.156030,
			add3_built_date_yr <= 34  =>   -0.106215,
			add3_built_date_yr <= 49  =>   -0.030856,
			add3_built_date_yr <= 57  =>   -0.004991,
			add3_built_date_yr <= 63  =>    0.005088,
			add3_built_date_yr <= 85  =>    0.094109,
			0.212458
		);

		mos_last_proflic_w := map(
			mos_last_proflic <  0    =>    0.016918,
			mos_last_proflic <= 21   =>   -0.446071,
			mos_last_proflic <= 39   =>   -0.186877,
			-0.015078
		);

		CALastSaleDate_mn_w := map(
			CALastSaleDate_mn <  0    =>   -0.000979,
			CALastSaleDate_mn <= 1    =>   -0.126557,
			CALastSaleDate_mn <= 3    =>   -0.065185,
			CALastSaleDate_mn <= 7    =>    0.004956,
			CALastSaleDate_mn <= 8    =>    0.027902,
			CALastSaleDate_mn <= 11   =>    0.035874,
			CALastSaleDate_mn <= 13   =>    0.076818,
			CALastSaleDate_mn <= 20   =>    0.093874,
			CALastSaleDate_mn <= 29   =>    0.049228,
			CALastSaleDate_mn <= 47   =>    0.012156,
			CALastSaleDate_mn <= 63   =>   -0.090513,
			CALastSaleDate_mn <= 105  =>   -0.092299,
			CALastSaleDate_mn <= 121  =>   -0.121721,
			CALastSaleDate_mn <= 125  =>   -0.151147,
			CALastSaleDate_mn <= 157  =>   -0.152497,
			CALastSaleDate_mn <= 163  =>   -0.168726,
			-0.227507
		);



		first_seen := adl_eq_first_seen > 0 or
			adl_tu_first_seen > 0 or
			adl_dl_first_seen > 0 or
			adl_pr_first_seen > 0 or
			adl_v_first_seen  > 0 or
			adl_em_first_seen > 0 or
			adl_w_first_seen  > 0 or
			adl_eq_last_seen  > 0 or
			adl_tu_last_seen  > 0 or
			adl_dl_last_seen  > 0 or
			adl_pr_last_seen  > 0 or
			adl_v_last_seen   > 0 or
			adl_em_last_seen  > 0 or
			adl_w_last_seen > 0;
		ind := if( models.common.isRV3Unscorable(le), 'Un-scorable', 'Scorable' );

		boca := if( ind='Un-scorable', 999,
			-0.845305 * num_liens_w          +
				-0.892529 * cri_lst_w                +
				-0.661502 * add1_avm_med_fips_w      +
				-0.200504 * add3_date_last_seen_mn_w +
				-0.255017 * mos_last_w               +
				-0.146136 * ssns_per_addr_w          +
				-0.969071 * add2_avm_sales_price_w   +
				-0.277740 * dist_a1toa2_w            +
				-0.166271 * add1_date_last_seen_mn_w +
				-0.558020 * add1_built_date_yr_w     +
				-0.167814 * addr_stability_w         +
				-0.246878 * dist_a1toa3_w            +
				-0.143277 * statusAddr_o_w           +
				-0.873104 * add2_mortgage_mn_w       +
				-0.528029 * add2_built_date_yr_w     +
				-0.940465 * add1_avm_recording_mn_w  +
				-0.366925 * add3_built_date_yr_w     +
				-0.195933 * mos_last_proflic_w       +
				-0.426610 * CALastSaleDate_mn_w
			);


		#if(WOMV_DEBUG)
			self.cri_lst := cri_lst;
			self.addr_stability := addr_stability;
			self.wealth_indicator := wealth_indicator;
			self.add1_date_last_seen_mn := add1_date_last_seen_mn;
			self.add3_date_last_seen_mn := add3_date_last_seen_mn;
			self.add1_built_date := add1_built_date;
			self.add2_built_date := add2_built_date;
			self.add3_built_date := add3_built_date;
			self.ssns_per_addr := ssns_per_addr;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.add1_avm_recording_date := add1_avm_recording_date;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add2_avm_sales_price := add2_avm_sales_price;
			self.add2_mortgage_date := add2_mortgage_date;
			self.adl_EQ_first_seen := adl_EQ_first_seen;
			self.adl_TU_first_seen := adl_TU_first_seen;
			self.adl_DL_first_seen := adl_DL_first_seen;
			self.adl_PR_first_seen := adl_PR_first_seen;
			self.adl_V_first_seen := adl_V_first_seen;
			self.adl_EM_first_seen := adl_EM_first_seen;
			self.adl_W_first_seen := adl_W_first_seen;
			self.adl_EQ_last_seen := adl_EQ_last_seen;
			self.adl_TU_last_seen := adl_TU_last_seen;
			self.adl_DL_last_seen := adl_DL_last_seen;
			self.adl_PR_last_seen := adl_PR_last_seen;
			self.adl_V_last_seen := adl_V_last_seen;
			self.adl_EM_last_seen := adl_EM_last_seen;
			self.adl_W_last_seen := adl_W_last_seen;
			self.history_date := history_date;
			self.is_fcra := is_fcra;
			
			self.truedid := truedid;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.cvi := cvi;
			self.rc_sources := rc_sources;
			self.out_addr_status := out_addr_status;
			self.credit_sourced := credit_sourced;
			self.rc_decsflag := rc_decsflag;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_lnamecount := combo_lnamecount;
			self.combo_addrcount := combo_addrcount;
			self.combo_ssncount := combo_ssncount;
			self.add1_naprop := add1_naprop;
			
			self.num_liens := num_liens;
			self.CAaddrChooser := CAaddrChooser;
			self.CALastSaleDate := CALastSaleDate;
			self.statusAddr1 := statusAddr1;
			self.date_last_proflic := date_last_proflic;
			self.earliest_date_last_seen := earliest_date_last_seen;
			self.mos_last := mos_last;
			self.add1_avm_recording_mn := add1_avm_recording_mn;
			self.add2_mortgage_mn := add2_mortgage_mn;
			self.mos_last_proflic := mos_last_proflic;
			self.CALastSaleDate_mn := CALastSaleDate_mn;
			self.add1_built_date_yr := add1_built_date_yr;
			self.add2_built_date_yr := add2_built_date_yr;
			self.add3_built_date_yr := add3_built_date_yr;
			self.num_liens_w := num_liens_w;
			self.cri_lst_w := cri_lst_w;
			self.add1_avm_med_fips_w := add1_avm_med_fips_w;
			self.add3_date_last_seen_mn_w := add3_date_last_seen_mn_w;
			self.mos_last_w := mos_last_w;
			self.ssns_per_addr_w := ssns_per_addr_w;
			self.add2_avm_sales_price_w := add2_avm_sales_price_w;
			self.dist_a1toa2_w := dist_a1toa2_w;
			self.add1_date_last_seen_mn_w := add1_date_last_seen_mn_w;
			self.add1_built_date_yr_w := add1_built_date_yr_w;
			self.addr_stability_w := addr_stability_w;
			self.dist_a1toa3_w := dist_a1toa3_w;
			self.statusAddr_o_w := statusAddr_o_w;
			self.add2_mortgage_mn_w := add2_mortgage_mn_w;
			self.add2_built_date_yr_w := add2_built_date_yr_w;
			self.add1_avm_recording_mn_w := add1_avm_recording_mn_w;
			self.add3_built_date_yr_w := add3_built_date_yr_w;
			self.mos_last_proflic_w := mos_last_proflic_w;
			self.CALastSaleDate_mn_w := CALastSaleDate_mn_w;
			self.first_seen := first_seen;
			self.ind := ind;
			self.boca := boca;
			
			self.crim_last_date := crim_last_date;
			self.add1_date_last_seen := add1_date_last_seen;
			self.add3_date_last_seen := add3_date_last_seen;
			self.statusaddr_o := statusaddr_o;
		#end;
		self.seq := le.seq;
		self.score := boca;
	END;
		
	model := project( clam, doModel(LEFT) );
	
	return model;
END;

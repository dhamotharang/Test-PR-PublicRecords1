import risk_indicators, ut, riskwise, std;

export MX361006_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	MX36_DEBUG := false;

	#if(MX36_DEBUG)
	layout_debug := record
		integer seq;
		real4 score;
		Integer liens_recent_unreleased_count;
    Integer total_number_derogs;
		Integer crim_last_date;
		Integer cri_lst;
		Integer addr_stability;
		Integer add2_date_last_seen_mn;
		Integer add1_built_date;
		Integer add3_built_date;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		String add2_avm_recording_date;
		Integer add1_avm_med_fips;
		String add1_avm_sales_price;
    Integer property_owned_total;
    Integer addrs_10yr;
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
		String rc_decsflag;
		Integer combo_fnamecount;
		Integer combo_lnamecount;
		Integer combo_addrcount;
		Integer combo_ssncount;
		integer add1_naprop;
		String history_date;
		Integer CAaddrChooser;
		Integer CALastSaleDate;
		Integer earliest_date_last_seen;
		Integer add2_avm_recording_mn;
		Integer CALastSaleDate_mn;
		Integer add1_built_date_yr;
		Integer add3_built_date_yr;
		Real liens_recent_unreleased_count_w;
    Real total_number_derogs_w;
		Real cri_lst_w;
		Real add1_avm_med_fips_w;
		Real add2_date_last_seen_mn_w;
		Real dist_a1toa2_w;
		Real add1_built_date_yr_w;
		Real addr_stability_w;
		Real dist_a1toa3_w;
		Real add2_avm_recording_mn_w;
		Real add3_built_date_yr_w;
		Real add1_avm_sales_price_w;
		Real property_owned_total_w;
		Real addrs_10yr_w;
		Real CALastSaleDate_mn_w;
		boolean first_seen;
		string ind;
		Real boca;
		Integer add2_date_last_seen;

	end;
	layout_debug doModel( clam le) := TRANSFORM
	#else
	
	layout_mvr := record
		integer seq;
		real4 score;
	end;
	layout_mvr doModel( clam le) := TRANSFORM
	#end

    total_number_derogs              := le.total_number_derogs;
		crim_last_date                   := le.bjl.last_criminal_date;
		addr_stability                   := (integer)le.mobility_indicator;
		add2_date_last_seen              := le.Address_Verification.Address_History_1.date_last_seen;
		add1_built_date                  := le.Address_Verification.Input_Address_Information.built_date;
		add3_built_date                  := le.Address_Verification.Address_History_2.built_date;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_avm_recording_date          := le.avm.address_history_1.avm_recording_date;
		add1_avm_med_fips                := le.AVM.Input_Address_Information.avm_median_fips_level;
    add1_avm_sales_price						 := le.AVM.Input_Address_Information.avm_sales_price;
    property_owned_total             := le.address_verification.owned.property_total;
    addrs_10yr                       := le.other_address_info.addrs_last_10years;
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
  		liens_recent_unreleased_count := le.bjl.liens_recent_unreleased_count;
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
		
		add2_avm_recording_mn            := getMonths((unsigned)add2_avm_recording_date);
		CALastSaleDate_mn                := getMonths(CALastSaleDate);
		cri_lst                          := getMonths(crim_last_date);
		add1_built_date_yr               := getYears(add1_built_date);
		add3_built_date_yr               := getYears(add3_built_date);
		add2_date_last_seen_mn           := getMonths(add2_date_last_seen);
		/******************************************************************/

		liens_recent_unreleased_count_w := map(	
			liens_recent_unreleased_count = 0    =>  0.031138,
			liens_recent_unreleased_count = 1    => -0.324934,
			liens_recent_unreleased_count = 2    => -0.418408,
			liens_recent_unreleased_count >= 3   => -0.421243,
			-0.185630
		);
	
		total_number_derogs_w := map(
			total_number_derogs = 0    => 0.067740,
			total_number_derogs = 1    => -0.153376,
			total_number_derogs = 2    => -0.268291,
			total_number_derogs = 3    => -0.355417,
			total_number_derogs = 4    => -0.369862,
			total_number_derogs <= 6    => -0.455663,
			total_number_derogs >= 7   => -0.506210,
			-0.179056
		);	
		
		cri_lst_w := map(
		  cri_lst  = NULL  =>  0.042158,
			cri_lst <= 21    => -0.867677,
			cri_lst <= 34    => -0.814657,
			cri_lst <= 48    => -0.660451,
			cri_lst >= 49    => -0.493217,
			0.042158
		);

		add1_avm_med_fips_w := map(
			add1_avm_med_fips <= 99762    =>     0.105355,
			add1_avm_med_fips <= 194504   =>     0.000501,
			add1_avm_med_fips <= 241093   =>    -0.103836,
			add1_avm_med_fips >= 241094   =>    -0.174502,
			-0.219651
		);

		add2_date_last_seen_mn_w := map(
		  add2_date_last_seen_mn  = NULL =>   -0.033995,
			add2_date_last_seen_mn <= 9    =>   -0.039077,
			add2_date_last_seen_mn <= 11   =>   -0.024697,
			add2_date_last_seen_mn <= 28   =>   -0.000111,
			add2_date_last_seen_mn <= 36   =>    0.026962,
			add2_date_last_seen_mn <= 38   =>    0.041268,
			add2_date_last_seen_mn  = 39   =>    0.091990,
			add2_date_last_seen_mn <= 74   =>    0.113822,
			add2_date_last_seen_mn <= 142  =>    0.140458,
			add2_date_last_seen_mn <= 153  =>    0.192299,
			add2_date_last_seen_mn <= 192  =>    0.223123,
			add2_date_last_seen_mn <= 263  =>    0.241577,
			add2_date_last_seen_mn >= 264  =>    0.335881,
			-0.033995
		);

		property_owned_total_w := map(
			property_owned_total  = 0    => -0.037444,
			property_owned_total  = 1    =>  0.067663,
			property_owned_total <= 3    =>  0.086841,
			property_owned_total  = 4    =>  0.137663,
			property_owned_total >= 5    =>  0.087849,
			-0.082129
		);		

		addrs_10yr_w := map(
			addrs_10yr = 0    =>  0.168169,
			addrs_10yr = 1    =>  0.048839,
			addrs_10yr = 2    =>  0.010969,
			addrs_10yr = 3    =>  -0.018235,
			addrs_10yr = 4    =>  -0.044291,
			addrs_10yr = 5    =>  -0.063835,
			addrs_10yr = 6    =>  -0.067056,
			addrs_10yr = 7    =>  -0.067907,
			addrs_10yr = 8    =>  -0.076178,
			addrs_10yr >= 9   =>  -0.095997,
			-0.107030
		);		

		add1_avm_sales_price_w := map(
			add1_avm_sales_price =  ''                 =>   0.045790,
			(integer)add1_avm_sales_price <= 62500     =>  -0.191336,
			(integer)add1_avm_sales_price <= 147000    =>  -0.123487,
			(integer)add1_avm_sales_price >= 147001    =>  -0.026919,
			0.019934
		);

		dist_a1toa2_w := map(
			dist_a1toa2 <  0 or dist_a1toa2 = 9999   =>  -0.037980,
			dist_a1toa2  = 0    =>  0.049143,
			dist_a1toa2 <= 1    => -0.036318,
			dist_a1toa2 <= 2   => -0.040425,
			dist_a1toa2 <= 3   => -0.042708,
			dist_a1toa2 <= 12   => -0.049320,
			dist_a1toa2 <= 15   => -0.056135,
			dist_a1toa2 <= 17  => -0.071596,
			dist_a1toa2  = 18  => -0.083147,
			dist_a1toa2 <= 25  => -0.093390,
			dist_a1toa2 <= 27  => -0.111640,
			dist_a1toa2 <= 37  =>  -0.143525,
			dist_a1toa2 <= 57  =>  -0.109393,
			dist_a1toa2 <= 67 =>  -0.105611,
			dist_a1toa2 <= 92 =>  -0.088621,
			dist_a1toa2 <= 155 =>  -0.065034,
			dist_a1toa2 <= 174 =>  -0.041334,
			dist_a1toa2 <= 242 =>  -0.004008,
			dist_a1toa2 <= 273 =>  0.026184,
			dist_a1toa2 <= 395 =>  0.051856,
			dist_a1toa2 <= 483 =>  0.076521,
			dist_a1toa2 <= 532 =>  0.088647,
			dist_a1toa2 <= 575 =>  0.089151,
			dist_a1toa2 <= 677 =>  0.131741,
			dist_a1toa2 <= 741 =>  0.137862,
			dist_a1toa2 <= 805 =>  0.179928,
			dist_a1toa2 <= 871 =>  0.189140,
			dist_a1toa2 >= 872 =>  0.232756,
			-0.037980
		);

		add1_built_date_yr_w := map(
		  add1_built_date_yr  = NULL =>     -0.045626,
			add1_built_date_yr <= 2    =>      0.234480,
			add1_built_date_yr <= 15   =>      0.128398,
			add1_built_date_yr <= 42   =>      0.065837,
			add1_built_date_yr <= 48   =>      0.007718,
			add1_built_date_yr <= 59   =>     -0.039071,
			add1_built_date_yr <= 77   =>     -0.089042,
			add1_built_date_yr <= 81   =>     -0.122839,
			add1_built_date_yr <= 128  =>     -0.152531,
			add1_built_date_yr >= 129  =>     -0.205421,
			-0.045626
		);

		addr_stability_w := map(
			addr_stability <= 1   =>    -0.036465,
			addr_stability <= 4   =>    -0.011271,
			addr_stability  = 5   =>     0.029622,
			addr_stability >= 6   =>     0.071351,
			-0.055086
		);

		dist_a1toa3_w := map(

			dist_a1toa3 <  0 or dist_a1toa3 = 9999    =>    -0.034194,
			dist_a1toa3  = 0    =>    0.059482,
			dist_a1toa3 <= 2    =>   -0.051235,
			dist_a1toa3 <= 15   =>   -0.060635,
			dist_a1toa3 <= 17   =>   -0.070715,
			dist_a1toa3 <= 25   =>   -0.125009,
			dist_a1toa3 <= 30   =>   -0.101731,
			dist_a1toa3 <= 56   =>   -0.097702,
			dist_a1toa3 <= 90   =>   -0.080872,
			dist_a1toa3 <= 119  =>   -0.041088,
			dist_a1toa3 <= 191  =>   -0.012152,
			dist_a1toa3 <= 269  =>    0.017273,
			dist_a1toa3 <= 302  =>    0.028530,
			dist_a1toa3 <= 722  =>    0.094683,
			dist_a1toa3 <= 786  =>    0.180687,
			dist_a1toa3 <= 851  =>    0.249912,
			dist_a1toa3 <= 1000 =>    0.257605,
			dist_a1toa3 >= 1001 =>    0.283650,
			-0.034194
		);

		add2_avm_recording_mn_w := map(
		  add2_avm_recording_mn  = NULL =>     0.020597,
			add2_avm_recording_mn <=  3   =>     0.129151,
			add2_avm_recording_mn <= 304  =>    -0.078067,
			add2_avm_recording_mn >=305   =>    -0.475660,
			0.020597
		);

		add3_built_date_yr_w := map(
			add3_built_date_yr  = NULL=>  -0.002282,
			add3_built_date_yr <= 8   =>  -0.018821,
			add3_built_date_yr <= 12  =>  -0.004523,
			add3_built_date_yr <= 22  =>   0.033750,
			add3_built_date_yr <= 24  =>   0.055154,
			add3_built_date_yr <= 28  =>   0.068514,
			add3_built_date_yr <= 30  =>   0.115992,
			add3_built_date_yr <= 41  =>   0.071534,
			add3_built_date_yr <= 43  =>   0.028782,
			add3_built_date_yr <= 49  =>   0.026879,
			add3_built_date_yr <= 51  =>   0.015780,
			add3_built_date_yr <= 53  =>   0.015365,
			add3_built_date_yr <= 66  =>  -0.040465,
			add3_built_date_yr <= 87  =>  -0.076326,
			add3_built_date_yr <= 107 =>  -0.080483,
			add3_built_date_yr >= 108 =>  -0.139830,
			-0.002282
		);

		CALastSaleDate_mn_w := map(
		  CALastSaleDate_mn  = NULL =>   -0.004042,
			CALastSaleDate_mn <= 2    =>    0.031157,
			CALastSaleDate_mn <= 4    =>    0.018040,
			CALastSaleDate_mn <= 11   =>   -0.022956,
			CALastSaleDate_mn <= 13   =>   -0.023161,
			CALastSaleDate_mn <= 16   =>   -0.060195,
			CALastSaleDate_mn  = 17   =>   -0.055489,
			CALastSaleDate_mn <= 29   =>    0.000060,
			CALastSaleDate_mn <= 33   =>    0.002034,
			CALastSaleDate_mn <= 44   =>    0.006016,
			CALastSaleDate_mn <= 83   =>    0.031888,
			CALastSaleDate_mn <= 108  =>    0.049698,
			CALastSaleDate_mn <= 132  =>    0.080508,
			CALastSaleDate_mn <= 161  =>    0.139223,
			CALastSaleDate_mn >= 162  =>    0.310055,
			-0.004042
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
			adl_w_last_seen   > 0;
		ind := if( models.common.isRV3Unscorable(le), 'Un-scorable', 'Scorable' );

		boca := if( ind='Un-scorable', 999,
       total_number_derogs_w          
     + add1_avm_med_fips_w            
     + dist_a1toa3_w                  
     + cri_lst_w                      
     + addrs_10yr_w                   
     + liens_recent_unreleased_count_w
     + add1_built_date_yr_w           
     + dist_a1toa2_w                  
     + add2_date_last_seen_mn_w       
     + add1_avm_sales_price_w         
     + add2_avm_recording_mn_w        
     + property_owned_total_w         
     + CALastSaleDate_mn_w            
     + add3_built_date_yr_w           
     + addr_stability_w               
		);

		#if(MX36_DEBUG)
  		self.total_number_derogs := total_number_derogs;
			self.cri_lst := cri_lst;
			self.addr_stability := addr_stability;
			self.add2_date_last_seen_mn := add2_date_last_seen_mn;
			self.add1_built_date := add1_built_date;
			self.add3_built_date := add3_built_date;
  		self.dist_a1toa2 := dist_a1toa2;
  		self.dist_a1toa3 := dist_a1toa3;
			self.add2_avm_recording_date := add2_avm_recording_date;
  		self.add1_avm_med_fips := add1_avm_med_fips;
 			self.add1_avm_sales_price := add1_avm_sales_price;
      self.property_owned_total := property_owned_total;
      self.addrs_10yr := addrs_10yr;
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
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.CAaddrChooser := CAaddrChooser;
			self.CALastSaleDate := CALastSaleDate;
			self.add2_avm_recording_mn := add2_avm_recording_mn;
			self.CALastSaleDate_mn := CALastSaleDate_mn;
			self.add1_built_date_yr := add1_built_date_yr;
			self.add3_built_date_yr := add3_built_date_yr;
			self.liens_recent_unreleased_count_w := liens_recent_unreleased_count_w;
  		self.cri_lst_w := cri_lst_w;
			self.add1_avm_med_fips_w := add1_avm_med_fips_w;
			self.add2_date_last_seen_mn_w := add2_date_last_seen_mn_w;
			self.add1_avm_sales_price_w := add1_avm_sales_price_w;
			self.property_owned_total_w := property_owned_total_w;
			self.addrs_10yr_w := addrs_10yr_w;
			self.dist_a1toa2_w := dist_a1toa2_w;
			self.add1_built_date_yr_w := add1_built_date_yr_w;
			self.addr_stability_w := addr_stability_w;
			self.dist_a1toa3_w := dist_a1toa3_w;
			self.add2_avm_recording_mn_w := add2_avm_recording_mn_w;
			self.add3_built_date_yr_w := add3_built_date_yr_w;
			self.CALastSaleDate_mn_w := CALastSaleDate_mn_w;
			self.earliest_date_last_seen := earliest_date_last_seen;
			self.total_number_derogs_w := total_number_derogs_w;
			self.add2_date_last_seen := add2_date_last_seen;
			self.first_seen := first_seen;
			self.ind := ind;
			self.boca := boca;
			self.crim_last_date := crim_last_date;
		#end;
		self.seq := le.seq;
		self.score := boca;
	END;
		
	model := project( clam, doModel(LEFT) );
	
	return model;
END;

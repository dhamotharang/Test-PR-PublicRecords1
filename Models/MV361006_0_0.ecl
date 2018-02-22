import risk_indicators, ut, riskwise, std;

export MV361006_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	MV36_DEBUG := false;

	#if(MV36_DEBUG)
	layout_debug := record
		integer seq;
		real4 score;
 		Integer crim_last_date;
		Integer cri_lst;
		Integer addr_stability;
		Integer add2_date_last_seen_mn;
		Integer add1_built_date;
  	Integer add2_built_date;
		Integer ssns_per_addr;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer add1_avm_med_fips;
		String  add2_avm_sales_price;
    String  add1_purchase_amount;
		Integer add1_built_date_yr;
		Integer add2_built_date_yr;
    Integer property_owned_total;
    Integer addrs_10yr;
		Integer date_derog;
		Integer date_last_derog;
		Integer mos_last_derog;
		Integer mos_last;
		boolean is_Issued3;
		integer adl_EQ_first_seen;
		integer adl_TU_first_seen;
		integer adl_DL_first_seen;
		integer adl_PR_first_seen;
		integer adl_V_first_seen;
		integer adl_EM_first_seen;
		integer adl_W_first_seen;
		integer adl_EQ_last_seen;
		integer adl_TU_last_seen;
		integer adl_DL_last_seen;
		integer adl_PR_last_seen;
		integer adl_V_last_seen;
		integer adl_EM_last_seen;
		integer adl_W_last_seen;
		boolean is_fcra;
		boolean truedid;
		integer nas_summary;
		integer nap_summary;
		integer cvi;
		string rc_sources;
		string out_addr_status;
		integer credit_sourced;
		String rc_decsflag;
		integer combo_fnamecount;
		integer combo_lnamecount;
		integer combo_addrcount;
		integer combo_ssncount;
		integer add1_naprop;
		integer add2_date_last_seen;
		String history_date;
		Integer earliest_date_last_seen;
		Real cri_lst_w;
		Real add1_avm_med_fips_w;
		Real add2_date_last_seen_mn_w;
		Real mos_last_w;
		Real ssns_per_addr_w;
  	Real add2_avm_sales_price_w;
    Real add1_purchase_amount_w;
		Real property_owned_total_w;
		Real addrs_10yr_w;
		Real dist_a1toa2_w;
		Real mos_last_derog_w;
		Real add1_built_date_yr_w;
		Real addr_stability_w;
		Real dist_a1toa3_w;
		Real add2_built_date_yr_w;
		Real is_Issued3_w;
		boolean first_seen;
		string ind;
		Real boca;
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
		add2_date_last_seen              := le.Address_Verification.Address_History_1.date_last_seen;
		add1_built_date                  := le.Address_Verification.Input_Address_Information.built_date;		
		add2_built_date                  := le.Address_Verification.Address_History_1.built_date;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add1_avm_med_fips                := le.AVM.Input_Address_Information.avm_median_fips_level;
		add2_avm_sales_price             := le.AVM.Address_History_1.avm_sales_price;
    add1_purchase_amount						 := le.address_verification.input_address_information.purchase_amount;
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
				
		/******************************************************************/
		/* CREATE 'INPUT' VALUES USED BY THE MODEL */
		fulldate := (unsigned4)((STRING6)le.historyDate+'01');
		history_date := if( le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.historydate );
		NULL := -999999999;
		checkDt( unsigned3 dls ) := if( dls=0, -NULL, dls );
		getMonths( unsigned date ) := if(date=0, NULL, max(0,((integer)history_date[1..4] - (integer)((STRING)date)[1..4])*12
		                           + (integer)history_date[5..6] - (integer)((STRING)date)[5..6]));
		getYears( unsigned date ) := if(date=0, NULL, max(0,(integer)((STRING)history_date)[1..4] - (integer)((STRING)date)[1..4]));
		
		/* RISKVIEW ATTRIBUTES */
		is_Issued3       := ((integer)history_date - (INTEGER)(le.iid.socllowissue[1..6])) < 300;

	  date_derog       := Max(Max(le.bjl.last_criminal_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
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
		/******************************************************************/

		cri_lst_w := map(
		  cri_lst  = NULL  =>  0.025219,
			cri_lst <= 20    => -0.599597,
			cri_lst <= 27    => -0.583970,
			cri_lst <= 35    => -0.532034,
			cri_lst <= 43    => -0.469458,
			cri_lst <= 52    => -0.422799,
			cri_lst <= 61    => -0.384427,
			cri_lst <= 71    => -0.357493,
			cri_lst >= 72    => -0.284744,
			0.025219
		);

		mos_last_derog_w := map(
		  mos_last_derog  = NULL  =>  0.106828,
			mos_last_derog <= 16    => -0.432194,
			mos_last_derog <= 19    => -0.360344,
			mos_last_derog  = 20    => -0.336716,
			mos_last_derog <= 32    => -0.298430,
			mos_last_derog <= 36    => -0.260386,
			mos_last_derog <= 48    => -0.218478,
			mos_last_derog <= 70    => -0.139047,
			mos_last_derog <= 84    => -0.080515,
			mos_last_derog <= 93    =>  0.222880,
			mos_last_derog <= 103   =>  0.252015,
			mos_last_derog >= 104   =>  0.354681,
			0.106828
		);
		
	add1_avm_med_fips_w := map(
			add1_avm_med_fips <= 83599    =>     0.182448,
			add1_avm_med_fips <= 99762    =>     0.148441,
			add1_avm_med_fips <= 210222   =>    -0.058526,
			add1_avm_med_fips <= 241093   =>    -0.110903,
			add1_avm_med_fips >= 241094   =>    -0.244414,
			-0.225152
		);

	add2_date_last_seen_mn_w := map(
	    add2_date_last_seen_mn  = NULL =>   -0.014628,
			add2_date_last_seen_mn <= 5    =>   -0.009906,
			add2_date_last_seen_mn <= 9    =>   -0.008450,
			add2_date_last_seen_mn  = 10   =>   -0.003033,
			add2_date_last_seen_mn <= 18   =>    0.000574,
			add2_date_last_seen_mn <= 23   =>    0.002841,
			add2_date_last_seen_mn <= 27   =>    0.006834,
			add2_date_last_seen_mn <= 31   =>    0.009474,
			add2_date_last_seen_mn <= 37   =>    0.016459,
			add2_date_last_seen_mn <= 66   =>    0.031586,
			add2_date_last_seen_mn <= 102  =>    0.038975,
			add2_date_last_seen_mn <= 130  =>    0.042792,
			add2_date_last_seen_mn <= 146  =>    0.054635,
			add2_date_last_seen_mn <= 175  =>    0.060092,
			add2_date_last_seen_mn <= 201  =>    0.070025,
			add2_date_last_seen_mn <= 265  =>    0.087798,
			add2_date_last_seen_mn >= 266  =>    0.097073,
			-0.014628
		);

		mos_last_w := map(
		  mos_last  = NULL =>  -0.060584,
			mos_last <= 6    =>  -0.060584,
			mos_last <= 19   =>   0.015037,
			mos_last <= 38   =>   0.026510,
			mos_last <= 41   =>   0.057435,
			mos_last  = 42   =>   0.086876,
			mos_last <= 144  =>   0.113536,
			mos_last <= 154  =>   0.135651,
			mos_last <= 201  =>   0.236216,
			mos_last <= 238  =>   0.319638,
			mos_last >= 239  =>   0.336369,		
			-0.060584
		);

		ssns_per_addr_w := map(
			ssns_per_addr <= 6     =>    0.024701,
			ssns_per_addr <= 8     =>    0.017894,
			ssns_per_addr  = 9     =>   -0.000213,
			ssns_per_addr <= 12    =>   -0.004940,
			ssns_per_addr <= 16    =>   -0.014426,
			ssns_per_addr  = 17    =>   -0.023137,
			ssns_per_addr <= 19    =>   -0.029643,
			ssns_per_addr <= 22    =>   -0.035041,
			ssns_per_addr <= 30    =>   -0.045096,
			ssns_per_addr >= 31    =>   -0.051401,
			-0.044451
		);

		add1_purchase_amount_w := map(
			(integer)add1_purchase_amount = 0          =>   0.042335,
			(integer)add1_purchase_amount <= 154000    =>  -0.067385,
			(integer)add1_purchase_amount <= 159900    =>  -0.096290,
			(integer)add1_purchase_amount <= 175000    =>  -0.053797,
			(integer)add1_purchase_amount <= 200000    =>  -0.034962,
			(integer)add1_purchase_amount <= 19925000  =>  -0.025761,
      (integer)add1_purchase_amount >= 19925001  =>   0.027209,
			-0.146461
		);
		
	  property_owned_total_w := map(
			property_owned_total  = 0   => -0.036056,
			property_owned_total  = 1   =>  0.069245,
			property_owned_total  = 2   =>  0.083365,
			property_owned_total  = 3   =>  0.085300,
			property_owned_total <= 6   =>  0.078011,
			property_owned_total >= 7   =>  0.048085,
			-0.057825
		);		

		addrs_10yr_w := map(
			addrs_10yr  = 0    =>   0.213193,
			addrs_10yr  = 1    =>   0.065091,
			addrs_10yr  = 2    =>   0.019129,
			addrs_10yr  = 3    =>  -0.013143,
			addrs_10yr  = 4    =>  -0.035003,
			addrs_10yr  = 5    =>  -0.052061,
			addrs_10yr  = 6    =>  -0.064341,
			addrs_10yr <= 8    =>  -0.086108,
			addrs_10yr  = 9    =>  -0.089505,
			addrs_10yr  = 10   =>  -0.106637,
			addrs_10yr >= 11   =>  -0.127565,
			-0.097661
		);		
		
		add2_avm_sales_price_w := map(
			add2_avm_sales_price =  ''                =>   0.019934,
			(integer)add2_avm_sales_price <= 29700    =>  -0.265342,
			(integer)add2_avm_sales_price <= 34900    =>  -0.210813,
			(integer)add2_avm_sales_price <= 56000    =>  -0.182698,
			(integer)add2_avm_sales_price <= 127900   =>  -0.129437,
			(integer)add2_avm_sales_price <= 139900   =>  -0.077928,
			(integer)add2_avm_sales_price <= 165000   =>  -0.026064,
			(integer)add2_avm_sales_price <= 202900   =>   0.013835,
			(integer)add2_avm_sales_price <= 300000   =>   0.044655,
      (integer)add2_avm_sales_price >= 300001   =>   0.083100,
			0.019934
		);

		dist_a1toa2_w := map(
			dist_a1toa2 < 0 or dist_a1toa2 = 9999   =>  -0.065014,
			dist_a1toa2  = 0    =>  0.062015,
			dist_a1toa2 <= 5    => -0.023039,
			dist_a1toa2 <= 16   => -0.046444,
			dist_a1toa2 <= 38   => -0.053412,
			dist_a1toa2 <= 41   => -0.083161,
			dist_a1toa2 <= 60   => -0.059591,
			dist_a1toa2 <= 126  => -0.052381,
			dist_a1toa2 <= 159  => -0.047733,
			dist_a1toa2 <= 187  => -0.015117,
			dist_a1toa2 <= 217  => -0.007395,
			dist_a1toa2 <= 664  =>  0.028512,
			dist_a1toa2 <= 713  =>  0.079302,
			dist_a1toa2 <= 1023 =>  0.126359,
			dist_a1toa2 >= 1024 =>  0.128650,
			-0.065014
		);
		
		add1_built_date_yr_w := map(
		  add1_built_date_yr  = NULL =>    -0.057557,
			add1_built_date_yr <= 1    =>     0.111548,
			add1_built_date_yr  = 2    =>     0.138438,
			add1_built_date_yr <= 4    =>     0.156317,
			add1_built_date_yr <= 9    =>     0.141266,
			add1_built_date_yr <= 15   =>     0.133981,
			add1_built_date_yr <= 20   =>     0.118304,
			add1_built_date_yr <= 32   =>     0.102742,
			add1_built_date_yr  = 33   =>     0.067094,
			add1_built_date_yr <= 43   =>     0.037092,
			add1_built_date_yr <= 53   =>     0.006233,
			add1_built_date_yr <= 56   =>    -0.004359,
			add1_built_date_yr <= 58   =>    -0.005572,
			add1_built_date_yr <= 73   =>    -0.027885,
			add1_built_date_yr <= 79   =>    -0.132152,
			add1_built_date_yr <= 81   =>    -0.151603,
			add1_built_date_yr >= 82   =>    -0.162485,
			-0.057557
		);

		addr_stability_w := map(
			addr_stability <= 1   =>    -0.054264,
			addr_stability <= 4   =>    -0.007864,
			addr_stability  = 5   =>     0.050836,
			addr_stability >= 6   =>     0.103813,
			-0.055335
		);

		dist_a1toa3_w := map(
			dist_a1toa3 <  0 or dist_a1toa3 = 9999    =>    -0.042845,
			dist_a1toa3  = 0    =>    0.044540,
			dist_a1toa3 <= 3    =>   -0.012412,
			dist_a1toa3 <= 9    =>   -0.013347,
			dist_a1toa3 <= 15   =>   -0.019777,
			dist_a1toa3 <= 41   =>   -0.020249,
			dist_a1toa3 <= 49   =>   -0.038352,
			dist_a1toa3 <= 124  =>   -0.031467,
			dist_a1toa3 <= 155  =>   -0.012266,
			dist_a1toa3 <= 207  =>   -0.007635,
			dist_a1toa3 <= 223  =>    0.007478,
			dist_a1toa3 <= 688  =>    0.021751,
			dist_a1toa3 <= 785  =>    0.064293,
			dist_a1toa3 <= 914  =>    0.078969,
			dist_a1toa3 >= 915  =>    0.086993,
			-0.042845
		);

		add2_built_date_yr_w := map(
		  add2_built_date_yr  = NULL =>  -0.006200,
			add2_built_date_yr <= 4   =>   -0.056945,
			add2_built_date_yr <= 6   =>   -0.032819,
			add2_built_date_yr  = 7   =>    0.038740,
			add2_built_date_yr <= 22  =>    0.058792,
			add2_built_date_yr  = 23  =>    0.108920,
			add2_built_date_yr <= 28  =>    0.130422,
			add2_built_date_yr <= 32  =>    0.094430,
			add2_built_date_yr <= 45  =>    0.047536,
			add2_built_date_yr <= 52  =>    0.006022,
			add2_built_date_yr <= 59  =>    0.003614,
			add2_built_date_yr <= 64  =>   -0.044954,
			add2_built_date_yr <= 71  =>   -0.078995,
			add2_built_date_yr <= 76  =>   -0.084756,
			add2_built_date_yr >= 77  =>   -0.119854,
			0.199561
		);

    is_Issued3_w := if(is_Issued3, 0.246836, 0.000559);
		
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
			 mos_last_derog_w        
     + add1_avm_med_fips_w     
     + mos_last_w              
     + addrs_10yr_w            
     + add1_built_date_yr_w    
     + cri_lst_w               
     + dist_a1toa2_w           
     + add2_avm_sales_price_w  
     + property_owned_total_w  
     + add1_purchase_amount_w  
     + addr_stability_w        
     + add2_built_date_yr_w    
     + dist_a1toa3_w           
     + ssns_per_addr_w         
     + is_Issued3_w             
     + add2_date_last_seen_mn_w
			);

		#if(MV36_DEBUG)
			self.cri_lst := cri_lst;
			self.addr_stability := addr_stability;
			self.add2_date_last_seen_mn := add2_date_last_seen_mn;
			self.add1_built_date := add1_built_date;
			self.add2_built_date := add2_built_date;
			self.ssns_per_addr := ssns_per_addr;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add2_avm_sales_price := add2_avm_sales_price;
      self.add1_purchase_amount := (String)add1_purchase_amount;
      self.property_owned_total := property_owned_total;
      self.addrs_10yr := addrs_10yr;
			self.date_derog := date_derog;
			self.date_last_derog := date_last_derog;
			self.mos_last_derog := mos_last_derog;
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
			self.is_Issued3 := is_Issued3;
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
			self.earliest_date_last_seen := earliest_date_last_seen;
			self.mos_last := mos_last;
  		self.add2_built_date_yr := add2_built_date_yr;
			self.add1_built_date_yr := add1_built_date_yr;
			self.cri_lst_w := cri_lst_w;
			self.add1_avm_med_fips_w := add1_avm_med_fips_w;
			self.add2_date_last_seen := add2_date_last_seen;
			self.add2_date_last_seen_mn_w := add2_date_last_seen_mn_w;
			self.mos_last_w := mos_last_w;
			self.ssns_per_addr_w := ssns_per_addr_w;
			self.add2_avm_sales_price_w := add2_avm_sales_price_w;
			self.add1_purchase_amount_w := add1_purchase_amount_w;
			self.property_owned_total_w := property_owned_total_w;
			self.addrs_10yr_w := addrs_10yr_w;
			self.dist_a1toa2_w := dist_a1toa2_w;
      self.is_Issued3_w := is_Issued3_w;
			self.add1_built_date_yr_w := add1_built_date_yr_w;
			self.addr_stability_w := addr_stability_w;
			self.dist_a1toa3_w := dist_a1toa3_w;
			self.mos_last_derog_w := mos_last_derog_w;
			self.add2_built_date_yr_w := add2_built_date_yr_w;
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

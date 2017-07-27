import risk_indicators, ut;

ANMK_DEBUG := false;

export ANMK909_0_1( grouped dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION




	#if(ANMK_DEBUG)
	layout_debug := record
		layout_modelout.seq;
		layout_modelout.score;
		// string3 finalScore;
		
		Integer rc_utiliaddr_addrcount;
		Integer EQ_count;
		Boolean dobpop;
		Boolean fname_tu_sourced;
		Boolean lname_eda_sourced;
		Integer Age;
		Boolean add1_applicant_sold;
		Integer ADD1_NAPROP;
		Integer add1_mortgage_amount;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer add2_avm_med_fips;
		Integer add2_mortgage_amount;
		Integer ADD2_ASSESSED_AMOUNT;
		Integer avg_lres;
		Integer ssns_per_adl;
		Integer ssns_per_addr;
		Integer phones_per_addr;
		Boolean Bankrupt;
		Integer criminal_count;
		Integer crim_rel_within25miles;
		Integer rel_prop_sold_count;
		Integer rel_educationunder8_count;
		Integer rel_count_addr;
		Boolean prof_license_flag;
		String addr_stability;
		Boolean trueDID;
		Integer NAS_Summary;
		Integer NAP_Summary;
		Integer CVI;
		String rc_sources;
		String rc_decsflag;
		Integer null;
		String score_ind;
		Boolean addr_stab_1234;
		Boolean add1_naprop_1;
		Real avg_lres_d;
		Real dist_a1toa3_d;
		Real dist_a1toa2_d;
		Real add2_avm_med_fips_d;
		Real criminal_count_d;
		Real ssns_per_addr_d;
		Real lname_eda_sourced_d;
		Real EQ_count_d;
		Real age_d;
		Real add1_mortgage_amount_d;
		Real crim_rel_within25miles_d;
		Real add2_assessed_amount_d;
		Real add2_mortgage_amount_d;
		Real xb;
		Real scorable_score;
		Integer scorable_nonattrscr;
		Integer scorable_nonattrscr_dec;
		Integer nonattrscr;
		String nonattrscr_dec;

	end;
	
	Layout_debug doModel( clam le ) := TRANSFORM
	#else
	Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end
		rc_utiliaddr_addrcount           := le.iid.utiliaddr_addrcount;
		EQ_count                         := le.source_verification.eq_count;
		dobpop                           := le.input_validation.dateofbirth;
		fname_tu_sourced                 := le.name_verification.fname_tu_sourced;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		age                              := le.name_verification.age;
		add1_applicant_sold              := le.address_verification.input_address_information.applicant_sold;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
		add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
		avg_lres                         := le.other_address_info.avg_lres;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		bankrupt                         := le.bjl.bankrupt;
		criminal_count                   := le.bjl.criminal_count;
		crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
		rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
		rel_educationunder8_count        := le.relatives.relative_educationunder8_count;
		rel_count_addr                   := le.relatives.relatives_at_input_address;
		prof_license_flag                := le.professional_license.professional_license_flag;
		addr_stability                   := le.mobility_indicator;
		truedid                          := le.truedid;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		cvi                              := le.iid.cvi;
		rc_sources                       := le.iid.sources;
		rc_decsflag                      := le.iid.decsflag;



		NULL := -99999999;
		score_ind := map(
			not truedid => 'No-hit',
			( (nas_summary<=4) and (nap_summary<=4) and (add1_naprop<=2)) => 'Un-scorable',
			cvi in [0, 10]                => 'Un-scorable',
			trim(rc_sources) in ['', ','] => 'Un-scorable',
			(integer)rc_decsflag = 1      => 'Un-scorable',
			'Scorable'
		);


		addr_stab_1234 := (integer)addr_stability in [1, 2, 3,4];
		add1_naprop_1 := add1_naprop = 1;

		/** splits based on avg_lres **/
		avg_lres_d := map(
			avg_lres < 14                     => 0.071450714,
			14 <= avg_lres and avg_lres < 24  => 0.0630089856,
			24 <= avg_lres and avg_lres < 33  => 0.067934808,
			33 <= avg_lres and avg_lres < 41  => 0.0333850737,
			41 <= avg_lres and avg_lres < 50  => 0.0422987319,
			50 <= avg_lres and avg_lres < 59  => 0.0145202822,
			59 <= avg_lres and avg_lres < 72  => -0.079980767,
			72 <= avg_lres and avg_lres < 87  => -0.063638263,
			87 <= avg_lres and avg_lres < 112 => -0.05745636,
			112 <= avg_lres                   => -0.07185174,
			NULL
		);

		/** splits based on dist_a1toa3 **/
		dist_a1toa3_d := map(
			0 <= dist_a1toa3 and dist_a1toa3 < 1       => -0.022817414,
			1 <= dist_a1toa3 and dist_a1toa3 < 4       => 0.0664550955,
			4 <= dist_a1toa3 and dist_a1toa3 < 7       => 0.0726417769,
			7 <= dist_a1toa3 and dist_a1toa3 < 12      => 0.043873732,
			12 <= dist_a1toa3 and dist_a1toa3 < 26     => 0.058027326,
			26 <= dist_a1toa3 and dist_a1toa3 < 109    => 0.020014089,
			109 <= dist_a1toa3 and dist_a1toa3 < 720   => -0.090340098,
			720 <= dist_a1toa3 and dist_a1toa3 <= 9998 => -0.122894491,
			dist_a1toa3 = 9999                         => -0.009038513,
			NULL
		);
		/** splits based on dist_a1toa2 **/
		dist_a1toa2_d := map(
			0 <= dist_a1toa2 and dist_a1toa2 < 3       => -0.006629195,
			3 <= dist_a1toa2 and dist_a1toa2 < 6       =>  0.0597188028,
			6 <= dist_a1toa2 and dist_a1toa2 < 10      =>  0.0354286988,
			10 <= dist_a1toa2 and dist_a1toa2 < 21     =>  0.0811848149,
			21 <= dist_a1toa2 and dist_a1toa2 < 85     =>  0.0438091831,
			85 <= dist_a1toa2 and dist_a1toa2 < 650    => -0.046736117,
			650 <= dist_a1toa2 and dist_a1toa2 <= 9998 => -0.154298632,
			dist_a1toa2 = 9999                         => -0.008071642,
			NULL
		);

		/** splits based on add2_avm_med_fips **/
		add2_avm_med_fips_d := map(
			0 <= add2_avm_med_fips and add2_avm_med_fips < 86522       => -0.085730607,
			86522 <= add2_avm_med_fips and add2_avm_med_fips < 123000  => -0.128310741,
			123000 <= add2_avm_med_fips and add2_avm_med_fips < 159000 => -0.082454733,
			159000 <= add2_avm_med_fips and add2_avm_med_fips < 227000 => -0.110439354,
			227000 <= add2_avm_med_fips and add2_avm_med_fips < 304500 => -0.139476107,
			304500 <= add2_avm_med_fips and add2_avm_med_fips < 400000 => 0.1844321041,
			400000 <= add2_avm_med_fips and add2_avm_med_fips < 485004 => -0.028305714,
			485004 <= add2_avm_med_fips                                => 0.3369917995,
			NULL
		);
		/** splits based on criminal_count **/
		criminal_count_d := map(
			0 <= criminal_count and criminal_count < 1 => -0.022429331,
			1 <= criminal_count                        => 0.1951845804,
			NULL
		);

		/** splits based on ssns_per_addr **/
		ssns_per_addr_d := map(
			0 <= ssns_per_addr and ssns_per_addr < 2     => 0.0114785577,
			2 <= ssns_per_addr and ssns_per_addr < 4     => -0.248328971,
			4 <= ssns_per_addr and ssns_per_addr < 6     => -0.160024532,
			6 <= ssns_per_addr and ssns_per_addr < 8     => -0.12784616,
			8 <= ssns_per_addr and ssns_per_addr < 10    => -0.014343425,
			10 <= ssns_per_addr and ssns_per_addr < 13   => 0.0123461871,
			13 <= ssns_per_addr and ssns_per_addr < 17   => 0.0812623889,
			17 <= ssns_per_addr and ssns_per_addr < 24   => 0.2038779404,
			24 <= ssns_per_addr                          => 0.2042590466,
			NULL
		);

		/** splits based on lname_eda_sourced **/
		lname_eda_sourced_d := if( lname_eda_sourced, -0.061180842, 0.0293229798 );

		/** splits based on EQ_count **/
		EQ_count_d := map(
			EQ_count < 2                       => -0.104904818,
			2 <= EQ_count and EQ_count < 4     => -0.034959198,
			4 <= EQ_count and EQ_count < 5     => -0.063372078,
			5 <= EQ_count and EQ_count < 6     => -0.080316702,
			6 <= EQ_count and EQ_count < 8     => -0.097255996,
			8 <= EQ_count and EQ_count < 10    => -0.033372832,
			10 <= EQ_count and EQ_count < 12   => 0.0019730239,
			12 <= EQ_count and EQ_count < 15   => 0.0382785766,
			15 <= EQ_count and EQ_count < 20   => 0.1067709327,
			20 <= EQ_count                     => 0.1876800906,
			NULL
		);

		/** splits based on age **/
		age_d := map(
			age < 25                => 0.1313678123,
			25 <= age and age  < 32 => 0.1444462597,
			32 <= age and age  < 38 => 0.1280692945,
			38 <= age and age  < 44 => 0.0866700377,
			44 <= age and age  < 49 => 0.0851065765,
			49 <= age and age  < 54 => 0.0597841275,
			54 <= age and age  < 60 => -0.021102693,
			60 <= age and age  < 66 => -0.062332909,
			66 <= age and age  < 76 => -0.24883626,
			76 <= age               => -0.193469304,
			NULL
		);

		/** splits based on add1_mortgage_amount **/
		add1_mortgage_amount_d := map(
			0 <= add1_mortgage_amount and add1_mortgage_amount < 136500      => -0.075587676,
			136500 <= add1_mortgage_amount and add1_mortgage_amount < 260000 => 0.214421431,
			260000 <= add1_mortgage_amount                                   => 0.2716164342,
			NULL
		);

		/** splits based on crim_rel_within25miles **/
		crim_rel_within25miles_d := map(
			0 <= crim_rel_within25miles and crim_rel_within25miles < 1  => -0.041268242,
			1 <= crim_rel_within25miles                                 => 0.1669391246,
			NULL
		);

		/** splits based on add2_assessed_amount **/
		add2_assessed_amount_d := map(
			0 <= add2_assessed_amount and add2_assessed_amount < 132600  => 0.0401235578,
			132600 <= add2_assessed_amount                               => -0.239632292,
			NULL
		);

		/** splits based on add2_mortgage_amount **/
		add2_mortgage_amount_d := map(
			0 <= add2_mortgage_amount and add2_mortgage_amount < 75550      => -0.041080452,
			75550 <= add2_mortgage_amount and add2_mortgage_amount < 203002 => 0.1206736378,
			203002 <= add2_mortgage_amount                                  => 0.1701244731,
			NULL
		);

		xb   :=   max(0, 0.7926821957  +
			0.8755910152 * add2_avm_med_fips_d            +
			0.0774286176 * rc_utiliaddr_addrcount         +
			-0.110989975 * (integer)fname_tu_sourced      +
			0.6583054391 * criminal_count_d               +
			0.3282778307 * ssns_per_addr_d                +
			0.0097012411 * phones_per_addr                +
			0.7517808122 * lname_eda_sourced_d            +
			-0.059403935 * (integer)add1_naprop_1         +
			0.3277795796 * EQ_count_d                     +
			0.3000583661 * age_d                          +
			0.1282145109 * (integer)bankrupt              +
			0.332911325  * add1_mortgage_amount_d         +
			0.3320779038 * crim_rel_within25miles_d       +
			0.0245611496 * rel_prop_sold_count            +
			0.0861251984 * (integer)addr_stab_1234        +
			0.0275101613 * ssns_per_adl                   +
			0.0663054734 * (integer)add1_applicant_sold   +
			0.2200773097 * add2_assessed_amount_d         +
			0.0424587085 * (integer)dobpop                +
			0.0647110752 * (integer)prof_license_flag     +
			0.4261437695 * avg_lres_d                     +
			0.0147507867 * rel_count_addr                 +
			0.2564775849 * add2_mortgage_amount_d         +
			0.4208482596 * dist_a1toa3_d                  +
			0.1719774466 * dist_a1toa2_d                  
		);


		// ***** SCORE SCALING ALGORITHM *****;
		scorable_score := map(
			xb <= 0.544916992 => ((829 - 997)/(0.544916992 - 0.145051778))*(xb - 0.145051778) + 997,
			xb <= 0.643799598 => ((785 - 828)/(0.643799598 - 0.544917968))*(xb - 0.544917968) + 828,
			xb <= 0.721440397 => ((753 - 784)/(0.721440397 - 0.643799627))*(xb - 0.643799627) + 784,
			xb <= 0.790532193 => ((726 - 752)/(0.790532193 - 0.721440520))*(xb - 0.721440520) + 752,
			xb <= 0.856789782 => ((700 - 725)/(0.856789782 - 0.790533363))*(xb - 0.790533363) + 725,
			xb <= 0.926230334 => ((675 - 699)/(0.926230334 - 0.856790351))*(xb - 0.856790351) + 699,
			xb <= 1.007846190 => ((648 - 674)/(1.007846190 - 0.926230766))*(xb - 0.926230766) + 674,
			xb <= 1.122437716 => ((616 - 647)/(1.122437716 - 1.007846852))*(xb - 1.007846852) + 647,
			xb <= 1.302992185 => ((572 - 615)/(1.302992185 - 1.122438594))*(xb - 1.122438594) + 615,
			xb  > 1.302992185 => ((232 - 571)/(3.534281364 - 1.302992745))*(xb - 1.302992745) + 571,
			NULL
		);

		scorable_nonattrscr := max(min(round(scorable_Score),997),200);

		// ***** SCALED SCORE DECILE DEFINITION *****;
		scorable_nonattrscr_dec := map(
			xb <= 0.544916992 => 10,
			xb <= 0.643799598 => 9,
			xb <= 0.721440397 => 8,
			xb <= 0.790532193 => 7,
			xb <= 0.856789782 => 6,
			xb <= 0.926230334 => 5,
			xb <= 1.007846190 => 4,
			xb <= 1.122437716 => 3,
			xb <= 1.302992185 => 2,
			xb  > 1.302992185 => 1,
			NULL
		);

		nonattrscr := case( score_ind,
			'Un-scorable' => 999,
			'No-hit'      => 998,
			scorable_nonattrscr
		);
	
		nonattrscr_dec := case( score_ind,
			'Un-scorable' => 'NoS',
			'No-hit'      => 'NoH',
			intformat(scorable_nonattrscr_dec,3,1)
		);
		
		
		self.seq := le.seq;
		self.score := intformat(nonattrscr,3,1);
		self.ri := [];
		
		#if(ANMK_DEBUG)
			self.rc_utiliaddr_addrcount := rc_utiliaddr_addrcount;
			self.EQ_count := EQ_count;
			self.dobpop := dobpop;
			self.fname_tu_sourced := fname_tu_sourced;
			self.lname_eda_sourced := lname_eda_sourced;
			self.age := age;
			self.add1_applicant_sold := add1_applicant_sold;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_amount := add1_mortgage_amount;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.add2_avm_med_fips := add2_avm_med_fips;
			self.add2_mortgage_amount := add2_mortgage_amount;
			self.add2_assessed_amount := add2_assessed_amount;
			self.avg_lres := avg_lres;
			self.ssns_per_adl := ssns_per_adl;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.bankrupt := bankrupt;
			self.criminal_count := criminal_count;
			self.crim_rel_within25miles := crim_rel_within25miles;
			self.rel_prop_sold_count := rel_prop_sold_count;
			self.rel_educationunder8_count := rel_educationunder8_count;
			self.rel_count_addr := rel_count_addr;
			self.prof_license_flag := prof_license_flag;
			self.addr_stability := addr_stability;
			self.truedid := truedid;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.cvi := cvi;
			self.rc_sources := rc_sources;
			self.rc_decsflag := rc_decsflag;
			self.NULL := NULL;
			self.score_ind := score_ind;
			self.addr_stab_1234 := addr_stab_1234;
			self.add1_naprop_1 := add1_naprop_1;
			self.avg_lres_d := avg_lres_d;
			self.dist_a1toa3_d := dist_a1toa3_d;
			self.dist_a1toa2_d := dist_a1toa2_d;
			self.add2_avm_med_fips_d := add2_avm_med_fips_d;
			self.criminal_count_d := criminal_count_d;
			self.ssns_per_addr_d := ssns_per_addr_d;
			self.lname_eda_sourced_d := lname_eda_sourced_d;
			self.EQ_count_d := EQ_count_d;
			self.age_d := age_d;
			self.add1_mortgage_amount_d := add1_mortgage_amount_d;
			self.crim_rel_within25miles_d := crim_rel_within25miles_d;
			self.add2_assessed_amount_d := add2_assessed_amount_d;
			self.add2_mortgage_amount_d := add2_mortgage_amount_d;
			self.xb := xb;
			self.scorable_score := scorable_score;
			self.scorable_nonattrscr := scorable_nonattrscr;
			self.scorable_nonattrscr_dec := scorable_nonattrscr_dec;
			self.nonattrscr := nonattrscr;
			self.nonattrscr_dec := nonattrscr_dec;
		#end
	end;
	
	scored := project( clam, doModel(LEFT) );
	
	return scored;
END;
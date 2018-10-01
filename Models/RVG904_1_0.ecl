import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;
RVG_DEBUG := FALSE;

export RVG904_1_0( dataset(risk_indicators.layout_boca_shell) clam, boolean isCalifornia ) := FUNCTION

#if(RVG_DEBUG)
	layout_debug := record
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_addrvalflag;
		String rc_addrcommflag;
		Integer hphnpop;
		Integer add1_naprop;
		Integer property_owned_total;
		Integer ssns_per_adl_c6;
		Integer ssns_per_addr_c6;
		String disposition;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer criminal_count;
		String ams_college_code;
		String ams_college_type;
		Integer add1_lres;
		Boolean prof_license_flag;
		Integer ssnlength;
		Integer rc_ssndobflag;
		Integer rc_decsflag;
		String rc_pwssndobflag;
		Integer rc_hrisksic;
		Integer inferred_dob;
		Integer archive_date;
		Integer null;
		Integer pdo_verx;
		Real pdo_verx_m;
		Integer pdo_add1_naprop;
		Real pdo_add1_naprop_m;
		Integer pdo_liens_unr;
		Real pdo_liens_unr_m;
		Integer pdo_bk_status;
		Real pdo_bk_status_m;
		Integer pdo_ams_level;
		Real pdo_ams_level_m;
		Integer pdo_ssns_per_adl_c6;
		Real pdo_ssns_per_adl_c6_m;
		Integer pdo_ssns_per_addr_c6;
		Real pdo_ssns_per_addr_c6_m;
		Boolean pdo_addr_prob;
		Real pdo_add1_lres_lg;
		Integer curr_date;
		Integer infer_date;
		Integer DOB;
		Integer calc_age;
		Integer combo_age;
		Integer pdo_combo_age;
		Real pdo_combo_age_lg;
		Boolean pdo_criminal_count;
		Real PDO_log;
		Integer base;
		Integer point;
		Real odds;
		Real phat;
		Integer PDO_CUSTOM;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Integer PDO_CUSTOM2;
		Boolean inCalif;

		models.Layout_ModelOut;
	end;
	
	layout_debug doModel( clam le ) := TRANSFORM
#else
	Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
#end

		in_dob                          :=  le.shell_input.dob;
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		rc_addrvalflag                  :=  le.iid.addrvalflag;
		rc_addrcommflag                 :=  le.iid.addrcommflag;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		property_owned_total            :=  le.address_verification.owned.property_total;
		ssns_per_adl_c6                 :=  le.velocity_counters.ssns_per_adl_created_6months;
		ssns_per_addr_c6                :=  le.velocity_counters.ssns_per_addr_created_6months;
		disposition                     :=  le.bjl.disposition;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		ams_college_code                :=  le.student.college_code;
		ams_college_type                :=  le.student.college_type;
		add1_lres                       :=  le.lres;
		prof_license_flag               :=  le.professional_license.professional_license_flag;
    ssnlength                       :=  (integer)le.input_validation.ssn_length;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_decsflag                     :=  (integer)le.ssn_verification.validation.deceased;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;

		inferred_dob                    :=  le.reported_dob;
		archive_date                    :=  if( le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate );

		/************************************************************************************/
		/* Code Starts Here		                                                           */
		/************************************************************************************/
		NULL := -99999999;
		
		pdo_verx := map( 
			nas_summary=12 and nap_summary=12 => 6,
			nas_summary=12 and nap_summary in [9,10,11] => 5,
			nas_summary=12 and nap_summary in [0,2,3,4,5,6,7,8] => 4,
			hphnpop=1 and nas_summary not in [4,7,9] => 3,
			hphnpop=1 and nas_summary != 1 => 2,
			hphnpop=0 and nas_summary in [4,7,9] => 0,
			1
		);


		pdo_verx_m := map( 
			pdo_verx = 0 => 0.5845070423,
			pdo_verx = 1 => 0.4285714286,
			pdo_verx = 2 => 0.3273155416,
			pdo_verx = 3 => 0.2922600619,
			pdo_verx = 4 => 0.2350277369,
			pdo_verx = 5 => 0.2045977011,
			pdo_verx = 6 => 0.1851318254,
			NULL
		);

		pdo_add1_naprop := map( 
			add1_naprop = 4 => 4,
			property_owned_total > 0 => 3,
			add1_naprop in [2,3] => 2,
			add1_naprop=0 => 1,
			0
		);

		pdo_add1_naprop_m := map( 
			pdo_add1_naprop = 0 => 0.2750252181,
			pdo_add1_naprop = 1 => 0.2619848335,
			pdo_add1_naprop = 2 => 0.2408180301,
			pdo_add1_naprop = 3 => 0.2101996762,
			pdo_add1_naprop = 4 => 0.1683006536,
			NULL
		);

		pdo_liens_unr := map( 
			liens_recent_unreleased_count>2 and liens_historical_unreleased_ct>0 => 0,
			liens_recent_unreleased_count=0 and liens_historical_unreleased_ct=0 => 4,
			liens_recent_unreleased_count=0 and liens_historical_unreleased_ct<3 => 3,
			liens_recent_unreleased_count=1 and liens_historical_unreleased_ct=0 => 3,
			liens_recent_unreleased_count=0 => 2,
			1
		);

		pdo_liens_unr_m := map( 
			pdo_liens_unr = 0 => 0.3820960699,
			pdo_liens_unr = 1 => 0.3119515885,
			pdo_liens_unr = 2 => 0.2806712963,
			pdo_liens_unr = 3 => 0.2529535166,
			pdo_liens_unr = 4 => 0.2328145266,
			NULL
		);

		pdo_bk_status := map( 
			StringLib.StringToUpperCase(disposition)='DISMISSED' => 1,
			StringLib.StringToUpperCase(disposition)='DISCHARGED' => 2,
			0
		);

		pdo_bk_status_m := map( 
			pdo_bk_status = 0 => 0.2556819668,
			pdo_bk_status = 1 => 0.2713896458,
			pdo_bk_status = 2 => 0.1911449655,
			0
		);

		pdo_ams_level := map( 
			ams_college_type='P' and (integer)ams_college_code=4 => 2,
			(integer)ams_college_code=4 => 1,
			0
		);

		pdo_ams_level_m := map( 
			pdo_ams_level = 0 => 0.2486888591,
			pdo_ams_level = 1 => 0.1909980431,
			pdo_ams_level = 2 => 0.1705202312,
			NULL
		);

		pdo_ssns_per_adl_c6 := min(ssns_per_adl_c6,2);

		pdo_ssns_per_adl_c6_m := map( 
			pdo_ssns_per_adl_c6 = 0 => 0.2376057331,
			pdo_ssns_per_adl_c6 = 1 => 0.2611320219,
			pdo_ssns_per_adl_c6 = 2 => 0.3294460641,
			-99999999
		);

		pdo_ssns_per_addr_c6 := min(ssns_per_addr_c6,3);

		pdo_ssns_per_addr_c6_m := map( 
			pdo_ssns_per_addr_c6 = 0 => 0.2342933457,
			pdo_ssns_per_addr_c6 = 1 => 0.2631281123,
			pdo_ssns_per_addr_c6 = 2 => 0.2721996518,
			pdo_ssns_per_addr_c6 = 3 => 0.3132875143,
			-99999999
		);

		pdo_addr_prob := (rc_addrvalflag in ['M','N'] or (integer)rc_addrcommflag in [1,2]);

		pdo_add1_lres_lg := ln(min(max(add1_lres,.01),500));




/*** BEGIN AGE ***/	

		/******************** COMBO AGE LOGIC **********************
		* 1. Calculate number of days between today's date and     *                        
		*    input date of birth.                                  *
		* 2. If not given input date of birth then use inferred    *
		* 	date of birth.                                        *
		* 3. Divide number from step 1 or 2 by 365.25 to get the   *
		* 	number of years since DOB.                            *
		* 4. Note that all calcaulations are done on the 1st of    *
		* 	the month.                                            *
		***********************************************************/

		curr_date := ut.DaysSince1900( ((STRING)archive_date)[1..4], ((STRING)archive_date)[5..6], '01' );
		infer_date := if( length((string)inferred_dob) >= 6, ut.DaysSince1900( ((STRING)inferred_dob)[1..4], ((STRING)inferred_dob)[5..6], '01' ), NULL );


		dob := ut.DaysSince1900( in_dob[1..4], (string4)max( 1, (integer4)in_dob[5..6]), '01' );
		calc_age := if( (integer)in_dob=0, NULL, (integer4)(( curr_date - dob ) / 365.25 ));
		combo_age := map(
			calc_age > 0      => calc_age,
			inferred_dob != 0 => (integer)( (curr_date - infer_date ) / 365.25 ),
			-1
		);

		pdo_combo_age := map(
			combo_age >= 60 => 30,
			combo_age = -1  => 26,
			min(max(combo_age,21),55)
		);	
		pdo_combo_age_lg := ln(pdo_combo_age);

		/*** END AGE ***/


		pdo_criminal_count := (criminal_count>0);

		PDO_log := -6.030135554
			+ pdo_verx_m  * 3.2298654189
			+ pdo_add1_naprop_m  * 3.2801751465
			+ pdo_liens_unr_m  * 5.6861797213
			+ pdo_bk_status_m  * 4.0624129675
			+ pdo_ams_level_m  * 6.6558228703
			+ pdo_ssns_per_adl_c6_m  * 2.9015823433
			+ pdo_ssns_per_addr_c6_m  * 3.2269249731
			+ (integer)pdo_addr_prob  * 0.1893818102
			+ pdo_add1_lres_lg  * -0.014307425
			+ pdo_combo_age_lg  * -0.633082157
			+ (integer)pdo_criminal_count  * 0.6082105307
			+ (integer)prof_license_flag  * -0.288102593
		;
     
		base  := 703;
		point :=  -40;
		odds  := .24509;

		phat := (exp(PDO_log)) / (1+exp(PDO_log));
     
		PDO_CUSTOM := max(501,min(900,
			round(point*(ln(phat/(1-phat)) - ln(odds))/ln(2) + base)
		));
     
		/* overrides */

		ov_ssndead       := ( ssnlength > 0 ) and ( rc_decsflag = 1 );
		ov_ssnprior      := ( rc_ssndobflag = 1 or (integer)rc_pwssndobflag = 1 );
		ov_criminal_flag := ( criminal_count > 0 );
		ov_corrections   := ( rc_hrisksic = 2225 );

		PDO_CUSTOM2 := map(
			riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid) => 222,
			PDO_CUSTOM > 610 and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections ) => 610,
			PDO_CUSTOM
		);



		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		riTemp2 := RiskWise.rvReasonCodes(le, 4, inCalif, true);

		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			riTemp2[1].hri='35' => '000',
			intformat( PDO_CUSTOM2, 3, 1 )
		);	


		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			PDO_CUSTOM2 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),		
			riTemp2
		);
		


		self.seq := le.seq;

	#if(RVG_DEBUG)
		self.in_dob := in_dob;
		self.nas_summary := nas_summary;
		self.nap_summary := nap_summary;
		self.rc_addrvalflag := rc_addrvalflag;
		self.rc_addrcommflag := rc_addrcommflag;
		self.hphnpop := hphnpop;
		self.add1_naprop := add1_naprop;
		self.property_owned_total := property_owned_total;
		self.ssns_per_adl_c6 := ssns_per_adl_c6;
		self.ssns_per_addr_c6 := ssns_per_addr_c6;
		self.disposition := disposition;
		self.liens_recent_unreleased_count := liens_recent_unreleased_count;
		self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		self.criminal_count := criminal_count;
		self.ams_college_code := ams_college_code;
		self.ams_college_type := ams_college_type;
		self.add1_lres := add1_lres;
		self.prof_license_flag := prof_license_flag;
		self.ssnlength := ssnlength;
		self.rc_ssndobflag := rc_ssndobflag;
		self.rc_decsflag := rc_decsflag;
		self.rc_pwssndobflag := rc_pwssndobflag;
		self.rc_hrisksic := rc_hrisksic;
		self.inferred_dob := inferred_dob;
		self.archive_date := archive_date;
		self.NULL := NULL;
		self.pdo_verx := pdo_verx;
		self.pdo_verx_m := pdo_verx_m;
		self.pdo_add1_naprop := pdo_add1_naprop;
		self.pdo_add1_naprop_m := pdo_add1_naprop_m;
		self.pdo_liens_unr := pdo_liens_unr;
		self.pdo_liens_unr_m := pdo_liens_unr_m;
		self.pdo_bk_status := pdo_bk_status;
		self.pdo_bk_status_m := pdo_bk_status_m;
		self.pdo_ams_level := pdo_ams_level;
		self.pdo_ams_level_m := pdo_ams_level_m;
		self.pdo_ssns_per_adl_c6 := pdo_ssns_per_adl_c6;
		self.pdo_ssns_per_adl_c6_m := pdo_ssns_per_adl_c6_m;
		self.pdo_ssns_per_addr_c6 := pdo_ssns_per_addr_c6;
		self.pdo_ssns_per_addr_c6_m := pdo_ssns_per_addr_c6_m;
		self.pdo_addr_prob := pdo_addr_prob;
		self.pdo_add1_lres_lg := pdo_add1_lres_lg;
		self.curr_date := curr_date;
		self.infer_date := infer_date;
		self.dob := dob;
		self.calc_age := calc_age;
		self.combo_age := combo_age;
		self.pdo_combo_age := pdo_combo_age;
		self.pdo_combo_age_lg := pdo_combo_age_lg;
		self.pdo_criminal_count := pdo_criminal_count;
		self.PDO_log := PDO_log;
		self.base := base;
		self.point := point;
		self.odds := odds;
		self.phat := phat;
		self.PDO_CUSTOM := PDO_CUSTOM;
		self.ov_ssndead := ov_ssndead;
		self.ov_ssnprior := ov_ssnprior;
		self.ov_criminal_flag := ov_criminal_flag;
		self.ov_corrections := ov_corrections;
		self.PDO_CUSTOM2 := PDO_CUSTOM2;
		self.inCalif := inCalif;
	
	#end


	END;

	model := project( clam, doModel(LEFT) );
	return model;

end;
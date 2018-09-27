import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVA709_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut doModel( clam le ) := TRANSFORM

		// ----------------------------------
		// Identity
		// ----------------------------------
		nas_summary                          := le.iid.nas_summary;
		nap_summary                          := le.iid.nap_summary;
		in_dob                               := le.shell_input.dob;


		// ----------------------------------
		// Phone
		// ----------------------------------

		telcordia_type                       := le.phone_verification.telcordia_type;
		nap_type                             := le.iid.nap_type;
		nap_status                           := le.iid.nap_status;
		recent_disconnects                   := le.phone_verification.recent_disconnects;
		rc_phonezipflag                      := (INTEGER)le.iid.phonezipflag;
		rc_hriskphoneflag                    := (INTEGER)le.iid.hriskphoneflag;
		rc_disthphoneaddr                    := le.iid.disthphoneaddr;
						 
		// ----------------------------------
		// Address
		// ----------------------------------

		add1_isbestmatch                     := le.address_verification.input_address_information.isbestmatch;
		add2_isbestmatch                     := le.address_verification.address_history_1.isbestmatch;
		add1_source_count                    := le.address_verification.input_address_information.source_count;
		add2_source_count                    := le.address_verification.address_history_1.source_count;
		add3_source_count                    := le.address_verification.address_history_2.source_count;
		addrs_5yr                            := le.other_address_info.addrs_last_5years;
		addrs_15yr                           := le.other_address_info.addrs_last_15years;
		rc_hrisksic                          := (INTEGER)le.iid.hrisksic;
		add1_naprop                          := le.address_verification.input_address_information.naprop;
		rc_dwelltype                         := le.Address_Validation.dwelling_type;

		// ----------------------------------
		// Property
		// ----------------------------------

		property_owned_total                 := le.address_verification.owned.property_total;

		// ----------------------------------
		// SSN
		// ----------------------------------

		rc_ssnlowissue                       := le.SSN_Verification.Validation.low_issue_date;
		rc_ssndobflag                        := (INTEGER)le.iid.socsdobflag;
		rc_decsflag                          := le.ssn_verification.validation.deceased;
					  
		// ----------------------------------
		// Velocity
		// ----------------------------------

		ssns_per_adl                         := le.velocity_counters.ssns_per_adl;
		ssns_per_addr                        := le.velocity_counters.ssns_per_addr;
		addrs_per_adl_c6                     := le.velocity_counters.addrs_per_adl_created_6months;
		adls_per_phone_c6                    := le.velocity_counters.adls_per_phone_created_6months;
		ssns_per_addr_c6                     := le.velocity_counters.ssns_per_addr_created_6months;
						   
		// ----------------------------------------
		// Bankruptcy/Derogatory
		// ----------------------------------------

		disposition                          := le.bjl.disposition;
		filing_count                         := le.bjl.filing_count;
		bk_recent_count                      := le.bjl.bk_recent_count;
		bk_disposed_recent_count             := le.bjl.bk_disposed_recent_count;
		bk_disposed_historical_count         := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count        := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_count    := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count          := le.bjl.liens_recent_released_count;
		liens_historical_released_count      := le.bjl.liens_historical_released_count;
		criminal_count                       := le.bjl.criminal_count;
 

		// helpers
		mymax( a, b ) := MACRO if( a < b, b, a ) ENDMACRO;
		mymin( a, b ) := MACRO if( a < b, a, b ) ENDMACRO;


		/*----------------*/
		/*  Verification  */
		/*----------------*/


		nas_ver := (nas_summary=12);


		nap_summary2 := map(
			nap_summary  =  0 => 0,
			nap_summary  =  1 => 1,
			nap_summary  <  8 => 2,
			nap_summary  =  8 => 3,
			nap_summary <= 11 => 4,
			5
		);

		verx := map(
			~nas_ver              => nap_summary2,
			nap_summary2 = 1      => 2,
			nap_summary2 in [0,2] => 6,
			nap_summary2 <= 4     => 7,
			8
		);


		isbestmatch := map(
			~add1_isbestmatch and ~add2_isbestmatch => 0,
			~add1_isbestmatch and  add2_isbestmatch => 1,
			2
		);


		max_add_source_count := mymax(mymax(add1_source_count, add2_source_count), add3_source_count);
		max_add_source_count2 := mymax(mymin(max_add_source_count,5),1);


		addr_quality := map(
			isbestmatch = 0  or max_add_source_count2 = 1 => 0,
			isbestmatch = 1 and max_add_source_count2 = 2 => 1,
			isbestmatch = 1 and max_add_source_count2 = 3 => 2,
			isbestmatch = 1 and max_add_source_count2 = 4 => 3,
			isbestmatch = 2 and max_add_source_count2 = 2 => 3,
			isbestmatch = 1 and max_add_source_count2 = 5 => 4,
			isbestmatch = 2 and max_add_source_count2 = 3 => 4,
			isbestmatch = 2 and max_add_source_count2 = 4 => 5, 
			6
		);

		verx7_m := map(
			(verx = 0 and addr_quality = 0) or (verx = 1)            => 42.00,
			(verx = 0 and addr_quality > 0) or verx = 2              => 37.49,
			(verx in [5,6,7] and addr_quality <= 1) or verx in [3,4] => 35.14,
			verx in [5,6,7]  and addr_quality in [2,3]               => 30.28,
			verx in [5,6]    and addr_quality > 3                    => 27.11,
			23.46
		);

		/*------------------------*/
		/*  Address Verification  */
		/*------------------------*/

		lo_addrs_15yr := (addrs_15yr <= 2);

		address_count_summary_m := map(
			addrs_5yr in [0,1] and ~lo_addrs_15yr => 25.76,
			addrs_5yr  = 2     and ~lo_addrs_15yr => 28.94,
			addrs_5yr in [3,4,5,6]                => 32.93,
			35.27
		);

		/*------------------------*/
		/*   Velocity/SSN Probs   */
		/*------------------------*/

		today := if( le.historydate=999999, (STRING)Std.Date.Today(), ((STRING)le.historydate)[1..6]+'01' );
		today1900 := ut.DaysSince1900( today[1..4], today[5..6], today[7..8] );
		birth1900 := ut.DaysSince1900( in_dob[1..4], in_dob[5..6], in_dob[7..8] );
		li1900    := ut.DaysSince1900( ((STRING)rc_ssnlowissue)[1..4], ((STRING)rc_ssnlowissue)[5..6], ((STRING)rc_ssnlowissue)[7..8] );
		
		age_calc := map
		(
			(INTEGER)in_dob = 0 and (INTEGER)rc_ssnlowissue != 0 => (INTEGER)((today1900 - li1900)/365.25),
			(INTEGER)in_dob = 0                                  => -1,
			(INTEGER)((today1900 - birth1900)/365.25)
		);
		age_calc2 := mymax(mymin(age_calc,65),20);
		
		
		dob_sas_undef := (INTEGER)in_dob = 0; // for sas: dob_sas = .
		age_low_issue_date    := map(
			dob_sas_undef OR rc_ssnlowissue = 0       => -1,
			li1900 < birth1900                        => -1, // low issue 
			(INTEGER)((li1900 - birth1900)/365.25)
		);
		
		age_low_issue_date2   := if( age_low_issue_date < 0, -1, mymin(age_low_issue_date,30) );

		age_int_age_low_issue := age_calc2*age_low_issue_date2;
	
		ssns_per_adl2        := mymax(mymin(ssns_per_adl,4),2);
		addrs_per_adl_c6_2   := mymin(addrs_per_adl_c6,2);
		adls_per_phone_c6_2  := mymin(adls_per_phone_c6,1);
		ssns_per_addr_c6_2   := mymin(ssns_per_addr_c6,6);

		ssns_per_addr_c6_3 := if(ssns_per_addr_c6_2=0 and ssns_per_addr=0, -1, ssns_per_addr_c6_2 );
		ssns_per_addr_apt := map(
			rc_dwelltype = 'E' => -2,
			ssns_per_addr_c6_3=0 and rc_dwelltype='A' => 0.5,
			ssns_per_addr_c6_3=1 and rc_dwelltype='A' => 1.5,
			ssns_per_addr_c6_3
		);


		ssns_per_addr_apt_m := case( ssns_per_addr_apt,
			-2  => 36.30,
			-1  => 33.01,
			0   => 26.72,
			0.5 => 28.56,
			1   => 31.41,
			1.5 => 33.40,
			2   => 35.50,
			3   => 38.67,
			4   => 38.21,
			5   => 43.59,
			55.17
		);


		/*------------*/
		/*   Derogs   */
		/*------------*/

		disposition_summary_m := map(
			trim(disposition) = '' => 32.98,
			stringlib.stringtouppercase(disposition[1..5]) = 'DISCH' => 24.38,
			29.41
		);


		many_filings := ( filing_count >= 4 );
		bk_recent_ind := mymin( bk_recent_count, 1 );
		many_disposed_recent := (bk_disposed_recent_count >= 3 );
		many_disposed_historical := (bk_disposed_historical_count >= 4);

		bad_bk := (INTEGER)((bk_recent_ind > 0) or many_filings or many_disposed_recent or many_disposed_historical);
		liens_recent_unreleased_ind := mymin(liens_recent_unreleased_count,1);


		liens_unreleased := map(
			0=liens_recent_unreleased_ind and liens_historical_unreleased_count = 1 => 1, // historical, no current unreleased
			0=liens_recent_unreleased_ind and liens_historical_unreleased_count = 0 => 0, // no unreleased liens
			2 //recent unreleased or many historical unreleased liens;
		);

		liens_released := map(
			liens_historical_released_count = 0 => 0,
			liens_historical_released_count = 1 and liens_recent_released_count <= 1 => 1,
			2
		);
			
		liens_summary := map(
			liens_unreleased <= 1 and liens_released >= 1 => 0,
			liens_unreleased  = 0 and liens_released  = 0 => 1,
			liens_unreleased  = 1 and liens_released  = 0 => 2,
			3
		);


		criminal_ind := (criminal_count >= 1);
		property_owned_ind := mymin(property_owned_total,1);

		liens_prop_crim_summary_m := map(
			criminal_ind => 45.59,
			liens_summary <= 2 and property_owned_ind=1 => 23.10,
			liens_summary = 3 and property_owned_ind=1  => 26.00,
			liens_summary = 0 and property_owned_ind=0  => 26.00,
			liens_summary in [1,2]                      => 32.60,
			34.87
		);

		/*--------------*/
		/*  Phone Prob  */
		/*--------------*/

		disconnected  := rc_hriskphoneflag=5;
		disconnected2 := (trim(nap_status) = 'D' or recent_disconnects > 2);

		disconnect_summary := map(
			~disconnected and ~disconnected2 => 0,
			 disconnected and ~disconnected2 => 1,
			 2
		);


		large_phone_addr_distance := (rc_disthphoneaddr >= 5);
		rc_phonezipflag2 := (rc_phonezipflag = 1);
		gonghit := (trim(nap_type) != '');

		phone_hi_risk := (rc_hriskphoneflag != 0);

		pnotpots := (telcordia_type not in ['00','50','51','52','54']);

		phone_addr_summary := map(
			~rc_phonezipflag2 and ~large_phone_addr_distance => 0,
			not (rc_phonezipflag2 and large_phone_addr_distance) => 1,
			2
		);

		phone_risk_summary3_m := map(
			not phone_hi_risk and not pnotpots and gonghit         => 29.74,
			not phone_hi_risk and not pnotpots and not gonghit     => 31.47,
			(phone_hi_risk or gonghit) and phone_addr_summary <= 1 => 33.22,
			phone_addr_summary = 2 or disconnect_summary = 2       => 37.99,
			43.60
		);

		/*-----------------------------------------------------*/
		/*   CREATE SCORES 									   */
		/*-----------------------------------------------------*/

		outest := -5.920624949
			+ verx7_m  * 0.0367914933
			+ address_count_summary_m  * 0.0194838328
			+ age_calc2  * -0.015351566
			+ age_low_issue_date2  * -0.03633716
			+ ssns_per_adl2  * 0.2812157205
			+ addrs_per_adl_c6_2  * 0.1015873392
			+ adls_per_phone_c6_2  * 0.1958077415
			+ bad_bk  * 0.4095740935
			+ disposition_summary_m  * 0.0264036946
			+ liens_prop_crim_summary_m  * 0.027573417
			+ phone_risk_summary3_m  * 0.0244133967
			+ ssns_per_addr_apt_m  * 0.0243578091
			+ age_int_age_low_issue  * 0.0006669238
		;
		outest2 := (exp(outest))/(1+exp(outest));

		base  := 650;
		odds  := .3192/.6808;  
		point := -40;
		phat  := outest2;
		rva709_1_0a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		rva709_1_0b := mymin(rva709_1_0a, 900);
		rva709_1_0c := mymax(rva709_1_0b, 501);

		ssndead := rc_decsflag;
		ssnprior:= (rc_ssndobflag = 1);
		corrections := (rc_hrisksic = 2225);

		// reason codes
		riTemp  := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RiskWise.rvReasonCodes(le, 4, inCalif)
		);
		//
		
		
		rva709_1_0 := map(
			riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid)  => 222,
			(ssndead or ssnprior or criminal_count>0 or corrections) and rva709_1_0c > 630 => 630,
			rva709_1_0c
		);
		
		// self.score := intformat(rva709_1_0, 3, 1);
		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			intformat(rva709_1_0,3,1)
		);

		self.seq := le.seq;
		self := [];
	END;

	final := project( clam, doModel(LEFT) );

	return final;
END;
import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVR611_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut doModel( clam le ) := TRANSFORM

		// input data
			in_dob			:= le.shell_input.dob;
			nas_summary		:= le.iid.nas_summary;
			nap_summary		:= le.iid.nap_summary;
			nap_status		:= le.iid.nap_status;

			addrpop			:= le.input_validation.address;
			ssnpop			:= le.input_validation.ssn;
			dobpop			:= le.input_validation.dateofbirth;
			hphnpop			:= le.input_validation.homephone;

			dwelling_type	:= le.address_validation.dwelling_type;
			error_codes		:= le.address_validation.error_codes;
			corrections		:= le.address_validation.corrections;

			source_count	:= le.name_verification.source_count;

			add1_address_score		:= le.address_verification.input_address_information.address_score;
			add1_isbestmatch		:= le.address_verification.input_address_information.isbestmatch;
			add1_source_count		:= le.address_verification.input_address_information.source_count;
			add1_naprop				:= le.address_verification.input_address_information.naprop;

			property_owned_total	:= le.address_verification.owned.property_total;
			property_sold_total		:= le.address_verification.sold.property_total;
			property_ambig_total	:= le.address_verification.ambiguous.property_total;

			add2_isbestmatch		:= le.address_verification.address_history_1.isbestmatch;
			add2_naprop				:= le.address_verification.address_history_1.naprop;
			add3_naprop				:= le.address_verification.address_history_2.naprop;

			phone_score				:= le.phone_verification.phone_score;
			telcordia_type			:= le.phone_verification.telcordia_type;
			phone_zip_mismatch		:= le.phone_verification.phone_zip_mismatch;
			disconnected			:= le.phone_verification.disconnected;
			adlperssn_count			:= le.SSN_Verification.adlPerSSN_count;
			deceased				:= le.ssn_verification.validation.deceased;

			high_issue_date			:= le.ssn_verification.validation.high_issue_date;
			low_issue_date			:= le.ssn_verification.validation.low_issue_date;

			bankrupt						:= le.bjl.bankrupt;
			liens_recent_unreleased_count	:= le.bjl.liens_recent_unreleased_count;
			criminal_count					:= le.bjl.criminal_count;
		// end input data

		contrary_phone := ( nap_summary = 1 );

		verfst_p := ( nap_summary in [2,3,4,8,9,10,12] );
		verlst_p := ( nap_summary in [2,5,7,8,9,11,12] );
		veradd_p := ( nap_summary in [3,5,6,8,10,11,12] );
		verphn_p := ( nap_summary in [4,6,7,9,10,11,12] );
			
			
		ssn479       := ( nas_summary in [4,7,9] );
		stolen_id_ap := ( nap_summary = 6 );

		nap_ver_level := map(
			verphn_p and verlst_p and veradd_p and verfst_p	=> 3,
			verphn_p and verlst_p							=> 2,
			verphn_p and stolen_id_ap						=> 1,
			contrary_phone									=> -1,
			verphn_p										=> 2,
			0
		);

		add1_address100 := ( add1_address_score between 40 and 100 );
		phone100        := ( phone_score between 80 and 100 );


		/* if add1_isbestmatch */
		source_count2_bestmatch := map(
			source_count <= 1	=> 1,
			source_count >= 3	=> 3,
			source_count

		);

		add1_source_count2_bestmatch := map(
			add1_source_count <= 2	=> 2,
			add1_source_count >= 4	=> 4,
			add1_source_count
		);

		source_count_combo_bestmatch := map(
			( source_count2_bestmatch >= 3 ) and ( add1_source_count2_bestmatch >= 4 )	=> 2,
			( source_count2_bestmatch <= 1 ) and ( add1_source_count2_bestmatch <= 2 )	=> 0,
			1
		);


		nap_ver_level_m_bestmatch := case( nap_ver_level,
			-1 => 0.1119592875,
						0	=> 0.0936495177,
						1	=> 0.0857306426,
						2	=> 0.0673460956,
						0.0543933054
		);

		source_count_combo_m_bestmatch := case( source_count_combo_bestmatch,
						0	=> 0.0834840891,
						1	=> 0.0731453444,
						0.0552805281
		);

		vermod_add1best_a := -4.412625908
			+ nap_ver_level_m_bestmatch  * 13.336604677
						+ source_count_combo_m_bestmatch  * 11.054274728
						;

		vermod_add1best_b := (exp(vermod_add1best_a )) / (1+exp(vermod_add1best_a));
		vermod_add1best   := round(1000 * vermod_add1best_b )/10;


		/* end if add1_isbestmatch */
		/* if not add1_isbestmatch */

		source_count2_b := map(
			source_count <= 2	=> 2,
			source_count >= 3	=> 3,
			source_count
		);

		nap_ver_level_notbestmatch := map(
			verphn_p and verlst_p	=> 2,
			~verlst_p and veradd_p	=> 0,
			contrary_phone		=> 0,
			1
		);

		verx_b := map(
			( nap_ver_level_notbestmatch = 0 ) and ssn479	=> 0,
			( nap_ver_level_notbestmatch = 1 ) and ssn479	=> 1,
			( nap_ver_level_notbestmatch = 2 ) and ssn479	=> 2,
			( nap_ver_level_notbestmatch = 0 ) 		=> 2,
			( nap_ver_level_notbestmatch = 1 ) 		=> 2,
			3
		);

		score_combo_b := map(
			add1_address100 and phone100	=> 2,
			add1_address100 or phone100	=> 1,
			0
		);

		source_count2_b_m := map(
			source_count2_b = 2	=> 0.1183739837,
			0.0990712074
		);

		verx_b_m := case( verx_b,
			0	=> 0.1585772508,
						1	=> 0.1390512204,
						2	=> 0.1032511611,
						0.0735502122
		);


		score_combo_b_m := case( score_combo_b,
			0 => 0.1335559265,
			1 => 0.1220300125,
			0.0975978498
		);

		vermod_add1notbesta := -4.806050114
			+ source_count2_b_m * 9.8434355582
						+ verx_b_m * 8.2052705202
						+ score_combo_b_m * 4.0408331959
						+ ((INTEGER)add2_isbestmatch) * 0.2397603404
						;
		vermod_add1notbestb := (exp(vermod_add1notbesta)) / (1+exp(vermod_add1notbesta));
		vermod_add1notbest := round(1000 * vermod_add1notbestb)/10.0;

		vermod := if( add1_isbestmatch, vermod_add1best, vermod_add1notbest );

		/* end if not add1_isnotbestmatch */



		/* Fraud Point */

		aptflag := ( addrpop and trim( dwelling_type ) = 'A' );

		ec1 := trim(error_codes)[1];
		ec3 := trim(error_codes)[3];
		ec4 := trim(error_codes)[4];


		addr_changed := ( addrpop and ec1 = 'S' and ec3 != '0' );
		unit_changed := ( addrpop and ec1 = 'S' and ec4 != '0' );

		standardization_level := map(
			addrpop and unit_changed	=> 1,
			addrpop and addr_changed	=> 2,
			0
		);

		pnotpots := hphnpop and ( ~telcordia_type in ['00','50','51','52','54'] );

		disconnect_level := map(
			hphnpop and disconnected			=> 2,
			hphnpop and trim(nap_status) = 'D'	=> 1,
			0
		);

		ssndead := ssnpop and deceased;


		/* SSNPrior */
		high_issue_dateyr := (INTEGER)(((STRING)high_issue_date)[1..4]);
		dob_year := (INTEGER)(in_dob[1..4]);
		year_diff := high_issue_dateyr - dob_year;
		ssnprior := ssnpop and ( high_issue_dateyr > 0 and dob_year > 0 and ( year_diff between -100 and 2 ) );

		adlperssn_count2 := map(
			adlperssn_count >= 4	=> 4,
			adlperssn_count >= 3	=> 3,
			adlperssn_count >= 2	=> 2,
			adlperssn_count >= 1	=> 1,
			0
		);


		/* Derog */
		liens_recent_unrel_flag     	:= liens_recent_unreleased_count > 0;

		criminal_flag := ( criminal_count > 0 );


		/* Age */
		dob_y := (INTEGER)(in_dob[1..4]);
		low_issue_year := (INTEGER)(((STRING)low_issue_date)[1..4]);

		sysyear := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));


		age_dob := sysyear - dob_y;
		age_ssn_issue := sysyear - low_issue_year;

		age_dob2 := map(
			age_dob <= 21	=> 21,
			age_dob >= 65	=> 65,
			age_dob
		);

		age_ssn_issue2 := map(
			age_ssn_issue > 200	=> 40,
			age_ssn_issue <= 33	=> 33,
			age_ssn_issue > 41	=> 41,
			age_ssn_issue
		);


		/* property */
		property_owned_total_x := if( property_owned_total > 0, 1, 0 );
		property_sold_total_x  := if( property_sold_total > 0, 1, 0 );
		property_ambig_total_x := if( property_ambig_total > 0, 1, 0 );

		Prop_owner := map(
			( add1_naprop = 4 ) or ( add2_naprop = 4 ) or ( add3_naprop = 4 )	=> 2,
			( property_owned_total_x + property_sold_total_x + property_ambig_total_x ) > 0	=> 1,
			0
		);

		add1_naprop_level := map(
			( add1_naprop = 4 )	=> 2,
			( add1_naprop = 3 ) or ( prop_owner >= 1 )	=> 1,
			0
		);

		add1_naprop_level_m := case( add1_naprop_level,
			0 => 0.0987272904,
			1 => 0.0661230421,
			0.051498847
		);

		/* models */
		crimbk := criminal_flag or bankrupt;

		fpmod2a := -2.881837026
			+ ((INTEGER)aptflag) * 0.1067952077
			+ standardization_level  * 0.0429080152
			+ ((INTEGER)phone_zip_mismatch)  * 0.2901461137
			+ disconnect_level  * 0.3042150184
			+ ((INTEGER)pnotpots) * 0.2328548206
			+ adlperssn_count2  * 0.1694935532
			+ ((INTEGER)ssnprior) * 0.703195186
			;

		fpmod2 := 100 * ( exp(fpmod2a) ) / ( 1+exp(fpmod2a) );

		mod7a := -3.888096222
			+ vermod  * 0.0731671503
			+ fpmod2  * 0.0631886092
			+ ((INTEGER)liens_recent_unrel_flag) * 1.0137439036
			+ ((INTEGER)crimbk) * 0.4586866608
			+ age_dob2  * -0.027529531
			+ add1_naprop_level_m  * 11.41986395
						;
		mod7b := (exp(mod7a)) / (1+exp(mod7a));
		phata := mod7b;
		mod7c := round(1000 * mod7b)/10;



		mod7_nodoba := -2.179839898
			+ vermod  * 0.0744301239
			+ fpmod2  * 0.0840160316
			+ ((INTEGER)liens_recent_unrel_flag) * 0.9503655024
			+ ((INTEGER)crimbk) * 0.3282613093
			+ age_ssn_issue2  * -0.075854726
			+ add1_naprop_level_m  * 9.6690003577
			;
		mod7_nodobb := (exp(mod7_nodoba)) / (1+exp(mod7_nodoba));
		phatb := mod7_nodobb;
		mod7_nodobc := round(1000 * mod7_nodobb)/10;


		phat := if( dobpop, phata, phatb );


		base  := 703;
		odds  := 0.047619048;
		point := -40;

		RiskView611a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

		RiskView611b := map(
			RiskView611a < 501	=> 501,
			RiskView611a > 900	=> 900,
			RiskView611a
		);


		/* Overrides Caps and NoScores */
		RiskView611c := if( ( RiskView611b > 680 ) and ( ssndead or ssnprior or criminal_flag or corrections ), 680, RiskView611b );

		RVR611a := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, RiskView611c );

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

		RVR611b := map(
			RVR611a < 501	=> 501,
			RVR611a > 900	=> 900,
			RVR611a
		);

		RVR611 := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, RVR611b);


		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;


		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RVR611 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rvReasonCodes(le, 4, inCalif)
		);

		self.score := if(riTemp[1].hri in ['91','92','93','94','95'], (string)((integer)riTemp[1].hri + 10), if(self.ri[1].hri='35', '000', intformat(RVR611,3,1)));
		self.seq := le.seq;		
		self := [];
	END;


	final := project(clam, doModel(left));

	RETURN (final);

END;

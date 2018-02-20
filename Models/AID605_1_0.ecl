import ut, risk_indicators, RiskWise, RiskWiseFCRA;

export AID605_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif, real employment_years, real employment_months, real applicant_income ) := FUNCTION



	Models.Layout_ModelOut doModel(clam le) := TRANSFORM
		/* Data provided by client on input record */
			employment_time := employment_years + (employment_months/12.0);
			
			employ_time_m := map( 
				employment_time <= 1  => 0.1064179,
				employment_time <= 4  => 0.0922209,
				employment_time <= 10 => 0.0816313,
				0.0758462
			);

			app_inc_im := map(
				applicant_income <= 1700 => 0.1150055,
				applicant_income <= 2100 => 0.1042018,
				applicant_income <= 2500 => 0.1000402,
				applicant_income <= 3333 => 0.0899965,
				applicant_income <= 4200 => 0.0664758,
				0.0488362
			);


		/* Phone Problems */
			pnotpots := if( le.phone_verification.telcordia_type in ['00', '50', '51', '52', '54'], 0, 1 );
			discon   := if( le.phone_verification.disconnected or le.iid.nap_status = 'D', 1, 0 );

			phnprob_m := map(
				discon = 1 => 0.1220395,
				pnotpots = 1 => 0.1140998,
				pnotpots = 0 and le.phone_verification.phone_zip_mismatch => 0.0971680,
				0.0825053
			);


			/* Distance Address to Phone */
			distance_c := if( le.phone_verification.distance = 9999, -1, Min( le.phone_verification.distance, 20 ) );
			distance_cl := ln( distance_c + 2 );


		/* Derogs */
		     //lien_recent_un := Min(2, le.bjl.liens_recent_unreleased_count);
			//lien_hist_un := Min(2, le.bjl.liens_historical_unreleased_count);
			//lien_recent_rel := Min(2, le.bjl.liens_recent_released_count);
			//lien_hist_rel := Min(2, le.bjl.liens_historical_released_count);

			unreleased_level := map(
				le.bjl.liens_recent_unreleased_count = 0 and le.bjl.liens_historical_unreleased_count = 0 => 0,
				le.bjl.liens_recent_unreleased_count = 0 and le.bjl.liens_historical_unreleased_count > 0 => 1,
				Min( le.bjl.liens_recent_unreleased_count, 3 ) + 1
			);

			unreleased_level_m := map(
				unreleased_level = 0 => 0.0880557,
				unreleased_level = 1 => 0.0920899,
				unreleased_level = 2 => 0.0992556,
				unreleased_level = 3 => 0.1183673,
				0.1458886
				// unreleased_level = 4 => 0.1458886
			);



		/* Vehicle data */
			vehicle_m := map(
				le.vehicles.historical_count = 0 => 0.1003232,
				le.vehicles.historical_count <= 5 => 0.0801158,
				0.0694833
				//le.vehicles.historical_count >= 6 => 0.0694833
			);




		/* Verification */
			nap_v1 := map(
				le.iid.nap_summary in [1] => 0,
				le.iid.nap_summary in [0] => 2,
				le.iid.nap_summary in [4, 6, 7, 9] => 1,
				le.iid.nap_summary in [2, 3, 5, 8] => 3,
				le.iid.nap_summary in [10, 11] => 4,
				5
				//le.iid.nap_summary in [12] => 5
			);

			gong_na := if( le.iid.nap_type = 'A', 1, 0 );


			nap_v2_m := map(
				nap_v1 = 5 and gong_na = 1 => 0.0542532,
				nap_v1 = 4 and gong_na = 1 => 0.0602345,
				nap_v1 = 5 and gong_na = 0 => 0.0805529,
				nap_v1 = 3 or  gong_na = 1 => 0.0844610,
				nap_v1 = 4                 => 0.0918972,
				nap_v1 = 2                 => 0.0926725,
				nap_v1 = 1                 => 0.1121509,
				0.1309307
				//nap_v1 = 0                 => 0.1309307
			);



		/* Address Verification */
			add1_source_count := le.address_verification.input_address_information.source_count;
			add1_src_cnt_m := map(
				add1_source_count = 0 => 0.1234894,
				add1_source_count = 1 => 0.0957098,
				add1_source_count = 2 => 0.0957098,
				add1_source_count = 3 => 0.0815368,
				add1_source_count = 4 => 0.0605723,
				0.0428152
				//add1_source_count > 4 => 0.0428152
			);



		/* Property */
			isbestmatch := map(
				le.address_verification.input_address_information.isbestmatch => 2,
				le.address_verification.address_history_1.isbestmatch => 1,
				0
			);

			naprop := map(
				le.address_verification.input_address_information.NAProp in [0] => 0,
				le.address_verification.input_address_information.NAProp in [1] => 1,
				le.address_verification.input_address_information.NAProp in [2, 3] => 2,
				3
				//le.address_verification.input_address_information.NAProp in [4] => 3
			);

			// is this the value we want to use?
			prop_owned := if( le.Address_Verification.owned.property_total > 0, 1, 0 );

			ownership := map(
				le.address_verification.input_address_information.applicant_owned => 2,
				le.address_verification.input_address_information.family_owned => 1,
				0
			);

			owner_tree := map(
				isbestmatch in [2] and ownership = 2 => 6,
				isbestmatch in [2] and ownership = 1 => 5,
				isbestmatch in [0,1] and ownership = 2 => 4,
				isbestmatch in [2] and ownership = 0 => 3,
				isbestmatch in [0,1] and ownership = 1 => 2,
				isbestmatch in [1] and ownership = 0 => 1,
				0
				//isbestmatch in [0] and ownership = 0 => 0
			);


			owner_tree2 := map(
				owner_tree = 0 and prop_owned = 1 => 1,
				owner_tree = 1 and prop_owned = 1 => 2,
				owner_tree = 3 and prop_owned = 1 => 5,
				owner_tree = 5 and prop_owned = 1 => 6,
				owner_tree
			);

			owner_tree3 := map(
				owner_tree2 in [0, 1, 3, 5] and naprop = 3 => 6,
				owner_tree2 in [3] and naprop = 2 => 5,
				owner_tree2
			);


			owner_tree3_m := map(
				owner_tree3 = 0 => 0.1276151,
				owner_tree3 = 1 => 0.1182462,
				owner_tree3 = 2 => 0.0974265,
				owner_tree3 = 3 => 0.0858728,
				owner_tree3 = 4 => 0.0790843,
				owner_tree3 = 5 => 0.0724320,
				0.0499277
				//owner_tree3 = 6 => 0.0499277
			);






		/* Calculate score */

			reg605b_mod_1  :=           -7.519300268
				+ phnprob_m          * 7.5255857316
				+ distance_cl        * 0.0618247135
				+ unreleased_level_m * 9.7041960795
				+ vehicle_m          * 6.7894221864
				+ nap_v2_m           * 5.2410214554
				+ add1_src_cnt_m     * 5.1417785892
				+ owner_tree3_m      * 5.7728634905
				+ employ_time_m      * 5.9561875195
				+ app_inc_im         * 10.601546386
			;

			base  := 660;
			odds  := 0.10 / 0.90;
			point := -80;

			reg605b_mod := (exp( reg605b_mod_1 )) / (1 + exp( reg605b_mod_1 ));
			phat := reg605b_mod;

	
			aid605a := (integer)(point*(ln(phat/(1-phat)) - ln(odds))/ln(2) + base);
			
			// limit to within the (250,999) range
			aid605 := map(
				aid605a < 250 => 250,										// score is at least 250
				le.ssn_verification.validation.deceased AND aid605a > 700 => 700,	// and at most 700 if deceased
				aid605a > 999	=> 999,										// and at most 999 if not deceased
				aid605a													
			);


		/* copied from 606_0_0 */
		self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), intformat(aid605,3,1));
		self.seq := le.seq;	
		/* </copied> */
	END;
	
	out := project(clam, doModel(LEFT));



	Models.Layout_ModelOut addReasons(Models.Layout_ModelOut le, clam ri) := TRANSFORM
		employ_months := employment_years*12 + employment_months;
		isCalifornia := inCalif and ((integer)(boolean)ri.iid.combo_firstcount+(integer)(boolean)ri.iid.combo_lastcount+
								(integer)(boolean)ri.iid.combo_addrcount+(integer)(boolean)ri.iid.combo_hphonecount+
								(integer)(boolean)ri.iid.combo_ssncount+(integer)(boolean)ri.iid.combo_dobcount) < 3;

		self.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.fbReasonCodes(ri, 4, OFAC, isCalifornia, employ_months, applicant_income));
		self.score := if((integer)self.ri[1].hri = 35, '000', le.score);
		self := le;
	END;
	final := join( out, clam, left.seq=right.seq, addReasons(left, right), left outer );


	RETURN( final );

END;
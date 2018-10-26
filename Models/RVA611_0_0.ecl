import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVA611_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut doModel( clam le ) := TRANSFORM

		/* Verification */

		/* NAP and NAS */
			contrary_phone := (le.iid.nap_summary = 1);
			
			verfst_p := ( le.iid.nap_summary in [2,3,4,8,9,10,12] );
			verlst_p := ( le.iid.nap_summary in [2,5,7,8,9,11,12] );
			veradd_p := ( le.iid.nap_summary in [3,5,6,8,10,11,12] );
			verphn_p := ( le.iid.nap_summary in [4,6,7,9,10,11,12] );


			phncount := (INTEGER)verfst_p + (INTEGER)verlst_p + (INTEGER)veradd_p + (INTEGER)verphn_p;

			dob_score100 := (le.name_verification.dob_score between 90 and 100);

			source_count2 := map(
				le.name_verification.source_count <= 1	=> 1,
				le.name_verification.source_count = 2	=> 2,
				3
			);

			// add1_source_count2 := ut.Min2( 5, le.address_verification.input_address_information.source_count );
			add1_source_count := le.address_verification.input_address_information.source_count;
			add1_source_count2 := if( add1_source_count > 5, 5, add1_source_count );


			/* Add1_IsBestMatch */
			add1_isbestmatch := le.address_verification.input_address_information.isbestmatch;

			source_count_sum_pk := 
				if( add1_isbestmatch, 
					map(
						source_count2 >= 3 and add1_source_count2 >= 5	=> 4,
						source_count2 >= 3 and add1_source_count2 >= 4	=> 3,
						source_count2 >= 3								=> 2,
											   add1_source_count2 >= 3	=> 2,
						source_count2 >= 2								=> 1,
						0
					),
					map(
						source_count2 >= 3 and add1_source_count2 >= 3	=> 14,
						source_count2 >= 2 and add1_source_count2 >= 2	=> 13,
						source_count2 >= 3								=> 12,
						source_count2 >= 2 and add1_source_count2 >= 1	=> 12,
						source_count2 >= 2								=> 11,
						source_count2 >= 1 and add1_source_count2 >= 1	=> 11,
						10
					)
				);
				
			

			ver_p_level :=
				if( add1_isbestmatch,
					map(
						verphn_p and verlst_p and veradd_p and verfst_p		=> 4,
						verphn_p and verlst_p and (veradd_p or verfst_p)	=> 3,
						phncount = 2 and verphn_p and veradd_p				=> 0,
						phncount = 2 and verlst_p and veradd_p				=> 0,
						phncount = 0										=> 1,
						2
					),
					map(
						verphn_p and verlst_p and veradd_p and verfst_p		=> 13,
						verphn_p and verlst_p and (veradd_p or verfst_p)	=> 12,
						phncount = 2 and verphn_p and veradd_p				=> 10,
						phncount = 2 and verlst_p and veradd_p				=> 10,
						11
					)
				);
				
				
				
				
			add_score100 := (INTEGER)if( add1_isbestmatch,
					le.address_verification.input_address_information.address_score = 100,
					le.address_verification.input_address_information.address_score between 50 and 100 );


			source_count_sum_pk_m := 
				if( add1_isbestmatch, 
					case( source_count_sum_pk,
						0	=> 0.1042600,
						1	=> 0.0961441,
						2	=> 0.0667807,
						3	=> 0.0498828,
						// 4	=> 0.0432271
						0.0432271
					),
					case( source_count_sum_pk,
						10	=> 0.1524677,
						11	=> 0.1336918,
						12	=> 0.1112426,
						13	=> 0.0852323,
						// 14	=> 0.0671043
						0.0671043
					)
				);	

			ver_p_level_m := 
				if( add1_isbestmatch,
					case( ver_p_level,
						0	=> 0.1043221,
						1	=> 0.0922911,
						2	=> 0.0851288,
						3	=> 0.0664804,
						// 4	=> 0.0529554
						0.0529554
					),
					case( ver_p_level,
						10	=> 0.1462517,
						11	=> 0.1344338,
						12	=> 0.1009082,
						// 13	=> 0.0897334,
						0.0897334
					)
				);

			
			vermod_best_pk := -4.119567383
				+ (INTEGER)contrary_phone  * 0.4385632308
				+ (INTEGER)dob_score100  * -0.213181335
				+ source_count_sum_pk_m  * 11.603723208
				+ ver_p_level_m  * 11.197587039
			;

			vermod_best_pk2 := 100 * (exp(vermod_best_pk )) / (1+exp(vermod_best_pk ));


			vermod_best_nodob_pk := -4.364334391
				+ (INTEGER)contrary_phone  * 0.445876405
				+ source_count_sum_pk_m  * 12.359236116
				+ ver_p_level_m  * 11.294759898
			;

			vermod_best_nodob_pk2 := 100 * (exp(vermod_best_nodob_pk )) / (1+exp(vermod_best_nodob_pk ));


			// notbest only used when add1_isbestmatch is false, so  voter_avail is also only relevant in that case
			fname_voter_sourced := le.Name_Verification.fname_voter_sourced;
			lname_voter_sourced := le.Name_Verification.lname_voter_sourced;
			add1_voter_sourced := le.address_verification.input_address_information.voter_sourced;
			
			voter_sourced_level := map(
				le.Available_Sources.Voter and lname_voter_sourced and add1_voter_sourced and fname_voter_sourced		=> 12,
				le.Available_Sources.Voter and ~lname_voter_sourced and ~add1_voter_sourced and ~fname_voter_sourced	=> 10,
				le.Available_Sources.Voter																				=> 11,
				10
			);
			
			voter_sourced_level_m := case( voter_sourced_level,
				10 => 0.1320041,
				11 => 0.1053109,
				// 12 => 0.0865111
				0.0865111
			);
			
			vermod_notbest_pk := -3.949438562
				+ add_score100  * -0.198367334
				+ source_count_sum_pk_m  * 4.2957044032
				+ voter_sourced_level_m  * 4.2511338863
				+ ver_p_level_m  * 8.4312132299
			;
			vermod_notbest_pk2 := 100 * (exp(vermod_notbest_pk )) / (1+exp(vermod_notbest_pk ));


			vermod := map(
				add1_isbestmatch and le.input_validation.dateofbirth	=> vermod_best_pk2,
				add1_isbestmatch			=> vermod_best_nodob_pk2,
				vermod_notbest_pk2
			);


			/* property */
			property_owned_total_x := le.address_verification.owned.property_total > 0;
			property_sold_total_x  := le.address_verification.sold.property_total > 0;
			property_ambig_total_x := le.address_verification.ambiguous.property_total > 0;

			property_total_x   := property_owned_total_x or property_sold_total_x or property_ambig_total_x;
			property_total_sum := (INTEGER1)property_owned_total_x + (INTEGER1)property_sold_total_x + (INTEGER1)property_ambig_total_x;

			add1_naprop := le.address_verification.input_address_information.naprop;
			add2_naprop := le.address_verification.address_history_1.naprop;
			add3_naprop := le.address_verification.address_history_2.naprop;

			Prop_Owner := map(
				add1_naprop = 4 or add2_naprop = 4 or add3_naprop = 4	=> 2,
				property_total_sum > 0									=> 1,
				0
			);

			Prop_occupant_owner := ( (INTEGER)le.address_verification.input_address_information.occupant_owned
									+ (INTEGER)le.address_verification.address_history_1.occupant_owned
									+ (INTEGER)le.address_verification.address_history_2.occupant_owned ) > 0;

			Prop_tree := map(
				Prop_Owner = 2 and Add1_Naprop = 4 and property_total_sum >= 2	=> 6,
				Prop_Owner = 2 and Add1_Naprop = 4 								=> 5,
				Prop_Owner = 2 and Prop_occupant_owner							=> 4,
				Prop_Owner in [1,2]												=> 3,
				Prop_Owner = 0 and Prop_occupant_owner							=> 2,
				1
			);

			Prop_tree_m := case( Prop_tree,
				1 => 0.1147679103,
				2 => 0.0920094259,
				3 => 0.0834398605,
				4 => 0.0765895954,
				5 => 0.0523432097,
				// 6 => 0.0318812363
				0.0318812363
			);






		/* derog */

			/* derog-liens*/
				liens_recent_unrel_flag     := le.bjl.liens_recent_unreleased_count > 0;
				liens_historical_unrel_flag := le.bjl.liens_historical_unreleased_count > 0;
				lien_tree := map(
					liens_recent_unrel_flag		=> 2,
					liens_historical_unrel_flag	=> 1,
					0
				);

				lien_tree_m := case( lien_tree,
					0 => 0.0836236499,
					1 => 0.121003926,
					// 2 => 0.151197202
					0.151197202
				);


			/* derog bankrupt */
				disposition := le.bjl.disposition;
				bk_discharged := map(
					trim(disposition) = ''		=> 0,
					length(trim(disposition)) < 9	=> 0,
					trim(disposition[1..9]) = 'Discharge'	=> 1,
					0
				);

				bk_recent_count2 := le.bjl.bk_recent_count >= 1;



			/* bankrupt variable */
			bk_4 := map(
				le.bjl.bankrupt and bk_discharged = 0 and bk_recent_count2	=> 2,
				le.bjl.bankrupt and bk_discharged = 0						=> 1,
				0
			);

			bk_4_m := case( bk_4,
				0 => 0.0868878003,
				1 => 0.2010582011,
				// 2 => 0.2599009901
				0.2599009901
			);




		/* fraud point*/
			ec1 := le.address_validation.error_codes[1];
			ec3 := le.address_validation.error_codes[3];
			ec4 := le.address_validation.error_codes[4];

			aptflag      := le.input_validation.address and trim(le.address_validation.dwelling_type) = 'A';
			zippobox     := le.input_validation.address and (INTEGER)le.address_validation.zip_type = 1;
			addr_changed := le.input_validation.address and ec1 = 'S' and ec3 != '0';
			unit_changed := le.input_validation.address and ec1 = 'S' and ec4 != '0';

			casserr_pk := map(
				~le.input_validation.address				=> 0,
				ec1 = 'S' and unit_changed and addr_changed	=> 4,
				ec1 = 'S' and unit_changed					=> 3,
				ec1 = 'E'									=> 2,
				ec1 = 'S'				   and addr_changed	=> 1,
				// ec1 = 'S'									=> 0,
				0
			);

			addprob := map(
				~le.input_validation.address	=> 0,
				casserr_pk < 2 and zippobox		=> 2,
				casserr_pk
			);

			
			addprob_m := if( ~le.input_validation.address, 0, 
				case( addprob,
					0 => 0.0810986,
					1 => 0.0916095,
					2 => 0.1045328,
					3 => 0.1244692,
					// 4 => 0.1362468
					0.1362468
				)
			);

			phone_zip_mismatch_n := if( le.input_validation.homephone, (INTEGER)le.phone_verification.phone_zip_mismatch, 0 );
			pnotpots := le.input_validation.homephone and ( not le.phone_verification.telcordia_type in ['00','50','51','52','54'] );
			
			not_connected := map(
				~le.input_validation.homephone	=> true,
				trim(le.iid.nap_status) = 'C' and ~le.phone_verification.disconnected	=> false,
				true
			);


			ssninval := le.input_validation.ssn and ~le.ssn_verification.validation.valid;
			ssndead  := le.input_validation.ssn and le.ssn_verification.validation.deceased;
			
			high_issue_dateyr	:= (INTEGER)(((STRING)le.ssn_verification.validation.high_issue_date)[1..4]);
			dob_year			:= (INTEGER)(le.shell_input.dob[1..4]);
			year_diff			:= high_issue_dateyr - dob_year;

			ssnprior			:= le.input_validation.ssn and high_issue_dateyr > 0 and dob_year > 0 and (year_diff between -100 and 2);

			ssnprob := le.input_validation.ssn and ( ssninval or ssndead or ssnprior );

			// adl_perssn_count2 := ut.Min2(le.SSN_Verification.adlPerSSN_count,3);
			adl_perssn_count2 := case( le.SSN_Verification.adlPerSSN_Count,
				0	=> 0,
				1	=> 1,
				2	=> 2,
				3
			);

			adlperssn_count2_m := case( adl_perssn_count2,
				0 => 0.1059602649,
				1 => 0.0853960627,
				2 => 0.0910810704,
				0.1032511306
			);


			 fp_mod_pka := -4.075608888
						  + (INTEGER)aptflag  * 0.2381462193
						  + addprob_m  * 5.0877141827
						  + phone_zip_mismatch_n  * 0.1554706023
						  + (INTEGER)pnotpots  * 0.3768432169
						  + (INTEGER)not_connected  * 0.2217473422
						  + (INTEGER)ssnprob  * 0.4338466465
						  + adlperssn_count2_m  * 11.919547707
			 ;
			 fp_mod_pk := 100 * (exp(fp_mod_pka )) / (1+exp(fp_mod_pka ));


		/* age */

			dob_y := (INTEGER)le.shell_input.dob[1..4];

			sysyear := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]) );

			input_age := sysyear - dob_y;

			input_age2 := if( input_age > 1000 or input_age < 19, 19, ut.Min2( input_age, 65 ) );



		/* SSN age alternative */


			low_issue_year := (INTEGER)(((STRING)le.ssn_verification.validation.low_issue_date)[1..4]);

			age_ssn_issue := sysyear - low_issue_year;

			age_ssn_issue2 := map(
				age_ssn_issue > 200	=> 13,
				age_ssn_issue <= 11	=> 13,
				age_ssn_issue <= 14	=> 14,
				age_ssn_issue > 47	=> 47,
				age_ssn_issue
			);



		/* Distance */
			distance := le.phone_verification.distance;
			dist2 := map(
				distance = 9999	=> 1,
				distance > 4	=> 4,
				distance
			);


			dist2_m := case( dist2,
				0 => 0.0787454121,
				1 => 0.0921216535,
				2 => 0.0999462654,
				3 => 0.1088328076,
				// 4 => 0.1116024054
				0.1116024054
			);



		/*lres*/

			add1_year_first_seen := (INTEGER)(((STRING)le.address_verification.input_address_information.date_first_seen)[1..4]);
			lres_yearsa := sysyear - add1_year_first_seen;
			yfseen_pop := not( lres_yearsa > 1000 );

			lres_years := map(
				lres_yearsa > 1000	=> -1,
				lres_yearsa > 30	=> 30,
				lres_yearsa
			);

			
			/* AVG Lres */
			firstseendate1 := if( add1_year_first_seen = 0, 10000, add1_year_first_seen ); // there was a if fsd1 =. check here, too, so this could be a trouble spot


			lres_years1a := if( add1_year_first_seen = 0, -1, abs( sysyear - firstseendate1 ) );
			lres_years1  := map(
				lres_years1a > 1000	=> -1,
				lres_years1a > 100	=> 100,
				lres_years1a
			);
			
			yfseen_pop1  := lres_years1a <= 1000;
			 
			 
			 
			 
			secondseendate1a := (INTEGER)(((STRING)le.address_verification.address_history_1.date_first_seen)[1..4]);
			secondseendate1 := if( secondseendate1a = 0, 10000, secondseendate1a ); // there was a if fsd1 =. check here, too, so this could be a trouble spot


			lres_years2a := abs( firstseendate1 - secondseendate1 );
			lres_years2  := map(
				lres_years2a > 1000	=> -1,
				lres_years2a > 100	=> 100,
				lres_years2a
			);
			
			yfseen_pop2  := lres_years2a <= 1000;
			 
			 
			 
			 
			thirdseendate1a := (INTEGER)(((STRING)le.address_verification.address_history_2.date_first_seen)[1..4]);
			thirdseendate1 := if( thirdseendate1a = 0, 10000, thirdseendate1a ); // there was a if fsd1 =. check here, too, so this could be a trouble spot


			lres_years3a := abs( secondseendate1 - thirdseendate1 );
			lres_years3  := map(
				lres_years3a > 1000	=> -1,
				lres_years3a > 100	=> 100,
				lres_years3a
			);
			
			yfseen_pop3  := lres_years3a <= 1000;



			/* Calculates avg length of years in each residence, also rounded to the nearest integer */
			res1 := (lres_years1 <> -1);
			res2 := (lres_years2 <> -1);
			res3 := (lres_years3 <> -1);
			
			total := (integer)res1 + (integer)res2 + (integer)res3;
			
			avglres := ( if(res1, lres_years1, 0)
							 + if(res2, lres_years2, 0)
							 + if(res3, lres_years3, 0) ) / total;

			lres_avg := map(
				avglres > 25	=> 25,
				total = 0		=> -1,
				avglres
			);




		/* RVA611 */


		base  := 703;
		odds  := 1.0/21.0;
		point := -40;

		mod_pk1a := if(
			le.input_validation.dateofbirth,
			-5.41991505
				+ vermod  * 0.0702849384
				+ Prop_tree_m  * 8.3782621576
				+ lien_tree_m  * 8.7323400785
				+ bk_4_m  * 8.0615722514
				+ fp_mod_pk  * 0.0339198481
				+ input_age2  * -0.008337832
				+ dist2_m  * 2.9039589737
				+ lres_years  * -0.011462445
				+ lres_avg  * -0.010581356,
			-5.515752186
				+ vermod  * 0.0691657896
				+ Prop_tree_m  * 8.5081893349
				+ lien_tree_m  * 8.7466228473
				+ bk_4_m  * 8.0453974033
				+ fp_mod_pk  * 0.039280461
				+ age_ssn_issue2  * -0.010037123
				+ dist2_m  * 2.8281845071
				+ lres_years  * -0.011647787
				+ lres_avg  * -0.011153149
		);

		phat := (exp(mod_pk1a)) / (1+exp(mod_pk1a));
		
		RVA611a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);


		/* Overrides Caps and NoScores */
		RVA611b := if( ssndead or ssnprior or le.bjl.criminal_count > 0 or le.address_validation.corrections, ut.Min2( RVA611a, 680 ), RVA611a );
		RVA611c := map(
			RVA611b < 501	=> 501,
			RVA611b > 900	=> 900,
			RVA611b
		);

		RVA611 := if( riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, RVA611c);


		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;


		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RVA611 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rvReasonCodes(le, 4, inCalif)
		);

		self.score := if(riTemp[1].hri in ['91','92','93','94','95'], (string)((integer)riTemp[1].hri + 10), if(self.ri[1].hri='35', '000', intformat(RVA611,3,1)));
		self.seq := le.seq;

	END;


	final := project(clam, doModel(left));

	RETURN (final);

END;

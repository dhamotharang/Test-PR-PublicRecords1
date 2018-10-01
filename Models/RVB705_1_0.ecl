import risk_indicators, ut, riskwise, riskwisefcra, std, riskview;

export RVB705_1_0(
	dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean isCalifornia ) := FUNCTION

	layout_modelout doModel( clam le ) := TRANSFORM
	
		// input data
			// phone
				telcordia_type                  := le.Phone_Verification.telcordia_type;
				phone_zip_mismatch              := le.phone_verification.phone_zip_mismatch;
				phn_corrections                 := le.phone_verification.corrections;
			
			// InstantID
				nap_status                      := le.iid.nap_status;
				nas_summary                     := le.iid.nas_summary;
				nap_summary                     := le.iid.nap_summary;
			
			// misc
				source_count                    := le.Name_Verification.source_count;
				addrpop                         := le.Input_Validation.Address;
				ssnpop                          := le.Input_Validation.SSN;
				archive_date                    := le.historydate;
				in_dob                          := le.shell_input.dob;
				age                             := le.Name_Verification.age;

			// ssn
				low_issue_date                  := le.ssn_verification.validation.low_issue_date;
				deceased                        := le.SSN_Verification.validation.deceased;
				ssn_valid                       := le.SSN_Verification.validation.valid;

			// vehicles
				historical_count                := le.vehicles.historical_count;
				current_count                   := le.vehicles.current_count;
			
			// address information
				add1_source_count               := le.address_verification.input_address_information.source_count;
				add2_source_count               := le.address_verification.address_history_1.source_count;
				add3_source_count               := le.address_verification.address_history_2.source_count;
				add1_naprop                     := le.address_verification.input_address_information.naprop;
				add2_naprop                     := le.address_verification.address_history_1.naprop;
				add1_applicant_owned            := le.address_verification.input_address_information.applicant_owned;
				add1_family_owned               := le.address_verification.input_address_information.family_owned;
				add1_occupant_owned             := le.address_verification.input_address_information.occupant_owned;
				property_owned_total            := le.address_verification.owned.property_total;
				usps_deliverable                := le.address_validation.USPS_Deliverable;
				error_codes                     := le.address_validation.Error_Codes;
				corrections                     := le.address_validation.corrections;

			// derogs
				criminal_count                  := le.bjl.criminal_count;
				disposition                     := stringlib.StringToUppercase(trim(le.bjl.disposition));
				bk_disposed_historical_count    := le.bjl.bk_disposed_historical_count;

				liens_historical_released_count := le.bjl.liens_historical_released_count;
				liens_recent_released_count     := le.bjl.liens_recent_released_count;
				liens_recent_unreleased_count   := le.bjl.liens_recent_unreleased_count;
				liens_historical_unreleased_ct  := le.bjl.liens_historical_unreleased_count;	
		//
		
		// VERIFICATION
			avgTmp := (add1_source_count + add2_source_count + add3_source_count) / 3;
			avg_add_source_count := Min( 5, round(avgTmp) );
			pnotpots             := telcordia_type not in ['00', '50', '51', '52', '54'];

			phone_prob := map(
				pnotpots => 0,
				phone_zip_mismatch or nap_status = '' => 1,
				2
			);

			nas_summary2 := map(
				nas_summary = 0   => 0,
				nas_summary <= 11 => 1,
				2
			);

			nap_summary2 := map(
				nap_summary in [0,2]   => 0,
				nap_summary in [1]     => 1,
				nap_summary in [3,5,8] => 2,
				nap_summary in [4,6,7] => 3,
				4
				// nap_summary in [9,10,11,12] => 4,
			);


			verx := map(
				nap_summary2 = 0 AND phone_prob = 0 AND nas_summary2 = 2 => 1,
				nap_summary2 = 0                                         => 2,
				nap_summary2 = 1                                         => 3,
				nap_summary2 = 2                                         => 0,
				nap_summary2 = 3 and nas_summary2 < 2                    => 3,
				source_count >= 4                                        => 6,
				avg_add_source_count >= 3                                => 5,
				4
			);

			verx_m := case( verx,
				0 => 61.68,
				1 => 56.42,
				2 => 45.91,
				3 => 40.29,
				4 => 37.23,
				5 => 34.60,
				28.90
				// 6 => 28.90
			);
		// END VERIFICATION

		// ADDRESS
			addr_changed := addrpop AND trim(error_codes)[1]='S' AND trim(error_codes)[3] != '0';
			delivery_prob := not usps_deliverable or addr_changed;
		// END ADDRESS

		// DATE CALCULATIONS
			today   := if(le.historydate <> 999999, ((string)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());
			today1900 := ut.DaysSince1900( today[1..4], today[5..6], today[7..8] );
			li1900    := ut.DaysSince1900( ((STRING)low_issue_date)[1..4], ((STRING)low_issue_date)[5..6], ((STRING)low_issue_date)[7..8] );
			birth1900 := ut.DaysSince1900( in_dob[1..4], in_dob[5..6], in_dob[7..8] );
		
			// AGE
				dob_sas_undef := (INTEGER)in_dob = 0; // for sas: dob_sas = .
				
				age_calc := map(
						(INTEGER)in_dob = 0 and low_issue_date != 0 => (INTEGER)((today1900 - li1900)/365.25),
						(INTEGER)in_dob = 0                         => -1,
						(INTEGER)((today1900 - birth1900)/365.25)
				);
				age_calc2 := Max(Min(age_calc,65),20);
				
				
			// LOW ISSUE
				age_low_issue_date := if( dob_sas_undef OR low_issue_date = 0, -1, (INTEGER)((li1900 - birth1900)/365.25) );
				age_low_issue_date2 := if( age_low_issue_date < 0, -2, Min(age_low_issue_date,30) );

				old_at_issue := age_low_issue_date2 >= 19;
		// END DATE CALCS
		


		//exp_car_owner
		exp_car_owner := (historical_count >=3 and current_count > 0);

		// PROPERTY
			//naprop_summary
				naprop_summary := map(
					2 <= add1_naprop AND add1_naprop <= 3 => 2.5,
					add2_naprop = 4  AND add1_naprop = 4 => 5,
					add1_naprop
				);

			//ownership_summary
				ownership_summary := map(
					add1_applicant_owned => 0,
					add1_family_owned    => 1,
					add1_occupant_owned  => 2,
					3
				);
			
			//ownership_20yos
				ownership_20yos := map(
					age_calc2 >  20 and ownership_summary  = 0 => 0,
					age_calc2 <= 20 and ownership_summary <= 1 => 0,
					age_calc2 <= 20 and ownership_summary  = 2 => 1,
					add1_naprop = 4                            => 1,
					source_count > 1                           => 2,
					3
				);
			
			//ownership_20yos_m
				ownership_20yos_m := case( ownership_20yos,
					0 => 29.91,
					1 => 32.68,
					2 => 39.94,
					42.68
				);
					
		// END PROPERTY
				
		// DEROGS
			criminal_ind := Min(criminal_count,1);

			bk_summary2 := map(
				disposition = '' => 0,
				disposition[1..9] != 'DISCHARGE' and bk_disposed_historical_count > 0 => 1,
				disposition[1..9] != 'DISCHARGE' and bk_disposed_historical_count = 0 => 2,
				bk_disposed_historical_count > 0                                      => 3,
				4
			);

			bk_summary2_m := case( bk_summary2,
				0 => 40.20,
				1 => 49.88,
				2 => 42.06,
				3 => 32.02,
				24.36
			);
			

			liens_released := not ( liens_historical_released_count in [0,1] and liens_recent_released_count = 0 );

			liens_unreleased_prop := map(
				liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct = 0 and property_owned_total > 0  => 0,	
				liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct = 0                               => 1,
				liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct > 0                               => 2,
				liens_recent_unreleased_count > 0 and liens_historical_unreleased_ct = 0                               => 3,
				4
				// liens_recent_unreleased_count > 0 and liens_historical_unreleased_ct > 0                               => 4
			);
			liens_prop := map(
				liens_unreleased_prop = 1 and liens_released          => 2,
				liens_unreleased_prop = 1 and naprop_summary in [4,5] => 0,
				liens_unreleased_prop
			);

			liens_prop_m := case( liens_prop,
				0 => 27.72,
				1 => 38.45,
				2 => 44.54,
				3 => 49.39,
				54.15
				// 4 => 54.15
			);
		// END DEROGS

		// CALC SCORE

			outest := -5.201071591                                                                                                                                  
				  + verx_m  * 0.0355475894                                                                                                                  
				  + (INTEGER)delivery_prob  * 0.3691113053                                                                                                           
				  + bk_summary2_m  * 0.040108434                                                                                                            
				  + liens_prop_m  * 0.0358207704                                                                                                            
				  + criminal_ind  * 0.5056711708                                                                                                            
				  + age_calc2  * -0.010679247                                                                                                               
				  + (INTEGER)exp_car_owner  * -0.217076926                                                                                                           
				  + (INTEGER)old_at_issue  * -0.878611968                                                                                                            
				  + ownership_20yos_m  * 0.0205781867                                                                                                       
			 ;                                                     
			outest1 := (exp(outest )) / (1+exp(outest ));                                                                            

			base  := 660;
			odds  := .3896/.6104;  
			point := -50;

			phat := outest1;
			RVB705_1_0a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

			RVB705_1_0b := Min(RVB705_1_0a, 900);
			RVB705_1_0c := Max(RVB705_1_0b, 501);
			override := deceased or (ssnpop and not ssn_valid) or phn_corrections or corrections or (age between 1 and 17);
			
			RVB705_1_0_tmp := if( override, Min( 610, RVB705_1_0c ), RVB705_1_0c );
      
      RVB705_1_0 := if( riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, RVB705_1_0_tmp);
	
  
		// END CALC SCORE
		
		// self.score := intformat(RVB705_1_0,3,1);
		self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		// self.score := if(self.ri[1].hri='35', '000', intformat(,3,1));
		self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), if(self.ri[1].hri='35', '000', intformat(RVB705_1_0,3,1)));
	
		self.seq := le.seq;
		self := [];
		
	END;

	out := project( clam, doModel(LEFT) );


	Layout_ModelOut addReasons(clam le, Layout_ModelOut ri) := TRANSFORM
		self.ri := if(ri.ri[1].hri <> '00', ri.ri, RiskWise.rvReasonCodes(le, 4, isCalifornia) );
		self := ri;
	END;
	final := join(clam, out, left.seq=right.seq, addReasons(left, right), left outer);

	RETURN (final);

END;
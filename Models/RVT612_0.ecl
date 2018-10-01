import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVT612_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM


/* VERIFICATION    */


/* NAP and NAS */
     
     verfst_p := le.iid.nap_summary in [2,3,4,8,9,10,12];
	 verlst_p := le.iid.nap_summary in [2,5,7,8,9,11,12];
	 veradd_p := le.iid.nap_summary in [3,5,6,8,10,11,12];
	 verphn_p := le.iid.nap_summary in [4,6,7,9,10,11,12];
	 
	 contrary_phone := le.iid.nap_summary = 1;

	 verlst_s := le.iid.nas_summary in [2,5,7,8,9,11,12];
	 veradd_s := le.iid.nas_summary in [3,5,6,8,10,11,12];
	 verssn_s := le.iid.nas_summary in [4,6,7,9,10,11,12];
	 
	 
	 /* Scores */

     lname100 := if(le.name_verification.lname_score = 100, 1, 0);
     add1_address100 := if(le.address_verification.input_address_information.address_score = 100, 1, 0);
     phone100 := if(le.phone_verification.phone_score = 100, 1, 0);
     ssn100 := if(le.ssn_verification.ssn_score = 100, 1, 0);
     dob100 := if(le.name_verification.dob_score >= 90 and le.name_verification.dob_score <= 100, 1, 0);


	 add1IsBest := le.address_verification.input_address_information.isBestMatch;
	 
	 
	 ver_p_level := map(verphn_p and verlst_p and verfst_p => 3,
        				verphn_p and verlst_p => 2,
        				contrary_phone => 0,
        				verphn_p and ~verlst_p and ~verfst_p => 0,
        				1);

        ver_s_level := map(verssn_s and verlst_s and veradd_s => 2,
        				   verssn_s and verlst_s => 1,
        				   0);
        				   
        				   
        verx := if(add1IsBest,
        	     				map(verphn_p and verlst_p and veradd_p and verfst_p => 4,
        							verphn_p and verlst_p and veradd_p => 3,
        							verphn_p and verlst_p => 2,
        							contrary_phone => -1,
        							verphn_p and veradd_p => 0,
        							1),
        						map(ver_p_level <= 1 and ver_s_level <= 0 => 0,
        							ver_p_level <= 0 and ver_s_level <= 1 => 0,
        							ver_p_level <= 1 and ver_s_level <= 1 => 1,
        							ver_p_level <= 3 and ver_s_level <= 0 => 2,
        							ver_p_level <= 3 and ver_s_level <= 1 => 3,
        							ver_p_level <= 0 and ver_s_level <= 2 => 3,
        							ver_p_level <= 2 and ver_s_level <= 2 => 4,
        							5));



        verx_m := if(add1IsBest,
              					map(verx = -1 => 0.1474164,
        							verx =  0 => 0.1383596,
        							verx =  1 => 0.0961079,
        							verx =  2 => 0.0778689,
        							verx =  3 => 0.0717684,
        							0.0501101),
        						map(verx = 0 => 0.2958487,
        							verx = 1 => 0.2118143,
        							verx = 2 => 0.1800487,
        							verx = 3 => 0.1588381,
        							verx = 4 => 0.1138162,
        							0.0783217));
        


        /* Source Counters */

        source_count2 := if(add1IsBest,
        				 				map(le.name_verification.source_count <= 1 => 1,
        									le.name_verification.source_count >= 4 => 4,
											le.name_verification.source_count),
										if(le.name_verification.source_count >= 4, 4, le.name_verification.source_count));


        add1_source_count2 := if(add1IsBest,
        						 			map(le.address_verification.input_address_information.source_count <= 2 => 2,
        										le.address_verification.input_address_information.source_count >= 5 => 5,
												le.address_verification.input_address_information.source_count),
											map(le.address_verification.input_address_information.source_count <= 1 => 1,
        										le.address_verification.input_address_information.source_count >= 3 => 3,
												le.address_verification.input_address_information.source_count));



        source_count_x := if(add1IsBest,
              							map(source_count2 <= 1  and add1_source_count2 <= 2 => 0,
        									source_count2 <= 2  and add1_source_count2 <= 2 => 1,
        									source_count2 <= 3  and add1_source_count2 <= 2 => 2,
        									source_count2 <= 2  and add1_source_count2 <= 3 => 2,
        									source_count2 <= 4  and add1_source_count2 <= 4 => 3,
        									source_count2 <= 3  and add1_source_count2 <= 5 => 3,
                            				4),
                            			map(add1_source_count2 <= 1 and source_count2 <= 1 => 0,
        									add1_source_count2 <= 1 and source_count2 <= 2 => 1,
        									add1_source_count2 <= 1 and source_count2 <= 3 => 2,
        									add1_source_count2 <= 1                        => 3,
        									add1_source_count2 <= 2 and source_count2 <= 2 => 2,
        									add1_source_count2 <= 2                        => 3,
        									add1_source_count2 <= 3 and source_count2 <= 3 => 4,
        									5));



		source_count_x_m := if(add1IsBest,
					      					map(source_count_x = 0 => 0.1376669,
        										source_count_x = 1 => 0.1007005,
        										source_count_x = 2 => 0.0590627,
        										source_count_x = 3 => 0.0494859,
        										0.0239808),
        									map(source_count_x = 0 => 0.2656546,
        										source_count_x = 1 => 0.1737912,
        										source_count_x = 2 => 0.1456853,
        										source_count_x = 3 => 0.0915916,
        										source_count_x = 4 => 0.0740203,
        										0.0547945));



        /* Sourced */

        eda_sourced_level := map(le.name_verification.lname_eda_sourced and le.name_verification.fname_eda_sourced => 2,
        						 le.name_verification.lname_eda_sourced => 1,
        						 0);

		voter_sourced_level := map(le.available_sources.voter and le.name_verification.lname_voter_sourced and le.name_verification.fname_voter_sourced and 
																						le.address_verification.input_address_information.voter_sourced => 2,
        						   (le.available_sources.voter and ((integer)le.name_verification.lname_voter_sourced + (integer)le.name_verification.fname_voter_sourced + 
																						(integer)le.address_verification.input_address_information.voter_sourced) = 0) => 0,
        						   1);


        sourced_level := map(eda_sourced_level <= 0 and voter_sourced_level <= 0 => 0,
        					 eda_sourced_level <= 0 and voter_sourced_level <= 1 => 1,
        					 eda_sourced_level <= 1 and voter_sourced_level <= 1 => 2,
        					 eda_sourced_level <= 2 and voter_sourced_level <= 1 => 3,
        					 eda_sourced_level <= 1 and voter_sourced_level <= 2 => 3,
        					 4);



        sourced_level_m := map(sourced_level = 0 => 0.1539912,
        					   sourced_level = 1 => 0.0984363,
        					   sourced_level = 2 => 0.0870991,
        					   sourced_level = 3 => 0.0648978,
        					   0.0346487);




        ver_score_mod_best1 := if(le.input_validation.dateofbirth,
        										-0.870058089
                        						+ lname100  * -0.441982742
                        						+ add1_address100  * -0.308588879
                        						+ dob100  * -0.414541193
                        						+ phone100  * -0.237202577
                        						+ ssn100  * -0.524997828,
                        					-0.93584784
                        					+ lname100  * -0.500046551
                        					+ add1_address100  * -0.304346371
                        					+ phone100  * -0.232618297
                        					+ ssn100  * -0.574962188);

           ver_score_mod_best := 100 * (exp(ver_score_mod_best1)) / (1+exp(ver_score_mod_best1));



           vermod_best1 := if(le.input_validation.dateofbirth,
           									-4.862182761
                        					+ verx_m  * 7.5795498842
                        					+ source_count_x_m  * 10.580865628
                        					+ sourced_level_m  * 2.9519260226
                        					+ ver_score_mod_best  * 0.0624875614,
                        				-4.813817816
                        				+ verx_m  * 7.3533569861
                        				+ source_count_x_m  * 10.902895804
                        				+ sourced_level_m  * 3.4982749846
                        				+ ver_score_mod_best  * 0.0509317976);



           vermod_best := 100 * (exp(vermod_best1)) / (1+exp(vermod_best1));
           
           
                      
                      vermod_notbest1 := if(le.input_validation.dateofbirth,
                      			 						-3.042798507
                        								+ verx_m  * 4.3632650977
                        								+ source_count_x_m  * 4.2914815546
                        								+ dob100  * -0.361864918,
                        							-3.328244817
                        							+ verx_m  * 4.3104647782
                        							+ source_count_x_m  * 5.0525413335);

           vermod_notbest := 100 * (exp(vermod_notbest1)) / (1+exp(vermod_notbest1));


           vermod := if(le.address_verification.input_address_information.isBestMatch, vermod_best, vermod_notbest);



	/* PROPERTY        */

	property_owned_total_x := le.address_verification.owned.property_total > 0;
    property_sold_total_x := le.address_verification.sold.property_total > 0;
	property_ambig_total_x := le.address_verification.ambiguous.property_total > 0;

    property_total_x := property_owned_total_x or property_sold_total_x or property_ambig_total_x;



	Prop_occupant_Owner := ((integer)le.address_verification.input_address_information.occupant_owned + (integer)le.address_verification.address_history_1.occupant_owned + 
							(integer)le.address_verification.address_history_2.occupant_owned) > 0;
    

	NaProp4_any := le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or 
				   le.address_verification.address_history_2.naprop = 4;

    NaProp3_any := le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or 
				   le.address_verification.address_history_2.naprop = 3;
    
	

     prop_level := map(le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 4 => 5,
					   le.address_verification.input_address_information.naprop = 4 => 4,
					   NaProp4_any => 3,
					   property_total_x => 3,
					   NaProp3_any => 2,
					   Prop_occupant_Owner => 1,
					   0);



     prop_level_m := map(prop_level = 0 => 0.1687474,
						 prop_level = 1 => 0.1541667,
						 prop_level = 2 => 0.1317140,
						 prop_level = 3 => 0.0951265,
						 prop_level = 4 => 0.0404348,
						 0.0315615);





/* LRES */


	add1_year_first_seen := (integer)(((STRING)le.address_verification.input_address_information.date_first_seen)[1..4]);
	sysyear := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
     
	lres_yearsa := sysyear - add1_year_first_seen;
	lres_yearsb := if(lres_yearsa > 1000, -1, if(lres_yearsa > 30, 30, lres_yearsa));




     lres_years := map(~add1IsBest => -1,
					   lres_yearsb > 8 => 8,
					   lres_yearsb);




/* DEROG           */



     bankrupt_n := (integer)le.bjl.bankrupt;

	criminal_flag := le.bjl.criminal_count > 0;
    liens_recent_unrel_flag := le.bjl.liens_recent_unreleased_count > 0;


     crimlien := if(criminal_flag or liens_recent_unrel_flag, 1, 0);



/* FP              */



        aptflag := if(trim(le.address_validation.dwelling_type) = 'A' and le.input_validation.address, 1, 0);
        addinval := if(~le.address_validation.usps_deliverable and le.input_validation.address, 1, 0);

        ec1 := le.address_validation.error_codes[1];
        ec3 := le.address_validation.error_codes[3];
        ec4 := le.address_validation.error_codes[4];


	addr_changed := ec1 = 'S' and ec3 <> '0';
	unit_changed := ec1 = 'S' and ec4 <> '0';


        E412 := le.address_validation.error_codes[1..4] = 'E412' and le.input_validation.address;

        casserror3 := map(~le.input_validation.address => 0,
						  ec1 = 'S' and addr_changed and unit_changed => 5,
						  ec1 = 'S' and unit_changed => 4,
						  ec1 = 'S' and addr_changed => 1,
						  ec1 = 'S' => 0,
						  ec1 = 'E' and E412 => 2,
						  3);



     casserror3_m := map(casserror3 =  0 => 0.1159410,
     					 casserror3 =  1 => 0.1244615,
     					 casserror3 =  2 => 0.1339286,
     					 casserror3 =  3 => 0.1663551,
     					 casserror3 =  4 => 0.1729323,
     					 0.2075472);



	
	phone_zip_mismatch_n := if(le.input_validation.homephone, (integer)le.phone_verification.phone_zip_mismatch, 0);
	pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'] or ~le.input_validation.homephone, 0, 1);
     disconnect_level := map(le.phone_verification.disconnected => 2,
					    trim(le.iid.nap_status) = 'D' => 1,
					    0);


  

	ssninval := ~le.ssn_verification.validation.valid and le.input_validation.ssn;
	ssndead := le.input_validation.ssn and le.ssn_verification.validation.deceased;
        

     /* SSNPrior */
	high_issue_dateyr := (integer)(((STRING)le.ssn_verification.validation.high_issue_date)[1..4]);
	dob_year := (integer)(le.shell_input.dob[1..4]);
	year_diff := high_issue_dateyr - dob_year;

	ssnprior := if(le.input_validation.ssn and high_issue_dateyr > 0 and dob_year > 0,
				if(year_diff >= -100 and year_diff <= 2, true, false), false);

	ssnprob2 := if(ssninval or ssndead or ssnprior, 1, 0);



     adlperssn_count2_m := map(le.ssn_verification.adlperssn_count >= 4 => 0.1539474,
					      le.ssn_verification.adlperssn_count >= 3 => 0.1440994,
					      le.ssn_verification.adlperssn_count >= 2 => 0.1282095,
					      le.ssn_verification.adlperssn_count >= 1 => 0.1117563,
					      0.2664526);




     fpmod1 := -3.27051745
                  + aptflag  * 0.5299630816
                  + addinval  * 0.2702539249
                  + casserror3_m  * 2.7256019898
                  + phone_zip_mismatch_n  * 0.3844246931
                  + disconnect_level  * 0.3135369046
                  + pnotpots  * 0.3823562322
                  + ssnprob2  * 0.7210691977
                  + adlperssn_count2_m  * 5.4165176862;

     fpmod2 := (exp(fpmod1)) / (1+exp(fpmod1));
     fpmod3 := round(100000 * fpmod2) / 1000;
     fpmod := if(fpmod3 > 30, 30, fpmod3);



/* AGE             */

	low_issue_year := (integer)(((STRING)le.ssn_verification.validation.low_issue_date)[1..4]);

     age_dob := sysyear - dob_year;
     age_ssn_issue := sysyear - low_issue_year;


     age_dob2 := map(age_dob >= 150 => 32,
				 age_dob <= 18 => 18,
				 age_dob >= 57 => 57,
				 age_dob);


     age_ssn_issue2 := map(age_ssn_issue > 200 => 0,
					  age_ssn_issue > 36 => 36,
					  age_ssn_issue);



/* BUREAU          */
	
	time_on_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_first_seen)[1..4]));

     time_on_header_years2 := map(time_on_header_years > 1000 => -1,
						    time_on_header_years > 17 => 17,
						    time_on_header_years);



/* MODEL */


		time_on_file1 := -1.40377563
						+ time_on_header_years2  * -0.063784998
						+ lres_years  * -0.113646163;

        time_on_file := 100 * (exp(time_on_file1)) / (1+exp(time_on_file1));


        mod7 := if(le.input_validation.dateofbirth, 
        						-3.531003831
                     			+ vermod  * 0.0510832359
                     			+ age_dob2  * -0.005023483
                     			+ bankrupt_n  * 0.4057310002
                     			+ crimlien  * 0.7834589477
                     			+ prop_level_m  * 5.9171967297
                     			+ fpmod  * 0.0212788332
                     			+ disconnect_level  * 0.1222466985
                     			+ pnotpots  * 0.2125138423
                     			+ time_on_header_years2  * -0.025324724
                     			+ lres_years  * -0.017515954,
                     	-4.024217056
                       + vermod  * 0.049634295
                       + age_ssn_issue2  * -0.010539776
                       + bankrupt_n  * 0.3706034607
                       + crimlien  * 0.7620517241
                       + prop_level_m  * 5.7684884309
                       + fpmod  * 0.0281507998
                       + time_on_file  * 0.0267606814);

        phat := (exp(mod7)) / (1+exp(mod7));
    


     base  := 703;
     odds  := 0.047619048;
     point := -40;



     RiskViewbase := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);


	RiskView6 := map(RiskViewbase < 501 => 501,
    				   RiskViewbase > 900 => 900,
    				   RiskViewbase);



     RiskView612 := if(RiskView6 > 680 and (ssndead or ssnprior or le.bjl.criminal_count > 0 or le.address_validation.corrections), 680, RiskView6);

     RVT612 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, RiskView612);


	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
						    (integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
						    (integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
						    
	self.ri := map(
				riTemp[1].hri <> '00' => riTemp,
				RVT612 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
				RiskWise.rvReasonCodes(le, 4, inCalif));
	self.score := if(riTemp[1].hri in ['91','92','93','94','95'], (string)((integer)riTemp[1].hri + 10), if(self.ri[1].hri='35', '000', intformat(RVT612,3,1)));
	self.seq := le.seq;
END;
final := project(clam, doModel(left));

RETURN (final);

END;
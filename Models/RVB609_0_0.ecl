import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVB609_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := 

FUNCTION
	  
		
Layout_ModelOut doModel(clam le) := TRANSFORM

	verfst_s := (integer)(le.iid.nas_summary in [2,3,4,8,9,10,12]);
	contrary_phone := (integer)(le.iid.nap_summary = 1);
	stolen_id_ap := (integer)(le.iid.nap_summary = 6);


     source_count2 := map(le.name_verification.source_count > 4 => 4,
					 le.name_verification.source_count < 1 => 1,
					 le.name_verification.source_count);


     add1_source_count2 := map(le.address_verification.input_address_information.source_count > 6 => 6,
						 le.address_verification.input_address_information.source_count < 1 => 1,
						 le.address_verification.input_address_information.source_count);

     source_count_sum2 := source_count2 + add1_source_count2;
     source_count_sum := min(source_count_sum2, 7);
	
	
	add1IsBestMatch := le.address_verification.input_address_information.isbestmatch;

     eda_sourced_level := if(add1IsBestMatch, 
							map(le.name_verification.lname_eda_sourced and le.name_verification.fname_eda_sourced => 12,
							    le.name_verification.lname_eda_sourced => 11,
							    10),
					    map(le.name_verification.lname_eda_sourced and le.name_verification.fname_eda_sourced and 
										le.address_verification.input_address_information.eda_sourced => 5,
						   le.name_verification.lname_eda_sourced and le.address_verification.input_address_information.eda_sourced => 4,
						   le.name_verification.lname_eda_sourced and le.name_verification.fname_eda_sourced => 3,
						   le.name_verification.lname_eda_sourced => 2,
						   le.name_verification.fname_eda_sourced or le.address_verification.input_address_information.eda_sourced => 1,
						   0));

    
     eda_sourced_level_m := map(eda_sourced_level =  0 => 0.0559207,
						  eda_sourced_level =  1 => 0.0402225,
						  eda_sourced_level =  2 => 0.0376506,
						  eda_sourced_level =  3 => 0.0341629,
						  eda_sourced_level =  4 => 0.0270453,
						  eda_sourced_level =  5 => 0.0194903,
						  eda_sourced_level = 10 => 0.0250268,
						  eda_sourced_level = 11 => 0.0173961,
						  0.0123938);


     source_count2_m := if(add1IsBestMatch,
						   map(source_count2 = 1 => 0.026753171,
							  source_count2 = 2 => 0.0158011669,
							  source_count2 = 3 => 0.0118146016,
							  0.0104448382),
					  map(source_count2 = 1 => 0.0498369429,
					      source_count2 = 2 => 0.0352613672,
					      source_count2 = 3 => 0.0297385062,
					      0.0215895611));		  



	source_count_sum_m := if(add1IsBestMatch, 
							map(source_count_sum = 2 => 0,
							    source_count_sum = 3 => 0.0272600186,
							    source_count_sum = 4 => 0.0197140198,
							    source_count_sum = 5 => 0.0151398,
							    source_count_sum = 6 => 0.0134554289,
							    0.0102030405),
						0);
						
						
	adl100 := if(le.name_verification.adl_score = 100, 1, 0);

	lname100 := map(le.name_verification.lname_score = 100 => 2,
				 add1IsBestMatch and le.name_verification.lname_score >= 90 and le.name_verification.lname_score <= 99 => 1,
				 0);

     phone100 := map(le.phone_verification.phone_score >= 90 and le.phone_verification.phone_score <= 100 => 2,
				 le.phone_verification.phone_score >= 50 and le.phone_verification.phone_score <= 89 => 1,
				 le.phone_verification.phone_score = 255 => 1,
				 0);

     ssn100 := if(le.ssn_verification.ssn_score = 100, 1, 0);

     dob100 := map(le.name_verification.dob_score >= 90 and le.name_verification.dob_score <= 100 => 2,
			    le.name_verification.dob_score >= 50 and le.name_verification.dob_score <= 80 => 1,
			    0);



	lname100_m := map(lname100 = 0 => 0.0364697301,
				   lname100 = 1 => 0.024,
				   0.0171419509);
				  

	phone100_m := if(add1IsBestMatch,
					map(phone100 = 0 => 0.0467730239,
					    phone100 = 1 => 0.0223746269,
					    0.0141329951),
				  map(phone100 = 0 => 0.0638722555,
					 phone100 = 1 => 0.0450583543,
					 0.0307844507));

	dob100_m := if(add1IsBestMatch,
					map(dob100 = 0 => 0.0361624529,
					    dob100 = 1 => 0.0225431965,
					    0.0144158789),
				map(dob100 = 0 => 0.0569294606,
				    dob100 = 1 => 0.0499219969,
				    0.0321332436));


	// dob populated, is best match
	 vermod_best1g := -6.311975758
                          + contrary_phone  * 0.5375744102
                          + stolen_id_ap  * 0.4439033126
                          + eda_sourced_level_m  * 22.735076882
                          + source_count_sum_m  * 36.230891969
                          + adl100  * -0.32882413
                          + lname100_m  * 15.489855212
                          + phone100_m  * 38.040648313
                          + dob100_m  * 27.297045537;

	vermod_best1g2 := (exp(vermod_best1g)) / (1+exp(vermod_best1g));
	vermod_best1g3 := round(100000000 * vermod_best1g2) / 1000000;

	// dob not populated, is best match
	vermod_best1h := -5.72713777
				 + contrary_phone  * 0.5468604092
				 + stolen_id_ap  * 0.476767063
				 + eda_sourced_level_m  * 24.952320801
				 + source_count_sum_m  * 47.968484484
				 + adl100  * -0.2953606
				 + ssn100  * -0.402416456
				 + lname100_m  * 15.658048093
				 + phone100_m  * 39.327386728;
				 
	vermod_best1h2 := (exp(vermod_best1h)) / (1+exp(vermod_best1h));
	vermod_best1h3 := round(100000000 * vermod_best1h2) / 1000000;


	vermod1 := if(le.input_validation.dateofbirth, vermod_best1g3, vermod_best1h3);



	// dob populated, is not best match
	vermod_best2g := -6.643691351
				 + contrary_phone  * 0.7264029264
				 + verfst_s  * 0.4839372552
				 + stolen_id_ap  * 0.3468934217
				 + eda_sourced_level_m  * 14.329268052
				 + source_count2_m  * 17.121584083
				 + phone100_m  * 25.575053545
				 + dob100_m  * 16.363496927;
				 
	vermod_best2g2 := (exp(vermod_best2g)) / (1+exp(vermod_best2g));
	vermod_best2g3 := round(100000000 * vermod_best2g2) / 1000000;


	// dob not populated, is not best match
	vermod_best2h := -5.193244125
				 + contrary_phone  * 0.3816393623
				 + verfst_s  * 0.4631990666
				 + eda_sourced_level_m  * 23.032110119
				 + source_count2_m  * 22.599177562
				 + adl100  * -0.325875241;
				 
	vermod_best2h2 := (exp(vermod_best2h)) / (1+exp(vermod_best2h));
	vermod_best2h3 := round(100000000 * vermod_best2h2) / 1000000;
		   
	vermod2 := if(le.input_validation.dateofbirth, vermod_best2g3, vermod_best2h3);
	
	
	
	vermod := if(add1IsBestMatch, vermod1, vermod2);


	/* Property */
	
	property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1, 0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1, 0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1, 0);

     property_total_x := property_owned_total_x = 1 or property_sold_total_x = 1 or property_ambig_total_x = 1;


	Prop_Owner := map(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4 => 2,
				   (property_owned_total_x + property_sold_total_x + property_ambig_total_x) > 0 => 1,
				   0);
      

     Prop_occupant_Owner := ((integer)le.address_verification.input_address_information.occupant_owned + (integer)le.address_verification.address_history_1.occupant_owned + 
							(integer)le.address_verification.address_history_2.occupant_owned) > 0;


     Prop_tree := map(Prop_Owner = 2 and le.address_verification.input_address_information.naprop = 4 => 3,
				  Prop_Owner = 2 and Prop_occupant_Owner => 2,
				  Prop_Owner = 2 => 2,
				  Prop_Owner = 1 => 2,
				  Prop_Owner = 0 and Prop_occupant_Owner => 1,
				  Prop_Owner = 0 and le.address_verification.input_address_information.naprop >= 4 => 1,
				  0);

     Prop_tree_m := map(Prop_tree = 0 => 0.0329127,
				    Prop_tree = 1 => 0.0268725,
				    Prop_tree = 2 => 0.0226849,
				    0.0101392);

    

     add1_year_first_seen := (integer)(((STRING)le.address_verification.input_address_information.date_first_seen)[1..4]);
     sysyear := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
     
     lres_yearsa := sysyear - add1_year_first_seen;
     lres_years := if(lres_yearsa > 1000, -1, if(lres_yearsa > 30, 30, lres_yearsa));


	/* AVG Lres */

     firstseendate1 := if(add1_year_first_seen = 0, 10000, add1_year_first_seen);
     lres_yearsb := abs(sysyear - firstseendate1);
     lres_years1 := if(lres_yearsb > 1000, -1, if(lres_yearsb > 100, 100, lres_yearsb));
     yfseen_pop1 := if(lres_yearsb > 1000 or lres_yearsb = -1, 0, 1);


     secondseendate := (integer)(((STRING)le.address_verification.address_history_1.date_first_seen)[1..4]);
     secondseendate2 := if(secondseendate = 0, 10000, secondseendate);
     lres_yearsc := abs(add1_year_first_seen - secondseendate2);
     lres_years2 := if(lres_yearsc > 1000, -1, if(lres_yearsc > 100, 100, lres_yearsc));
     yfseen_pop2 := if(lres_yearsc > 1000 or lres_yearsc = -1, 0, 1);


     thirdseendate := (integer)(((STRING)le.address_verification.address_history_2.date_first_seen)[1..4]);
     thirdseendate3 := if(thirdseendate = 0, 10000, thirdseendate);
     lres_yearsd := abs(secondseendate - thirdseendate3);
     lres_years3 := if(lres_yearsd > 1000, -1, if(lres_yearsd > 100, 100, lres_yearsd));
     yfseen_pop3 := if(lres_yearsd > 1000 or lres_yearsd = -1, 0, 1);
     

	a := lres_years1 <> -1;
	b := lres_years2 <> -1;
	c := lres_years3 <> -1;
	total := (integer)a + (integer)b + (integer)c;
     avglres := (if(a, lres_years1, 0) + if(b, lres_years2, 0) + if(c, lres_years3, 0)) / total;

     lres_avg := map(lres_years1 = -1 and lres_years2 = -1 and lres_years3 = -1 => -1,
				 avglres > 12 => 12,
				 avglres);


     yfseen_tree := map((yfseen_pop1 + yfseen_pop2 + yfseen_pop3) = 3 => 4,
				    yfseen_pop1 = 1 and (yfseen_pop2 + yfseen_pop3) = 0 => 4,
				    yfseen_pop1 = 1 and yfseen_pop2 = 1 => 3,
				    yfseen_pop1 = 1 and yfseen_pop3 = 1 => 2,
				    yfseen_pop1 = 1 => 2,
				    (yfseen_pop1 + yfseen_pop2 + yfseen_pop3) = 0 => 0,
				    1);

     lres_mod1 := -2.611547975
                  + lres_years  * -0.028981724
                  + lres_avg  * -0.076266436
                  + yfseen_tree  * -0.225844915;
			   
     lres_mod2 := (exp(lres_mod1)) / (1+exp(lres_mod1));
     lres_mod := round(1000000 * lres_mod2) / 10000;
	
	
	/* Fraud Point */

	aptflag := trim(le.address_validation.dwelling_type) = 'A';

	addr_changed := le.address_validation.error_codes[1] = 'S' and le.address_validation.error_codes[3] <> '0';
	unit_changed := le.address_validation.error_codes[1] = 'S' and le.address_validation.error_codes[4] <> '0';

	casserror2 := map(le.address_validation.error_codes[1..4] = 'E412' => 2,
				   le.address_validation.error_codes[1] = 'E' => 3,
				   le.address_validation.error_codes[1] = 'S' and addr_changed and unit_changed => 4,
				   le.address_validation.error_codes[1] = 'S' and unit_changed => 3,
				   le.address_validation.error_codes[1] = 'S' and addr_changed => 1,
				   0);

	addprob2 := if(casserror2 <= 3 and aptflag, 3, casserror2);

	addprob2_m1 := map(addprob2 = 0 => 0.0171902,
				    addprob2 = 1 => 0.0223955,
				    addprob2 = 2 => 0.0269021,
				    addprob2 = 3 => 0.0365517,
				    0.0419542);


	
     addprob2_m := if(le.input_validation.address, addprob2_m1, 0.0419542);


	phone_zip_mismatch_n := if(le.input_validation.homephone, (integer)le.phone_verification.phone_zip_mismatch, 0);
	pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'] or ~le.input_validation.homephone, 0, 1);
	not_connected := if((trim(le.iid.nap_status) = 'C' and ~le.phone_verification.disconnected) and le.input_validation.homephone, 0, 1);
	  



	ssninval := ~le.ssn_verification.validation.valid and le.input_validation.ssn;
	ssndead := le.input_validation.ssn and le.ssn_verification.validation.deceased;

	high_issue_dateyr := (integer)(((STRING)le.ssn_verification.validation.high_issue_date)[1..4]);
	dob_year := (integer)(le.shell_input.dob[1..4]);
	year_diff := high_issue_dateyr - dob_year;

	ssnprior := if(le.input_validation.ssn and high_issue_dateyr > 0 and dob_year > 0,
				if(year_diff >= -100 and year_diff <= 2, true, false), false);

	ssnprob := if(ssninval or ssndead or ssnprior, 1, 0);



     fp_mod41 := -4.760050843
                  + addprob2_m  * 29.756463199
                  + phone_zip_mismatch_n  * 0.7797220272
                  + pnotpots  * 0.5923515638
                  + not_connected  * 0.2950875331
                  + ssnprob  * 0.624893247;
			   
     fp_mod42 := (exp(fp_mod41)) / (1+exp(fp_mod41));
     fp_mod4 := round(100000000 * fp_mod42) / 1000000;
	
	
	/* Distance */

     dist2 := map(le.phone_verification.distance = 9999 => 1,
			   le.phone_verification.distance > 50 => 50,
			   le.phone_verification.distance);


	/* Derogs */

     criminal_flag := if(le.bjl.criminal_count > 2, 2, 0);
     liens_recent_unrel_flag := if(le.bjl.liens_recent_unreleased_count > 0, 1, 0);

	
	/*  Age   */

     input_age := sysyear - dob_year;
     input_age2 := map(dob_year = 0 => 19,
				   input_age < 19 => 19,
				   input_age > 65 => 65,
				   input_age);
				   
				   

     low_issue_age := sysyear - (integer)(((STRING)le.ssn_verification.validation.low_issue_date)[1..4]);


     low_issue_age2 := map(low_issue_age < 3 => 3,
						   low_issue_age > 150 => 18,
						   low_issue_age > 40 => 40,
						   low_issue_age);

	
	/* Models   */
	
	bankrupt := (integer)le.bjl.bankrupt;

     mod71 := -4.549198402
                  + fp_mod4  * 0.0830598177
                  + vermod  * 0.1614320567
                  + dist2  * 0.0114102597
                  + criminal_flag  * 0.5213310537
                  + bankrupt  * 0.4098058721
                  + liens_recent_unrel_flag  * 1.2014880969
                  + input_age2  * -0.019183756
                  + Prop_tree_m  * 28.171679623
                  + lres_mod  * 0.0615210631;

     mod7 := (exp(mod71)) / (1+exp(mod71));

	 
	 // new code
	 mod7_inf_age21 := -4.93478703
						+ fp_mod4  * 0.106349908
						+ vermod  * 0.154638012
						+ dist2  * 0.0121309031
						+ criminal_flag  * 0.5289712559
						+ bankrupt  * 0.3971543928
						+ liens_recent_unrel_flag  * 1.1908550286
						+ low_issue_age2  * -0.01787476
						+ Prop_tree_m  * 28.513167603
						+ lres_mod  * 0.0755379428;

     mod7_inf_age2 := (exp(mod7_inf_age21)) / (1+exp(mod7_inf_age21));
	 
	 
	phat := if(le.input_validation.dateofbirth, mod7, mod7_inf_age2);

	
	
     base  := 703;
     odds  := 1/21;
     point := -40;

     RVB609 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	
	// overrides
	
	bankcard1 := if((ssndead or ssnprior or le.bjl.criminal_count > 0 or le.address_validation.corrections) and RVB609 > 785, 785, RVB609);
	
	bankcard := map(bankcard1 > 900 => 900,
				 bankcard1 < 501 => 501,
				 bankcard1);
				 
	bankcard2 := if( riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, bankcard);
	
	
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
						    (integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
						    (integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
						    
	self.ri := map(
				riTemp[1].hri <> '00' => riTemp,
				bankcard2 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')},{'00',''},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc), 
				RiskWise.rvReasonCodes(le, 4, inCalif));
	self.score := if(riTemp[1].hri in ['91','92','93','94','95'], (string)((integer)riTemp[1].hri + 10), if(self.ri[1].hri='35', '000', intformat(bankcard2,3,1)));
	self.seq := le.seq;
	
END;
final := project(clam, doModel(left));

RETURN (final);

END;
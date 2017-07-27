import ut, Risk_Indicators, riskwise;

export RSN509_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(riskwise.Layout_IT1O_model_in) rsn_prep) := FUNCTION

models.Layout_ModelOut doModel(clam le, rsn_prep rt) := TRANSFORM 

     /*string addr_type_a, string addr_confidence_a, string ph_phone_type_a_1, 
			   string dcd_match_code_1, string chargeoff_amount
			   */
			   
	sysyear := IF(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	
	address_confirmed := if(trim(StringLib.StringToUpperCase(rt.addr_type_a)) = 'C', true,false);
	address_updated := if(trim(StringLib.StringToUpperCase(rt.addr_type_a)) = 'U', true,false);
	address_verified := if(trim(StringLib.StringToUpperCase(rt.addr_confidence_a)) = 'A', true,false);
	
	EDA_Match_Level := map(trim(StringLib.StringToUpperCase(rt.phone_type_a)) = 'A' => 2,
					   trim(StringLib.StringToUpperCase(rt.phone_type_a)) = 'C' => 1,
					   0);
	
	
	deceased_sc := if(rt.decsflag = '1', 1,0);
	
	
	
	/* Modeling Shell */
	
	
	/* NAP and NAS */		
								 
	property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1,0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1,0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1,0);
	
	Prop_Owner := map(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4 => 2,
				   (property_owned_total_x + property_sold_total_x + property_ambig_total_x) > 0 => 1,
				   0);
	
	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    
	property_owned_total_med := if (le.address_verification.owned.property_total >= 2, 2, le.address_verification.owned.property_total);
	
	
	Prop_Owner_med := map(Prop_Owner = 0 and NaProp_Tree = 0 => 0,
					  Prop_Owner = 0 and NaProp_Tree > 0 => 1,
					  Prop_Owner = 1 => 2,
					  3);	// added this myself so it syntax checks
	
	prop_med := map(Prop_Owner_med = 0 => 0,
				 Prop_Owner_med = 1 => 1,
				 Prop_Owner_med = 2 and property_owned_total_med <= 1 => 2,
				 Prop_Owner_med = 2 and property_owned_total_med = 2 => 5,
				 Prop_Owner_med = 3 and property_owned_total_med <= 0 => 3,
				 Prop_Owner_med = 3 and property_owned_total_med <= 1 => 4,
				 5);	// added this myself so it syntax checks
				 
	add1_year_first_seen1 := le.address_verification.input_address_information.date_first_seen;
	add1_year_first_seen := (integer)(add1_year_first_seen1[1..4]);
	
	lres2 := map(add1_year_first_seen = 0 => 0,
			   (sysyear - add1_year_first_seen) >= 16 => 3,
			   (sysyear - add1_year_first_seen) >= 11 => 2,
			   (sysyear - add1_year_first_seen) >= 6  => 1,
			   0);
			   
	lien_unrel_count := map(le.bjl.liens_historical_unreleased_count = 0 => 0,
					    le.bjl.liens_historical_unreleased_count = 1 => 1,
					    2);
	criminal_flag := if(le.bjl.criminal_count > 0, 1,0);
	crimlien := if(criminal_flag = 1 or lien_unrel_count = 2, 2,lien_unrel_count);
				
	
	
	/* Relatives */
							    
	rel_income := map(le.relatives.relative_incomeover100_count > 0 => 101,
				   le.relatives.relative_incomeunder100_count > 0 => 100,
				   le.relatives.relative_incomeunder75_count > 0 => 75,
				   le.relatives.relative_incomeunder50_count > 0 => 50,
				   le.relatives.relative_incomeunder25_count > 0 => 25,
				   0);
				   
	rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);
	rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);
	
	rel_criminal_flag_med_m := if(rel_criminal_flag = 0, 0.1288260364, 0.0838299563);
	
	
	
	/* Sources    */
	
	eda_counter := map(((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + (integer)le.address_verification.input_address_information.eda_sourced) = 3 => 2,
				    ((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + (integer)le.address_verification.input_address_information.eda_sourced) = 2 => 1,
				    0);
	
	
	voter_counter_med := if(le.available_sources.voter and ((integer)le.address_verification.input_address_information.voter_sourced + (integer)le.name_verification.fname_voter_sourced + 
												   (integer)le.name_verification.lname_voter_sourced) = 0, 0, 1);
	
	

					   
	// Telco Portion 
	
	chargeoff_amount_tel_code := map((integer)rt.in_chargeoffamt <= 100 => 0,
							   (integer)rt.in_chargeoffamt <= 300 => 1,
							   (integer)rt.in_chargeoffamt <= 600 => 2,
							   3);
	
	address_ver_sc_tel := map(address_confirmed and address_verified => 3,
						 address_updated and address_verified => 3,
						 address_confirmed => 2,
						 address_updated => 1,
						 0);
	
	dl_counter_tel := map(le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											   (integer)le.address_verification.input_address_information.dl_sourced) = 3 => 3,
					  le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											   (integer)le.address_verification.input_address_information.dl_sourced) = 0 => 1,
					  le.available_sources.dl => 2,
					  ~le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											    (integer)le.address_verification.input_address_information.dl_sourced) > 0 => 2,
					  0);
	
	 eda_counter2_tel := map(EDA_Match_Level = 0 and eda_counter = 0 => 0,
						EDA_Match_Level = 0 => 0,
						EDA_Match_Level = 1 and eda_counter = 0 => 0,
						EDA_Match_Level = 1 and eda_counter = 1 => 1,
						EDA_Match_Level = 1 and eda_counter = 2 => 1,
						EDA_Match_Level = 2 and eda_counter = 0 => 1,
						EDA_Match_Level = 2 and eda_counter = 1 => 2,
						3);	// set as default
	
	agecode_tel := map(le.name_verification.age <= 24 => 0,
				    le.name_verification.age <= 38 => 1,
				    le.name_verification.age <= 48 => 2,
				    le.name_verification.age <= 56 => 3,
				    4);
	
	add1_census_income_tel_code := map(le.address_verification.input_address_information.census_income = '' => 0.75,
								(integer)le.address_verification.input_address_information.census_income <= 30000 => 0,
								(integer)le.address_verification.input_address_information.census_income <= 40000 => 1,
								(integer)le.address_verification.input_address_information.census_income <= 50000 and 
											(integer)le.address_verification.input_address_information.census_home_value <= 96000 => 1,
								(integer)le.address_verification.input_address_information.census_income <= 50000 => 2,
								(integer)le.address_verification.input_address_information.census_income <= 70000 => 2,
								3);
								
								
	// Telco Means 
	
	dl_counter_tel_tel_m := map(dl_counter_tel = 0 => 0.1997377622,
						   dl_counter_tel = 1 => 0.2302325581,
						   dl_counter_tel = 2 => 0.27,
						   0.2873443983);	// set as default
	
	voter_counter_med_tel_m := if(voter_counter_med = 0, 0.2487100103, 0.2228773585);
	
	eda_counter2_tel_tel_m := map(eda_counter2_tel = 0 => 0.1654914973,
							eda_counter2_tel = 1 => 0.210619469,
							eda_counter2_tel = 2 => 0.303070761,
							0.4015852048);	// set as default
	
	address_ver_sc_tel_tel_m := map(address_ver_sc_tel = 0 => 0.1578947368,
							  address_ver_sc_tel = 1 => 0.1649428416,
							  address_ver_sc_tel = 2 => 0.2522123894,
							  0.3545554336);	// set as default
	
	crimlien_tel_m := map(crimlien = 0 => 0.2445853143,
					  crimlien = 1 => 0.1642335766,
					  0.1848341232);	// set as default
	
	chargeoff_amount_tel_code_tel_m := map(chargeoff_amount_tel_code = 0 => 0.344873502,
								    chargeoff_amount_tel_code = 1 => 0.2470254958,
								    chargeoff_amount_tel_code = 2 => 0.2050040355,
								    0.1375515818);	// set as default
	
	Prop_med_tel_m := map(Prop_med = 0 => 0.1870064609,
					  Prop_med = 1 => 0.2440273038,
					  Prop_med = 2 => 0.310880829,
					  Prop_med = 3 => 0.3469785575,
					  Prop_med = 4 => 0.3536977492,
					  0.3978494624);	// set as default
	
	agecode_tel_tel_m := map(agecode_tel = 0 => 0.1744097487,
						agecode_tel = 1 => 0.2120765832,
						agecode_tel = 2 => 0.2446448703,
						agecode_tel = 3 => 0.311546841,
						0.3698924731);	// set as default
	
	add1_census_inc_tel_code_tel_m := map(add1_census_income_tel_code = 0 => 0.1799256506,
								   add1_census_income_tel_code = 0.75 => 0.2173913043,
								   add1_census_income_tel_code = 1 => 0.2348525469,
								   add1_census_income_tel_code = 2 => 0.2877906977,
								   0.3333333333);	// set as default
								   
								   
	// Telco Score 
	
	lres2_tel_m := map(lres2 = 0 => 0.2109553309,
				    lres2 = 1 => 0.2223756906,
				    lres2 = 2 => 0.3137254902,
				    0.3992932862);	// set as default
	
	rel_income_tel_m := map(rel_income = 0 => 0.1558185404,
					    rel_income = 25 => 0.1921921922,
					    rel_income = 50 => 0.2124616956,
					    rel_income = 75 => 0.283476899,
					    rel_income = 100 => 0.3016949153,
					    0.3482142857);	// set as default
	
	telmod4 := -13.48696212
			   + rel_criminal_flag_med_m  * 4.7297319811
			   + rel_bk_flag  * -0.217022123
			   + deceased_sc  * -1.305167815
			   + dl_counter_tel_tel_m  * 4.8260666658
			   + voter_counter_med_tel_m  * 13.51812306
			   + eda_counter2_tel_tel_m  * 2.8791217856
			   + address_ver_sc_tel_tel_m  * 2.4625866919
			   + crimlien_tel_m  * 7.1664196279
			   + chargeoff_amount_tel_code_tel_m  * 5.9341393033
			   + Prop_med_tel_m  * 1.7755860963
			   + agecode_tel_tel_m  * 3.4181124089
			   + add1_census_inc_tel_code_tel_m  * 3.280056821
			   + lres2_tel_m  * 2.0080092154
			   + rel_income_tel_m  * 2.654692642;
		
	telmod42 := (exp(telmod4)) / (1+exp(telmod4));
	phat8 := telmod42;
	
	
	// new code for this model
	phat_tel := 1000*phat8;
     Recover_Migration := 0.0006 * phat_tel * phat_tel + 0.8008 * phat_tel + 30.362; 

     Recover_Migration_Tel := map(Recover_Migration < 0 => 0,
						    Recover_Migration > 999 => 999,
						    (integer)Recover_Migration);
	/////////////////////
								   
					

	self.score := (string)Recover_Migration_Tel;
	self.seq := le.seq;
	self.ri := [];
END;
scores := join(clam, rsn_prep, left.seq=right.seq, doModel(LEFT, right));

RETURN (scores);

END;
import ut, risk_indicators, EASI;

export MSN610_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date) := 

FUNCTION


layout_bseasi := RECORD 
	Risk_Indicators.Layout_Boca_Shell  bs;
	Easi.layout_census  ea;
END;

layout_bseasi join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
	self.bs := le;
	self.ea := ri;
	self := [];
END; 				 
results := join(clam, Easi.Key_Easi_Census,
			 keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
			 join2recs(left, right),
			 left outer, atmost(10000), keep(1));
  

Layout_ModelOut doModel(results le) := TRANSFORM
	
	/* Verification */

     source_count2 := map(le.bs.name_verification.source_count > 6 => 5,
					 le.bs.name_verification.source_count > 4 => 4,
					 le.bs.name_verification.source_count < 1 => 1,
					 le.bs.name_verification.source_count);


     add1_source_count2 := map(le.bs.address_verification.input_address_information.source_count > 5 => 5,
						 le.bs.address_verification.input_address_information.source_count < 1 => 1,
						 le.bs.address_verification.input_address_information.source_count);


     source_count_combo := map(add1_source_count2 <= 1 =>
											   map(source_count2 <= 1 => 0,
												  source_count2 <= 2 => 1,
												  source_count2 <= 4 => 2,
												  3),
						 add1_source_count2 <= 2 =>
											   map(source_count2 <= 1 => 1,
											       source_count2 <= 2 => 2,
											       source_count2 <= 4 => 3,
											       4),
						 add1_source_count2 <= 3 =>
											   if(source_count2 <= 2, 3, 4),
						 add1_source_count2 <= 4 =>
											   if(source_count2 <= 1, 4, 5),
						 map(source_count2 <= 3 => 5,
							source_count2 <= 4 => 6,
							7));


     source_count_combo_m := map(source_count_combo = 0 => 0.0506667,
						   source_count_combo = 1 => 0.0398119,
						   source_count_combo = 2 => 0.0334716,
						   source_count_combo = 3 => 0.0240132,
						   source_count_combo = 4 => 0.0174616,
						   source_count_combo = 5 => 0.0140877,
						   source_count_combo = 6 => 0.0116094,
						   0.0107686);
						   
						   
	// is best match addr1
	eda_sourced_flag_m := map(le.bs.name_verification.fname_eda_sourced and le.bs.name_verification.lname_eda_sourced and le.bs.address_verification.input_address_information.eda_sourced => 0.0121340235,
						 le.bs.name_verification.lname_eda_sourced and le.bs.address_verification.input_address_information.eda_sourced => 0.0178002306,
						 0.0241098901);

	// not is best match addr1
	tu_sourced_flag_m := map(le.bs.name_verification.fname_tu_sourced and le.bs.name_verification.lname_tu_sourced => 0.0285443821,
					     le.bs.name_verification.fname_tu_sourced or le.bs.name_verification.lname_tu_sourced => 0.0367521368,
					     0.0544490277);

     eda_sourced_flag_m2 := map(le.bs.name_verification.fname_eda_sourced and le.bs.name_verification.lname_eda_sourced and le.bs.address_verification.input_address_information.eda_sourced => 0.0179455446,
						  ((integer)le.bs.name_verification.fname_eda_sourced + (integer)le.bs.name_verification.lname_eda_sourced + 
																 (integer)le.bs.address_verification.input_address_information.eda_sourced) >= 2 => 0.025961405,
						  le.bs.address_verification.input_address_information.eda_sourced => 0.0353603604,
						  0.0461095101);

     voter_sourced_flag_m := map(le.bs.available_sources.voter and le.bs.address_verification.input_address_information.voter_sourced and le.bs.name_verification.lname_voter_sourced and 
																												le.bs.name_verification.fname_voter_sourced => 0.0186464088,
						   le.bs.available_sources.voter and ((integer)le.bs.address_verification.input_address_information.voter_sourced + (integer)le.bs.name_verification.lname_voter_sourced + 
																								(integer)le.bs.name_verification.fname_voter_sourced) = 0 => 0.0407872749,
						   le.bs.available_sources.voter => 0.0307935949,
						   0.0323778765);


	lname100 := if(le.bs.name_verification.lname_score = 100, 1, 0);



	// is best match addr1
	vermod_a := -5.013913763
				 + source_count_combo_m  * 39.018049422
				 + eda_sourced_flag_m  * 43.540102814
				 + lname100  * -0.610970702;
			 
	vermod_a2 := (exp(vermod_a)) / (1+exp(vermod_a));


	// not is best match addr1
	vermod_b := -5.577185201
			   + tu_sourced_flag_m  * 18.342920874
			   + eda_sourced_flag_m2  * 25.116900799
			   + voter_sourced_flag_m  * 19.075616435;
			   
	vermod_b2 := (exp(vermod_b)) / (1+exp(vermod_b));

     
	vermod1 := if(le.bs.address_verification.input_address_information.isbestmatch, round(100000 * vermod_a2), round(100000 * vermod_b2));
	vermod := vermod1 / 1000;



	/* Property                      */

     property_owned_total_x := if(le.bs.address_verification.owned.property_total > 0, 1, 0);
     property_sold_total_x := if(le.bs.address_verification.sold.property_total > 0, 1, 0);
     property_ambig_total_x := if(le.bs.address_verification.ambiguous.property_total > 0, 1, 0);

     property_total_x := property_owned_total_x = 1 or
                         property_sold_total_x = 1 or
                         property_ambig_total_x = 1;



     Prop_Owner := map(le.bs.address_verification.input_address_information.naprop = 4 or le.bs.address_verification.address_history_1.naprop = 4 or 
																			le.bs.address_verification.address_history_2.naprop = 4 => 2,
				   (property_owned_total_x + property_sold_total_x + property_ambig_total_x) > 0 => 1,
				   0);

     Prop_Family_Owner := ((integer)le.bs.address_verification.input_address_information.family_owned + (integer)le.bs.address_verification.address_history_1.family_owned + 
								(integer)le.bs.address_verification.address_history_2.family_owned) > 0;

     Prop_Applicant_Owner := ((integer)le.bs.address_verification.input_address_information.applicant_owned + (integer)le.bs.address_verification.address_history_2.applicant_owned + 
								(integer)le.bs.address_verification.address_history_2.applicant_owned) > 0;

     Prop_occupant_Owner := ((integer)le.bs.address_verification.input_address_information.occupant_owned + (integer)le.bs.address_verification.address_history_1.occupant_owned + 
								(integer)le.bs.address_verification.address_history_2.occupant_owned) > 0;


     prop_tree := map(Prop_Applicant_Owner and Prop_occupant_Owner and Prop_Family_Owner => 5,
				  Prop_Applicant_Owner and Prop_occupant_Owner => 4,
				  Prop_Applicant_Owner and Prop_Family_Owner => 3,
				  Prop_Applicant_Owner => 3,
				  Prop_occupant_Owner and Prop_Family_Owner => 2,
				  Prop_occupant_Owner or  Prop_Family_Owner => 1,
				  0);


     prop_tree2 := map(le.bs.address_verification.input_address_information.naprop = 4 and prop_tree = 5 => 6,
				   le.bs.address_verification.input_address_information.naprop = 4 and Prop_Family_Owner => 5,
				   le.bs.address_verification.input_address_information.naprop = 4                   => 4,
				   prop_tree = 5 => 3,
				   property_total_x => 3,
				   prop_owner > 0 => 3,
				   le.bs.address_verification.input_address_information.naprop = 3 => 2,
				   le.bs.address_verification.input_address_information.naprop = 2 => 1,
				   le.bs.address_verification.input_address_information.naprop in [0,1] and prop_tree = 0 => 0,
				   le.bs.address_verification.input_address_information.naprop in [0,1] and prop_tree = 1 => 1,
				   le.bs.address_verification.input_address_information.naprop = 1 => 1,
				   1);



     prop_tree2_m := map(prop_tree2 = 0 => 0.0396985,
					prop_tree2 = 1 => 0.0355265,
					prop_tree2 = 2 => 0.0283119,
					prop_tree2 = 3 => 0.0220494,
					prop_tree2 = 4 => 0.0119879,
					prop_tree2 = 5 => 0.0099184,
					0.0091189);

     
	
	/* AVG Lres */
	
	add1_year_first_seen := (integer)(le.bs.address_verification.input_address_information.date_first_seen[1..4]);
	sysyear := if(history_date <> 999999, (integer)((string)history_date[1..4]), (integer)(ut.GetDate[1..4]));

     firstseendate1 := if(add1_year_first_seen = 0, 10000, add1_year_first_seen);
     lres_yearsb := abs(sysyear - firstseendate1);
     lres_years1 := if(lres_yearsb > 1000, -1, if(lres_yearsb > 100, 100, lres_yearsb));
     yfseen_pop1 := if(lres_yearsb > 1000, 0, 1);


     secondseendate := (integer)(le.bs.address_verification.address_history_1.date_first_seen[1..4]);
     secondseendate2 := if(secondseendate = 0, 10000, secondseendate);
     lres_yearsc := abs(firstseendate1 - secondseendate2);
     lres_years2 := if(lres_yearsc > 1000, -1, if(lres_yearsc > 100, 100, lres_yearsc));
     yfseen_pop2 := if(lres_yearsc > 1000, 0, 1);


     thirdseendate := (integer)(le.bs.address_verification.address_history_2.date_first_seen[1..4]);
     thirdseendate3 := if(thirdseendate = 0, 10000, thirdseendate);
     lres_yearsd := abs(secondseendate2 - thirdseendate3);
     lres_years3 := if(lres_yearsd > 1000, -1, if(lres_yearsd > 100, 100, lres_yearsd));
     yfseen_pop3 := if(lres_yearsd > 1000, 0, 1);
     

	a := lres_years1 <> -1;
	b := lres_years2 <> -1;
	c := lres_years3 <> -1;
	total := (integer)a + (integer)b + (integer)c;
     avglres := (if(a, lres_years1, 0) + if(b, lres_years2, 0) + if(c, lres_years3, 0)) / total;

     lres_avg := map(lres_years1 = -1 and lres_years2 = -1 and lres_years3 = -1 => -1,
				 avglres > 12 => 12,
				 avglres);
				 
				 
	/* Derog                         */

	criminal_flag := if(le.bs.bjl.criminal_count > 0, 1, 0);
     liens_recent_unrel_flag := if(le.bs.bjl.liens_recent_unreleased_count > 0, 1, 0);
	

	/* Fraud Point                   */

     phn_ver_type := map(le.bs.iid.nap_type = 'U' => 2,
					le.bs.iid.nap_type = 'A' => 0,
					le.bs.iid.nap_type = 'P' => 0,    /* 02-09-2007 - Inserted This Line - PK */
					1);


	/* Relatives                     */

     rel_count2 := if(le.bs.relatives.relative_count > 5, 5, le.bs.relatives.relative_count);
     rel_flag := if(rel_count2 > 0, 1, 0);


	/* Relative BK and Criminal             */

     rel_bankrupt_flag := map(rel_flag = 0 => 3,
						le.bs.relatives.relative_bankrupt_count >= 2 => 2,
						le.bs.relatives.relative_bankrupt_count >= 1 => 1,
						0);

     rel_criminal_flag := if(le.bs.relatives.relative_criminal_count >= 1, 1, 0);



	/* Code to Means */

     rel_bankrupt_flag_m := map(rel_bankrupt_flag = 0 => 0.0186585573,
						  rel_bankrupt_flag = 1 => 0.0215647339,
						  rel_bankrupt_flag = 2 => 0.0285222796,
						  0.051588785);

     rel_criminal_flag_m := if(rel_criminal_flag = 0, 0.0209266924, 0.0251652557);


	/* Age                           */

     age2 := map(le.bs.name_verification.age = 0 => 24.5,
			  le.bs.name_verification.age <= 22 => 22,
			  le.bs.name_verification.age >= 55 => 55,
			  le.bs.name_verification.age);




	/* Census                     EASI Census Tract Block Group Data              */


     cenmod2a := -4.072027423
                  + (real)le.ea.urban_p  * 0.0025123686
                  + (real)le.ea.fammar_p  * -0.002074794
                  + (real)le.ea.young  * 0.0117363288
                  + (real)le.ea.ownocp  * -0.004840935
                  + (real)le.ea.low_hval  * 0.0029805638
                  + (real)le.ea.high_ed  * -0.009381731
                  + (real)le.ea.cartheft  * 0.0008932951
                  + (real)le.ea.lar_fam  * 0.0018626502
                  + (real)le.ea.med_inc  * -0.000859675
                  + (real)le.ea.unattach  * 0.0019564522;
			   
     cenmod2b := (exp(cenmod2a)) / (1+exp(cenmod2a));
	cenmod2c := round(1000000 * cenmod2b);
     cenmod2 := if(trim(le.ea.geolink) = '', 2.07101, cenmod2c / 10000);



	/* Model                        */

     mod9 := -6.247508576
                  + vermod  * 0.1212148534
                  + liens_recent_unrel_flag  * 1.0971399131
                  + criminal_flag  * 0.3284010463
                  + (integer)le.bs.bjl.bankrupt  * 0.450730596
                  + phn_ver_type * 0.1313483129
                  + age2  * -0.015590208
                  + prop_tree2_m  * 27.655415449
                  + lres_avg  * -0.015751817
                  + cenmod2  * 0.2056414863
                  + rel_bankrupt_flag_m  * 6.0488430242
                  + rel_criminal_flag_m  * 65.799298425;
			   
     phat := (exp(mod9)) / (1+exp(mod9));


     base  := 703;
     odds  := 1/21;
     point := -40;

     MSN610 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	
	thindexLite := if(le.bs.shell_input.fname<>'' and le.bs.shell_input.lname<>'' and le.bs.shell_input.in_streetAddress<>'' and 	// check for minimum input else 000
						(le.bs.shell_input.in_zipCode<>'' or (le.bs.shell_input.in_city<>'' and le.bs.shell_input.in_state<>'')), 
				   map(MSN610 > 999 => '999',
					  MSN610 < 501 => '501',
					  (string)MSN610),
				   '000');
	
	
	self.score := thindexLite;
	self.seq := le.bs.seq;
	self := [];
END;
out := project(results, doModel(left));

RETURN out;

END;
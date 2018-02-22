import ut, risk_indicators, RiskWise, std;

export CDN604_0_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC, boolean useBillTo=false) := 

FUNCTION


Layout_ModelOut doModel(clam le) := transform

	sysyear := IF(le.bill_to_out.historydate <> 999999, (integer)(((string)le.bill_to_out.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
	
	
	// ShipTo
	
	shipto := IF(((integer)le.eddo.addrscore between 65 and 100) or useBillTo, 0, 1);
	
	// BILLTO CODE
	
	/* Age */
	
	age_flag := if(le.bill_to_out.name_verification.age = 0, 0, 1);
	
	/* Verification */
	
	verphn_p := if(le.Bill_To_Out.iid.nap_summary in [4,6,7,9,10,11,12], 1, 0);
	
	nap_ver_level := MAP(le.Bill_To_Out.iid.nap_summary <= 4 => 0,
					 le.Bill_To_Out.iid.nap_summary <= 9 => 1,
					 le.Bill_To_Out.iid.nap_summary <= 11 => 2,
					 3);
					 
	nas_ver_level := MAP(le.Bill_To_Out.iid.nas_summary = 0 => 0,
					 le.Bill_To_Out.iid.nas_summary = 8 => 2,
					 1);
					 
					 
	add1_isbestmatch := le.Bill_To_Out.address_verification.input_address_information.isbestmatch;
	
	
	add1_source_count2 := IF(~add1_isbestmatch,
						MAP(le.Bill_To_Out.address_verification.input_address_information.source_count = 0 => 0,
						    le.Bill_To_Out.address_verification.input_address_information.source_count <= 2 => 1,
						     2),
						// add1_isbestmatch part
						MAP(le.Bill_To_Out.address_verification.input_address_information.source_count <= 2 => 0,
						    le.Bill_To_Out.address_verification.input_address_information.source_count <= 3 => 1,
						    2));
						 						 
	ver_level := IF(~add1_isbestmatch,
				  MAP(nap_ver_level = 0 and nas_ver_level = 0 => 0,
					 nap_ver_level = 0 and nas_ver_level = 1 => 1,
					 nap_ver_level = 0 and nas_ver_level = 2 => 2,
					 nap_ver_level = 1 and nas_ver_level = 0 => 1,
					 nap_ver_level = 1				    => 3,
					 nap_ver_level <= 3 and nas_ver_level = 0 => 3,
					 nap_ver_level <= 3 and nas_ver_level = 1 => 4,
					 5),
					 // add1_isbestmatch part
					 nap_ver_level + verphn_p + 10);
				  
	ver_level1 := IF(~add1_isbestmatch and ver_level in [1,2,3] and verphn_p = 1, ver_level + 1, ver_level);
	
	ver_level2 := IF(~add1_isbestmatch,
				  IF(add1_source_count2 = 2, ver_level1 + 1, ver_level1),
				  // add1_isbestmatch part
				  MAP(ver_level1 = 10 and add1_source_count2 = 0 => 10,
					 (ver_level1 in [10,11] and add1_source_count2 = 1) or (ver_level1 = 12 and add1_source_count2 = 0) => 12,
					 ver_level1 in [10,11] and add1_source_count2 = 2 => 13,
					 ver_level1 = 11 and add1_source_count2 = 0 => 11,
					 ver_level1 = 12 and add1_source_count2 = 1 => 13,
					 ver_level1 in [12,13] and add1_source_count2 = 2 => 15,
					 ver_level1 in [13,14] and add1_source_count2 = 0 => 13,
					 ver_level1 = 13 and add1_source_count2 = 1 => 14,
					 ver_level1 = 14 and add1_source_count2 = 1 => 16,
					17));
				  
	ver_level_m := MAP(ver_level2 =  0 => 0.0368527,
				    ver_level2 =  1 => 0.0147055,
				    ver_level2 =  2 => 0.0080716,
				    ver_level2 =  3 => 0.0053073,
				    ver_level2 =  4 => 0.0030026,
				    ver_level2 =  5 => 0.0021347,
				    ver_level2 =  6 => 0.0011080,
				    ver_level2 = 10 => 0.0055480,
				    ver_level2 = 11 => 0.0033705,
				    ver_level2 = 12 => 0.0020290,
				    ver_level2 = 13 => 0.0010799,
				    ver_level2 = 14 => 0.000788519,
				    ver_level2 = 15 => 0.000650021,
				    ver_level2 = 16 => 0.000533903,
				    0.000461148);

	// Property
	
	property_owned_total_x := if(le.Bill_To_Out.address_verification.owned.property_total > 0, true, false);
	property_sold_total_x := if(le.Bill_To_Out.address_verification.sold.property_total > 0, true, false);
	property_ambig_total_x := if(le.Bill_To_Out.address_verification.ambiguous.property_total > 0, true, false);
	
	property_total_x := property_owned_total_x or property_sold_total_x or property_ambig_total_x;
	
	NaProp4_any := if(le.Bill_To_Out.address_verification.input_address_information.naprop = 4 or le.Bill_To_Out.address_verification.address_history_1.naprop = 4 or le.Bill_To_Out.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.Bill_To_Out.address_verification.input_address_information.naprop = 3 or le.Bill_To_Out.address_verification.address_history_1.naprop = 3 or le.Bill_To_Out.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    
				    
	add1_year_first_seen1 := le.Bill_To_Out.address_verification.input_address_information.date_first_seen;
	add1_year_first_seen := (integer)(((STRING)add1_year_first_seen1)[1..4]);
	
	lres := sysyear - add1_year_first_seen;
	lres_years := IF(lres > 100, 0, lres);
	
	
	property_tree := MAP(le.Bill_To_Out.address_verification.input_address_information.naprop = 4 and le.Bill_To_Out.address_verification.input_address_information.family_owned => 5,
					 le.Bill_To_Out.address_verification.input_address_information.naprop = 4 => 4,
					 le.Bill_To_Out.address_verification.input_address_information.family_owned => 3,
					 le.Bill_To_Out.address_verification.input_address_information.naprop in [2,3] => 1,
					 NaProp_Tree = 2 => 2,
					 NaProp_Tree = 1 or property_total_x => 1,
					 0);
					 
	lres_code := MAP(lres_years <= 0 => 0,
				  lres_years <= 2 => 1,
				  lres_years <= 5 => 2,
				  3);
				  
				  
	pnotpots := if(trim(le.Bill_To_Out.phone_verification.telcordia_type) in ['00','50','51','52','54'], false, true);
	
	not_connected := IF(trim(le.Bill_To_Out.iid.nap_status) = 'C' and ~le.Bill_To_Out.phone_verification.disconnected, false, true);
	
	phnprob := MAP(not_connected and (pnotpots or le.Bill_To_Out.phone_verification.phone_zip_mismatch) => 2,
				not_connected or pnotpots or le.Bill_To_Out.phone_verification.phone_zip_mismatch => 1,
				0);
				
	
	// Relatives
	
	rel_dist := MAP(le.Bill_To_Out.relatives.relative_count = 0 => 0,
				 le.Bill_To_Out.relatives.relative_within25miles_count  > 0 => 25,
				 le.Bill_To_Out.relatives.relative_within100miles_count > 0 => 100,
				 le.Bill_To_Out.relatives.relative_within500miles_count > 0 => 500,
				 501);
				 
	norel25 := IF(rel_dist = 0 or rel_dist > 25, 1, 0);

     rel_flag := IF(le.Bill_To_Out.relatives.relative_count > 0, true, false);

     rel_prop_owned_flag := IF(rel_flag and le.Bill_To_Out.relatives.owned.relatives_property_count > 0, 1, 0);
	
	
	// Census
	
	add1_census_age_cb := MAP((integer)le.Bill_To_Out.address_verification.input_address_information.census_age <= 0 => 29,
						 (integer)le.Bill_To_Out.address_verification.input_address_information.census_age <= 26 => 26,
						 (integer)le.Bill_To_Out.address_verification.input_address_information.census_age >= 40 => 40,
						 (integer)le.Bill_To_Out.address_verification.input_address_information.census_age);

     add1_census_income_cb := MAP((integer)le.Bill_To_Out.address_verification.input_address_information.census_income <= 0 => 35000,
						    (integer)le.Bill_To_Out.address_verification.input_address_information.census_income <= 16000 => 16000,
						    (integer)le.Bill_To_Out.address_verification.input_address_information.census_income >= 100000 => 100000,
						    (integer)le.Bill_To_Out.address_verification.input_address_information.census_income);

     add1_census_education_cb := MAP((integer)le.Bill_To_Out.address_verification.input_address_information.census_education <= 0 => 12,
							  (integer)le.Bill_To_Out.address_verification.input_address_information.census_education <= 11 => 11,
							  (integer)le.Bill_To_Out.address_verification.input_address_information.census_education >= 14 => 14,
							  (integer)le.Bill_To_Out.address_verification.input_address_information.census_education);


     cenmod_b1 := -2.003338442
				+ add1_census_age_cb  * -0.032486997
				+ add1_census_income_cb  * -0.000022373
				+ add1_census_education_cb  * -0.092292191;
     cenmod_b2 := (exp(cenmod_b1)) / (1+exp(cenmod_b1));
     cenmod_b := 100 * cenmod_b2;

	
	// SHIPTO CODE
	
	/* Verification */
	
	verphn_p_s := if(le.Ship_To_Out.iid.nap_summary in [4,6,7,9,10,11,12], 1, 0);
	
	nap_ver_level_s := MAP(le.Ship_To_Out.iid.nap_summary <= 3 => 0,
					   le.Ship_To_Out.iid.nap_summary <= 9 => 1,
					   2);
					 
	nas_ver_level_s := MAP(le.Ship_To_Out.iid.nas_summary = 0 => 0,
					   le.Ship_To_Out.iid.nas_summary = 8 => 2,
					   1);
					 
	source_count2_s := MAP(le.Ship_To_Out.name_verification.source_count > 3 => 2,
					   le.Ship_To_Out.name_verification.source_count > 1 => 1,
					   0);
					   
	voter_sourced_flag_s := MAP(le.Ship_To_Out.available_sources.voter and le.Ship_To_Out.name_verification.fname_voter_sourced and le.Ship_To_Out.name_verification.lname_voter_sourced and 
								le.Ship_To_Out.address_verification.input_address_information.voter_sourced => 2,
						   le.Ship_To_Out.available_sources.voter and (le.Ship_To_Out.name_verification.fname_voter_sourced or le.Ship_To_Out.name_verification.lname_voter_sourced or 
																le.Ship_To_Out.address_verification.input_address_information.voter_sourced) => 1,
						   le.Ship_To_Out.available_sources.voter => 0,
						   1);
					 
				 
					 
	add1_isbestmatch_s := le.Ship_To_Out.address_verification.input_address_information.isbestmatch;
	
	
	add1_source_count2_s := IF(~add1_isbestmatch_s,
						  MAP(le.Ship_To_Out.address_verification.input_address_information.source_count = 0 => 0,
						      le.Ship_To_Out.address_verification.input_address_information.source_count <= 2 => 1,
						       2),
						  // add1_isbestmatch part
						  MAP(le.Ship_To_Out.address_verification.input_address_information.source_count <= 2 => 0,
						      le.Ship_To_Out.address_verification.input_address_information.source_count <= 3 => 1,
						      2));
							 
	ver_level_s := IF(~add1_isbestmatch_s,
				  MAP(nap_ver_level_s = 0 and nas_ver_level_s = 0 => 0,
					 nap_ver_level_s = 0 => 1,
					 nap_ver_level_s = 1 and nas_ver_level_s = 0 => 2,
					 3),
				  // add1_isbestmatch part
				  IF((nap_ver_level_s + 10) = 11 and verphn_p_s = 1, nap_ver_level_s + 11, nap_ver_level_s + 10));
				  
	ver_level1_s := IF(~add1_isbestmatch_s and ver_level_s in [2,3] and verphn_p_s = 0, ver_level_s - 1, ver_level_s);
	
	ver_level2_s := IF(~add1_isbestmatch_s,
				    MAP(ver_level1_s = 0 => 0,
					   ver_level1_s = 1 and source_count2_s = 0 => 1,
					   ver_level1_s = 1 and source_count2_s = 1 => 2,
					   (ver_level1_s = 1 and source_count2_s = 2) or ver_level1_s = 2 => 3,
					   ver_level1_s = 3 and source_count2_s <= 1 => 4,
					   5),
				    // add1_isbestmatch part
				    MAP(ver_level1_s = 10 and add1_source_count2_s <= 1 => 10,
					   ver_level1_s = 10 => 11,
				        ver_level1_s = 11 and add1_source_count2_s <= 0 => 10,
					   ver_level1_s = 11 => 11,
					   ver_level1_s = 12 and add1_source_count2_s <= 1 => 11,
					   12));
					   
	
     ver_level_s_m := MAP(ver_level2_s =  0 => 0.0155168,
					 ver_level2_s =  1 => 0.0093141,
					 ver_level2_s =  2 => 0.0081499,
					 ver_level2_s =  3 => 0.0058714,
					 ver_level2_s =  4 => 0.0032878,
					 ver_level2_s =  5 => 0.0024335,
					 ver_level2_s = 10 => 0.0099774,
					 ver_level2_s = 11 => 0.0038111,
					 0.0021151);



     ver_level_sb_m := MAP(ver_level2 =  0 => 0.0200927,
					  ver_level2 =  1 => 0.0149415,
					  ver_level2 =  2 => 0.0085397,
					  ver_level2 =  3 => 0.0087366,
					  ver_level2 =  4 => 0.0063158,
					  ver_level2 =  5 => 0.0038666,
					  ver_level2 =  6 => 0.0038666,
					  ver_level2 = 10 => 0.0082645,
					  ver_level2 = 11 => 0.0067318,
					  ver_level2 = 12 => 0.0057633,
					  ver_level2 = 13 => 0.0058852,
					  ver_level2 = 14 => 0.0060325,
					  ver_level2 = 15 => 0.0038818,
					  ver_level2 = 16 => 0.0038610,
					  0.0038610);


	/* Property */

     property_owned_total_x_s := if(le.Ship_To_Out.address_verification.owned.property_total > 0, true, false);
	property_sold_total_x_s := if(le.Ship_To_Out.address_verification.sold.property_total > 0, true, false);
	property_ambig_total_x_s := if(le.Ship_To_Out.address_verification.ambiguous.property_total > 0, true, false);
	
	property_total_x_s := property_owned_total_x_s or property_sold_total_x_s or property_ambig_total_x_s;
	
	NaProp4_any_s := if(le.Ship_To_Out.address_verification.input_address_information.naprop = 4 or le.Ship_To_Out.address_verification.address_history_1.naprop = 4 or le.Ship_To_Out.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any_s := if(le.Ship_To_Out.address_verification.input_address_information.naprop = 3 or le.Ship_To_Out.address_verification.address_history_1.naprop = 3 or le.Ship_To_Out.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree_s := map(NaProp4_any_s = 1 => 2,
				    NaProp3_any_s = 1 => 1,
				    0);


     add1_year_first_seen1_s := le.Ship_To_Out.address_verification.input_address_information.date_first_seen;
	add1_year_first_seen_s := (integer)(((STRING)add1_year_first_seen1_s)[1..4]);
	
	lres_s := sysyear - add1_year_first_seen_s;
	lres_years_s := IF(lres_s > 100, 0, lres_s);
	
	
	property_tree_s := MAP(le.Ship_To_Out.address_verification.input_address_information.naprop = 4 => 4,
					 le.Ship_To_Out.address_verification.input_address_information.family_owned => 3,
					 le.Ship_To_Out.address_verification.input_address_information.naprop in [2,3] => 1,
					 NaProp_Tree_s = 2 => 2,
					 NaProp_Tree_s = 1 or property_total_x_s => 1,
					 0);
					 
	lres_code_s := MAP(lres_years_s <= 0 => 0,
				  lres_years_s <= 4 => 1,
				  lres_years_s <= 10 => 2,
				  3);
				  
	lien_unrel_flag_s := IF(le.Ship_To_Out.bjl.liens_historical_unreleased_count = 0, 0, 1);			  
				  
				  
	pnotpots_s := if(trim(le.Ship_To_Out.phone_verification.telcordia_type) in ['00','50','51','52','54'], false, true);
	
	not_connected_s := IF(trim(le.Ship_To_Out.iid.nap_status) = 'C' and ~le.Ship_To_Out.phone_verification.disconnected, false, true);
	
	addprob_s := IF(trim(StringLib.StringToUpperCase(le.Ship_To_Out.address_validation.dwelling_type)) = 'A', 1, 0);
	
	
	phnprob_s := MAP(not_connected_s and (pnotpots_s or le.Ship_To_Out.phone_verification.phone_zip_mismatch) => 2,
				not_connected_s or pnotpots_s or le.Ship_To_Out.phone_verification.phone_zip_mismatch => 1,
				0);


     fpprob_s := addprob_s + phnprob_s;


	
	/* Census */

     add1_census_age_cb_s := MAP((integer)le.Ship_To_Out.address_verification.input_address_information.census_age <= 29 => 29,
						   (integer)le.Ship_To_Out.address_verification.input_address_information.census_age >= 38 => 38,
						   (integer)le.Ship_To_Out.address_verification.input_address_information.census_age);

     add1_census_income_cb_s := MAP((integer)le.Ship_To_Out.address_verification.input_address_information.census_income <= 0 => 35000,
						    (integer)le.Ship_To_Out.address_verification.input_address_information.census_income <= 25000 => 25000,
						    (integer)le.Ship_To_Out.address_verification.input_address_information.census_income >= 84000 => 84000,
						    (integer)le.Ship_To_Out.address_verification.input_address_information.census_income);

     add1_census_education_cb_s := MAP((integer)le.Ship_To_Out.address_verification.input_address_information.census_education <= 0 => 12,
							  (integer)le.Ship_To_Out.address_verification.input_address_information.census_education <= 11 => 11,
							  (integer)le.Ship_To_Out.address_verification.input_address_information.census_education >= 14 => 14,
							  (integer)le.Ship_To_Out.address_verification.input_address_information.census_education);


     cenmod_s1 := 0.1665770296
				+ add1_census_age_cb_s  * -0.055357876
				+ add1_census_income_cb_s  * -5.394331E-6
				+ add1_census_education_cb_s  * -0.220725382;
     cenmod_s := 100 * (exp(cenmod_s1)) / (1+exp(cenmod_s1));


	/* Distance */

     dist_p1a1_s := MAP(le.eddo.distphoneaddr = '' => 2,
				    (integer)le.eddo.distphoneaddr  = 0 => 0,
				    (integer)le.eddo.distphoneaddr <= 7 => 1,
				    2);

     dist_p2a2_s := MAP(le.eddo.distphone2addr2 = '' => 2,
				    (integer)le.eddo.distphone2addr2  = 0 => 0,
				    (integer)le.eddo.distphone2addr2 <= 2 => 1,
				    2);


     dist_a1a2_s := MAP(le.eddo.distaddraddr2   = '' => 1,
				    (integer)le.eddo.distaddraddr2 <=   5 =>  0,
				    (integer)le.eddo.distaddraddr2 <= 100 =>  1,
				    (integer)le.eddo.distaddraddr2 <= 400 =>  2,
				    (integer)le.eddo.distaddraddr2 <= 2000 => 3,
				    4);

     dist_a1p2_s := MAP(le.eddo.distaddrphone2 = '' => 2,
				    (integer)le.eddo.distaddrphone2 <= 3 => 0,
				    1);


     distmod_s1 := -6.781328252
				+ dist_p1a1_s  * 0.3087053809
				+ dist_p2a2_s  * 0.3725296576
				+ dist_a1a2_s  * 0.4262970874
				+ dist_a1p2_s  * 0.1508457786;
     distmod_s := 100 * (exp(distmod_s1)) / (1+exp(distmod_s1));
	
	
	/* Means - BILLTO */
	
	age_flag_m := IF(age_flag = 0, 0.0119610789, 0.0021703988);
	
	phnprob_m := MAP(phnprob = 0 => 0.0014238737,
				  phnprob = 1 => 0.0035327125,
				  0.0116461846);


     property_tree_m := MAP(property_tree = 0 => 0.0094662318,
					   property_tree = 1 => 0.0048707005,
					   property_tree = 2 => 0.003442743,
					   property_tree = 3 => 0.0016368673,
					   property_tree = 4 => 0.0010380713,
					   0.0006604763);


     lres_code_m := MAP(lres_code = 0 => 0.0118605651,
				    lres_code = 1 => 0.0018126021,
				    lres_code = 2 => 0.0012205724,
				    0.0008332036);


     norel25_m := IF(norel25 = 0, 0.0021377317, 0.0166344442);
	
	
	/* Means - SHIPTO */
	
	phnprob_sbm := MAP(phnprob = 0 => 0.004898759,
				    phnprob = 1 => 0.0064706867,
				    0.0125954198);


     rel_prop_owned_flag_sbm := IF(rel_prop_owned_flag = 0, 0.0102285817, 0.0057980399);


     voter_sourced_flag_s_sm := MAP(voter_sourced_flag_s = 0 => 0.0099041771,
							 voter_sourced_flag_s = 1 => 0.006162465,
							 0.0025611176);


     property_tree_s_sm := MAP(property_tree_s = 0 => 0.010534196,
						 property_tree_s = 1 => 0.0069488313,
						 property_tree_s = 2 => 0.004532413,
						 property_tree_s = 3 => 0.0033102618,
						 0.0024024522);


     lres_code_s_sm := MAP(lres_code_s = 0 => 0.0093470258,
					  lres_code_s = 1 => 0.0051403717,
					  lres_code_s = 2 => 0.0031055901,
					  0.0020897357);
					  
	lres_code_sm := map(lres_code = 0 => 0.01130751,
					lres_code = 1 => 0.0059639527,
					lres_code = 2 => 0.0051643353,
					0.0062750537);
					
	lien_unrel_flag_s_sm := IF(lien_unrel_flag_s = 0, 0.0076225174, 0.0080367394);


     fpprob_s_sm := MAP(fpprob_s = 0 => 0.0030097087,
				    fpprob_s = 1 => 0.0050822123,
				    fpprob_s = 2 => 0.0116374365,
				    0.0146617605);
				    
				    
	/* Models */
	
	billToModeScore_c := -8.322507439
					   + ver_level_m  * 34.111063092
					   + cenmod_b  * 0.9505402823
					   + age_flag_m  * 15.89230122
					   + phnprob_m  * 104.02583896
					   + property_tree_m  * 66.159645815
					   + lres_code_m  * 109.50813134
					   + norel25_m  * 24.377735454;
     phat_b := (exp(billToModeScore_c)) / (1+exp(billToModeScore_c));

     sbmod21 := -5.356327288
                  + ver_level_sb_m  * 68.453835164
                  + add1_census_education_cb  * -0.093625614
                  + phnprob_sbm  * 85.491971067
                  + rel_prop_owned_flag_sbm  * 54.127708235;
     sbmod2 := 100 * (exp(sbmod21)) / (1+exp(sbmod21));

     shipToModeScore := -17.38977671
					   + sbmod2  * 0.5666433722
					   + voter_sourced_flag_s_sm  * 94.372891122
					   + property_tree_s_sm  * 47.542401576
					   + lres_code_s_sm  * 74.239904797
					   + lien_unrel_flag_s_sm  * 964.50154141
					   + fpprob_s_sm  * 51.776549075
					   + lres_code_sm  * 41.872026304
					   + ver_level_s_m  * 29.792325704
					   + cenmod_s  * 1.0022112448
					   + distmod_s  * 0.757249704
					   + add1_census_age_cb  * 0.034241307
					   + add1_census_education_cb  * -0.073439566;
     phat_s := (exp(shipToModeScore)) / (1+exp(shipToModeScore));

     base  := 660;
     odds  := .0476;
     point :=  -30;

     CDN604 := if(shipto=1, (integer)(point*(log(phat_s/(1-phat_s)) - log(odds))/log(2) + base),(integer)(point*(log(phat_b/(1-phat_b)) - log(odds))/log(2) + base));

     CDN604_0_0 := map(CDN604 > 999 => 999,
				   CDN604 < 0 => 0,
				   CDN604);
				   
	SELF.score := intformat(cdn604_0_0,3,1);
	SELF.seq := le.Bill_To_Out.seq;
	SELF.ri := [];

END;
out := PROJECT(clam, doModel(LEFT));


// need to project billto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
	self.seq := le.Bill_To_Out.seq;
	self.historydate := le.Bill_To_Out.historydate;
	self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
	self.nxx_type := le.Bill_To_Out.phone_verification.telcordia_type;
	self := le.Bill_To_Out.iid;
	self := le.Bill_To_Out.shell_input;
	self.header_summary := le.bill_to_out.header_summary;
	self.hhid_summary := le.bill_to_out.hhid_summary;
	self := le;
	self := [];
end;
iidBT := project(clam, into_layout_output(left));


Layout_ModelOut addBTReasons(Layout_ModelOut le, iidBT ri) := transform
	SELF.ri := RiskWise.cbdoReasonCodes(ri, 6);
	SELF := le;
end;
BTReasons := join(out, iidBT, left.seq = right.seq, addBTReasons(left, right), left outer);

RETURN (BTReasons);

END;
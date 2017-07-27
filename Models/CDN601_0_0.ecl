import ut, risk_indicators, address, RiskWise, NetAcuity;

export CDN601_0_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC=true, dataset(Models.Layout_CD) indata,
			   boolean IBICID, unsigned3 history_date) := 

FUNCTION


Layout_ModelOut doModel(clam le, indata ri) := transform

	sysyear := IF(history_date <> 999999, (integer)((string)history_date[1..4]), (integer)(ut.GetDate[1..4]));
	
	// ShipTo
	
	shipto := IF((integer)le.eddo.addrscore between 65 and 100, 0, 1);
	
	// Verification
	
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
	add1_year_first_seen := (integer)(add1_year_first_seen1[1..4]);
	
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


     rel_bk_flag := IF(le.Bill_To_Out.relatives.relative_bankrupt_count > 0, 1, 0);

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


	// IP
	
	dr_country := trim(Stringlib.StringToUpperCase(le.ip2o.countrycode));
	dr_us_flag := MAP(dr_country = 'USA' => 1,
				   dr_country = '' => -1,
				   0);

     dr_foreign_flag := IF(dr_us_flag = 0, 1, 0);

	dr_domain_name := trim(Stringlib.StringToLowerCase(le.ip2o.domain));
     dr_domain_name2 := MAP(dr_domain_name = '' => 'Missing',
					   dr_domain_name in ['comcast.net','quesmk','aol.com','rr.com','cox.net','bestbuy.com','verizon.net','charter.com','level3.net','optonline.net',
									  'bellsouth.net','pacbell.net','ameritech.net','qwest.net','adelphia.net','swbell.net','mindspring.com','dsl-verizon.net'] => dr_domain_name,
					   'Uncommon');


     dr_domain_risk := map(dr_domain_name2 in ['ameritech.net','aol.com','charter.com','comcast.net','cox.net','qwest.net','rr.com','swbell.net',
									  'verizon.net','adelphia.net','level3.net','optonline.net'] => 0,
					  dr_domain_name2 in ['dsl-verizon.net', 'mindspring.com', 'pacbell.net'] => 1,
					  dr_domain_name2 in ['Uncommon', 'bellsouth.net'] => 2,
					  dr_domain_name2 in ['Missing', 'bestbuy.com'] => 3,
					  4);



     dr_st_match := map(shipto = 0 and trim(StringLib.StringToUpperCase(le.ip2o.state/*ri.response.region*/)) = trim(le.Bill_To_Out.shell_input.in_state) => 1,
				    shipto = 1 and trim(StringLib.StringToUpperCase(le.ip2o.state/*.response.region*/)) = trim(le.Ship_To_Out.shell_input.in_state) => 1,
				    0);


     em_first_match := IF(le.eddo.efirstscore = '255' or (integer)le.eddo.efirstscore <= 25, false, true);
     em_last_match := IF(le.eddo.elastscore = '255' or (integer)le.eddo.elastscore <= 25, false, true);
     em_match := IF(em_first_match or em_last_match, 1, 0);




// starting ship to

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
	add1_year_first_seen_s := (integer)(add1_year_first_seen1_s[1..4]);
	
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


	// IP
	
	dr_speed := trim(StringLib.StringToLowerCase(le.ip2o.ipconnection));
	dr_speed_risk_s := MAP(dr_speed in ['cable', 't1', 'xdsl'] => 0,
					   (trim(StringLib.StringToUpperCase(le.ip2o.iptype)) = 'RESERVED') or le.ip2o.ipaddr = ''  => 1,
					   2);


	
     dr_domain_risk_s := MAP(dr_domain_name2 in ['ameritech.net','aol.com','charter.com','comcast.net','cox.net','qwest.net','rr.com','swbell.net','verizon.net',
									    'adelphia.net','level3.net','optonline.net','dsl-verizon.net', 'mindspring.com', 'pacbell.net','Uncommon', 'bellsouth.net'] => 0,
					    dr_domain_name2 in ['Missing', 'bestbuy.com'] => 1,
					    2);

	
	dr_st_match_s := MAP(trim(StringLib.StringToUpperCase(le.ip2o.state/*response.region*/)) = trim(le.Bill_To_Out.shell_input.in_state) => 1,
				      shipto = 1 and trim(StringLib.StringToUpperCase(le.ip2o.state/*response.region*/)) = trim(le.Ship_To_Out.shell_input.in_state) => 1,
				      0);

     
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


	/* AVS */
	
	avs := trim(StringLib.StringToUpperCase(ri.avscode));

     AVS_Unavailable := IF(avs in [ '0', '5', '9', 'E', 'R', 'S', 'U', '', '1'], true, false);
     AVS_Match := IF(avs in ['M', 'X', 'D', 'Y'], true, false);
     AVS_No_Match := IF(avs in ['N', 'I', 'G', 'C'], true, false);
     AVS_Zip_Match := IF(avs in ['Z', 'P', 'W'], true, false);
     AVS_Addr_Match := IF(avs in ['B','A'], true, false);
     AVS_Partial_Match := IF(avs in ['F', 'L', 'O'], true, false);
     AVS_Name_Only_Match := IF(avs in ['K'], true, false);

     AVS_Match_Level := MAP(AVS_Match => 2,
					   AVS_Zip_Match or AVS_Addr_Match or AVS_Partial_Match or AVS_Name_Only_Match  => 1,
					   0) ;


	/* Means */

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


     rel_bk_flag_m := IF(rel_bk_flag = 0, 0.0048276674, 0.0026344561);


     rel_prop_owned_flag_m := IF(rel_prop_owned_flag = 0, 0.0080102944, 0.0018226032);


     dr_foreign_flag_m := IF(dr_foreign_flag = 0, 0.0033402842, 0.0649141631);


     dr_domain_risk_m := MAP(dr_domain_risk = 0 => 0.0022052338,
					    dr_domain_risk = 1 => 0.0035930035,
					    dr_domain_risk = 2 => 0.004276996,
					    dr_domain_risk = 3 => 0.0051979366,
					    0.0136663319);


     dr_st_match_m := IF(dr_st_match = 0, 0.0069790822, 0.0021953636);


     em_match_m := IF(em_match = 0, 0.0044384688, 0.0024096386);


     AVS_Match_Level_m := MAP(AVS_Match_Level = 0 => 0.0377467501,
						AVS_Match_Level = 1 => 0.0026340086,
						0.0007932287);


	/* Means - Shipto */

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


     lien_unrel_flag_s_sm := IF(lien_unrel_flag_s = 0, 0.0076225174, 0.0080367394);


     fpprob_s_sm := MAP(fpprob_s = 0 => 0.0030097087,
				    fpprob_s = 1 => 0.0050822123,
				    fpprob_s = 2 => 0.0116374365,
				    0.0146617605);


     dr_us_flag_sm := MAP(dr_us_flag = -1 => 0.0074236545,
					 dr_us_flag = 0 => 0.0789391576,
					 0.0059977666);


     dr_speed_risk_s_sm := MAP(dr_speed_risk_s = 0 => 0.0055406613,
						 dr_speed_risk_s = 1 => 0.0074236545,
						 0.008913668);


     dr_domain_risk_s_sm := MAP(dr_domain_risk_s = 0 => 0.0065011243,
						  dr_domain_risk_s = 1 => 0.0075889625,
						  0.0177124417);


     dr_st_match_s_sm := IF(dr_st_match_s = 0, 0.0119155034, 0.0043601704);


     AVS_Match_Level_sm := MAP(AVS_Match_Level = 0 => 0.0227461398,
						 AVS_Match_Level = 1 => 0.0074551149,
						 0.005613677);




	/* Models */


     next_day_delivery := IF(trim(ri.shipmode) = '2', 1, 0);

     second_day_delivery := IF(trim(ri.shipmode) = '7', 1, 0);


     billmod9 := -11.56648283
				   + ver_level_m  * 10.542157029
				   + cenmod_b  * 0.7098047576
				   + phnprob_m  * 96.607990447
				   + property_tree_m  * 27.657784159
				   + lres_code_m  * 52.881171939
				   + norel25_m  * 12.573103337
				   + rel_bk_flag_m  * 58.997266839
				   + rel_prop_owned_flag_m  * 23.129047145
				   + dr_foreign_flag_m  * 25.197044395
				   + dr_domain_risk_m  * 82.771149459
				   + dr_st_match_m  * 51.196395668
				   + em_match_m  * 388.24207543
				   + AVS_Match_Level_m  * 75.531903258
				   + next_day_delivery  * 2.0651628451
				   + second_day_delivery  * 0.4725822117;
     phat_b := (exp(billmod9)) / (1+exp(billmod9));


     sbmod21 := -5.356327288
                  + ver_level_sb_m  * 68.453835164
                  + add1_census_education_cb  * -0.093625614
                  + phnprob_sbm  * 85.491971067
                  + rel_prop_owned_flag_sbm  * 54.127708235;
     sbmod2 := 100 * (exp(sbmod21)) / (1+exp(sbmod21));




     shipmod7 := -22.20626081
                  + sbmod2  * 0.3374389375
                  + voter_sourced_flag_s_sm  * 99.679660101
                  + property_tree_s_sm  * 32.372524857
                  + lres_code_s_sm  * 59.786168129
                  + lien_unrel_flag_s_sm  * 1214.3214862
                  + fpprob_s_sm  * 62.635689123
                  + dr_us_flag_sm  * 24.274719788
                  + dr_speed_risk_s_sm  * 55.785789241
                  + dr_domain_risk_s_sm  * 53.696464703
                  + dr_st_match_s_sm  * 52.282099446
                  + AVS_Match_Level_sm  * 56.681131205
                  + ver_level_s_m  * 30.786285298
                  + cenmod_s  * 0.9277171599
                  + distmod_s  * 0.5843067461
                  + add1_census_age_cb  * 0.0409387354
                  + next_day_delivery  * 2.1265341333
                  + second_day_delivery  * 0.6831291357;
     phat_s := (exp(shipmod7)) / (1+exp(shipmod7));



     base := 660;
     odds := .0476;
     point :=  -30;

     CBDefender601 := IF(shipto = 1, (integer)(point*(log(phat_s/(1-phat_s)) - log(odds))/log(2) + base),
							  (integer)(point*(log(phat_b/(1-phat_b)) - log(odds))/log(2) + base));


     cdn601_0_0 := MAP(CBDefender601 > 999 => 999,
				   CBDefender601 < 0 => 0,
				   CBDefender601);

	SELF.score := intformat(cdn601_0_0,3,1);
	SELF.seq := le.Bill_To_Out.seq;
	SELF.ri := [];

END;
out := JOIN(clam, indata, left.bill_to_out.seq = (right.seq*2), doModel(LEFT,RIGHT), left outer);


// need to project billto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
	self.seq := le.Bill_To_Out.seq;
	self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
	self := le.Bill_To_Out.iid;
	self := le.Bill_To_Out.shell_input;
	self := [];
end;
iidBT := project(clam, into_layout_output(left));

RiskWise.Layout_IP2O fill_ip(clam le) := transform
	self := le.ip2o;
end;
ipInfo := PROJECT(clam, fill_ip(LEFT));


Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := transform
	self.seq := le.seq;
	SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, true, IBICID);
	SELF := [];
end;
BTReasons := join(iidBT, ipInfo, left.seq = right.seq, addBTReasons(left, right), left outer);

Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := transform
	self.ri := rt.ri;
	self := le;
end;
BTrecord := JOIN(out, BTReasons, left.seq = right.seq, fillReasons(LEFT,RIGHT), left outer);


// need to project the shipto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output2(clam le) := transform
	self.seq := le.Ship_To_Out.seq;
	self.socllowissue := (string)le.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Ship_To_Out.iid.NAS_summary;
	self := le.Ship_To_Out.iid;
	self := le.Ship_To_Out.shell_input;
	self := [];
end;
iidST := project(clam, into_layout_output2(left));


Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := transform
	self.seq := le.seq;
	SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, false, IBICID);
	SELF := [];
end;
STReasons := join(iidST, ipInfo, left.seq=((right.seq*2)-1), addSTReasons(LEFT, RIGHT), left outer);

Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := transform
	self.ri := le.ri + rt.ri;
	self := le;
end;
STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(LEFT,RIGHT), left outer);

RETURN (STRecord);

END;
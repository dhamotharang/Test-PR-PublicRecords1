import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std;

export TRD605_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM

	contrary_phone := if(le.iid.nap_summary = 1, 1, 0);
	
	ssn479 := if(le.iid.nas_summary in [4,7,9], 1, 0);
	
	nap_ver := map(le.iid.nap_summary in [0,1] => 0,
				le.iid.nap_summary = 12 => 3,
				le.iid.nap_summary in [6,10,11] => 2,
				1);

     eda_source_ver := map(le.name_verification.fname_eda_sourced and le.name_verification.lname_eda_sourced => 3,
					  le.name_verification.lname_eda_sourced and le.address_verification.input_address_information.eda_sourced => 2,
					  ((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + 
								(integer)le.address_verification.input_address_information.eda_sourced) = 0 => 0,
					  1);
					  
	
	best_match_level := map(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);
					    
	
	today := IF(le.historydate <> 999999, ((STRING)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);

     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));	
     age_years := if(age_years1 <= 0, -99, age_years1);

     age_combo := age_years;	// removed the system calculated age
	age_combo2 := map(age_combo < 20 => 20,
				   age_combo > 58 => 58,
				   age_combo);
				    
	property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1, 0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1, 0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1, 0);

     property_total_x := property_owned_total_x = 1 or property_sold_total_x = 1 or property_ambig_total_x = 1;


	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1, 0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1, 0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    
	lien_unrel_flag := if(le.bjl.liens_historical_unreleased_count = 0, 0, 1);
     criminal_flag := if(le.bjl.criminal_count > 0, 1, 0);
     crimlien := if(criminal_flag = 1 or lien_unrel_flag = 1, 1, 0);


     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);

     phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;
	
	not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0, 1);
	
	phnprob := map(not_connected = 1 and (pnotpots = 1 or phone_zip_mismatch_n = 1) => 2,
				not_connected = 1 or pnotpots = 1 or phone_zip_mismatch_n = 1 => 1,
				0);
				
	/* New Fields to Create TRD605 */

     mult_adl_retail_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
						    le.ssn_verification.adlperssn_count <= 2 => 1,
						    le.ssn_verification.adlperssn_count <= 3 => 2,
						    3);

     mult_adl_retail_count_m := map(mult_adl_retail_count = 0 => 0.1100934,
							 mult_adl_retail_count = 1 => 0.1363581,
							 mult_adl_retail_count = 2 => 0.1534031,
							 0.1779221);


     verx_retail := map(best_match_level >= 2 and nap_ver >= 3 => 9,
				    best_match_level >= 2 and nap_ver >= 2 and eda_source_ver >= 2 => 7,
				    best_match_level >= 2 and nap_ver >= 2 => 6,
				    best_match_level >= 2 and nap_ver >= 1 and eda_source_ver >= 3 => 5,
				    best_match_level >= 2 and nap_ver >= 1 => 3,
				    best_match_level >= 2 and nap_ver >= 0 => 3,
				    best_match_level >= 1 and nap_ver >= 3 => 8,
				    best_match_level >= 1 and nap_ver >= 2 => 6,
				    best_match_level >= 1 and nap_ver >= 1 and eda_source_ver >= 3 => 8,
				    best_match_level >= 1 and nap_ver >= 1 => 2,
				    best_match_level >= 1 and nap_ver >= 0 => 1,
				    best_match_level >= 0 and nap_ver >= 1 and eda_source_ver >= 3 => 3,
				    best_match_level >= 0 and nap_ver >= 2 and eda_source_ver >= 1 => 1,
				    best_match_level >= 0 and nap_ver >= 2 => 0,
				    best_match_level >= 0 and nap_ver >= 1 => 1,
				    best_match_level >= 0 and nap_ver >= 0 and eda_source_ver >= 1 => 1,
				    0);


    
					
	verx_retail2 := map(verx_retail = 0 and ssn479 = 1 => 1,
					verx_retail = 0 => 4,
					verx_retail = 1 and ssn479 = 1 => 2,
					verx_retail in [1,2,3] => 4,
					verx_retail in [5,6] => 5,
					verx_retail = 7 => 6,
					verx_retail = 8 => 7,
					verx_retail = 9 => 8,
					verx_retail);


     verx_retail3 := if(verx_retail2 in [2,3,4] and contrary_phone = 1, verx_retail2 - 1, verx_retail2);


     verx_retail_m := map(verx_retail3 = 1 => 0.1947769,
					 verx_retail3 = 2 => 0.1616249,
					 verx_retail3 = 3 => 0.1429454,
					 verx_retail3 = 4 => 0.1218469,
					 verx_retail3 = 5 => 0.1081507,
					 verx_retail3 = 6 => 0.0942090,
					 verx_retail3 = 7 => 0.0790850,
					 0.0721088);


     prop_flag := if(NaProp_Tree > 0 or property_total_x, 1, 0);

     NaProp_Tree_Retail2 := map(best_match_level = 2 and prop_flag = 1 and le.address_verification.input_address_information.naprop = 4 => 5,
						  best_match_level = 2 and prop_flag = 1 => 4,
						  best_match_level = 2 => 3,
						  best_match_level = 1 => 2,
						  best_match_level = 0 and prop_flag = 1 => 1,
						  0);

     NaProp_Tree_Retail2_m := map(NaProp_Tree_Retail2 = 0 => 0.1748748,
						    NaProp_Tree_Retail2 = 1 => 0.1288614,
						    NaProp_Tree_Retail2 = 2 => 0.1247191,
						    NaProp_Tree_Retail2 = 3 => 0.1133124,
						    NaProp_Tree_Retail2 = 4 => 0.1022806,
						    0.0567246);


     base := 673;
     odds := .06 / .94;
     point := -18;


     fcra_retail_mod := -3.338925091
					   + age_combo2  * -0.057174754
					   + phnprob  * 0.1173610803
					   + crimlien  * 0.9968207815
					   + verx_retail_m  * 1.877936978
					   + mult_adl_retail_count_m  * 10.436126669
					   + NaProp_Tree_Retail2_m  * 5.6993626576;
     
     fcra_retail_mod2 := (exp(fcra_retail_mod)) / (1+exp(fcra_retail_mod));
     phat := fcra_retail_mod2;

	// changed the following on 9-11-06 per pk and bs
     x := point*(log(phat/(1-phat)) - log(odds))/log(2) + base;

     TRD605 := if(x <= 670, -838.383970857 + (2.265938069 * x), 284.141587678 + (0.587973934 * x));

     TRD6052 := round(TRD605);
	
	TRD6053 := TRD6052 + 3;
	// end changes





	// 13 Sept 2007 override (bug 26625)
	rc3  := ('03' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc6  := ('06' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc8  := ('08' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc11 := ('11' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc19 := ('19' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );

	nas1 := ( le.iid.nas_summary = 1 );
	override := rc19 and ( rc3 or rc6 or rc8 or rc11 or nas1 );

	TRD6053a := if( TRD6053 > 650, TRD6053-60, TRD6053 ); // the override score, unbounded
	TRD6053b := if( ~override, TRD6053, // when not overridden, use the already calculated score
			Min( 650, Max( 600, TRD6053a) ) ); // the override score, bound within [600,650]


	TRD6054 := map(le.ssn_verification.validation.deceased and TRD6053b > 625 => 625,
				 TRD6053b > 999 => 999,
				 TRD6053b < 250 => 250,
				 TRD6053b);


	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
     self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)TRD6054);
	self.seq := le.seq;
END;
out := project(clam, doModel(left));


Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
END;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
	self.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif));
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right), left outer);

RETURN (final);

END;
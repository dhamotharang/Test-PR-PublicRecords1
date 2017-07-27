import ut, Risk_Indicators, RiskWise, RiskWiseFCRA;

export TRD609_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM

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
				    
	ssn479 := if(le.iid.nas_summary in [4,7,9], 1, 0); 
	contrary_phone := if(le.iid.nap_summary = 1, 1, 0);
				    
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


 	// the above is copied from trd605_0_0
	
	
	// new stuff for this model is below
	verx_retail_ae := ut.imin2(verx_retail3, 6);

	verx_retail_ae_l := map(verx_retail_ae = 1 => -0.39803013,
					    verx_retail_ae = 2 => -0.60109801,
					    verx_retail_ae = 3 => -0.72509878,
					    verx_retail_ae = 4 => -0.855615706,
					    verx_retail_ae = 5 => -0.945245984,
					    -1.324221932);

	adlperssn_count_ae := ut.imin2(le.ssn_verification.adlperssn_count, 3);


	adlperssn_count_ae_l := map(adlperssn_count_ae = 0 => -1.333012995,
						   adlperssn_count_ae = 1 => -0.966144925,
						   adlperssn_count_ae = 2 => -0.68797921,
						   -0.526093096);


	naproptree_ae := map(best_match_level = 0 and le.address_verification.input_address_information.naprop >= 3 and le.address_verification.address_history_1.naprop >= 0 => 1,
					 best_match_level = 0 and le.address_verification.input_address_information.naprop >= 0 and le.address_verification.address_history_1.naprop >= 3 => 1,
					 best_match_level = 0 and le.address_verification.input_address_information.naprop >= 0 and le.address_verification.address_history_1.naprop >= 0 => 3,
					 best_match_level = 1 and le.address_verification.input_address_information.naprop >= 0 and le.address_verification.address_history_1.naprop >= 0 => 2,
					 best_match_level = 2 and le.address_verification.input_address_information.naprop >= 3 and le.address_verification.address_history_1.naprop >= 0 => 0,
					 best_match_level = 2 and le.address_verification.input_address_information.naprop >= 0 and le.address_verification.address_history_1.naprop >= 3 => 0,
					 2);



	ae_score_final := -0.090523069
					   + crimlien  * 0.5672989785
					   + verx_retail_ae_l  * 0.495679623
					   + adlperssn_count_ae_l  * 0.8798516644
					   + naproptree_ae  * 0.2208254852
					   + phnprob  * 0.0673463487;

	base := 685;
	odds := .295;
	point := -43;

	ae_score_final2 := (exp(ae_score_final)) / (1+exp(ae_score_final ));
	
	score := if((point*(log(ae_score_final2/(1-ae_score_final2)) - log(odds))/log(2) + base) < 1000, point*(log(ae_score_final2/(1-ae_score_final2)) - log(odds))/log(2) + base, 1000);
	
	score2 :=  -1448.76 + 5.38252 * score + -0.00330876 * score * score;
	
	trd60910 := (integer)(score2) + 2;


	// 13 Sept 2007 override (bug 26625)
	rc3  := ('03' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc6  := ('06' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc8  := ('08' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc11 := ('11' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc19 := ('19' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );

	nas1 := ( le.iid.nas_summary = 1 );
	override := rc19 and ( rc3 or rc6 or rc8 or rc11 or nas1 );

	trd60910a := if( trd60910 > 650, trd60910-60, trd60910 ); // the override score, unbounded
	trd60910b := if( ~override, trd60910, // when not overridden, use the already calculated score
			ut.imin2( 650, ut.max2( 600, trd60910a ) ) ); // the override score, bound within [600,650]


	trd60911 := map(le.ssn_verification.validation.deceased and trd60910b > 625 => 625,
				 trd60910b > 999 => 999,
				 trd60910b < 250 => 250,
				 trd60910b);


	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
     self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)trd60911);
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
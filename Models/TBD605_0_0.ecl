﻿import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std;

export TBD605_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM
	
	sysyear := IF(le.historydate <> 999999, (integer)(((STRING)le.historydate)[1..4]) + 1, (integer)(((STRING)Std.Date.Today())[1..4]) + 1);
		
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	veradd_p := if(le.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	
	verla_p := if(verlst_p = 1 or veradd_p = 1, 1, 0);

     best_match_level := map(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);


     addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,le.address_verification.address_history_1.predir,le.address_verification.address_history_1.prim_name,
								  le.address_verification.address_history_1.addr_suffix,le.address_verification.address_history_1.postdir,le.address_verification.address_history_1.unit_desig,
								  le.address_verification.address_history_1.sec_range);
     addr2pop := if(addr2 = '' , 0, 1);


     property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1, 0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1, 0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1, 0);

     property_total_x := property_owned_total_x = 1 or property_sold_total_x = 1 or property_ambig_total_x = 1;


	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1, 0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1, 0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    


     prop_tree_credit2 := map(NaProp_Tree = 2 and property_total_x => 3,
						NaProp_Tree = 2 => 2,
						NaProp_Tree = 1 and property_total_x => 2,
						NaProp_Tree = 1 => 1,
						NaProp_Tree = 0 and property_total_x => 2,
						NaProp_Tree = 0 => 0,
						0);

	time_on_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_first_seen)[1..4]));

    
     time_since_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_last_seen)[1..4]));

    							
	lien_unrel_flag := if(le.bjl.liens_historical_unreleased_count = 0, 0, 1);
     criminal_flag := if(le.bjl.criminal_count > 0, 1, 0);
     crimlien := if(criminal_flag = 1 or lien_unrel_flag = 1, 1, 0);


     hr_address_n := (integer)le.address_validation.hr_address;

     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);

     phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;
	
	not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0, 1);

     disconnect_level := map(le.input_validation.homephone and disconnected_n = 1 => 2,
					    le.input_validation.homephone and not_connected = 1 => 1,
					    ~(le.input_validation.homephone) => 1,
					    0);

     phnprob_credit := map(~(le.input_validation.homephone) => 1,
					  disconnect_level = 2 or pnotpots = 1 or phone_zip_mismatch_n = 1 => 2,
					  disconnect_level = 1 => 1,
					  0);

     mult_adl_credit_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
						    le.ssn_verification.adlperssn_count <= 4 => 1,
						    2);

     addprob := map(trim(le.address_validation.dwelling_type) = 'A' => 1,
				hr_address_n = 1 => 1,
				le.input_validation.address and ~le.address_validation.usps_deliverable => 1,
				0);

     fp_prob := phnprob_credit + addprob;

     fp_prob_m := map(fp_prob = 0 => 0.0343578043,
				  fp_prob = 1 => 0.058488228,
				  fp_prob = 2 => 0.081668729,
				  fp_prob = 3 => 0.0957215373,
				  0.0957215373);


	crimlienbk := if(crimlien = 1 or le.bjl.bankrupt, 1, 0);


	/* New Vars Needed */
	dobpop := if(trim(le.shell_input.dob)<>'', 1, 0);
     dobver := map(le.name_verification.dob_score <= 40 => 0,
			    le.name_verification.dob_score=255 => dobpop,
			    1);
	
	today := IF(le.historydate <> 999999, ((STRING)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);


	byr := le.shell_input.dob[1..4];
	bmn := le.shell_input.dob[5..6];
	bdy := le.shell_input.dob[7..8];    	    
	birthdt := if(le.shell_input.dob = '', 0, ut.DaysSince1900(byr, bmn, bdy));
	in_age := if(birthdt = 0, 0, (integer)((today1900 - birthdt)/365.25));
	
	agevar2 := map(in_age < 15 => 25,
				in_age > 50 => 50,
				in_age);


	/* New FCRA Stuff */

	/* Verification */

     ssn_ver := if(le.iid.nas_summary >= 10, 1, 0);

     eda_sourced := le.name_verification.fname_eda_sourced and le.name_verification.lname_eda_sourced;


     sum_ver := ssn_ver + verphn_p + verla_p;


     ver_level_fcra2 := map(best_match_level = 2 and addr2pop = 1 and sum_ver = 3 and eda_sourced => 6,
					   best_match_level = 2 and addr2pop = 1 and sum_ver = 3 and le.name_verification.lname_eda_sourced => 5,
					   best_match_level = 2 and addr2pop = 1 and sum_ver = 3 => 4,
					   best_match_level = 2 and addr2pop = 1 => 4,
					   best_match_level = 2 and addr2pop = 0 and sum_ver = 3 and eda_sourced => 4,
					   best_match_level = 2 and addr2pop = 0 and sum_ver = 3 => 3,
					   best_match_level = 0 and ssn_ver = 0 and eda_sourced => 1,
					   best_match_level = 0 and ssn_ver = 0 => 0,
					   le.name_verification.lname_eda_sourced => 2,
					   1);

     ver_level_fcra2_m := map(ver_level_fcra2 = 0 => 0.1431694,
						ver_level_fcra2 = 1 => 0.0916076,
						ver_level_fcra2 = 2 => 0.0721726,
						ver_level_fcra2 = 3 => 0.0688742,
						ver_level_fcra2 = 4 => 0.0548381,
						ver_level_fcra2 = 5 => 0.0435876,
						0.0410248);
						
						
	/* Header Matrix */


     time_on_header_code2 := map(time_on_header_years <= 5 or time_on_header_years = sysyear => 0,
						   time_on_header_years <= 14 => 1,
						   time_on_header_years <= 17 => 2,
						   3);

     time_since_header_code2 := if(time_since_header_years >= 4, 1, 0);

     header_matrix2 := map(time_on_header_code2 = 0 and time_since_header_code2 = 1 => 0,
					  time_on_header_code2 = 0 => 1,
					  time_on_header_code2 = 1 and time_since_header_code2 = 1 => 1,
					  time_on_header_code2 = 1 => 2,
					  time_on_header_code2 = 2 => 2,
					  time_on_header_code2 = 3 and time_since_header_code2 = 1 => 2,
					  3);


     header_matrix2_m := map(header_matrix2 = 0 => 0.0986452,
					    header_matrix2 = 1 => 0.0736842,
					    header_matrix2 = 2 => 0.0553412,
					    0.0380536);


     cred_fs_pop := if(le.ssn_verification.credit_first_seen = 0, 1, 0);


     prop_tree_credit2_mean := map(prop_tree_credit2 = 0 => 0.0665721,
							prop_tree_credit2 = 1 => 0.0646965,
							prop_tree_credit2 = 2 => 0.0493250,
							0.0431956);



     base := 689;
     odds := 0.06 / 0.94;
     point := -22;

     fcra_mod4 := -3.485019026
                  + fp_prob_m  * 3.6774210912
                  + crimlienbk  * 0.7430915666
                  + mult_adl_credit_count * 0.1886740718
                  + agevar2  * -0.011367554
                  + cred_fs_pop  * -0.567718604 
                  + dobver  * -0.846369972
                  + ver_level_fcra2_m  * 10.414555283
                  + header_matrix2_m  * 9.6085947946
                  + prop_tree_credit2_mean  * 8.3233950915;

     phat := (exp(fcra_mod4)) / (1+exp(fcra_mod4));

     x  := point*(log(phat/(1-phat)) - log(odds))/log(2) + base;

	x2 := 1.342100038 * x - 236.224975733;
	tbd6053 := round(x2);  /* New scaling logic 9-21-06 */
	
	
	// 23 May 2008 override
	rc3  := ('03' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc6  := ('06' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc8  := ('08' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc11 := ('11' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc19 := ('19' in [ le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6 ] );
	rc72 := Risk_Indicators.rcset.isCode72((string)le.iid.socsverlevel, le.shell_input.SSN, le.iid.ssnExists, le.iid.lastssnmatch2);

	nas1 := ( le.iid.nas_summary = 1 );
	not_ver := (le.iid.nap_summary < 4 and le.iid.nas_summary < 4);
	override := (rc19 or not_ver) and ( rc3 or rc6 or rc8 or rc11 or nas1 or rc72 );

	TBD6053a := if( TBD6053 > 640, TBD6053-60, TBD6053 ); // the override score, unbounded
	TBD6053b := if( ~override, TBD6053, // when not overridden, use the already calculated score
			Min( 640, Max( 590, TBD6053a) ) ); // the override score, bound within [590,640]


	TBD605 := map(le.ssn_verification.validation.deceased and TBD6053b > 625 => 625,
				 TBD6053b > 999 => 999,
				 TBD6053b < 300 => 300,
				 TBD6053b);
	


	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
     self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), intformat(tbd605,3,1));
	self.seq := le.seq;
END;
out := project(clam, doModel(left));


// need to project boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
	self := [];
END;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
	self.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif));
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right), left outer);

RETURN (final);

END;
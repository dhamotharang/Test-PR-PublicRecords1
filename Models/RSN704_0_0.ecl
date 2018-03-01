import ut, Risk_Indicators, easi, riskwise, std;

export RSN704_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

temp := record
	Risk_Indicators.Layout_Boca_Shell;
	string1 addr_type_a;
	string1 addr_confidence_a;
end;

temp add_rs(clam le, recoverscore_batchin rt) := TRANSFORM 

	self.addr_type_a := rt.address_type;
	self.addr_confidence_a := rt.address_confidence;
	self := le;
end;

with_rs_batchin := join(clam, recoverscore_batchin, left.seq=right.seq, add_rs(left,right));

Layout_RecoverScore doModel(with_rs_batchin le, easi.Key_Easi_Census rt) := TRANSFORM 

	sysyear := (integer)(((STRING)Std.Date.Today())[1..4]);
	
	addr_type_a := le.addr_type_a;
	addr_confidence_a := le.addr_confidence_a;
	
// ****************************************** Credit Recover Score Logic ******************************************
	best_match_level := map(le.address_verification.input_address_information.isbestmatch => 3,
							le.address_verification.address_history_1.isbestmatch => 2,
							1);
	
	addr_a_level := map(addr_type_a  = 'C' and addr_confidence_a  = 'A' => 4,
						addr_type_a  = 'U' and addr_confidence_a  = 'A' => 3,
						addr_type_a  = 'X' => 2,
						addr_type_a  = 'C' => 1,
						0);
	
	addr_a_level2 := map(addr_a_level  = 4  and best_match_level  = 3 => 8, 
						 addr_a_level  = 3  and best_match_level  = 2 => 7, 
						 addr_a_level  = 2  and best_match_level  = 2 => 7, 
						 addr_a_level  = 3  and best_match_level  = 3 => 6, 
						 addr_a_level  = 1  and best_match_level >= 1 => 5, 
						 addr_a_level  = 4  and best_match_level <= 2 => 4, 
						 addr_a_level  = 0  and best_match_level  = 2 => 3, 
						 addr_a_level  = 0  and best_match_level  = 2 => 3, 
						 addr_a_level  = 0  and best_match_level >= 1 => 2, 
						 addr_a_level  = 2  and best_match_level >= 1 => 1, 
						 addr_a_level  = 3  and best_match_level  = 1 => 1,
						 1);
						 
	nap_level := map(le.iid.nap_summary >= 9 => 3,
				     le.iid.nap_summary >= 7 => 2,
					 1);
	
	nas_address_verified := if(le.iid.nas_summary in [3, 5, 6, 8, 10, 11, 12], 1,0);
	nap_lname_verified := if(le.iid.nap_summary in [5, 7, 8, 9, 11, 12], 1, 0);
	nap_fname_verified := if(le.iid.nap_summary in [3, 4, 8, 9, 10, 12], 1, 0);

	nap_level2 := map(nap_level  = 3 and nap_lname_verified  = 1 => 5, 
					  nap_level  = 3 and nap_lname_verified  = 0 => 4, 
					  nap_level  = 2 and nap_lname_verified >= 0 => 3, 
					  nap_level  = 1 and nap_lname_verified  = 1 => 2, 
					  nap_level  = 1 and nap_lname_verified  = 0 => 1,
					  1);
	nap_level3 := if(nap_level2 = 5 and nap_fname_verified = 1, 6, nap_level2);
	
	nap_nas := map(nap_level3  = 6 and nas_address_verified  = 1 => 7, 
				   nap_level3  = 5 and nas_address_verified  = 1 => 6, 
				   nap_level3  = 4 and nas_address_verified  = 1 => 5, 
				   nap_level3 >= 4 and nas_address_verified  = 0 => 4, 
				   nap_level3  = 3 and nas_address_verified >= 0 => 3, 
				   nap_level3  = 2 and nas_address_verified >= 0 => 2, 
				   nap_level3  = 1 and nas_address_verified >= 0 => 1,
				   1);
	
	disconnect_flag := if(le.phone_verification.disconnected, 1, 0);
	phnzip := if(le.phone_verification.phone_zip_mismatch, 1, 0);

	telcotype := le.phone_verification.telcordia_type;
	pnotpots := if((integer)telcotype in [0,50,51,52,54] and telcotype!='', 0, 1);
	
	hphnpop := if(le.input_validation.homephone,1,0);
	
	phnprob :=  map(hphnpop = 1 and    pnotpots = 0 and    phnzip = 0 and  disconnect_flag = 0 => 0, 
					hphnpop = 1 and    pnotpots = 1 and                    disconnect_flag = 0 => 1, 
					hphnpop = 0 => 2, 
					hphnpop = 1 and    pnotpots = 0 and    phnzip = 1 and  disconnect_flag = 0 => 3,
					4);

	phnprob2 := map(phnprob  = 4 or    trim(le.iid.nap_status) = 'D' => 4, 
					phnprob  = 3 and   trim(le.iid.nap_status) = '' => 3,
					phnprob  < 3 and   trim(le.iid.nap_status) = '' => 2,
					phnprob  > 0 and   trim(le.iid.nap_status) = 'C' => 1,
					0);
  
  	// handle the null values in SAS as -999 in ECL						
	age := if(le.name_verification.age=0 or le.name_verification.age > 100, -999, le.name_verification.age);
	age2 := if(age<>-999, Min(age, 83), 52);
	age2_abs := abs(age2-39);
	
	high_issue_dateyr1 := (integer)(le.ssn_verification.validation.high_issue_date/10000);
	high_issue_dateyr := if(high_issue_dateyr1=0, -999, high_issue_dateyr1);
	
	ssnage_high := if(high_issue_dateyr<>-999, sysyear - high_issue_dateyr, -999);
	agediff_high := if(age<>-999 and ssnage_high<>-999, age - ssnage_high, -999);

	agediff_high_flag := if(agediff_high<>-999 and (agediff_high <= -6 or agediff_high >= 68), 1, 0);
	
	ssninval := if(le.ssn_verification.validation.valid, 0, 1);
	
	ssnprob := map(ssninval  =  0 and agediff_high_flag  =  0 => 0,
				   ssninval  =  1 and agediff_high_flag  =  1 => 1,
				   2);
  
  	lien_hist_un := Min(3, le.bjl.liens_historical_unreleased_count);
	lien_hist_rel := Min(1, le.bjl.liens_historical_released_count);
	
	lienprob := map(lien_hist_un  = 0 and lien_hist_rel  = 0 => 0, 
					lien_hist_un  = 0 and lien_hist_rel  = 1 => 1, 
					lien_hist_un  = 1 => 2, 
					lien_hist_un  = 2 => 3, 
					lien_hist_un  = 3 and lien_hist_rel  = 1 => 4, 
					lien_hist_un  = 3 and lien_hist_rel  = 0 => 5, 
					5);
	
	crimflag := if(le.bjl.criminal_count > 0, 1, 0);
	
	crimlien := map(lienprob  = 0 and crimflag  = 0 => 0, 
					lienprob  = 1 and crimflag  = 0 => 1, 
					lienprob  = 2 and crimflag  = 0 => 2, 
					lienprob  = 0 and crimflag  = 1 => 2, 
					lienprob <= 4 and crimflag  = 0 => 3, 
					lienprob  = 5 and crimflag  = 0 => 4,
					5);
	
	property_owner := if(le.address_verification.owned.property_total > 0, 1,0);
	
	add1_naprop := le.address_verification.input_address_information.naprop;
	add1_isbestmatch := if(le.address_verification.input_address_information.isbestmatch, 1, 0);
	
	add1_naprop_level := map(add1_naprop = 4 and add1_isbestmatch  = 1 => 8, 
							 add1_naprop = 4 and add1_isbestmatch  = 0 => 7, 
							 add1_naprop = 3 and add1_isbestmatch  = 1 => 6, 
							 add1_naprop = 3 and add1_isbestmatch  = 0 => 5, 
							 add1_naprop = 0 and add1_isbestmatch  = 0 => 4, 
							 add1_naprop = 0 and add1_isbestmatch  = 1 => 3, 
							 add1_naprop = 2 and add1_isbestmatch  = 0 => 2, 
							 add1_naprop = 2 and add1_isbestmatch  = 1 => 2, 
							 add1_naprop = 1 and add1_isbestmatch  = 1 => 1,
							 0);
	
	rel_criminal_count_cap3 := Min(le.relatives.relative_criminal_count, 3);

	lname_change_year_s := (string)le.name_verification.lname_change_date;
	yrs_since_lname_change := if(le.name_verification.lname_change_date=0, 7.5, 
									Min(sysyear - (integer)lname_change_year_s[1..4], 11));

	census_missing := if(rt.geolink='', 1, 0);
	
	census_ed := (integer)le.address_verification.input_address_information.census_education;
	add1_census_education := if(census_ed=0, 10, Min(Max(census_ed,9), 17));

	addr_a_level2_l := map(addr_a_level2 = 1 => -4.083171262, 
						   addr_a_level2 = 2 => -3.857595359, 
						   addr_a_level2 = 3 => -3.240637317, 
						   addr_a_level2 = 4 => -3.390888012, 
						   addr_a_level2 = 5 => -3.06475942, 
						   addr_a_level2 = 6 => -3.012261576, 
						   addr_a_level2 = 7 => -2.663668908, 
						   -2.15410307);

	nap_nas_m := map(nap_nas = 1 => 0.0225151016, 
					 nap_nas = 2 => 0.0275862069, 
					 nap_nas = 3 => 0.0360408822, 
					 nap_nas = 4 => 0.0366412214, 
					 nap_nas = 5 => 0.0655737705, 
					 nap_nas = 6 => 0.0735677083, 
					 0.0859348775) ;

	phnprob2_l := map(phnprob2 = 0 =>  -2.784417524, 
					  phnprob2 = 1 =>  -3.4052123, 
					  phnprob2 = 2 =>  -3.715189069, 
					  phnprob2 = 3 =>  -4.343805422, 
					  -5.407171771) ;

	ssnprob_m := map(ssnprob = 0 => 0.0398082745, 
					 ssnprob = 1 => 0.0283018868, 
					 0) ;

	crimlien_m := map(crimlien = 0 => 0.0514531936, 
					  crimlien = 1 => 0.0362694301, 
					  crimlien = 2 => 0.0270445695, 
					  crimlien = 3 => 0.0219378428, 
					  crimlien = 4 => 0.0127737226, 
					  0.0068965517) ;

	add1_naprop_level_l := map(add1_naprop_level = 0 => -3.761200116, 
							   add1_naprop_level = 1 => -3.690729593, 
							   add1_naprop_level = 2 => -3.580737295, 
							   add1_naprop_level = 3 => -3.380737935, 
							   add1_naprop_level = 4 => -3.02665932, 
							   add1_naprop_level = 5 => -2.885308456, 
							   add1_naprop_level = 6 => -2.828052993, 
							   add1_naprop_level = 7 => -2.789937361, 
							   -2.496681386) ;
	
	c_no_move := if ( (integer)rt.no_move < 0 or rt.no_move = '', 77.9192500, (real)rt.no_move);
	c_span_lang := if ( (integer)rt.span_lang < 0 or rt.span_lang = '', 123.0572000, (real)rt.span_lang);
	
	C_HVAL_100K_C1 := (real)rt.HVAL_20K_P + (real)rt.HVAL_40K_P + (real)rt.HVAL_60K_P + (real)rt.HVAL_80K_P + (real)rt.HVAL_100K_P;
	C_HVAL_100K_C2 := if((integer)rt.HVAL_20K_P < 0 or 
					   (integer)rt.HVAL_40K_P < 0 or
					   (integer)rt.HVAL_60K_P < 0 or
					   (integer)rt.HVAL_80K_P < 0 or
					   (integer)rt.HVAL_100K_P < 0 or
					   census_missing = 1, -999, if(c_hval_100k_c1 > 100, 100, c_hval_100k_c1));

	C_HVAL_100K_C := if ( C_HVAL_100K_C2 = -999, 51.5921876, C_HVAL_100K_C2);
	
	recover_cred1 := -4.282315996
                  + census_missing  * -0.679740359
                  + age2_abs  * 0.0184172604
                  + property_owner  * 0.3909909482
                  + add1_census_education  * 0.0675937091
                  + rel_criminal_count_cap3  * -0.239126047
                  + yrs_since_lname_change  * 0.0489507143
                  + addr_a_level2_l  * 0.4975276785
                  + nap_nas_m  * 10.895960167
                  + phnprob2_l  * 0.4080275614
                  + ssnprob_m  * 70.197871666
                  + crimlien_m  * 28.552083435
                  + add1_naprop_level_l  * 0.4121258545
                  + C_NO_MOVE  * 0.0025673907
                  + C_SPAN_LANG  * -0.004227786
                  + C_HVAL_100K_C  * -0.006336823;

	phat := (exp(recover_cred1)) / (1+exp(recover_cred1));

	base  := 700;
	odds  := .04 / .96;
	point :=  50;

	recover_cred2 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	recover_cred := Min(Max(recover_cred2, 250), 999);

	
	SELF.recover_score := intformat(recover_cred,3,1);
	SELF.bankcard_recover_score := intformat(recover_cred,3,1);

	SELF.seq := (string)le.seq;
END;

scores := join(with_rs_batchin, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

// RETURN (scores);
indices := RecoverScore_Collection_Indices( clam, recoverscore_batchin );

layout_recoverscore doIndices( scores le, indices ri ) := TRANSFORM
	SELF.address_index          := ri.address_index;
	SELF.telephone_index        := ri.telephone_index;
	SELF.contactability_score   := ri.contactability_score;
	SELF.asset_index            := ri.asset_index;
	SELF.lifecycle_stress_index := ri.lifecycle_stress_index;
	SELF.liquidity_score        := ri.liquidity_score;
	self := le;
END;

withIndices := join( scores, indices, left.seq=right.seq, doIndices(left,right));    
RETURN (withIndices);
END;
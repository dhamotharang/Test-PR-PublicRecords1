import ut, Risk_Indicators, RiskWise, easi;

export RSN704_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

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
 
	sysyear := (integer)(ut.GetDate[1..4]);
	SELF.seq := (string)le.seq;
	
	addr_type_a := le.addr_type_a;
	addr_confidence_a := le.addr_confidence_a;
	
/* DEFINE THE FOLLOWING VARIABLES */
	addr_a_level := map(addr_type_a  = 'C' and addr_confidence_a  = 'A' => 5,
						addr_type_a  = 'C' and addr_confidence_a  = 'B' => 4,
						addr_type_a  = 'U' and addr_confidence_a  = 'A' => 3,
						addr_type_a  = 'X' => 2,
						1);

	nas_zero := if(le.iid.nas_summary = 0, 1, 0);
	nas_bad := if(le.iid.nas_summary = 1 , 1, 0);
	nas_address_verified := if(le.iid.nas_summary in [3, 5, 6, 8, 10, 11, 12], 1, 0);
	nap_lname_verified := if(le.iid.nap_summary in [5, 7, 8, 9, 11, 12], 1, 0);
	nap_phone_verified := if(le.iid.nap_summary in [4, 6, 7, 9, 10, 11, 12], 1, 0);

	hphnpop := if(le.input_validation.homephone,1,0);
	nap_level := map(le.iid.nap_summary >= 9 and hphnpop >= 0 => 5,
						le.iid.nap_summary >=  7 and hphnpop  = 1 => 4,
						le.iid.nap_summary >=  7 and hphnpop  = 0 => 3,
						le.iid.nap_summary >=  0 and hphnpop  = 1 => 2,
						1);

	nap_level2 := map(nap_level = 5 and nap_lname_verified  = 1 => 4,
						nap_level >= 2 and nap_lname_verified  = 1 => 3,
						nap_level = 1 and nap_lname_verified  = 1 => 2,
						1);
	
	nap_level3 := map(nap_level2 = 4 and nap_phone_verified >= 0 => 5,
						nap_level2 = 3 and nap_phone_verified  = 1 => 4,
						nap_level2 = 3 and nap_phone_verified  = 0 => 3,
						nap_level2 = 2 and nap_phone_verified >= 0 => 2,
						1);

	nap_level4 := map(nap_level3 >= 4 => nap_level3,
						nap_level3 = 3 and hphnpop  = 1 => 3,
						nap_level3 = 3 and hphnpop  = 0 => 2,
						nap_level3 = 2 and hphnpop >= 0 => 2,
						1);
	nap_nas_level := if(nas_zero = 1 or nas_bad = 1, 0, nap_level4);

	nap_nas_level2 := map(nap_nas_level = 0 => 0, 
							nap_nas_level = 1 and nas_address_verified = 0 => 1,
							nap_nas_level + 2);
							
	// handle the null values in SAS as -999 in ECL						
	today := if(le.historyDate = 999999, ut.GetDate, (string)le.historyDate);
	archive_year := (integer)today[1..4];
	dob_year := (integer)le.shell_input.dob[1..4];
	input_age1 := archive_year - dob_year;
	input_age := if(input_age1 < 0 or input_age1 > 100, -999, input_age1);
	
	age := if(le.name_verification.age=0 or le.name_verification.age > 100, -999, le.name_verification.age);
	age_cbe := if(age = -999 and input_age <> -999, input_age, age);
	
	high_issue_dateyr1 := (integer)(le.ssn_verification.validation.high_issue_date/10000);
	high_issue_dateyr := if(high_issue_dateyr1=0, -999, high_issue_dateyr1);
	
	ssnage_high := archive_year - high_issue_dateyr;

	ssnage_high_level := map(high_issue_dateyr < 0 => 0,
							ssnage_high <= 6 => 2,
							ssnage_high <= 17 => 1,
							0);
							
	agediff_input := if(age <> -999 and input_age <> -999, ut.iMin2(ut.max2(age-input_age, -5), 2), -999);

	agediff_input_level := map(agediff_input = -5 => 3,
								agediff_input = 2 => 2,
								1);
								
	agediff_high := age_cbe - ssnage_high;
	
	agediff_high2 := if(age_cbe <> -999 and ssnage_high <> -999, ut.iMin2(ut.max2(agediff_high, -10), 30), -999);
	
	agediff_high_flag := if(agediff_high2 >= 30, 1, 0);
	
	ssnprob := map(ssnage_high_level  =  0 and agediff_high_flag  =  0 => 0,
					ssnage_high_level  =  0 and agediff_high_flag  =  1 => 1,
					ssnage_high_level  =  1 and agediff_high_flag  =  0 => 2,
					ssnage_high_level  =  2 and agediff_high_flag  =  0 => 3,
					ssnage_high_level  =  1 and agediff_high_flag  =  1 => 4,
					5);

	ssnprob2 := map(ssnprob  =  0 and agediff_input_level  =  1 => 0,
					ssnprob <=  2 and agediff_input_level <=  2 => 1,
					ssnprob  =  3 and agediff_input_level <=  2 => 2,
					ssnprob  =  4 and agediff_input_level <=  2 => 3,
					ssnprob  =  5 and agediff_input_level <=  2 => 4,
					5);
	
	bk_year := (integer)le.bjl.date_last_seen[1..4];
	bk_discharged := if(stringlib.stringfind(Stringlib.StringToUpperCase(le.bjl.disposition), 'DISCHARGE', 1) > 0, 1, 0);
	
	lien_recent_un := ut.imin2(2, le.bjl.liens_recent_unreleased_count);
	lien_hist_un := ut.imin2(2, le.bjl.liens_historical_unreleased_count);
	
	lien_level := map(lien_recent_un  =  0 and lien_hist_un  =  0 => 0,
						lien_recent_un >=  0 and lien_hist_un <=  1 => 1,
						lien_recent_un  =  0 and lien_hist_un  =  2 => 1,
						2);
	
	criminal_count_cbe := ut.imin2(le.bjl.criminal_count, 3);
	
	crimlien := map(lien_level  =  0 and criminal_count_cbe  =  0 => 0,
					lien_level  =  1 and criminal_count_cbe  =  0 => 1,
					lien_level  =  0 and criminal_count_cbe  =  1 => 1,
					lien_level  =  2 and criminal_count_cbe  =  0 => 2,
					lien_level  =  0 and criminal_count_cbe  =  2 => 2,
					3);
					
	property_owned_level := map(le.address_verification.owned.property_total  =  0 => 0,
								le.address_verification.owned.property_total <=  3 => 1,
								2);
	
	add1_naprop_level := map(le.address_verification.input_address_information.naprop >= 3 => 3,
							  le.address_verification.input_address_information.naprop = 0 => 2,
							  1);
	
	add1_naprop_level2 := map(add1_naprop_level <=  2 and property_owned_level  =  0 => 0,
							add1_naprop_level  =  3 and property_owned_level  =  0 => 1,
							add1_naprop_level <=  2 and property_owned_level  =  1 => 1,
							add1_naprop_level  =  1 and property_owned_level  =  2 => 1,
							add1_naprop_level  =  3 and property_owned_level  =  1 => 2,
							3);

	
	rel_ind := if(le.relatives.relative_count > 0, 1, 0);
	rel_criminal_count_cbe2 := ut.imin2(le.relatives.relative_criminal_count, 2);
	rel_prop_owned_count_cbe := ut.imin2(le.relatives.owned.relatives_property_count, 1);
	
	rel_level := map(rel_ind  =  0 and rel_prop_owned_count_cbe >=  0 and rel_criminal_count_cbe2 >=  0 => 0,
					 rel_ind  =  1 and rel_prop_owned_count_cbe  =  0 and rel_criminal_count_cbe2 >=  0 => 1,
					 rel_ind  =  1 and rel_prop_owned_count_cbe  =  1 and rel_criminal_count_cbe2  =  2 => 2,
					 rel_ind  =  1 and rel_prop_owned_count_cbe  =  1 and rel_criminal_count_cbe2  =  1 => 3,
					 4);
					 
	rel_educ := map(le.relatives.relative_educationover12_count > 0 => 13,
					le.relatives.relative_educationunder12_count > 0 => 12,
					le.relatives.relative_educationunder8_count > 0 => 8,
					-999);
					
	rel_educ_level := map(rel_educ = -999 => 0,
						  rel_educ <= 12 => 1,
						  2);

	rel_level2 := map(rel_level  =  0 and rel_educ_level >=  0 => 0,
					  rel_level  =  1 and rel_educ_level <=  1 => 1,
					  rel_level  =  2 and rel_educ_level <=  1 => 2,
					  rel_level <=  2 and rel_educ_level  =  2 => 3,
					  rel_level  =  3 and rel_educ_level >=  0 => 4,
					  rel_level  =  4 and rel_educ_level <=  1 => 4,
					  5);
	lncd := le.name_verification.lname_change_date;				  
	yrs_since_lname_change := if(lncd = 0, -999, ut.imin2(11, archive_year-(integer)lncd[1..4]));
	
	lnpcd := le.name_verification.lname_prev_change_date;				  
	yrs_since_prev_lname_change := if(lnpcd = 0, -999, ut.imin2(10, archive_year-(integer)lnpcd[1..4]));
	
	lname_change_ind := if(yrs_since_lname_change <> -999, 1, 0);
	prev_lname_change_ind := if(yrs_since_prev_lname_change <> -999, 1, 0);
	
	lname_change_level := map(lname_change_ind  =  0 and prev_lname_change_ind  =  0 => 0,
							  lname_change_ind  =  1 and prev_lname_change_ind  =  0 => 1,
							  2);


/* *********************************  logic:  mean substitutions  **************************************************************/
	addr_a_level_m := map(addr_a_level = 1 => 0.0753608593,
						  addr_a_level = 2 => 0.0896226415,
						  addr_a_level = 3 => 0.1053105311,
						  addr_a_level = 4 => 0.1068773234,
						  0.138534279) ;

	nap_nas_level2_l := map(nap_nas_level2 = 0 => -2.901421594,
						   nap_nas_level2 = 1 => -2.683757509,
						   nap_nas_level2 = 3 => -2.378306333,
						   nap_nas_level2 = 4 => -2.308052575,
						   nap_nas_level2 = 5 => -2.193418674,
						   nap_nas_level2 = 6 => -2.072061434,
						   -1.937857765) ;

	ssnprob2_l := map(ssnprob2 = 0 => -2.143060523,
						ssnprob2 = 1 => -2.386276046,
						ssnprob2 = 2 => -2.595254707,
						ssnprob2 = 3 => -2.669210368,
						ssnprob2 = 4 => -2.789490533,
						-3.412247218) ;

	crimlien_m := map(crimlien = 0 => 0.107568597,
					  crimlien = 1 => 0.0924488356,
					  crimlien = 2 => 0.0696661829,
					  0.0596727623) ;

	add1_naprop_level2_m := map(add1_naprop_level2 = 0 => 0.0871015893,
								add1_naprop_level2 = 1 => 0.1101995565,
								add1_naprop_level2 = 2 => 0.1245725452,
								0.1779141104) ;

	rel_level2_l := map(rel_level2 = 0 => -2.626277603,
						rel_level2 = 1 => -2.515855503,
						rel_level2 = 2 => -2.466214517,
						rel_level2 = 3 => -2.289961581,
						rel_level2 = 4 => -2.219150589,
						-2.01437438) ;

	lname_change_level_m := map(lname_change_level = 0 => 0.1049775449,
								lname_change_level = 1 => 0.0848501071,
								0.0721649485) ;	
								
/* *********************************  logic:  census recodes  **********************************************/

	census_missing := if(rt.geolink='', 1, 0);
	C_HVAL_80K_C1 := (real)rt.HVAL_20K_P + (real)rt.HVAL_40K_P + (real)rt.HVAL_60K_P + (real)rt.HVAL_80K_P;

	C_HVAL_80K_C2 := if((integer)rt.HVAL_20K_P < 0 or 
					   (integer)rt.HVAL_40K_P < 0 or
					   (integer)rt.HVAL_60K_P < 0 or
					   (integer)rt.HVAL_80K_P < 0 or
					   (integer)rt.HVAL_100K_P < 0 or
					   (integer)rt.HVAL_125K_P < 0 or
					   (integer)rt.HVAL_150K_P < 0 or
					   (integer)rt.HVAL_175K_P < 0 or
					   (integer)rt.HVAL_200K_P < 0 or
					   (integer)rt.HVAL_250K_P < 0 or
					   (integer)rt.HVAL_300K_P < 0 or
					   (integer)rt.HVAL_400K_P < 0 or
					   (integer)rt.HVAL_500K_P < 0 or
					   (integer)rt.HVAL_750K_P < 0 or
					   (integer)rt.HVAL_1000K_P < 0 or
					   (integer)rt.HVAL_1001K_P < 0 or
					   census_missing = 1, -999, if(c_hval_80k_c1 > 100, 100, c_hval_80k_c1));

	c_housingcpi := if ( (integer)rt.HOUSINGCPI < 0 or rt.HOUSINGCPI = '', 190.9877097, (real)rt.housingcpi);
	c_CONSTRUCTION := if ( (integer)rt.CONSTRUCTION < 0 or rt.CONSTRUCTION = '', 6.6572222, (real)rt.CONSTRUCTION);
	c_mort_indx := if ( (integer)rt.mort_indx < 0 or rt.mort_indx = '', 87.6622250, (real)rt.mort_indx);
	c_for_sale := if ( (integer)rt.for_sale < 0 or rt.for_sale = '', 100.7306265, (real)rt.for_sale);
	c_sub_bus := if ( (integer)rt.sub_bus < 0 or rt.sub_bus = '', 106.5299159, (real)rt.sub_bus);
	c_rich_fam := if ( (integer)rt.rich_fam < 0 or rt.rich_fam = '', 100.3629095, (real)rt.rich_fam);
	c_span_lang := if ( (integer)rt.span_lang < 0 or rt.span_lang = '', 121.9932591, (real)rt.span_lang);
	C_HVAL_80K_C := if ( C_HVAL_80K_C2 = -999, 38.8724277, C_HVAL_80K_C2);
//

	rsn704_1 := -2.391051278
					  + census_missing  * 0.2744676964
					  + C_HOUSINGCPI  * 0.0075537121
					  + C_CONSTRUCTION  * 0.0019942247
					  + C_MORT_INDX  * 0.0006666344
					  + C_FOR_SALE  * 0.001200991
					  + C_SUB_BUS  * -0.001428629
					  + C_RICH_FAM  * 0.0007984839
					  + C_SPAN_LANG  * -0.002121788
					  + C_HVAL_80K_C  * -0.001883857
					  + addr_a_level_m  * 6.9175904384
					  + nap_nas_level2_l  * 0.5640468495
					  + ssnprob2_l  * 0.7086167076
					  + crimlien_m  * 11.341476689
					  + add1_naprop_level2_m  * 4.9144563526
					  + rel_level2_l  * 0.5121705812
					  + lname_change_level_m  * 4.7748231963;

	phat := (exp(rsn704_1)) / (1+exp(rsn704_1));

	base  := 700;
	odds  := .04 / .96;
	point :=  50;

	rsn704 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	
	self.recover_score := map(rsn704 >= 999 => '999',
							  rsn704 <= 250 => '250',
							  (string)rsn704);			  

	self := [];
END;

scores := join(with_rs_batchin, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

// return scores;
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


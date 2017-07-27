import ut, Risk_Indicators, RiskWise, easi;

export RSN607_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

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

	SELF.seq := (string)le.seq;
	
	addr_type_a := le.addr_type_a;
	addr_confidence_a := le.addr_confidence_a;
	
/* DEFINE THE FOLLOWING VARIABLES */
	addr_a_level := map(addr_type_a  = 'C' and addr_confidence_a  = 'A' => 0,
						addr_type_a  = 'C' => 1,
						addr_type_a  = 'U' and addr_confidence_a  = 'B' => 2,
						addr_type_a  = 'U' => 3,
						addr_type_a  = 'X' => 4,
						4);
						
						
	nas_summary_doe := map(le.iid.nas_summary >= 10 => 12,
						   le.iid.nas_summary > 1 => 8,
						   le.iid.nas_summary >= 0 => 0,
						   le.iid.nas_summary);
						   
	nap_lname_verified := if(le.iid.nap_summary in [5, 7, 8, 9, 11, 12], 1, 0);
	
	nap_nas := map(le.iid.nap_summary >= 11 and nas_summary_doe  = 12 => 1, 
					le.iid.nap_summary >= 11 and nas_summary_doe  < 12 => 2, 
					le.iid.nap_summary >=  3 and nas_summary_doe  = 12 => 3, 
					le.iid.nap_summary  =  0 and nas_summary_doe  = 12 => 4, 
					le.iid.nap_summary >=  3 and nas_summary_doe  < 12 => 5, 
					le.iid.nap_summary  =  1 and nas_summary_doe  = 12 => 6, 
					le.iid.nap_summary <=  1 and nas_summary_doe  < 12 => 7,
					7);
	
	nap_nas2 := map(nap_nas  = 1 and nap_lname_verified  = 1 => 1, 
					nap_nas <= 3 and nap_lname_verified  = 1 => 2, 
					nap_nas  = 5 and nap_lname_verified  = 1 => 3, 
					nap_nas  = 4 and nap_lname_verified  = 0 => 4, 
					nap_nas  = 3 and nap_lname_verified  = 0 => 5,
					nap_nas + 1);
					
	add2_source_count_doe := ut.imin2(le.address_verification.address_history_1.source_count, 5);


	add1_source_count_doe := map(le.address_verification.input_address_information.source_count = 0 => 0,
								 le.address_verification.input_address_information.source_count < 4 => 1,
								 2);
	
	source_count_level := map(add1_source_count_doe  = 0 and add2_source_count_doe >= 0 => 1, 
							  add1_source_count_doe  = 1 and add2_source_count_doe <= 1 => 1, 
							  add1_source_count_doe  = 2 and add2_source_count_doe  = 0 => 1, 
							  add1_source_count_doe  = 1 and add2_source_count_doe <= 4 => 2, 
							  add1_source_count_doe  = 2 and add2_source_count_doe <= 2 => 2,
							  3);

	nap_nas2_source := map(nap_nas2 <= 2 and source_count_level  = 3 => 1, 
						   nap_nas2  = 1 and source_count_level  = 2 => 2, 
						   nap_nas2  = 1 and source_count_level  = 1 => 3, 
						   nap_nas2  = 2 and source_count_level  = 2 => 3, 
						   nap_nas2 >= 3 and source_count_level  = 3 => 4, 
						   nap_nas2 <= 3 and source_count_level >= 1 => 4, 
						   nap_nas2 <= 5 and source_count_level >= 1 => 4, 
						   nap_nas2 <= 7 and source_count_level >= 1 => 5, 
						   nap_nas2  = 8 and source_count_level >= 1 => 6,
						   4); // most frequent, made 4 the default else case, even though the else case should never be hit
						   
	
	phnzip := if(le.phone_verification.phone_zip_mismatch, 1, 0);

	telcotype := le.phone_verification.telcordia_type;
	pnotpots := if((integer)telcotype in [0,50,51,52,54] and telcotype!='', 0, 1);
	
	hphnpop := if(le.input_validation.homephone,1,0);
	phnprob := map(hphnpop = 1 and pnotpots = 0 and phnzip = 0 => 1,
				   hphnpop = 0 => 2,
				   hphnpop = 1 and (pnotpots = 1 or phnzip = 1) => 3,
				   3); // picked 3 as the default case, since it wasn't provided in the SAS code

	
	// handle the null values in SAS as -999 in ECL						
	today := if(le.historydate = 999999, ut.GetDate, (string)le.historydate);
	archive_year := (integer)today[1..4];
	dob_year := (integer)le.shell_input.dob[1..4];
	age := if(le.name_verification.age=0, -999, le.name_verification.age);
	
	input_age1 := if(le.shell_input.dob<>'', archive_year - dob_year, -999);
	input_age := map(input_age1<> -999 => ut.imin2(ut.max2(input_age1,21), 76),
					 age<> -999 => ut.imin2(ut.max2(age,21), 76),
					 35);
	
	bk_discharged := if(stringlib.stringfind(Stringlib.StringToUpperCase(le.bjl.disposition), 'DISCHARGE', 1) > 0, 1, 0);

	
	add1_year_first_seen1 := (integer)(le.address_verification.input_address_information.date_first_seen/100);
	add1_year_first_seen := if(add1_year_first_seen1 < 1900, -999, add1_year_first_seen1);
	
	lres_years := if(add1_year_first_seen <> -999, ut.imin2(archive_year - add1_year_first_seen, 20), -999);
	
	lres_code := map(lres_years = -999 => 2,
					 lres_years <= 3 => 0,
					 lres_years <= 7 => 1,
					 lres_years <= 15 => 3,
					 4);
	
	rel_prop_owned_count := ut.imin2(le.relatives.owned.relatives_property_count, 99); 
		
	rel_home_val := map( le.relatives.relative_homeover500_count   > 0 => 200 , 
						 le.relatives.relative_homeunder500_count  > 0 => 200 , 
						 le.relatives.relative_homeunder300_count  > 0 => 200 , 
						 le.relatives.relative_homeunder200_count  > 0 => 200 , 
						 le.relatives.relative_homeunder150_count  > 0 => 150 , 
						 le.relatives.relative_homeunder100_count  > 0 => 100 , 
						 le.relatives.relative_homeunder50_count   > 0 => 50 ,
						 10) ;
	rel_home_val_c := ut.imin2(rel_home_val, 100);
		
	addr_a_level_m := map(addr_a_level = 0 => 0.279650437 , 
						  addr_a_level = 1 => 0.233672858 , 
						  addr_a_level = 2 => 0.1820029028 , 
						  addr_a_level = 3 => 0.1805555556 , 
						  0.0869565217) ;

	nap_nas2_source_m := map(nap_nas2_source = 1 => 0.2975609756 , 
							 nap_nas2_source = 2 => 0.2749326146 , 
							 nap_nas2_source = 3 => 0.2365448505 , 
							 nap_nas2_source = 4 => 0.1910195981 , 
							 nap_nas2_source = 5 => 0.1299734748 , 
							 0.1042944785);

	lres_code_m := map(lres_code = 0 => 0.2621219395 , 
						lres_code = 1 => 0.2092320966 , 
						lres_code = 2 => 0.1961367013 , 
						lres_code = 3 => 0.1897926635 , 
						0.1758893281) ;


	rel_home_val_c_m := map(rel_home_val_c = 10 => 0.1307420495 , 
						  rel_home_val_c = 50 => 0.1448516579 , 
						  0.2219097173) ;
	
	
	C_CIV_EMP := if ( (integer)rt.CIV_EMP < 0 or rt.CIV_EMP = '', 59.0310018, (real)rt.CIV_EMP);
	C_ROBBERY := if ( (integer)rt.ROBBERY < 0 or rt.ROBBERY = '', 115.2675054, (real)rt.ROBBERY);
	C_CPIALL := if ( (integer)rt.CPIALL < 0 or rt.CPIALL = '', 189.9776323, (real)rt.CPIALL);
	C_ARMFORCE := if ( (integer)rt.ARMFORCE < 0 or rt.ARMFORCE = '', 104.0869341, (real)rt.ARMFORCE);
					
					
	rsn607_0a := -5.212180659
                  + phnprob  * -0.142342306
                  + input_age  * -0.04538959
                  + bk_discharged  * 0.5373102669
                  + addr_a_level_m  * 5.248301467
                  + nap_nas2_source_m  * 3.9493302766
                  + lres_code_m  * 2.9619810075
                  + rel_prop_owned_count  * 0.0251522764
                  + rel_home_val_c_m  * 4.1552391881
                  + C_CIV_EMP  * 0.0102647199
                  + C_ROBBERY  * -0.001043785
                  + C_CPIALL  * 0.0087458373
                  + C_ARMFORCE  * 0.001962226;


	rsn607_0b := (exp(rsn607_0a)) / (1+exp(rsn607_0a));

     base  :=   700;
     odds  := .17647;
     point :=    40;

	rsn607_0c := ut.imin2(ut.max2((integer)(point*(log(rsn607_0b/(1-rsn607_0b)) - log(odds))/log(2) + base), 250), 999);
	
	self.recover_score := (string)rsn607_0c;	  
							  		  
	self := [];
END;

scores := join(with_rs_batchin, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

// RETURN (scores);

indices := RecoverScore_Collection_Indices( clam, recoverscore_batchin);

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


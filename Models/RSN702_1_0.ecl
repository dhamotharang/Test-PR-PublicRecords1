import ut, Risk_Indicators, easi, riskwise;
// custom recover score for premiere credit
export RSN702_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

temp := record
	Risk_Indicators.Layout_Boca_Shell;
	string easi_low_ed;
end;

temp add_easi(clam le, easi.Key_Easi_Census rt) := transform
	self.easi_low_ed := rt.low_ed;
	self := le;
end;

with_easi := join(clam, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				add_easi(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

Layout_RecoverScore doModel(with_easi le, recoverscore_batchin rt) := TRANSFORM 

	SELF.seq := (string)le.seq;
	
	addr_type_a := rt.address_type;
	addr_confidence_a := rt.address_confidence;
	
	/* DEFINE THE FOLLOWING VARIABLES */
	current_count2 := if(le.vehicles.current_count > 2, 2, le.vehicles.current_count);
	criminal_count2 := if(le.bjl.criminal_count > 1, 1, le.bjl.criminal_count);
	confirmed := trim(StringLib.StringToUpperCase(addr_type_a)) = 'C';
	confidence_a := trim(StringLib.StringToUpperCase(addr_confidence_a)) = 'A';
	
	sc_verx_m := map(confirmed and confidence_a => 0.2809,
					 confirmed and ~confidence_a => 0.2008,
					 ~confirmed => 0.1006,
					 0.1504);
	
	pobox := if(le.address_validation.dwelling_type='E' or le.address_validation.zip_type='1', 1, 0);
	
	addrprob_m := map(~le.address_validation.usps_deliverable => 6.12,
					  pobox=1 => 6.12,
					  le.address_validation.dwelling_type='R' => 6.12,
					  17.22);
	
	
	liens_recent_unreleased_ind := le.bjl.liens_recent_unreleased_count >= 1;
	
	prop_derog_level_m := map(liens_recent_unreleased_ind and criminal_count2 = 0 => 34.39,
								liens_recent_unreleased_ind and criminal_count2 = 1 => 15.49,
								le.address_verification.owned.property_owned_purchase_count = 0 => 10.52,
								le.address_verification.owned.property_owned_purchase_count = 1 => 5.24,
								1.10);
								
	
	rel_within100miles_ind := le.relatives.relative_within100miles_count >= 1;
	rel_within500miles_ind := le.relatives.relative_within500miles_count >= 1;
	rel_withinother_ind := le.relatives.relative_withinother_count >= 1;
	
	rel_26plus := map(rel_within100miles_ind or rel_within500miles_ind => 2,
					  rel_withinother_ind => 1,
					  0);
	
	rel_distance_m := map(rel_26plus = 0 => 8.05,
						  rel_26plus = 1 and le.relatives.relative_within25miles_count <= 1 => 8.05,
						  rel_26plus = 1 and le.relatives.relative_within25miles_count <= 4 => 12.99,
						  rel_26plus = 2 and le.relatives.relative_within25miles_count <= 3 => 12.99,
						  24.14);
						  
	
	c_low_ed := if(le.easi_low_ed in ['','-1'], 44.56, (real)le.easi_low_ed);
	C_LOW_ED2 := if(c_low_ed > 75.00, 75.00, c_low_ed);
	
	/*  CALCULATE SCORE */
	outest1 := -6.064118966
			  + C_LOW_ED2  * 0.0099526663
			  + addrprob_m  * 0.0794409107
			  + criminal_count2  * 0.072333416
			  + current_count2  * -1.154694599
			  + prop_derog_level_m  * 0.0587206704
			  + rel_distance_m  * 0.059133084
			  + sc_verx_m  * 5.0773908599;

	outest := (exp(outest1 )) / (1+exp(outest1 ));   

	base  := 700;
	odds  := .126 / .874;
	point := 50;

	phat := outest;

	RSN702_1 := (integer)( (point*(log(phat/(1-phat)) - log(odds))/log(2) + base) );	
	
	self.recover_score := map(RSN702_1 >= 999 => '999',
							  RSN702_1 <= 250 => '250',
							  (string)RSN702_1);
							  
	self := [];
END;

scores := join(with_easi, recoverscore_batchin, left.seq=right.seq, doModel(LEFT, right));

RETURN (scores);

END;
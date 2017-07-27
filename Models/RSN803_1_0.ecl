import ut, Risk_Indicators, RiskWise, easi;

export RSN803_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

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
			
	sysyear := (integer)(ut.GetDate[1..4]);
		
	Layout_RecoverScore doModel(with_rs_batchin le, easi.Key_Easi_Census ri) := TRANSFORM 
		// fields from surecontact
		addr_type_a := le.addr_type_a;
		addr_confidence_a := le.addr_confidence_a;
	 
		/************************************************************************************/
		/* Fields from Modeling Shell                                                       */
		/************************************************************************************/
 
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		cvi                             :=  le.iid.CVI;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_phonevalflag                 :=  le.iid.phonevalflag;
		rc_hriskaddrflag                :=  (INTEGER)le.iid.hriskaddrflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_addrvalflag                  :=  le.iid.addrvalflag;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		property_owned_total            :=  le.address_verification.owned.property_total;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count     :=  le.bjl.liens_recent_released_count;
		criminal_count                  :=  le.bjl.criminal_count;
		rel_count                       :=  le.relatives.relative_count;
		rel_criminal_count              :=  le.relatives.relative_criminal_count;
		rel_incomeunder25_count         :=  le.relatives.relative_incomeUnder25_count;
		watercraft_count                :=  le.watercraft.watercraft_count;
		wealth_index                    :=  le.wealth_indicator;

		/************************************************************************************/
		/* Fields from Census		                                                       */
		/************************************************************************************/

		c_fammar_p                      := ri.fammar_p;
		c_mil_emp                       := ri.mil_emp;



		/************************************************************************************/
		/* Code Starts Here                                                                 */
		/************************************************************************************/
		/* HELPERS */
		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		add1_prop_ver := map( 
			add1_naprop = 4 => 9,
			add1_naprop = 3 => 7,
			add1_naprop = 0 and property_owned_total > 0 => 5,
			3
		);

		liens_hist_unr_ct_3 := mymin(liens_historical_unreleased_ct,3);

		sc_addr_x := map( 
			addr_type_a = 'C' and addr_confidence_a = 'A' => 7,
			addr_type_a = 'C' or addr_confidence_a = 'A' => 5,
			addr_type_a = 'X' => 3,
			1
		);

		addr_prob := map( 
			rc_hriskaddrflag != 0 and rc_addrvalflag != 'V' => 7,
			rc_addrvalflag != 'V' => 5,
			rc_dwelltype != '' => 5,
			3
		);

		phn_prob := map( 
			hphnpop = 0 => 9,
			(INTEGER)rc_hriskphoneflag not in [0,1] => 11,
			(INTEGER)rc_phonevalflag = 1 => 1,
			(INTEGER)rc_phonevalflag = 2 => 5,
			7
		);

		wealth_index_a    := mymin((INTEGER)wealth_index,3);
		rel_criminal_ct_3 := mymin(rel_criminal_count,3);
		criminal_f        := (criminal_count>0);
		liens_recent_released_ct_f := (liens_recent_released_count > 0);
	
		rel_under25k_p_a := map(
			rel_count = 0 => 40,
			mymax((INTEGER)((rel_incomeunder25_count / rel_count)*100),30)
		);
		rel_under25k_p := if( rel_under25k_p_a=100, 50, rel_under25k_p_a );

	
		c_fammar_p_a_a   := mymax(mymin((INTEGER)c_fammar_p,100),0);
		c_fammar_p_a     := if((INTEGER)c_fammar_p in [-1,0], 100, c_fammar_p_a_a );
		c_fammar_p_calc  := (0.07384 + 0.00207*c_fammar_p_a);
		c_mil_emp_b      := mymax(mymin((INTEGER)c_mil_emp,25),0);
		own_watercraft_f := (watercraft_count > 0);
		ssnpop           := ((INTEGER)rc_decsflag != 2);
		
		verx := if( (INTEGER)ssnpop=0,
			map( 
				nas_summary = 8 and nap_summary = 12 => 5,
				nas_summary = 8 and nap_summary = 11 => 4,
				nas_summary = 8 and nap_summary in [2,3,4,5,6,7,8,9,10] => 3,
				nas_summary = 8 => 2,
				1
			),
			map( 
				nas_summary = 12 and nap_summary = 12 => 10,
				nas_summary = 12 and nap_summary = 11 => 9,
				nas_summary = 12 and nap_summary in [2,3,4,5,6,7,8,9,10] => 7,
				nas_summary = 12 => 6,
				8
			)
		);

		cvi_a := map(
			cvi=50 => 5,
			cvi=40 => 3,
			1
		);

		/*** MEAN SUBSTITUTION ***/

		add1_prop_ver_m := map( 
			add1_prop_ver = 3 => 0.2001878341,
			add1_prop_ver = 5 => 0.2364485981,
			add1_prop_ver = 7 => 0.2442094663,
			0.3008264463
		);

		liens_hist_unr_ct_3_m := map( 
			liens_hist_unr_ct_3 = 0 => 0.2319955639,
			liens_hist_unr_ct_3 = 1 => 0.1930184805,
			liens_hist_unr_ct_3 = 2 => 0.1803127875,
			0.1636230825
		);

		sc_addr_x_m := map( 
			sc_addr_x = 1 => 0.194656012,
			sc_addr_x = 3 => 0.2147806005,
			sc_addr_x = 5 => 0.2305693362,
			0.3186318632
		);

		addr_prob_m := map( 
			addr_prob = 3 => 0.2317652136,
			addr_prob = 5 => 0.1946161515,
			0.0972568579
		);

		phn_prob_m := map( 
			phn_prob = 1 => 0.3099009901,
			phn_prob = 5 => 0.2513396716,
			phn_prob = 7 => 0.2122289371,
			phn_prob = 9 => 0.1970196492,
			0.1781852374
		);

		cvi_a_m := map( 
			cvi_a = 1 => 0.1549347546,
			cvi_a = 3 => 0.1990902729,
			0.2563753517
		);

		wealth_index_a_m := map( 
			wealth_index_a = 1 => 0.168030888,
			wealth_index_a = 2 => 0.2365547505,
			0.2729960578
		);

		rel_criminal_ct_3_m := map( 
			rel_criminal_ct_3 = 0 => 0.2303325223,
			rel_criminal_ct_3 = 1 => 0.2138300587,
			rel_criminal_ct_3 = 2 => 0.1852861035,
			0.1792629606
		);

		verx_m := map( 
			verx = 1 => 0.0870535714,
			verx = 2 => 0.0952380952,
			verx = 3 => 0.11328125,
			verx = 4 => 0.1594827586,
			verx = 5 => 0.206779661,
			verx = 6 => 0.2187334627,
			verx = 7 => 0.2243955447,
			verx = 8 => 0.2568203198,
			verx = 9 => 0.3163731246,
			0.327077748
		);
	
		mk_score_a := -7.548805577
			+ add1_prop_ver_m  * 2.7771904672
			+ liens_hist_unr_ct_3_m  * 5.1379197561
			+ sc_addr_x_m  * 1.7019402044
			+ addr_prob_m  * 2.9990862688
			+ phn_prob_m  * 1.6262870314
			+ wealth_index_a_m  * 2.7445445511
			+ rel_criminal_ct_3_m  * 4.5737761672
			+ (INTEGER)criminal_f  * -0.27358378
			+ (INTEGER)liens_recent_released_ct_f  * 0.3969030894
			+ rel_under25k_p  * -0.005717283
			+ c_fammar_p_calc  * 2.199021405
			+ c_mil_emp_b  * 0.0305821294
			+ (INTEGER)own_watercraft_f  * 0.2780198711
			+ verx_m  * 4.1502336211
			+ cvi_a_m  * 1.5495850282
		;
     
		mk_score := (exp(mk_score_a)) / (1+exp(mk_score_a));

		phat := mk_score;

		base  := 700;
		odds  := .21/.79;
		point := 50;

		rsn803_a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		
		rsn803 := map(
			rsn803_a < 250 => 250,
			rsn803_a > 999 => 999,
			rsn803_a
		);

		self.seq := (string)le.seq;
		self.recover_score := (string3)rsn803;
		self := [];
	END;
	
	scores := join(with_rs_batchin, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

	// Get the indices
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

	return withIndices;
	
END;
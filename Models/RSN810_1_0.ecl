import ut, Risk_Indicators, RiskWise, easi;

export RSN810_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

temp := record
	Risk_Indicators.Layout_Boca_Shell;
	string1 addr_type_a;
	string1 addr_confidence_a;
	string15	cus_chargeoff_amt := '';	
end;

temp add_rs(clam le, recoverscore_batchin rt) := TRANSFORM 

	self.addr_type_a := rt.address_type;
	self.addr_confidence_a := rt.address_confidence;
	self.cus_chargeoff_amt := rt.debt_amount;
	self := le;
end;

with_rs_batchin := join(clam, recoverscore_batchin, left.seq=right.seq, add_rs(left,right));


	sysyear := (integer)(ut.GetDate[1..4]);
		
	Layout_RecoverScore doModel(with_rs_batchin le, easi.Key_Easi_Census ri) := TRANSFORM
		// fields from surecontact
		addr_type_a := le.addr_type_a;
		addr_confidence_a := le.addr_confidence_a;
		cus_chargeoff_amt := le.cus_chargeoff_amt;
	
		// Fields from Modeling Shell 1.0
		nas_summary                      :=  le.iid.nas_summary;
		nap_summary                      :=  le.iid.nap_summary;
		fname_eda_sourced                :=  le.name_verification.fname_eda_sourced;
		lname_eda_sourced                :=  le.name_verification.lname_eda_sourced;
		fname_voter_sourced              :=  le.name_verification.fname_voter_sourced;
		lname_voter_sourced              :=  le.name_verification.lname_voter_sourced;
		add1_source_count                :=  le.address_verification.input_address_information.source_count;
		add2_source_count                :=  le.address_verification.address_history_1.source_count;
		disposition                      :=  le.bjl.disposition;
		filing_count                     :=  le.bjl.filing_count;
		liens_historical_unreleased_ct   :=  le.bjl.liens_historical_unreleased_count;
		liens_historical_released_count  :=  le.bjl.liens_historical_released_count;
		criminal_count                   :=  le.bjl.criminal_count;
		rel_criminal_count               :=  le.relatives.relative_criminal_count;
		rel_prop_owned_count             :=  le.relatives.owned.relatives_property_count;
		rel_within25miles_count          :=  le.relatives.relative_within25miles_count;
		voter_avail                      :=  le.Available_Sources.voter;

		// Fields from Easi census
		C_ROBBERY   := ri.ROBBERY;
		C_CARTHEFT  := ri.CARTHEFT;
		C_POP_85P_P := ri.POP_85P_P;
		C_SUB_BUS   := ri.SUB_BUS;
		/***********************************************************/

		vcus_chargeoff_amt     := min(10000.0,max(500.0,(real)cus_chargeoff_amt));
		vcus_chargeoff_amt_log := ln(vcus_chargeoff_amt);



		addr_a_level := map( 
			(addr_type_a = 'C' and addr_confidence_a  = 'A') => 0,
			(addr_type_a = 'C')                              => 1,
			(addr_type_a = 'U' and addr_confidence_a  = 'B') => 2,
			(addr_type_a = 'U')                              => 3,
			4
		);

		addr_a_level_m := case( addr_a_level,
			0 => 0.16928159,
			1 => 0.14177762,
			2 => 0.10945274,
			3 => 0.10367893,
			4 => 0.08641975,
			     0.13024431
		);


		v_nas_ver := (integer)(nas_summary >= 10);

		v_nap_nas := map( 
			(nap_summary >= 11 and v_nas_ver = 1) => 1,
			(nap_summary >= 11 and v_nas_ver = 0) => 2,
			(nap_summary >=  3 and v_nas_ver = 1) => 3,
			(nap_summary >=  3 and v_nas_ver = 0) => 5,
			(nap_summary <   3 and v_nas_ver = 1) => 4,
			6
		);

		v_verl_nap := (integer)( nap_summary in [2,5,7,8,9,11,12] );

		v_nap_nas2 := map( 
			v_nap_nas = 1 => 1,
			v_nap_nas = 2 => 2,
			v_nap_nas = 3 and v_verl_nap=1 => 2,
			v_nap_nas = 3 and v_verl_nap=0 => 3,
			v_nap_nas = 4 => 3,
			v_nap_nas = 5 => 4,
			5
		);

		v_add1_source_cnt := map( 
			(add1_source_count  = 0) => 0,
			(add1_source_count <= 4) => 1,
			2
		);

		v_add2_source_cnt := min(add2_source_count, 5);


		v_add_source_cnt := map(
			v_add1_source_cnt=2                          => 1,
			v_add1_source_cnt=1 and v_add2_source_cnt>=3 => 2,
			v_add1_source_cnt=1                          => 3,
			v_add1_source_cnt=0 and v_add2_source_cnt>=4 => 2,
			3
		);

		v_nap_nas_verx := map( 
			v_nap_nas2=1 and v_add_source_cnt <=2 => 1,
			v_nap_nas2=1 and v_add_source_cnt  =3 => 2,
			v_nap_nas2=2 and v_add_source_cnt  =1 => 1,
			v_nap_nas2=2 and v_add_source_cnt >=2 => 3,
			v_nap_nas2=3 and v_add_source_cnt  =1 => 1,
			v_nap_nas2=3 and v_add_source_cnt  =2 => 3,
			v_nap_nas2=3 and v_add_source_cnt  =3 => 4,
			v_nap_nas2=4 and v_add_source_cnt <=2 => 3,
			v_nap_nas2=4 and v_add_source_cnt  =3 => 4,
			5
		);

		v_name_eda_souced := map( 
			fname_eda_sourced and lname_eda_sourced => 1,
			lname_eda_sourced => 2,
			3
		);

		v_name_voter_sourced := map( 
			lname_voter_sourced => 1,
			fname_voter_sourced => 4,
			voter_avail         => 3,
			2
		);

		v_name_eda_voter_sourced := map( 
			v_name_eda_souced = 1 and v_name_voter_sourced <=2 => 1,
			v_name_eda_souced = 1 and v_name_voter_sourced =3 => 2,
			v_name_eda_souced = 1 => 3,
			v_name_eda_souced = 2 and v_name_voter_sourced <=2 => 2,
			v_name_eda_souced = 2 => 3,
			v_name_eda_souced = 3 and v_name_voter_sourced =1 => 2,
			v_name_eda_souced = 3 and v_name_voter_sourced =2 => 3,
			4
		);


		v_napnas_verx3 := map(
			v_nap_nas_verx=1 and v_name_eda_voter_sourced=1  => 1,
			v_nap_nas_verx=1 and v_name_eda_voter_sourced=2  => 2,
			v_nap_nas_verx=1 and v_name_eda_voter_sourced=3  => 4,
			v_nap_nas_verx=1 and v_name_eda_voter_sourced=4  => 6,
			v_nap_nas_verx=2 and v_name_eda_voter_sourced<=2 => 3,
			v_nap_nas_verx=2 and v_name_eda_voter_sourced=3  => 4,
			v_nap_nas_verx=2 and v_name_eda_voter_sourced=4  => 6,
			v_nap_nas_verx=3 and v_name_eda_voter_sourced<=2 => 4,
			v_nap_nas_verx=3 and v_name_eda_voter_sourced=3  => 5,
			v_nap_nas_verx=3 and v_name_eda_voter_sourced=4  => 6,
			v_nap_nas_verx=4 and v_name_eda_voter_sourced=1  => 4,
			v_nap_nas_verx=4 and v_name_eda_voter_sourced<=3 => 5,
			v_nap_nas_verx=4 and v_name_eda_voter_sourced=4  => 6,
			6
		);

		v_napnas_verx3_m := case( v_napnas_verx3,
			1 => 0.16271552,
			2 => 0.15330739,
			3 => 0.14590444,
			4 => 0.13585746,
			5 => 0.11976419,
			6 => 0.10099103,
			     0.13024431
		);

		v_bk_cnt := map( 
			filing_count = 0 => 0,
			filing_count = 1 => 1,
			2
		);

		v_bk_dismissed := (integer)(StringLib.StringToUpperCase(disposition) in ['DISMISSED', 'CASE DISMISSED','PETITION DISMISSED'] );

		v_lien_unrel_cnt := map( 
			liens_historical_unreleased_ct = 0 => 0,
			liens_historical_unreleased_ct = 1 => 1,
			2
		);

		v_lien_rel_cnt := map(
			liens_historical_released_count=0 => 0,
			liens_historical_released_count=1 => 1,
			2
		);

		v_lien_cntx := map( 
			v_lien_unrel_cnt = 0                       => 3,
			v_lien_unrel_cnt = 1 and v_lien_rel_cnt>=1 => 3,
			v_lien_unrel_cnt = 1                       => 2,
			v_lien_unrel_cnt = 2 and v_lien_rel_cnt =2 => 3,
			v_lien_unrel_cnt = 2 and v_lien_rel_cnt =1 => 2,
			1
		);
		v_criminal_cnt := map(
			criminal_count=0 => 0,
			criminal_count=1 => 1,
			2
		);

		v_bk_lien_x := map( 
			v_bk_cnt=0 and v_lien_cntx=3 => 4,
			v_bk_cnt=0 and v_lien_cntx=2 => 3,
			v_bk_cnt=0 => 2,
			v_bk_cnt=1 and v_lien_cntx=3 => 4,
			v_bk_cnt=1 and v_lien_cntx=2 => 3,
			v_bk_cnt=1 => 2,
			v_bk_cnt=2 and v_lien_cntx=3 => 3,
			v_bk_cnt=2 => 1,
			-99999
		);

		v_bk_lien_x2 := if( v_bk_lien_x = 1 or v_bk_dismissed=1, 1, v_bk_lien_x );

		v_derog_x2 := map(
			v_bk_lien_x2=4 and v_criminal_cnt=0 => 1,
			v_bk_lien_x2=4 and v_criminal_cnt=1 => 2,
			v_bk_lien_x2=4 and v_criminal_cnt=2 => 3,
			v_bk_lien_x2=3 and v_criminal_cnt=0 => 2,
			v_bk_lien_x2=3                      => 3,
			v_bk_lien_x2=2 and v_criminal_cnt=0 => 3,
			4
		);

		v_derog_x2_m := map( 
			v_derog_x2 =      1 => 0.13873853,
			v_derog_x2 =      2 => 0.12611465,
			v_derog_x2 =      3 => 0.10748408,
			v_derog_x2 =      4 => 0.06227106,
			0.13024431
		);



		v_rel_within25miles_gt0 := (integer)(rel_within25miles_count >0);
		v_rel_criminal          := (integer)(rel_criminal_count >0 );
		v_rel_prop_owner        := (integer)(rel_prop_owned_count > 0);

		v_rel_cat := map(
			v_rel_within25miles_gt0=0 and v_rel_prop_owner=0 => '1no close rel,no prop',
			v_rel_within25miles_gt0=0 and v_rel_prop_owner=1 => '2no close rel,   prop',
			v_rel_within25miles_gt0=1 and v_rel_prop_owner=0 => '3   close rel,no prop',
			v_rel_within25miles_gt0=1 and v_rel_prop_owner=1 => '4   close rel,   prop',
			'wrong'
		);

		v_rel_cat2 := map(
			v_rel_cat='1no close rel,no prop' and v_rel_criminal=0 => 2,
			v_rel_cat='1no close rel,no prop' and v_rel_criminal=1 => 1,
			v_rel_cat='2no close rel,   prop' and v_rel_criminal=0 => 2,
			v_rel_cat='2no close rel,   prop' and v_rel_criminal=1 => 1,
			v_rel_cat='3   close rel,no prop' and v_rel_criminal=0 => 3,
			v_rel_cat='3   close rel,no prop' and v_rel_criminal=1 => 2,
			v_rel_cat='4   close rel,   prop' and v_rel_criminal=0 => 4,
			v_rel_cat='4   close rel,   prop' and v_rel_criminal=1 => 4,
			-1
		);


		v_rel_cat2_m := case( v_rel_cat2, 
			1 => 0.08666667,
			2 => 0.11180339,
			3 => 0.13441034,
			4 => 0.13981382,
			     0.13024431
		);


		vC_ROBBERY_i := map(
			trim(C_ROBBERY)=''       => 1,
			(integer)C_ROBBERY <= 80 => 4,
			(integer)C_ROBBERY <=140 => 3,
			(integer)C_ROBBERY <=170 => 2,
			1
		 );

		vC_CARTHEFT_i := map(
			trim(C_CARTHEFT)=''       => 1,
			(integer)C_CARTHEFT <= 20 => 5,
			(integer)C_CARTHEFT <= 30 => 4,
			(integer)C_CARTHEFT <= 40 => 3,
			(integer)C_CARTHEFT <=100 => 2,
			1
		);

		vc_crime_x := map(

			vC_CARTHEFT_i = 1 and vC_ROBBERY_i  <= 3 => 1,
			vC_CARTHEFT_i = 1                        => 2,
			vC_CARTHEFT_i = 2 and vC_ROBBERY_i  <= 2 => 1,
			vC_CARTHEFT_i = 2                        => 2,
			vC_CARTHEFT_i = 3 and vC_ROBBERY_i  = 1  => 1,
			vC_CARTHEFT_i = 3 and vC_ROBBERY_i  = 2  => 2,
			vC_CARTHEFT_i = 3                        => 3,
			vC_CARTHEFT_i = 4 and vC_ROBBERY_i  = 1  => 2,
			vC_CARTHEFT_i = 4 and vC_ROBBERY_i  = 2  => 3,
			vC_CARTHEFT_i = 4                        => 4,
			vC_CARTHEFT_i = 5 and vC_ROBBERY_i  = 1  => 3,
			vC_CARTHEFT_i = 5 and vC_ROBBERY_i <= 3  => 4,
			5
		);
		
				
		vc_crime_x_m := case( vc_crime_x,
			1 => 0.11433293,
			2 => 0.14162011,
			3 => 0.15950920,
			4 => 0.16441441,
			5 => 0.18116976,
			     0.13024431
		);

		vc_POP_85P_P_high := (integer)(((real)C_POP_85P_P) > 2.0);
		vc_SUB_BUS_low    := (integer)((integer)C_SUB_BUS < 100);


		logit07_cus := -10.33203038
			+ vcus_chargeoff_amt_log  * 0.5448415271
			+ vc_crime_x_m  * 5.2956567603
			+ addr_a_level_m  * 6.4112040076
			+ v_derog_x2_m  * 11.722671019
			+ v_napnas_verx3_m  * 5.0906844938
			+ vc_POP_85P_P_high  * 0.1579635245
			+ v_rel_cat2_m  * 3.8611818163
			+ vc_SUB_BUS_low  * 0.1126784051
		;
		phat07_cus := (exp(logit07_cus )) / (1+exp(logit07_cus ));
		log07_cus  := round(40*(ln(phat07_cus/(1-phat07_cus)) - ln(15/85))/ln(2) + 700);

		RSN810_1_0 := min(900, max(501, log07_cus));

		self.seq := (string)le.seq;
		self.recover_score := intformat(rsn810_1_0,3,1);
		self := [];
	end;

	scores := join(with_rs_batchin, easi.key_easi_census, 
					keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
					doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

	indices := RecoverScore_Collection_Indices( clam, recoverscore_batchin );

	layout_recoverscore doIndices( layout_recoverscore le, indices ri ) := TRANSFORM
		SELF.address_index          := ri.address_index;
		SELF.telephone_index        := ri.telephone_index;
		SELF.contactability_score   := ri.contactability_score;
		SELF.asset_index            := ri.asset_index;
		SELF.lifecycle_stress_index := ri.lifecycle_stress_index;
		SELF.liquidity_score        := ri.liquidity_score;
		self := le;
	END;

	withIndices := join( scores, indices, left.seq=right.seq, doIndices(left,right));    
	RETURN withIndices;

END;

import ut, Risk_Indicators, RiskWise, easi;

export RSN802_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

	sysyear := (integer)(ut.GetDate[1..4]);
		
	Layout_RecoverScore doModel(clam le, recoverscore_batchin rt) := TRANSFORM 
	 
	 	addr_type_a := rt.address_type;
		addr_confidence_a := rt.address_confidence;
		ph_phone_type_a_1 := rt.phone_type;
	
		/************************************************************************************/
		/* Fields from Modeling Shell                                                       */
		/************************************************************************************/
		nap_summary                      := le.iid.nap_summary;
		rc_hriskaddrflag                 := (INTEGER)le.iid.hriskaddrflag;
		rc_decsflag                      := le.ssn_verification.validation.deceased;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_phonezipflag                  := (INTEGER)le.iid.phonezipflag;
		addr_sources                     := StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
		ssn_sources                      := StringLib.StringToUppercase(trim(le.Source_Verification.socssources));
		hphnpop                          := (INTEGER)le.input_validation.homephone;
		add1_avm_land_use                := le.AVM.Input_Address_Information.avm_land_use_code;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		property_owned_total             := le.address_verification.owned.property_total;
		telcordia_type                   := le.phone_verification.telcordia_type;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adlperssn_count                  := le.SSN_Verification.adlPerSSN_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		criminal_count                   := le.bjl.criminal_count;
		rel_within25miles_count          := le.relatives.relative_within25miles_count;
		rel_within100miles_count         := le.relatives.relative_within100miles_count;
		rel_within500miles_count         := le.relatives.relative_within500miles_count;
		rel_withinother_count            := le.relatives.relative_withinOther_count;
		rel_ageunder40_count             := le.Relatives.relative_ageUnder40_count;
		rel_ageunder50_count             := le.Relatives.relative_ageUnder50_count;
		rel_ageunder60_count             := le.Relatives.relative_ageUnder60_count;
		rel_ageunder70_count             := le.Relatives.relative_ageUnder70_count;
		rel_ageover70_count              := le.Relatives.relative_ageOver70_count;
		current_count                    := le.vehicles.current_count;
		addr_stability                   := (integer)le.mobility_indicator;
		
		/************************************************************************************/

		mymin(a,b) := MACRO if((a)<(b),(a),(b)) ENDMACRO;
		mymax(a,b) := MACRO if((a)>(b),(a),(b)) ENDMACRO;
		boolean contains( string src, string pat ) := stringlib.stringfind( src, pat, 1 ) != 0;

		
		source_L2_add := (INTEGER)contains(addr_sources, 'L2,' );
		source_P_add  := (INTEGER)contains(addr_sources, 'P ,' );
		source_WP_add := (INTEGER)contains(addr_sources, 'WP,' );


		/* SSN COUNTS */

		source_AK_ssn := (INTEGER)contains(ssn_sources, 'AK,' );
		source_AM_ssn := (INTEGER)contains(ssn_sources, 'AM,' );
		source_AR_ssn := (INTEGER)contains(ssn_sources, 'AR,' );
		source_BA_ssn := (INTEGER)contains(ssn_sources, 'BA,' );
		source_CG_ssn := (INTEGER)contains(ssn_sources, 'CG,' );
		source_D_ssn  := (INTEGER)contains(ssn_sources, 'D ,' );
		source_DA_ssn := (INTEGER)contains(ssn_sources, 'DA,' );
		source_DS_ssn := (INTEGER)contains(ssn_sources, 'DS,' );
		source_EB_ssn := (INTEGER)contains(ssn_sources, 'EB,' );
		source_EM_ssn := (INTEGER)contains(ssn_sources, 'EM,' );
		source_VO_ssn := (INTEGER)contains(ssn_sources, 'VO,' );
		source_EM_VO_ssn := if(source_EM_ssn=1 or source_VO_ssn=1, 1, 0);
		source_EQ_ssn := (INTEGER)contains(ssn_sources, 'EQ,' );
		source_FF_ssn := (INTEGER)contains(ssn_sources, 'FF,' );
		source_FR_ssn := (INTEGER)contains(ssn_sources, 'FR,' );
		source_L2_ssn := (INTEGER)contains(ssn_sources, 'L2,' );
		source_LI_ssn := (INTEGER)contains(ssn_sources, 'LI,' );
		source_MW_ssn := (INTEGER)contains(ssn_sources, 'MW,' );
		source_P_ssn  := (INTEGER)contains(ssn_sources, 'P ,' );
		source_PL_ssn := (INTEGER)contains(ssn_sources, 'PL,' );
		source_TU_ssn := (INTEGER)contains(ssn_sources, 'TU,' );
		source_V_ssn  := (INTEGER)contains(ssn_sources, 'V ,' );
		source_W_ssn  := (INTEGER)contains(ssn_sources, 'W ,' );
		source_WP_ssn := (INTEGER)contains(ssn_sources, 'WP,' );
		source_other_ssn := (INTEGER)contains(ssn_sources, 'other,' );



		num_pos_sources_NOEQ_ssn :=
			 source_AM_ssn
			+source_AR_ssn
			+source_CG_ssn
			+source_D_ssn 
			+source_EB_ssn
			+source_EM_VO_ssn
			+source_MW_ssn
			+source_P_ssn 
			+source_PL_ssn
			+source_TU_ssn
			+source_V_ssn 
			+source_W_ssn 
			+source_WP_ssn;

		add1_avm_land_use_a := map(
			add1_avm_land_use = '' => 1,
			(INTEGER)add1_avm_land_use = 1  => 3,
			5
		);
		
		add1_naprop_a := map(
			add1_naprop  = 4 and property_owned_total > 0 => 9,
			add1_naprop >= 3                              => 7,
			add1_naprop  = 0                              => 5,
			// add1_naprop  in [1,2]                         => 3
			3
		);
		
		bk_recent_i := (integer)(bk_recent_count > 0);
		criminal_3  := mymin(criminal_count,3);
		liens_recent_unreleased_count_2 := mymin(liens_recent_unreleased_count,2);

		liens_released_a := map(
			liens_recent_released_count     > 0 => 5,
			liens_historical_released_count > 0	=> 3,
			1
		);
		
		// whoa
		messy_file_b := mymax(mymax(mymin(adlperssn_count,5),1),mymax(mymin(ssns_per_adl,5),1));

		add_sources := map(
			source_l2_add > 0 and source_p_add > 0 and source_wp_add > 0 => 7,
			(source_l2_add > 0 and source_p_add  > 0) or 
			(source_p_add  > 0 and source_wp_add > 0) or
			(source_l2_add > 0 and source_wp_add > 0)                    => 5,
			source_l2_add > 0 or source_p_add > 0 or source_wp_add > 0	 => 3,
			1
		);
		
		addr_risk := map(
			rc_hriskaddrflag = 0 and rc_addrvalflag = 'V' => 1,
			rc_hriskaddrflag = 0                          => 3,
			5
		);

		deceased_i := (integer)((INTEGER)rc_decsflag = 1);	

		closest_rel := map(
			rel_within25miles_count  > 0 => 7,
			rel_within100miles_count > 0 => 5,
			rel_within500miles_count > 0 => 3,
			rel_withinother_count    > 0 => 3,
			1
		);
		
		
		rel_age31plus_i := (integer)((rel_ageunder40_count
					+rel_ageunder50_count
					+rel_ageunder60_count
					+rel_ageunder70_count
					+rel_ageover70_count) > 0
		);
		
		current_count_4 := mymin(current_count,4);
		
			
		addr_stability_a := map(
			addr_stability in [1,2,3,4] => 3,
			addr_stability = 0          => 1,
			addr_stability = 5          => 5,
			7
		);

		nap_a := if( hphnpop = 1,
			map(
				nap_summary = 12                 => 9,
				nap_summary in [10,11]           => 7,
				nap_summary in [2,3,4,5,6,7,8,9] => 5,
				nap_summary =  0                 => 3,
				1
			),
			map(
				nap_summary in [0,3] => 1,
				nap_summary = 8      => 7,
				5
			)
		);

		sc_phone_x := map(
			ph_phone_type_a_1 =  'B' => 1,
			telcordia_type    = '04' => 3,
			ph_phone_type_a_1 =  ' ' => 5,
			ph_phone_type_a_1 =  'C' and rc_phonezipflag = 1 => 7,
			ph_phone_type_a_1 =  'C' => 9,
			11
		);
		
		sc_addr_x := map(
			addr_type_a = 'C' and addr_confidence_a = 'A' => 7,
			addr_type_a = 'C' or  addr_confidence_a = 'A' => 5,
			addr_confidence_a = 'B' => 3,
			1
		);

		/*** MEAN SUBSTITUTION ***/
		add1_avm_land_use_a_m := case( add1_avm_land_use_a,
			1 => 0.1567260451,
			3 => 0.1848037223,
			0.2485453034
		);

		add1_naprop_a_m := case( add1_naprop_a,
			3 => 0.1379794772,
			5 => 0.1554297694,
			7 => 0.1692672575,
			0.2407279029
		);

		bk_recent_i_m := if( bk_recent_i = 0, 0.1697729988, 0.1293322063 );

		criminal_3_m := case( criminal_3,
			0 => 0.1789889744,
			1 => 0.1354905693,
			2 => 0.1308876812,
			0.1141011841
		);

		liens_recent_unreleased_ct_2_m := case(liens_recent_unreleased_count_2,
			0 => 0.1523274545,
			1 => 0.2360046759,
			0.2483570646
		);

		liens_released_a_m := case(liens_released_a,
			1 => 0.1565083258,
			3 => 0.1951219512,
			0.3661106234
		);

		messy_file_b_m := case(messy_file_b,
			1 => 0.183889501,
			2 => 0.1657208725,
			3 => 0.1540789308,
			4 => 0.1317923763,
			0.1008522727
		);

		add_sources_m := case(add_sources,
			1 => 0.1469752511,
			3 => 0.2323268206,
			5 => 0.2899594777,
			0.3386243386
		);

		addr_risk_m := case(addr_risk,
			1 => 0.1720055344,
			3 => 0.1271367521,
			0.091954023
		);

		deceased_i_m := if(deceased_i=0, 0.1708469028, 0.0711743772 );

		closest_rel_m := case(closest_rel,
			1 => 0.0927561837,
			3 => 0.1239837398,
			5 => 0.1361043195,
			0.1759339869
		);

		rel_age31plus_i_m := if(rel_age31plus_i = 0, 0.1270594806, 0.1746782992 );

		current_count_4_m := case(current_count_4,
			0 => 0.1577064285,
			1 => 0.1833740831,
			2 => 0.1928438662,
			3 => 0.2176899957,
			0.2218905473
		);


		addr_stability_a_m := case(addr_stability_a,
			1 => 0.0920436817,
			3 => 0.1590886748,
			5 => 0.1887197502,
			0.2192652589
		);

		nap_a_m := case(nap_a,
			1 => 0.1326648327,
			3 => 0.1456996149,
			5 => 0.1544461778,
			7 => 0.1754448399,
			0.2149620471
		);
		
		
		
		sc_addr_x_m := case( sc_addr_x,
			1 => 0.1036834925,
			3 => 0.1366428626,
			5 => 0.1843579406,
			0.2613247433
		);

		sc_phone_x_m := case( sc_phone_x,
			1 => 0.1292611984,
			3 => 0.1373092926,
			5 => 0.1488265111,
			7 => 0.1670403587,
			9 => 0.1744282744,
			0.2167233422
		);

		axiant_log1a := -14.28070534
			+ add1_avm_land_use_a_m          * 3.6311365125
			+ add1_naprop_a_m                * 3.4197211348
			+ bk_recent_i_m                  * 13.623095018
			+ criminal_3_m                   * 7.3401138562
			+ liens_recent_unreleased_ct_2_m * 3.4944400034
			+ liens_released_a_m             * 3.9158530816
			+ messy_file_b_m                 * 6.9524034547
			+ add_sources_m                  * 1.8456003134
			+ num_pos_sources_NOEQ_ssn       * 0.0392716984
			+ addr_risk_m                    * 3.542620129
			+ deceased_i_m                   * 9.0970566873
			+ closest_rel_m                  * 3.6480289629
			+ rel_age31plus_i_m              * 3.5098036868
			+ current_count_4_m              * 3.4161177039
			+ sc_phone_x_m                   * 2.086115406
			+ addr_stability_a_m             * 2.6539099343
			+ sc_addr_x                      * 0.0829244465
		;



		axiant_log1 := (exp(axiant_log1a )) / (1+exp(axiant_log1a ));

		phat := axiant_log1;

		base  := 700;
		odds  := 0.16/0.84;
		point := 50;
 
		rsn802_1_0a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		
		rsn802_1_0b := map(
			rsn802_1_0a < 250 => 250,
			rsn802_1_0a > 999 => 999,
			rsn802_1_0a
		);
		
		self.seq := (string)le.seq;
		self.recover_score := (string3)rsn802_1_0b;
		self := [];
	END;
	
	scores := join(clam, recoverscore_batchin, left.seq=right.seq, doModel(left,right));
	
	// Get the indices
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

	return withIndices;
	
END;
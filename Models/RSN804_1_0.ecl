import ut, Risk_Indicators, RiskWise, easi;

export RSN804_1_0(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	dataset(riskwise.Layout_SkipTrace) skiptrace,
	dataset(easi.Layout_Census) easi
) := FUNCTION

	// keep fields from clam and EASI to join to skiptrace
	temp_layout := record
		Risk_Indicators.Layout_Boca_Shell;
		string9 high_ed;                
	end;
	
	temp_fields := join( clam, easi, left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk=right.geolink,
		transform( temp_layout, self.high_ed := right.high_ed, self := left ),
		left outer, keep(1)
	);

	Layout_ModelOut doModel(temp_fields le, skiptrace rt) := TRANSFORM 
		// ************************************************************************************/
		/* Field Mapping			                                                         				 */
		// ************************************************************************************/
		string1 addr_type_a := rt.addr_type_a;  							
		string1 addr_confidence_a := rt.addr_confidence_a; 	
		
		real c_high_ed := (real)le.high_ed;    


		in_dob                          :=  le.shell_input.dob;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.lastnamesources));
		today                           :=  ut.GetDate;
		sysyear                         :=  (INTEGER)today[1..4];
		ageDate                         :=  if(le.historydate <> 999999, (unsigned)((string)le.historydate[1..6]+'31'), (unsigned)today);

		age                             :=  ut.GetAgeI_asOf(le.reported_dob, ageDate);
		add1_house_number_match         :=  (integer)le.Address_Verification.Input_Address_Information.house_number_match;
		add1_isbestmatch                :=  (integer)le.address_verification.input_address_information.isbestmatch;
		add1_pop                        :=  (integer)le.input_validation.address;
		add1_census_home_value          :=  trim(le.address_verification.input_address_information.census_home_value);
		property_owned_total            :=  le.address_verification.owned.property_total;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		filing_count                    :=  le.bjl.filing_count;
		criminal_count                  :=  le.bjl.criminal_count;
		rel_count                       :=  le.relatives.relative_count;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		wealth_index                    :=  trim(le.wealth_indicator);

	                                              

		/* ***********************************************************************************/
		/* Code Starts Here                                                                 * /
		//************************************************************************************/


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


		_source_lname_AM := contains_i(lname_sources, 'AM,');
		_source_lname_AR := contains_i(lname_sources, 'AR,');
		_source_lname_CG := contains_i(lname_sources, 'CG,');
		_source_lname_D  := contains_i(lname_sources, 'D ,');
		_source_lname_EB := contains_i(lname_sources, 'EB,');
		_source_lname_EM := contains_i(lname_sources, 'EM,');
		_source_lname_VO := contains_i(lname_sources, 'VO,');
		_source_lname_EM_VO := if(_source_lname_EM=1 or _source_lname_VO=1, 1, 0);
		_source_lname_FF := contains_i(lname_sources, 'FF,');
		_source_lname_MW := contains_i(lname_sources, 'MW,');
		_source_lname_P  := contains_i(lname_sources, 'P ,');
		_source_lname_PL := contains_i(lname_sources, 'PL,');
		_source_lname_TU := contains_i(lname_sources, 'TU,');
		_source_lname_V  := contains_i(lname_sources, 'V ,');
		_source_lname_W  := contains_i(lname_sources, 'W ,');
		_source_lname_WP := contains_i(lname_sources, 'WP,');

     
		num_pos_sources_noeq_lst := _source_lname_AM
			+ _source_lname_AR
			+ _source_lname_CG
			+ _source_lname_D 
			+ _source_lname_EB
			+ _source_lname_EM_VO
			+ _source_lname_FF
			+ _source_lname_MW
			+ _source_lname_P 
			+ _source_lname_PL
			+ _source_lname_TU
			+ _source_lname_V 
			+ _source_lname_W 
			+ _source_lname_WP
		;	


		add1_prop_ver := map( 
			add1_naprop = 4 => 9,
			property_owned_total > 0 => 7,
			add1_naprop = 3 => 5,
			add1_naprop = 0 => 3,
			1
		);

		s_liens_unr := map( 
			liens_recent_unreleased_count   > 0 => 5,
			liens_historical_unreleased_ct  > 0 => 3,
			1
		);

		add1_match := map( 
			add1_pop = 0 => 1,
			add1_isbestmatch = 1 and add1_house_number_match = 1 => 5,
			add1_isbestmatch = 1 or  add1_house_number_match = 1 => 3,
			1
		);

		fp_phn := map( 
			(integer)rc_hriskphoneflag = 5      => 3, // DC'd Phone,
			(integer)rc_hriskphoneflag in [1,3] => 5, // Mobile or PCS,
			(integer)rc_hriskphoneflag = 7      => 7, // Phone Empty,
			1 // low risk
		);





		messy_file_b := max(max(min(adlperssn_count,5),1),max(min(ssns_per_adl,5),1));
		wealth_index_a := if( wealth_index='', 1, (integer)wealth_index);

		s_num_pos_sources_noeq_lst_a := max(min(num_pos_sources_noeq_lst,3),1);

		filing_ct_2 := min(filing_count,2);
	
		sc_addr := map( 
			addr_type_a = 'C' and addr_confidence_a = 'A' => 5,
			addr_type_a = 'C' or  addr_confidence_a = 'A' => 3,
			1
		);


		rel_i             := (INTEGER)(rel_count > 0);
		s_criminal_i      := (INTEGER)(criminal_count > 0);
		s_fp_zip_mismatch := (INTEGER)((integer)rc_phonezipflag = 1);
		
		
		s_add1_census_home_value_a := if( add1_census_home_value = '', 1000000, max(min((integer)add1_census_home_value,1000000),25000) );
		s_add1_census_home_value_log := ln(s_add1_census_home_value_a);

		dob_yr     := (integer)in_dob[1..4];
		age_a      := if( (integer)in_dob=0, age, sysyear-dob_yr );
		s_age_calc := if( age_a = 0, 40, min(max(age_a, 35), 75) );
		s_age_sq   := s_age_calc*s_age_calc;
		
		s_c_high_ed_a := max(min(c_high_ed, 100),0);	
		
		/*** MEAN SUBSTITUTION ***/	
			
			
		add1_prop_ver_m := map( 
			add1_prop_ver = 1 => 0.1917181257,
			add1_prop_ver = 3 => 0.2313660294,
			add1_prop_ver = 5 => 0.3334111059,
			add1_prop_ver = 7 => 0.4831113225,
			add1_prop_ver = 9 => 0.6415656795,
			-9999
		);

		s_liens_unr_m := map( 
			s_liens_unr = 1 => 0.4156671574,
			s_liens_unr = 3 => 0.2153827977,
			s_liens_unr = 5 => 0.1314723098,
			-9999
		);

		add1_match_m := map( 
			add1_match = 1 => 0.1560657596,
			add1_match = 3 => 0.3843351548,
			add1_match = 5 => 0.5015293745,
			-9999
		);

		fp_phn_m := map( 
			fp_phn = 1 => 0.4386740651,
			fp_phn = 3 => 0.343336906,
			fp_phn = 5 => 0.2759971868,
			fp_phn = 7 => 0.0947986577,
			-9999
		);

		messy_file_b_m := map( 
			messy_file_b = 1 => 0.3924852692,
			messy_file_b = 2 => 0.3819285011,
			messy_file_b = 3 => 0.3102395113,
			messy_file_b = 4 => 0.269815418,
			messy_file_b = 5 => 0.2026342452,
			-9999
		);

		wealth_index_a_m := map( 
			wealth_index_a = 1 => 0.176318064,
			wealth_index_a = 2 => 0.2248254111,
			wealth_index_a = 3 => 0.2945700763,
			wealth_index_a = 4 => 0.4080192112,
			wealth_index_a = 5 => 0.593582204,
			wealth_index_a = 6 => 0.6673340007,
			-9999
		);

		s_num_pos_sources_noeq_lst_a_m := map( 
			s_num_pos_sources_noeq_lst_a = 1 => 0.2043071323,
			s_num_pos_sources_noeq_lst_a = 2 => 0.4435016556,
			s_num_pos_sources_noeq_lst_a = 3 => 0.5633076712,
			-9999
		);

		filing_ct_2_m := map( 
			filing_ct_2 = 0 => 0.3769721528,
			filing_ct_2 = 1 => 0.3375174338,
			filing_ct_2 = 2 => 0.2192362093,
			-9999
		);

		sc_addr_m := map( 
			sc_addr = 1 => 0.1894763599,
			sc_addr = 3 => 0.4680936847,
			sc_addr = 5 => 0.549622751,
			-9999
		);

     
		rsn804_1_0a := -10.5686696
			+ add1_prop_ver_m  * 1.4530046094
			+ s_liens_unr_m  * 3.9376056247
			+ add1_match_m  * 1.8057002879
			+ fp_phn_m  * 2.9569980875
			+ messy_file_b  * -0.198165647
			+ wealth_index_a_m  * 0.6371373021
			+ s_num_pos_sources_noeq_lst_a_m  * 1.5354400465
			+ filing_ct_2_m  * 3.4387591042
			+ sc_addr_m  * 0.8455660516
			+ rel_i  * 0.3517667668
			+ s_criminal_i  * -0.214910859
			+ s_fp_zip_mismatch  * -0.705262423
			+ s_add1_census_home_value_log  * 0.2460182828
			+ s_age_sq  * 0.000257423
			+ s_c_high_ed_a  * 0.0138966014
		;
     
		rsn804_1_0b := (exp(rsn804_1_0a)) / (1+exp(rsn804_1_0a));
    
		phat := rsn804_1_0b;

		base  := 700;
		odds  := .37/.63;
		point := 50;
 
		rsn804_1_0_a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

		rsn804_1 := map(
			rsn804_1_0_a < 250 => 250,
			rsn804_1_0_a > 999 => 999,
			rsn804_1_0_a
		);


		self.seq := le.seq;
		self.score := (string3)rsn804_1;
		self := [];
	END;
	
	rscore := join(temp_fields, skiptrace, left.seq=right.seq, doModel(LEFT, right), left outer );
	
	return rscore;
END;
import ut, Risk_Indicators, RiskWise, easi, std;

export RSN803_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,
									dataset(riskwise.Layout_SkipTrace) skiptrace) := 
FUNCTION

	// keep fields from clam and EASI to join to skiptrace
	temp_layout := record
		Risk_Indicators.Layout_Boca_Shell;
		string9 fammar_p;                
		string9 hhsize;
	end;
	
	temp_fields := join(clam, Easi.Key_Easi_Census,
						left.input_validation.address and
						keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk) ,
						transform(temp_layout, self.fammar_p := right.fammar_p, self.hhsize := right.hhsize, self := left), 
						left outer, keep(1));
							
Layout_RecoverScore doModel(temp_fields le, skiptrace rt) := TRANSFORM 
	// ************************************************************************************/
	/* Field Mapping			                                                         				 */
	// ************************************************************************************/
	string1 addr_type_a := rt.addr_type_a;  							
	string1 addr_confidence_a := rt.addr_confidence_a; 	

	integer nas_summary := le.iid.nas_summary;
	integer nap_summary := le.iid.nap_summary;
	string1 nap_type := le.iid.nap_type;
	string1 rc_dwelltype := le.iid.dwelltype;
	string1 rc_ssnvalflag := le.iid.socsvalflag;
	integer ssnlength := (integer)le.input_validation.ssn_length;
	integer hphnpop := if(le.input_validation.homephone, 1, 0);
	today := (STRING8)Std.Date.Today();
	ageDate := if(le.historydate <> 999999, (unsigned)(((string)le.historydate)[1..6]+'31'), (unsigned)today);
	integer age := ut.Age(le.reported_dob, ageDate);
	integer add1_isbestmatch := if(le.address_verification.input_address_information.isbestmatch, 1, 0);
	integer add1_naprop := le.address_verification.input_address_information.naprop;
	integer property_owned_total := le.address_verification.owned.property_total;
	integer addrs_per_adl_c6 := le.velocity_counters.addrs_per_adl_created_6months;

	integer liens_recent_unreleased_count := le.bjl.liens_recent_unreleased_count;
	integer liens_historical_unreleased_ct := le.bjl.liens_historical_unreleased_count;
	integer rel_criminal_total := (integer)le.relatives.relative_criminal_total;
	integer wealth_index := (integer)le.wealth_indicator;
	integer addr_stability := (integer)le.mobility_indicator; 

	real c_fammar_p := (real)le.fammar_p;                 
	real c_hhsize := (real)le.hhsize;                                   

 /* ***********************************************************************************/
 /* Code Starts Here                                                                 * /
 //************************************************************************************/
	
	add1_prop := map( add1_naprop = 4 and property_owned_total > 0 and add1_isbestmatch = 1	=> 9,
										add1_naprop >= 3	and add1_isbestmatch = 1 => 7,
										add1_naprop >= 3 => 5,
										add1_isbestmatch = 1 => 3,
										1 );
	
	nap_a := map ( 	hphnpop=1 and nap_summary in [10,11,12] => 9,
									hphnpop=1 and nap_summary in [5,6,7,8,9]	and 	nap_type in ['P','A']	=> 7,
									hphnpop=1 and nap_summary in [5,6,7,8,9]							=> 5,
									hphnpop=1 and nap_summary = 0									=> 3,
									hphnpop=1 and nap_summary in [1,2,3,4]							=> 1,
									nap_summary >= 5	and nap_type in ['P','A']	=> 7,
									nap_summary >= 5							=> 5,
									 3 );

	addr_stability_a := map( 	addr_stability in [0,1]		=> 1,
														addr_stability in [2,3,4]		=> 3,
														addr_stability = 5			=> 5,
														7);
	
	liens_unreleased_a := map( 	liens_recent_unreleased_count>0 and liens_historical_unreleased_ct>0 	=> 7,
															liens_recent_unreleased_count>0 or liens_historical_unreleased_ct>0 => 5,
															3);
	
	rel_criminal_total_3 := Min(rel_criminal_total,3);
	
	dwell_status := map( rc_dwelltype = ' ' => 5,
											 rc_dwelltype = 'A'	=> 3,
											 1 );
	
	c_hhsize_a1 	:= if(c_hhsize > 0, c_hhsize, 0);
	c_hhsize_a := if(c_hhsize_a1 = 0, 5, c_hhsize_a1);
	
	c_fammar_p_a1 	:= if(c_fammar_p > 0, c_fammar_p, 0);
	c_fammar_p_a := if(c_fammar_p_a1 = 0, 100, c_fammar_p_a1);
	
	age1 := if(age = 0, 45, age);
	age_a := Max( Min(age1,50), 21);
	
	no_addrs_per_adl_c6_i :=  if(addrs_per_adl_c6 = 0, 1, 0);
	
	wealth_index_a := map( wealth_index in [1,2,3] => 1,
												 wealth_index = 4 => 3,
												 5 );
												 
	nas_ssn := if(nas_summary in [4,6,7,9,10,11,12], 1, 0);
	nas_fst := if(nas_summary in [2,3,4,8,9,10,12], 1, 0);
	nas_lst := if(nas_summary in [2,5,7,8,9,11,12], 1, 0);
	nas_add := if(nas_summary in [3,5,6,8,10,11,12], 1, 0);
		
	ssn_prob := map( ssnlength = 9 and nas_ssn = 1	=> 1,
									 ssnlength = 9 and rc_ssnvalflag<>'1' => 3,
									 5 );
	
	sc_addr := map( addr_type_a = 'C' and addr_confidence_a = 'A'	=> 7,
									addr_type_a = 'C'	=> 5,
									addr_confidence_a = 'A' => 3,
									1 );
	
	/* *** MEAN SUBSTITUTION ***/
    add1_prop_m := map(add1_prop = 1 => 0.366311517,
												 add1_prop = 3 => 0.448767834,
												 add1_prop = 5 => 0.5022421525,
												 add1_prop = 7 => 0.6016483516,
																					0.6200980392 );
     
     nap_a_m := map(nap_a = 1 => 0.3559322034,
										 nap_a = 3 => 0.3693477391,
										 nap_a = 5 => 0.4330590875,
										 nap_a = 7 => 0.5023937762,
										 0.5545602606);
     
     addr_stability_a_m := map( addr_stability_a = 1 => 0.3906682483,
																 addr_stability_a = 3 => 0.4294906166,
																 addr_stability_a = 5 => 0.4977404777,
																 0.5870088212);
     
     liens_unreleased_a_m := map(liens_unreleased_a = 3 => 0.445362244,
																 liens_unreleased_a = 5 => 0.4561606798,
																 0.4946564885);
     
     rel_criminal_total_3_m := map(rel_criminal_total_3 = 0 => 0.4613883128,
																	 rel_criminal_total_3 = 1 => 0.4148296593,
																	 rel_criminal_total_3 = 2 => 0.3383458647,
																	 0.2610619469);
																	 
     dwell_status_m := map(dwell_status = 1 => 0.3148788927,
													 dwell_status = 3 => 0.3440742764,
													 0.4862292718);
     
     wealth_index_a_m := map(wealth_index_a = 1 => 0.4592657598,
														 wealth_index_a = 3 => 0.4372693727,
														 0.4087837838);
     
     ssn_prob_m := map(ssn_prob = 1 => 0.5041509434,
											 ssn_prob = 3 => 0.3744884038,
											 0.2116182573);
     
     sc_addr_m := map(sc_addr = 1 => 0.348035488,
											 sc_addr = 3 => 0.38,
											 sc_addr = 5 => 0.5479725871,
											 0.6013986014);
                              
		/* *** MODEL EQUATION ***/

		rsn803_2_0a := -13.06189978
								+ add1_prop_m  * 1.0206010376
								+ nap_a_m  * 1.2351555675
								+ addr_stability_a_m  * 1.6625765536
								+ liens_unreleased_a_m  * 5.009847621
								+ rel_criminal_total_3_m  * 3.8136942323
								+ dwell_status_m  * 2.5573359885
								+ c_hhsize_a  * 0.1850591428
								+ c_fammar_p_a  * -0.007240523
								+ age_a  * 0.0108778474
								+ no_addrs_per_adl_c6_i  * 0.255432601
								+ wealth_index_a_m  * 6.2368561198
								+ ssn_prob_m  * 3.1403787705
								+ sc_addr_m  * 2.1474544053
		;
		
		rsn803_2_0b := (exp(rsn803_2_0a)) / (1+exp(rsn803_2_0a));

		phat := rsn803_2_0b;

		base  := 700;
		odds  := .58/.42;
		point := 50;

		rsn803_2_0c :=  (point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		
		rsn803_2_0d := (integer)rsn803_2_0c;
		
		rsn803_2 := map(rsn803_2_0d < 250 => 250,
										rsn803_2_0d > 999 => 999,
										rsn803_2_0d);		
	
		self.seq := (string)le.seq;
		self.recover_score := (string3) rsn803_2;
		self := [];
	END;
	
	rscore := join(temp_fields, skiptrace, left.seq=right.seq, doModel(LEFT, right) );
	
	return rscore;
END;
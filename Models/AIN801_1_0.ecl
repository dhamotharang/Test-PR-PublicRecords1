// WFS4 Model
import Risk_Indicators, easi, riskwise, ut;

export AIN801_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, string5 grade) := function

Layout_ModelOut doModel(clam le, Easi.Key_Easi_Census rt ) := transform
	SELF.seq := le.seq;
	
	// ************** Variable Mapping ****************
	integer add1_applicant_sold := if(le.address_verification.input_address_information.applicant_sold, 1, 0);
	integer add1_isbestmatch := if(le.address_verification.input_address_information.isbestmatch, 1, 0);
	integer add1_naprop := le.address_verification.input_address_information.naprop;
	string addr_sources := le.source_verification.addrsources;
	integer addrs_per_adl_c6 := le.velocity_counters.addrs_per_adl_created_6months;
	unsigned adl_EQ_first_seen := le.source_verification.adl_eqfs_first_seen;
	integer adlperssn_count := le.ssn_verification.adlperssn_count;
	integer age := le.name_verification.age;
	integer ams_college_code := (integer)le.student.college_code;
	string ams_file_type := le.student.file_type;
	string ab_av_edu := rt.ab_av_edu;
	integer combo_dobscore := le.iid.combo_dobscore;
	integer criminal_count := le.bjl.criminal_count;
	string disposition := trim(Stringlib.StringToUpperCase(le.bjl.disposition));
	integer hphnpop := if(le.input_validation.homephone, 1, 0);
	string in_dob := le.shell_input.dob;
	integer liens_historical_released_count := le.bjl.liens_historical_released_count;
	integer liens_historical_unreleased_ct := le.bjl.liens_historical_unreleased_count;
	integer liens_recent_released_count := le.bjl.liens_recent_released_count;
	integer liens_recent_unreleased_count := le.bjl.liens_recent_unreleased_count;
	string nap_status := le.iid.nap_status;
	integer nap_summary := le.iid.nap_summary;
	integer nas_summary := le.iid.nas_summary;
	integer phones_per_addr := le.velocity_counters.phones_per_addr;
	integer property_owned_total := le.address_verification.owned.property_total;
	string rc_addrcommflag := le.iid.addrcommflag;
	string rc_addrvalflag := le.iid.addrvalflag;
	string rc_cityzipflag := le.iid.cityzipflag;
	string rc_decsflag := le.iid.decsflag;
	UNSIGNED3 rc_disthphoneaddr := le.iid.disthphoneaddr;
	string rc_dwelltype := le.iid.dwelltype;
	string rc_hphonetypeflag := le.iid.hphonetypeflag;
	string rc_hriskphoneflag := le.iid.hriskphoneflag;
	string rc_phonezipflag := le.iid.phonezipflag;
	string rc_pwphonezipflag := le.iid.pwphonezipflag;
	string rc_pwssnvalflag := le.iid.pwsocsvalflag;
	string rc_sources := le.iid.sources;
	string rc_ssndobflag := le.iid.socsdobflag;
	string rc_ssnvalflag := le.iid.socsvalflag;
	integer rel_count := le.relatives.relative_count;
	integer rel_prop_owned_count := le.relatives.owned.relatives_property_count;
	integer ssns_per_addr := le.velocity_counters.ssns_per_addr;
	integer ssns_per_addr_c6 := le.velocity_counters.ssns_per_addr_created_6months;
	integer ssns_per_adl := le.velocity_counters.ssns_per_adl;
	string telcordia_type := le.phone_verification.telcordia_type;
	
// ******************* Model Code Starts Here ****************
	log_offset := 2.8785184905;  

	_scoring_date := IF(le.historydate <> 999999, (string)le.historydate[1..6] + '01', ut.GetDate[1..6] + '01');
	today1900 := ut.DaysSince1900(_scoring_date[1..4], _scoring_date[5..6], _scoring_date[7..8]);
	
	// use the following age code so that age is rounded instead of actual age 
	// so if someone is 23 years old and 10 months, this will say they're 24 as opposed to ut.GetAgeI which would say 23
	byr := le.shell_input.dob[1..4];
	bmn := le.shell_input.dob[5..6];
	bdy := '01';//le.shell_input.dob[7..8];    	    
	birthdt := if(le.shell_input.dob = '', 0, ut.DaysSince1900(byr, bmn, bdy));
	_in_age := if(birthdt = 0, 0, round((today1900 - birthdt)/365));
		
	adl_EQ_yr := adl_EQ_first_seen[1..4];
	adl_EQ_mn := adl_EQ_first_seen[5..6];
	adl_EQ_dy := '01';    	    
	adl_EQ_first_seen_days_since1900 := if(adl_EQ_first_seen=0, 0, ut.DaysSince1900(adl_EQ_yr, adl_EQ_mn, adl_EQ_dy));
	_adl_EQ_first_seen_years := if(length(trim((string)adl_EQ_first_seen))<> 6, 
																	-1, 
																	round((today1900 - adl_EQ_first_seen_days_since1900)/365));
		
	integer source_exists( string sources, string source ) := 
												if(StringLib.StringFind(sources, source, 1) > 0, 1, 0);

	_source_addr_AM := source_exists(addr_sources, 'AM'); //)>0); label _source_addr_AM := "addr-Airmen                    ";
	_source_addr_AR := source_exists(addr_sources, 'AR'); //)>0); label _source_addr_AR := "addr-Aircrafts                 ";
	_source_addr_CG := source_exists(addr_sources, 'CG'); //)>0); label _source_addr_CG := "addr-US Coast Guard            ";
	_source_addr_D  := source_exists(addr_sources, 'D '); //)>0); label _source_addr_D  := "addr-Driver's License Sources  ";
	_source_addr_EB := source_exists(addr_sources, 'EB'); //)>0); label _source_addr_EB := "addr-eMerge Boat               ";
	
	_source_addr_EM := source_exists(addr_sources, 'EM'); //)>0); label _source_addr_EM := "addr-Voter Registration Sources";
	_source_addr_VO := source_exists(addr_sources, 'VO'); // voter is seperate from EM now
	_source_addr_EM_VO := if(_source_addr_EM=1 or _source_addr_VO=1, 1, 0);	// check for either em or vo
	
	_source_addr_EQ := source_exists(addr_sources, 'EQ'); //)>0); label _source_addr_EQ := "addr-Equifax Header            ";
	_source_addr_MW := source_exists(addr_sources, 'MW'); //)>0); label _source_addr_MW := "addr-MS Worker Comp            ";
	_source_addr_P  := source_exists(addr_sources, 'P ' ); //)>0); label _source_addr_P  := "addr-Property Data Sources     ";
	_source_addr_PL := source_exists(addr_sources, 'PL'); //)>0); label _source_addr_PL := "addr-Professional License      ";
	_source_addr_TU := source_exists(addr_sources, 'TU'); //)>0); label _source_addr_TU := "addr-TransUnion Static Header  ";
	_source_addr_V  := source_exists(addr_sources, 'V ' ); //)>0); label _source_addr_V  := "addr-Vehicle Sources           ";
	_source_addr_W  := source_exists(addr_sources, 'W ' ); //)>0); label _source_addr_W  := "addr-Watercraft Sources        ";
	_source_addr_WP := source_exists(addr_sources, 'WP'); 
	
	_source_addrpos := _source_addr_AM + _source_addr_AR    + _source_addr_CG + _source_addr_D +
										 _source_addr_EB + _source_addr_EM_VO + _source_addr_EQ + _source_addr_MW + _source_addr_P  + 
										 _source_addr_PL + _source_addr_TU    + _source_addr_V  + _source_addr_W  + _source_addr_WP ;
	
	c_ab_av_edu_du := if( ab_av_edu='' or ab_av_edu='-1', 100, (integer)ab_av_edu );

	age_combo := map( _in_age > 0 => _in_age,
										age > 0 => age,
										18 );
										
	age_combo_18_45 := ut.imin2( ut.max2(age_combo,18), 45 );

	ams_level := map(ams_college_code in [1,2,4] =>  2,
									 ams_file_type in ['H','M'] => 1,
									 0);
									 
	// ******************/
	// *** Relatives ***/						 
	rel_pct_prop1 := if (rel_count > 0,
											(integer)((rel_prop_owned_count/rel_count)*100),
											-1 );
	rel_pct_prop := if(rel_pct_prop1 > 100, 100, rel_pct_prop1); // cap the pct at 100
	
	// ******************/
	// *** Address ***/
	prop_tree := map( add1_naprop = 4 and add1_applicant_sold = 0 and property_owned_total >= 2 => 6, 
										add1_naprop = 4 and add1_applicant_sold = 0 and property_owned_total  = 1 => 5, 
										add1_naprop = 4 and add1_applicant_sold = 0 and property_owned_total  = 0 => 4, 
										add1_naprop = 4 and add1_applicant_sold = 1 => 4,                    
										property_owned_total > 0 => 3.5, 
										add1_naprop = 3 => 3, 
										add1_naprop in [1,2] => 0, 
										1);
	
	// ******************/
	// *** Velocity ***/
	phones_per_addr_2plus := if(phones_per_addr >= 2, 1, 0);
	ssns_per_adl_4plus := if(ssns_per_adl >= 4, 1, 0);
	adls_per_ssn_3plus := if(adlperssn_count >= 3, 1, 0);
	ssns_per_addr_10plus := if(ssns_per_addr >= 10, 1, 0);

  vel_c6_prob := map( ssns_per_addr_c6 >= 2 =>  2,
											addrs_per_adl_c6 >= 2 =>  1,
											0 );
	vel_c6_prob2 := vel_c6_prob + phones_per_addr_2plus;
	vel_prob := ut.imin2(  (ssns_per_addr_10plus + adls_per_ssn_3plus + ssns_per_adl_4plus + phones_per_addr_2plus),3);

	// ******************/
	// *** Derogs  ***/
	
	_source_tot_FR := source_exists(rc_sources,'FR'); 
	
	// this is what the model has coded, but it's odd that they're only counting dismissed bankruptcy in derogs
	bk_dism := if(disposition[1..4]='DISM', 1, 0);  
	
	liens_rec_unr_3 := ut.imin2(liens_recent_unreleased_count,3);
	liens_unr := if(liens_rec_unr_3=0 and liens_historical_unreleased_ct > 0 , 0.5, liens_rec_unr_3);
	
	liens_rel := map(liens_recent_released_count > 0 => 2,
									 liens_recent_released_count = 0 and liens_historical_released_count > 0 => 1,
									 0);
	liens_unr_rel := if(liens_unr = 0 and liens_rel > 0, 0.5, liens_unr) ;
	
	derog := map( _source_tot_FR = 1 or bk_dism = 1 => 2, 
								criminal_count > 0 => 1,
								0 );
	
	// ******************/
	// *** FP  ***/
	addprob1 := map( rc_addrcommflag = '2' => 3,
									 rc_dwelltype = 'A'  => 2,
									 rc_addrvalflag = 'N' => 1,
									 0 );
	addprob := if(rc_cityzipflag='1', ut.imin2(addprob1 + 1,3), addprob1);

	notpots := if(telcordia_type not in ['00','50','51','52','54'], 1, 0);

	phnprob := map( rc_pwssnvalflag = '4' => 2,
									rc_pwphonezipflag = '1' or nap_status = 'D' => 2,
									rc_disthphoneaddr = 0 and notpots = 0 and rc_hphonetypeflag  = '0' => 0,
									notpots = 0 and rc_hphonetypeflag  = '0' => 1,
									2 );

	addphnprob := map( 	addprob = 0 and phnprob = 0 => 0,
											addprob = 0 and phnprob = 1 => 1,
											addprob = 1 and phnprob = 0 => 1,
											addprob = 0 and phnprob = 2 => 2,
											addprob = 1 and phnprob = 1 => 2,
											addprob = 1 and phnprob = 2 => 2,
											addprob = 2                 => 3,
											addprob = 3                 => 4, 
											4);

	vel_c6_add_phn_prob := map(vel_c6_prob2=0 and addphnprob=0 => 0,
														 vel_c6_prob2=0 and addphnprob=1 => 1,
														 vel_c6_prob2=0 and addphnprob > 1 => 2, 
														 vel_c6_prob2 + 2);
														
	// ******************/
	// *** Verx  ***/
	verx := map( 	nas_summary >= 10 and nap_summary = 12 => 5,
								nas_summary >= 10 and nap_summary in[10,11] => 4,
																			nap_summary >= 10 => 3,
								nas_summary >= 10 and nap_summary in[2,3,4,5,6,7,8,9] => 3,
								nas_summary >= 10 and nap_summary in[0] => 2,
								1 );

	dob_v := if(combo_dobscore between 90 and 100, 1, 0);

	_source_addrpos3 := ut.imin2(_source_addrpos,3);

	_adl_EQ_first_seen_years_25 := if(_adl_EQ_first_seen_years < 0, 
																	4.5,
																	ut.imin2(_adl_EQ_first_seen_years,25) );
																		
	// ****************** code to mean: verx ******************/
	verx_l := map( verx = 1 => 0.3878148596, 
								verx = 2 => -0.051687481, 
								verx = 3 => -0.162854161, 
								verx = 4 => -0.438337852, 
								verx = 5 => -0.574871896,
								-0.14465325) ;

	// ****************** code to mean: _source_addrpos3 ******************/
	_source_addrpos3_m := map( _source_addrpos3 = 0 => 0.6021573604, 
														_source_addrpos3 = 1 => 0.5214345755, 
														_source_addrpos3 = 2 => 0.4180961991, 
														_source_addrpos3 = 3 => 0.3358608385,
														0.4638996139 ) ;

	// ****************** code to mean: derog ******************/
	derog_m := map( derog = 0 => 0.4560236511, 
								 derog = 1 => 0.4711111111, 
								 derog = 2 => 0.6264236902,
								 0.4638996139 );

	// ****************** code to mean: liens_unr_rel ******************/
	liens_unr_rel_m := map( 	liens_unr_rel = 0 => 0.4373340414, 
													liens_unr_rel = 0.5 => 0.5162138475, 
													liens_unr_rel = 1 => 0.5695067265, 
													liens_unr_rel = 2 => 0.6071428571, 
													liens_unr_rel = 3 => 0.6587677725,
													0.4638996139 ) ;

	// ****************** code to mean: prop_tree ******************/
	prop_tree_l := map( prop_tree = 0 => 0.191092913, 
										 prop_tree = 1 => 0.1366144676, 
										 prop_tree = 3 => 0.0062305507, 
										 prop_tree = 3.5 => -0.162734422, 
										 prop_tree = 4 => -0.387592982, 
										 prop_tree = 5 => -0.608504536, 
										 prop_tree = 6 => -0.749783317,
										 -0.14465325) ;

	// ****************** code to mean: ams_level ******************/
	ams_level_m := map( ams_level = 0 => 0.4687993265, 
										 ams_level = 1 => 0.4433285509, 
										 ams_level = 2 => 0.2625,
										 0.4638996139 ) ;

	vel_prob_l := map( vel_prob = 0 => -0.435796195, 
									 vel_prob = 1 => -0.095016474, 
									 vel_prob = 2 => 0.1168718748, 
									 vel_prob = 3 => 0.6070180274,
									 -0.14465325) ;
									 
									 
	// *** LN Only Model ***/
	wfsmod1_full := -7.811671302
							+ _source_addrpos3_m  * 1.1138205541
							+ liens_unr_rel_m  * 4.7828804056
							+ _adl_EQ_first_seen_years_25  * -0.012464186
							+ c_ab_av_edu_du  * -0.003252893
							+ derog_m  * 4.5622832643
							+ prop_tree_l  * 0.3630235201
							+ ams_level_m  * 4.0237463133
							+ verx_l  * 0.2917224858
							+ vel_prob_l  * 0.4258464528
							+ rel_pct_prop  * -0.003797165
							+ age_combo_18_45  * -0.016780576
							+ add1_isbestmatch  * -0.171377965
							+ dob_v  * -0.13499012
							+ vel_c6_add_phn_prob  * 0.0894920966
							+ log_offset  * 1;
							
	phat := (exp(wfsmod1_full )) / (1+exp(wfsmod1_full ));

	base  := 620;
	odds  := 0.4 / 0.6;
	point := -20;

	LN_Only_Score := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);


	// **** Disaster Overrides ****/
	phn_unverified := if(nap_summary in [0,1,2,3,5,8] and hphnpop=1, 1, 0);

	ain801_disaster_overrides := 
		map(nas_summary in [0,1,2,3,4,7,9] and nap_summary in [0,1,2,3,4,7,9] => ut.imin2(ln_only_score,599), 
				nas_summary in [0,1,2,3,5,8] => ut.imin2(ln_only_score,609), 
				rc_hriskphoneflag = '6' and hphnpop = 1 => ut.imin2(ln_only_score,609), 
				rc_addrcommflag = '2' or rc_dwelltype = 'E' => ut.imin2(ln_only_score,615), 
				rc_addrvalflag = 'N' => ut.imin2(ln_only_score,616), 
				adlperssn_count >= 4 => ut.imin2(ln_only_score,617), 
				nas_summary in [0,1,2,3,4,5,6,7,8,9] => ut.imin2(ln_only_score,618), 
				phn_unverified = 1 and rc_hriskphoneflag = '5' => ut.imin2(ln_only_score,619), 
				phn_unverified = 1 and notpots = 1 => ut.imin2(ln_only_score,628), 
				phn_unverified = 1 and rc_phonezipflag = '1' => ut.imin2(ln_only_score,629),
				ln_only_score > 999 => 999,
				ln_only_score < 250 => 250,
				ln_only_score);

 //  *** Overrides ***/
	over200 := if(rc_decsflag = '1' or rc_ssndobflag = '1' or rc_ssnvalflag in ['1','2'], 1, 0);
	over201 := if(rc_ssnvalflag = '3', 1, 0);
// over528 := if(grade>='8', 1, 0);
// *** Replace over528 line above with lines below ***/
// *** Because client provides 2-digit grade in production but only 1-digit for test ***/
  over528 := if(grade not in ['A0', 'A1','A2','B1', 'B3','C1'], 1, 0);

	AIN801_1_0_score := map(over201 = 1 => 201,
													over200 = 1 => 200,
													over528 = 1 => 528,
													nas_summary in [0,1,2,3,4,5,6,7,10,11] and nap_summary in [0,1,2,3,4,5,6,7,10,11] => 202, // additional override added for wachovia
													ain801_disaster_overrides);
	
	self.score := (string)AIN801_1_0_score;  
	self.ri := [];
	
end;
		 
out := join(clam, Easi.Key_Easi_Census,
					 left.shell_input.st<>'' and left.shell_input.county <>'' and left.shell_input.geo_blk <> '' and
			     keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
			     doModel(left, right), left outer,
			     atmost(RiskWise.max_atmost)
			     ,keep(1) );
					 
Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
END;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
	self.ri := RiskWise.mmReasonCodes(ri, 4, OFAC, false, TRUE);
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;
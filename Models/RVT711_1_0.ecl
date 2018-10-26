import riskwise, risk_indicators, ut, riskwisefcra, std, riskview;

export RVT711_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, 
				  boolean isCalifornia = false) :=


FUNCTION

	// Process Model into Layout
	Models.Layout_ModelOut DoModel(clam le) := TRANSFORM	
		
		// variables
		out_addr_status                  := le.Address_Validation.Error_Codes; //Address Standardization Result Code
		in_dob                           := le.shell_input.dob; // Input DOB
		nas_summary                      := le.iid.nas_summary; //Name-Address-SSN verification from InstantID
		nap_summary                      := le.iid.nap_summary; //Name-Address-Phone verification from InstantID
		nap_status                       := le.iid.nap_Status;  //Phone Status
		rc_hriskphoneflag                := le.iid.hriskphoneflag; //Input Phone High Risk Indicator (PI)
		rc_hrisksic             		 		 := (INTEGER)le.iid.hrisksic;
		rc_phonezipflag                  := le.iid.phonezipflag; //Input Phone to Zip Code Match Indicator (PI)
		rc_decsflag                      := (integer)le.iid.decsflag = 1; // le.ssn_verification.validation.deceased; //SSN Deceased Indicator     
		rc_ssndobflag                    := (INTEGER)le.iid.socsdobflag; //SSN Prior Indicator (PI)
		rc_pwssndobflag                  := le.iid.PWsocsdobflag; //SSN Prior Indicator (PW)
		rc_ssnvalflag                    := le.iid.socsvalflag; //SSN Validation Indicator (PI)
		rc_pwssnvalflag                  := le.iid.PWsocsvalflag; //SSN Validation Indicator (PW)
		rc_ssnlowissue                   := le.iid.socllowissue; //First year of possible SSN issuance (YYYY0101)
		rc_ssnhighissue                  := le.iid.soclhighissue; //Last year of possible SSN issuance (YYYY1231)
		rc_addrvalflag                   := le.iid.addrvalflag; //Address Validation Indicator
		rc_dwelltype                     := le.iid.dwelltype; //Type of Dwelling
		rc_bansflag                      := le.iid.bansflag; //Bankruptcy Indicator
		rc_sources                       := le.iid.sources; //Header Sources Key
		rc_numelever                     := le.iid.numelever; //Number of Elements Verified (0 - 8)
		rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag; //SSN Miskey Indicator
		rc_hphonemiskeyflag              := le.iid.hphonemiskeyflag; //Phone Miskey Indicator
		rc_addrmiskeyflag                := le.iid.addrmiskeyflag; //Address Miskey Indicator
		combo_ssnscore                   := le.iid.combo_ssnscore; //SSN Name Match Score (255 = Could not calculate)
		combo_dobcount                   := le.iid.combo_dobcount; //Number of Sources Confirming DOB
		addr_sources                     := le.source_verification.addrsources; //Header Sources Confirming Address
		ssn_sources                      := le.source_verification.socssources; //Header Sources Confirming SSN
		addrpop                          := le.input_validation.Address;  //le.addrpop; //Address Populated Indicator
		
		ssnlength                        := le.input_validation.ssn_length; //Length of Input SSN
		dobpop                           := (INTEGER)le.input_validation.dateofbirth; //DOB Populated Indicator
		hphnpop                          := (INTEGER)le.input_validation.homephone; //Home Phone # Populated Indicator
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_naprop                      := le.address_verification.input_address_information.naprop;   
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_ambig_total             := le.address_verification.ambiguous.property_total;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		telcordia_type                   := le.phone_verification.telcordia_type;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;  //le.velocity_counters.ssns_per_addr;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		bankrupt                         := le.bjl.bankrupt;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		archive_date 					 					 := if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);
		add1_lres 											 := le.lres; // archive_date - le.address_verification.input_address_information.date_first_seen;
		
		adl_EQ_first_seen 		        	 := le.source_verification.adl_EQfs_first_seen;
		add1_avm_assessed_total_value    := (integer)le.avm.input_address_information.avm_assessed_total_value;
		add1_occupant_owned              := (integer)le.address_verification.input_address_information.occupant_owned;
		add2_occupant_owned              := (integer)le.address_verification.address_history_1.occupant_owned;		
		add3_occupant_owned              := (integer)le.address_verification.address_history_2.occupant_owned;	

		
		year := (integer)(archive_date / 100);

		//**************** updated vermod *******************/

		ssn100 := if(combo_ssnscore = 100, 1, 0);
		contrary_phone := if(nap_summary = 1, 1, 0);

		verfst_p := if(nap_summary IN [2,3,4,8,9,10,12], 1, 0);
		verlst_p := if(nap_summary IN [2,5,7,8,9,11,12], 1, 0);
		veradd_p := if(nap_summary IN [3,5,6,8,10,11,12], 1, 0);
		verphn_p := if(nap_summary IN [4,6,7,9,10,11,12], 1, 0);

		verlst_s := if(nas_summary IN [2,5,7,8,9,11,12], 1, 0);
		veradd_s := if(nas_summary IN [3,5,6,8,10,11,12], 1, 0);
		verssn_s := if(nas_summary IN [4,6,7,9,10,11,12], 1, 0);
		 
	 
	 
		boolean contains( string needle, string haystack ) := StringLib.StringFind(haystack, needle, 1) > 0;


		_source_tot_AM := (integer)contains('AM', rc_sources);
		_source_tot_AR := (integer)contains('AR', rc_sources);
		_source_tot_EB := (integer)contains('EB', rc_sources);
		_source_tot_L2 := (integer)contains('L2', rc_sources);
		_source_tot_P  := (integer)contains('P ', rc_sources);
		_source_tot_PL := (integer)contains('PL', rc_sources);
		_source_tot_W  := (integer)contains('W ', rc_sources);

		_source_totfcraPos_f := max(_source_tot_p,_source_tot_am, _source_tot_ar,_source_tot_eb,
									   _source_tot_pl,_source_tot_W );


		_source_addr_AM := (integer)contains('AM', addr_sources);
		_source_addr_AR := (integer)contains('AR', addr_sources);
		_source_addr_BA := (integer)contains('BA', addr_sources);
		_source_addr_CG := (integer)contains('CG', addr_sources);
		_source_addr_CO := (integer)contains('CO', addr_sources);
		_source_addr_EB := (integer)contains('EB', addr_sources);
		_source_addr_EM := (integer)contains('EM', addr_sources);
		_source_addr_VO := (integer)contains('VO', addr_sources);
		_source_addr_EM_VO := if(_source_addr_EM=1 or _source_addr_VO=1, 1, 0);
		_source_addr_EQ := (integer)contains('EQ', addr_sources);
		_source_addr_L2 := (integer)contains('L2', addr_sources);
		_source_addr_MW := (integer)contains('MW', addr_sources);
		_source_addr_P  := (integer)contains('P ', addr_sources);
		_source_addr_PL := (integer)contains('PL', addr_sources);
		_source_addr_W  := (integer)contains('W ', addr_sources);
		_source_addr_WP := (integer)contains('WP', addr_sources);
                        
		_source_addrfcraPos := sum(_source_addr_AM,_source_addr_AR,_source_addr_CG,_source_addr_EB,
									 _source_addr_EM_VO,_source_addr_EQ,_source_addr_MW,_source_addr_P ,
									 _source_addr_PL   ,_source_addr_W ,_source_addr_WP);

		_source_addrfcraPosCap := min(3, _source_addrfcraPos);
		 
		_source_addrfcraPosCap_bestl := Map(_source_addrfcraPosCap = 0 => -1.768339189,
											 _source_addrfcraPosCap = 1 => -2.104885529,
											 _source_addrfcraPosCap = 2 => -2.782212064,
											 _source_addrfcraPosCap = 3 => -3.654731528,
											 -2.363126786);
			
		_source_addrfcraPosCap_notbestl := Map(_source_addrfcraPosCap = 0 => -1.199438355,
											 _source_addrfcraPosCap = 1 => -1.886041893,
											 _source_addrfcraPosCap = 2 => -2.752501948,
											 _source_addrfcraPosCap = 3 => -3.07797035,
											 -1.464397934);		
											 

		_source_addrfcraNeg := sum(_source_addr_BA,_source_addr_CO,_source_addr_L2);
		 
		_source_addrfcraNegCap := min(2,_source_addrfcraNeg);
		
		_source_addrfcraNegCap_bestl := Map(_source_addrfcraNegCap = 0 => -2.414927209,
											 _source_addrfcraNegCap = 1 => -1.671051594,
											 _source_addrfcraNegCap = 2 => -1.003302106,
											 -2.363126786);		


		_source_ssn_BA := (integer)contains('BA', ssn_sources);
		_source_ssn_CO := (integer)contains('CO', ssn_sources);
		_source_ssn_L2 := (integer)contains('L2', ssn_sources);
		_source_ssnfcraNeg := sum(_source_ssn_BA,_source_ssn_CO,_source_ssn_L2);
		_source_ssnfcraNegCap := min(2,_source_ssnfcraNeg);
		 
		_rc_numelever := min(7,max(3,rc_numelever));
			 
		_rc_numelever_bestl := Map(_rc_numelever = 3 => -1.365240948,
								   _rc_numelever = 4 => -2.061776698,
								   _rc_numelever = 5 => -2.316557366,
								   _rc_numelever = 6 => -2.467816994,
								   _rc_numelever = 7 => -2.933211898,
								   -2.363126786);
								   
		
		_rc_numelever_notbestl := Map(_rc_numelever = 3 => -0.849151427,
									  _rc_numelever = 4 => -1.381831487,
									  _rc_numelever = 5 => -1.531422419,
									  _rc_numelever = 6 => -1.812299338,
									  _rc_numelever = 7 => -2.007630254,
									  -1.464397934);	



		verx_tmp1 := Map(verphn_p=1 and verlst_p=1 and veradd_p=1 and verfst_p=1 => 4,
					verphn_p=1 and verlst_p=1 and veradd_p=1 => 3,
					verphn_p=1 and verlst_p=1 => 2,
					contrary_phone=1 => -1,
					verphn_p=1 and veradd_p=1 => 0,
					1);

		verx_m_tmp1 := Map(verx_tmp1 = -1 => 0.1474164,
					  verx_tmp1 = 0 => 0.1383596,
					  verx_tmp1 = 1 => 0.0961079,
					  verx_tmp1 = 2 => 0.0778689,
					  verx_tmp1 = 3 => 0.0717684,
					  verx_tmp1 = 4 => 0.0501101,
					  0);
		
		ModRVT8_vermod_add1best := 2.6483581525
						+ ssn100  * -0.494554486
						+ verx_m_tmp1  * 9.4016731062
						+ _source_totfcraPos_f  * -1.039331718
						+ _source_addrfcraPosCap_bestl  * 0.3920035873
						+ _source_addrfcraNegCap_bestl  * 0.911760381
						+ _source_ssnfcraNegCap  * 0.2254808737
						+ _rc_numelever_bestl  * 0.8326627833;

		ModRVT8_vermod_tmp1 := 100 * (exp(ModRVT8_vermod_add1best )) / (1+exp(ModRVT8_vermod_add1best ));
	 

		ver_p_level := Map(verphn_p=1 and verlst_p=1 and verfst_p=1 => 3,
						   verphn_p=1 and verlst_p=1 => 2,
						   contrary_phone=1 => 0,
						   ( verphn_p=1 and ( verlst_p = 0 ) and ( verfst_p = 0 )) => 0,
						   1);

		ver_s_level := Map(verssn_s=1 and verlst_s=1 and veradd_s=1 => 2,
						   verssn_s=1 and verlst_s=1 => 1,
						   0);


		verx_tmp2 := Map(ver_p_level <= 1 and ver_s_level <= 0 => 0,
					 ver_p_level <= 0 and ver_s_level <= 1 => 0,
					 ver_p_level <= 1 and ver_s_level <= 1 => 1,
					 ver_p_level <= 3 and ver_s_level <= 0 => 2,
					 ver_p_level <= 3 and ver_s_level <= 1 => 3,
					 ver_p_level <= 0 and ver_s_level <= 2 => 3,
					 ver_p_level <= 2 and ver_s_level <= 2 => 4,
					 ver_p_level <= 3 and ver_s_level <= 2 => 5,
					 0);

		verx_m_tmp2 := Map(verx_tmp2 = 0 => 0.2958487,
					  verx_tmp2 = 1 => 0.2118143,
					  verx_tmp2 = 2 => 0.1800487,
					  verx_tmp2 = 3 => 0.1588381,
					  verx_tmp2 = 4 => 0.1138162,
					  verx_tmp2 = 5 => 0.0783217,
					  0);
					  
		verx := if(add1_isbestmatch, verx_tmp1, verx_tmp2);
		verx_m := if(add1_isbestmatch, verx_m_tmp1, verx_m_tmp2);


		ModRVT8_vermod_add1notbest := -1.145986763
						 + verx_m  * 4.3459254738
						 + _source_totfcraPos_f  * -0.81170956
						 + _source_addrfcraPosCap_notbestl  * 0.2318968019
						 + _rc_numelever_notbestl  * 0.4380936187;

		ModRVT8_vermod_tmp2 := 100 * (exp(ModRVT8_vermod_add1notbest )) / (1+exp(ModRVT8_vermod_add1notbest ));
			
		ModRVT8_vermod := if(add1_isbestmatch, ModRVT8_vermod_tmp1, ModRVT8_vermod_tmp2);

		/*********** updated fpmod *******/

		aptflag := if(rc_dwelltype[1] = 'A', true, false);
		addinval := if(rc_addrvalflag <> 'V', true, false);


		ec1 := out_addr_status[1];
		ec3 := out_addr_status[3];
		ec4 := out_addr_status[4];

		addr_changed := if(ec1 = 'S' and ec3 <> '0', true, false);
		unit_changed := if(ec1 = 'S' and ec4 <> '0', true, false);


		E412 := if(trim(out_addr_status) = 'E412', true, false);

		casserror3_tmp := Map(ec1 = 'S' and addr_changed and unit_changed => 5,
						   ec1 = 'S' and unit_changed => 4,
						   ec1 = 'S' and addr_changed => 1,
						   ec1 = 'S' => 0,
						   ec1 = 'E' and E412 => 2, 
						   ec1 = 'E' => 3,
						   0);
						   
		casserror3 := if(addrpop, casserror3_tmp, 0);
								
		casserror3_m := Map(casserror3 = 0 => 0.1159410,
							casserror3 = 1 => 0.1244615,
							casserror3 = 2 => 0.1339286,
							casserror3 = 3 => 0.1663551,
							casserror3 = 4 => 0.1729323,
							casserror3 = 5 => 0.2075472,
							0);


		phone_zip_mismatch := if(rc_phonezipflag = '1', 1, 0);
		disconnected := if(rc_hriskphoneflag = '5', 1, 0);

		phone_zip_mismatch_n_tmp := 1 * phone_zip_mismatch;
		pnotpots_tmp := if(trim(telcordia_type) in ['00', '50', '51', '52', '54'], 0, 1);

		disconnect_level_tmp := Map(disconnected = 1 => 2,
								nap_status = 'D' => 1,
								0);
								
		phone_zip_mismatch_n := if(hphnpop = 1, phone_zip_mismatch_n_tmp, 0);
		pnotpots := if(hphnpop = 1, pnotpots_tmp, 0);
		disconnect_level := if(hphnpop = 1, disconnect_level_tmp,0);	
		
								
		adlperssn_count2_m := Map(adlperssn_count >= 4 => 0.1539474,
								  adlperssn_count >= 3 => 0.1440994,
								  adlperssn_count >= 2 => 0.1282095,
								  adlperssn_count >= 1 => 0.1117563,
								  adlperssn_count >= 0 =>0.2664526,
								  0);


		_ssns_per_adl := if(ssns_per_adl=0, 3, min(3,ssns_per_adl));
		

		_ssns_per_adl_l := Map(_ssns_per_adl = 1 => -2.067227374,
							   _ssns_per_adl = 2 => -1.883768645,
							   _ssns_per_adl = 3 => -1.092387277,
							   -1.959245953);
							   
		_adls_per_addr := Map(adls_per_addr=0 => 0,
							  adls_per_addr=1 => 1,
							  adls_per_addr<=2 => 2,
							  adls_per_addr<=3 => 3,
							  adls_per_addr<=4 => 4,
							  adls_per_addr<=5 => 5,
							  adls_per_addr<=8 => 8,
							  adls_per_addr<=12 => 12,
							  adls_per_addr<=24 => 24,
							  25);
		
		_adls_per_addr_l := Map(_adls_per_addr = 0 => -1.584276753,
								_adls_per_addr = 1 => -1.954583223,
								_adls_per_addr = 2 => -2.619466306,
								_adls_per_addr = 3 => -2.462858501,
								_adls_per_addr = 4 => -2.441688045,
								_adls_per_addr = 5 => -2.389294481,
								_adls_per_addr = 8 => -2.265288807,
								_adls_per_addr = 12 => -1.991177447,
								_adls_per_addr = 24 => -1.681758569,
								_adls_per_addr = 25 => -1.287979669,
								-1.959245953);
								

		_phones_per_addr := Map(phones_per_addr=0 => 1,
								phones_per_addr=1 => 0,
								phones_per_addr=2 => 1,
								2);
								
		_phones_per_addr_l := Map(_phones_per_addr = 0 => -2.201544229,
								  _phones_per_addr = 1 => -1.987254046,
								  _phones_per_addr = 2 => -1.487992823,
								  -1.959245953);

		_adls_per_phone := Map(adls_per_phone=2 => 0,
							   adls_per_phone=1 => 1,
							   2);
							   
		
		_adls_per_phone_l := Map(_adls_per_phone = 0 => -2.307904244,
								 _adls_per_phone = 1 => -2.00809934,
								 _adls_per_phone = 2 => -1.845971764,
								 -1.959245953);


		_ssns_per_addr_c6 := min(2,ssns_per_addr_c6);
		 
		 
		_ssns_per_addr_c6_l := Map(_ssns_per_addr_c6 = 0 => -2.071359141,
								   _ssns_per_addr_c6 = 1 => -1.862652572,
								   _ssns_per_addr_c6 = 2 => -1.692288909,
								   -1.959245953);
		

		_phones_per_addr_c6 := min(2,phones_per_addr_c6);
		 
		
		_phones_per_addr_c6_l := Map(_phones_per_addr_c6 = 0 => -2.08867418,
									 _phones_per_addr_c6 = 1 => -1.693110383,
									 _phones_per_addr_c6 = 2 => -1.444281615,
									 -1.959245953);
									 

		ssn_valid := if( (rc_ssnvalflag in ['0', '3'] ) or ( (rc_ssnvalflag = '2') and ((integer)ssnlength = 4) ), 1, 0);
		deceased := if(rc_decsflag, 1, 0);
		ssninval := if(ssn_valid = 0, 1, 0);
		ssndead := 1 * deceased;

		// SSNPrior
		high_issue_dateyr := (integer)rc_ssnhighissue/10000;

		dob_year := if( (INTEGER)in_dob != 0, (INTEGER)in_dob[1..4], 0 );
		year_diff := high_issue_dateyr - dob_year;

		ssnprior := if( high_issue_dateyr > 0 and dob_year > 0, if(year_diff BETWEEN -100 AND 2, 1, 0), 0);

		ssnprob2 := if( ssninval=1 or ssndead=1 or ssnprior=1, 1, 0);

		 
		_ssnhighissue_dob_diff := if( length(trim(in_dob))=8 and length(trim(rc_ssnhighissue))=8, 
									(integer)rc_ssnhighissue[1..4] - (integer)in_dob[1..4], 9999);


		_rc_ssnProb := rc_decsflag or rc_ssndobflag=1 or rc_pwssndobflag='1' or rc_ssnvalflag='1' or
					(integer)rc_pwssnvalflag BETWEEN 1 AND 4 or 
					((integer)_ssnhighissue_dob_diff <> 9999 and (integer)_ssnhighissue_dob_diff<=2);

		_ssnProb := max(ssnprob2, _rc_ssnProb);

		_rc_miskeyflag := max(rc_ssnmiskeyflag,rc_hphonemiskeyflag, rc_addrmiskeyflag);
		 

		ModRVT8_fpmod_tmp := 3.3902452452
					  + casserror3_m  * 5.213698077
					  + phone_zip_mismatch_n  * 0.3183113822
					  + disconnect_level  * 0.1937347358
					  + pnotpots  * 0.2454775276
					  + adlperssn_count2_m  * 1.768454522
					  + _ssns_per_adl_l  * 0.7585610341
					  + _adls_per_addr_l  * 0.704643338
					  + _phones_per_addr_l  * 0.2721583866
					  + _adls_per_phone_l  * 0.5856780406
					  + _ssns_per_addr_c6_l  * 0.6308025708
					  + _phones_per_addr_c6_l  * 0.3251178621
					  + _ssnProb  * 0.7435694476
					  + (integer)_rc_miskeyflag * 0.1942936655;
		
		ModRVT8_fpmod := 100 * (exp(ModRVT8_fpmod_tmp )) / (1+exp(ModRVT8_fpmod_tmp ));
		 

 
		// PROPERTY

		property_owned_total_x := if(property_owned_total > 0, 1, 0);
		property_sold_total_x := if(property_sold_total > 0, 1, 0);
		property_ambig_total_x := if(property_ambig_total > 0, 1, 0);


		property_total_x := property_owned_total_x=1 or property_sold_total_x=1 or property_ambig_total_x=1;
		Prop_occupant_Owner := if( sum( add1_occupant_owned, add2_occupant_owned, add3_occupant_owned ) > 0, 1, 0);


		NaProp4_any := if( (add1_naprop = 4 ) or ( add2_naprop = 4 ) or ( add3_naprop = 4 ), 1, 0);

		NaProp3_any := if( ( add1_naprop = 3 ) or ( add2_naprop = 3 ) or ( add3_naprop = 3 ), 1, 0);

		prop_level := Map(add1_naprop = 4 and add2_naprop = 4 => 5,
						  add1_naprop = 4 => 4,
						  NaProp4_any = 1 => 3,
						  property_total_x = true => 3,
						  NaProp3_any = 1 => 2,
						  Prop_occupant_Owner = 1 => 1,
						  0);
					
		prop_level_m := Map(prop_level = 0 => 0.1687474,
							prop_level = 1 => 0.1541667,
							prop_level = 2 => 0.1317140,
							prop_level = 3 => 0.0951265,
							prop_level = 4 => 0.0404348,
							prop_level = 5 => 0.0315615,
							0);
		
		

		// BUREAU

		time_on_header_years_tmp := round( year - (integer)header_first_seen/100 );

		time_on_header_years2 := Map((integer)header_first_seen = 0 => -1,
									 time_on_header_years_tmp > 1000 => -1,
									 time_on_header_years_tmp > 17 => 17,
									 time_on_header_years_tmp);


		_adl_EQ_first_seen_age := if(length(trim(in_dob))=8 and length(trim((string)adl_EQ_first_seen))=6, 
									 (integer)((STRING)adl_EQ_first_seen)[1..4] - (integer)in_dob[1..4], 9999); 
		
		
		_adl_EQ_first_seen_age_i := Map(_adl_EQ_first_seen_age = 9999 => 5,
										_adl_EQ_first_seen_age <= 17 => 6,
										_adl_EQ_first_seen_age <= 20 => 5,
										_adl_EQ_first_seen_age <= 22 => 4,
										_adl_EQ_first_seen_age <= 24 => 3,
										_adl_EQ_first_seen_age <= 28 => 2,
										_adl_EQ_first_seen_age <= 40 => 1,
										0);
		
		
		_adl_EQ_first_seen_age_i_l := Map(_adl_EQ_first_seen_age_i = 0 => -2.575251128,
										  _adl_EQ_first_seen_age_i = 1 => -2.336891781,
										  _adl_EQ_first_seen_age_i = 2 => -2.199183433,
										  _adl_EQ_first_seen_age_i = 3 => -2.149573357,
										  _adl_EQ_first_seen_age_i = 4 => -2.033673116,
										  _adl_EQ_first_seen_age_i = 5 => -1.838231605,
										  _adl_EQ_first_seen_age_i = 6 => -1.383348847,
										  -1.959245953);


		// AGE

		low_issue_year := (integer)rc_ssnlowissue[1..4];
		age_ssn_issue2_tmp := year - low_issue_year;
		age_ssn_issue2 := if(age_ssn_issue2_tmp > 200, 0, if(age_ssn_issue2_tmp > 36, 36, age_ssn_issue2_tmp));
		_combo_dobcount := min(4, combo_dobcount);
		 
		// lres

		_add1_lres := Map(add1_lres=0 => 3,
						  add1_lres<=36 => 2,
						  add1_lres<=120 => 1,
						  0);

		_add1_lres_l := Map(_add1_lres = 0 => -2.888244403,
							_add1_lres = 1 => -2.403432812,
							_add1_lres = 2 => -2.051234536,
							_add1_lres = 3 => -1.269040453,
							-1.959245953);
							
				 
		// derog
		 
		bankrupt_n := (integer)bankrupt;
		_rc_bansflag := ((integer)rc_bansflag <> 0);                      


		_liens_unreleased_histor_f := If(liens_historical_unreleased_ct > 0 or _source_tot_L2=1, 1, 0);
		_liens_unreleased_recent_f := If(liens_recent_unreleased_count  > 0, 1, 0);
		_lien_i := if(_liens_unreleased_recent_f = 1, 2, _liens_unreleased_histor_f);
		
		_criminal_flag := (criminal_count>0);
		_liencriminal_i := if(_criminal_flag, 2, _lien_i);
		_lienCriminalBK2_i := if(_liencriminal_i=0 and _source_addr_ba=1, 1, _liencriminal_i);

	   
		_lienCriminalBk2_i_l  := Map(_lienCriminalBk2_i = 0 => -2.043652426,
									 _lienCriminalBk2_i = 1 => -1.699010105,
									 _lienCriminalBk2_i = 2 => -1.268051657,
									 -1.959245953);
	 
		
		// AVM
		_add1_avm_assessValue := Map(add1_avm_assessed_total_value=0 or add1_avm_assessed_total_value<202436 => 3,
									 add1_avm_assessed_total_value<270200 => 2,
									 add1_avm_assessed_total_value<382700 => 1,
									 0);

		_add1_avm_assessValue_l := Map(_add1_avm_assessValue = 0 => -2.702908787,
									   _add1_avm_assessValue = 1 => -2.531612925,
									   _add1_avm_assessValue = 2 => -2.412494061,
									   _add1_avm_assessValue = 3 => -1.90512748,
									   -1.95924595);
		
		// FINAL MOD
		logit_tmp1 := 0.6575732479
				 + ModRVT8_vermod  * 0.0403676254
				 + prop_level_m  * 4.8233221733
				 + ModRVT8_fpmod  * 0.0261770235
				 + disconnect_level  * 0.0852760301
				 + time_on_header_years2  * -0.024203512
				 + _combo_dobcount  * -0.148875061
				 + _lienCriminalBk2_i_l  * 1.2490121786
				 + _add1_lres_l  * 0.1840050617
				 + _add1_avm_assessValue_l  * 0.3632708418
				 + _adl_EQ_first_seen_age_i_l  * 0.232403009
				 + (integer)_rc_bansflag  * 0.2730089309;

		logit_tmp2 := -0.537749637
				 + ModRVT8_vermod  * 0.0435541648
				 + age_ssn_issue2  * -0.012901052
				 + bankrupt_n  * 0.5875211764
				 + prop_level_m  * 5.6368730063
				 + ModRVT8_fpmod  * 0.0424712145
				 + time_on_header_years2  * -0.041696376
				 + _lienCriminalBk2_i_l  * 1.0347307475
				 + _add1_lres_l  * 0.2894086568;

		logit := if(dobpop > 0, logit_tmp1, logit_tmp2);

		phat := (exp(logit )) / (1+exp(logit ));

		ModRVT8 := round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);  
		 
		 
		RVT711_1_0_tmp := min(900,max(501,ModRVT8));

		//* override */
		 
		ssndead_x := ((integer)ssnlength>0 and rc_decsflag);
		ssnprior_x := (rc_ssndobflag=1 or rc_pwssndobflag='1');
		criminal_flag := (criminal_count>0);
		corrections := (rc_hrisksic=2225);
		

		RVT711_1_0_tmp2 := if( (( RVT711_1_0_tmp>680 ) and (ssndead_x or ssnprior_x or criminal_flag or corrections )), 680, RVT711_1_0_tmp);		
				
		// reason codes
		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
								
								
		// More overrides - Added 5/14/2009 - DU
		// Instead of checking for all 17 reason codes (original request), we are now going to just run the rvReasonCodes logic and check the 4 that are returned. 
		// Modeling understands that doing it this way will not catch every possible override, but it is what the client wants.
		
		 ri := RiskWise.rvReasonCodes(le, 4, inCalif, true); 
		 
		 ri_set := [ri[1].hri, ri[2].hri, ri[3].hri, ri[4].hri];
		 ri_corr_set := [riTemp[1].hri, riTemp[2].hri, riTemp[3].hri, riTemp[4].hri];
		 
	 
     hitRC_02 := '02' IN ri_set; 
     hitRC_92 := '92' IN ri_corr_set;
		 // Ricardo - 7/30/09: Removed the following overrides (and scores below) to fix bug 41978
		 // hitRC_29 := '29' IN ri_set;
		 // hitRC_38 := '38' IN ri_set; 
		 // hitRC_51 := '51' IN ri_set;
		 // hitRC_52 := '52' IN ri_set;
		 // hitRC_72 := '72' IN ri_set;
		 // hitRC_MI := 'MI' IN ri_set;
		 // hitRC_MS := 'MS' IN ri_set;
		 // hitRC_03 := '03' IN ri_set;
		 // hitRC_83 := '83' IN ri_set;
		 // hitRC_39 := '39' IN ri_set;
		 // hitRC_89 := '89' IN ri_set;
		 // hitRC_MN := 'MN' IN ri_set;
		 // hitRC_06 := '06' IN ri_set;
		 // hitRC_26 := '26' IN ri_set;
		 hitRC_93 := '93' IN ri_corr_set;
		                                     
		 
		 // Per Darrin - 6/9/09 - Correction reason codes should be highest priority as those would be the codes returned to the customer.
		 RVT711_1_0_tmp3 := Map(
												hitRC_02 => 200,
												RVT711_1_0_tmp2);
		
		
		
		// Per DU; Move 222 override to last as it is highest priority.
		RVT711_1_0 := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222,	RVT711_1_0_tmp3);	
														
											

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RVT711_1_0 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),		
			ri
		);
		

		self.score := map
		(
			// Overrides for 92 and 93 have already been set. See mapping for RVT711_1_0_tmp3.
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			intformat(RVT711_1_0,3,1)
		);

		self.seq := le.seq;
	
	END;


	final := project(clam, DoModel(left));

	RETURN (final);

END;
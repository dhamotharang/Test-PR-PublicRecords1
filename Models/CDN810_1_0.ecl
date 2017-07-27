/************************************************************************************
 * DELL CBD SCORE                    DELL810                                 by EG  *
 *                                                                        10/01/2008*
 ************************************************************************************

 ************************************************************************************
 * Return CDN810_1_0 score                                                          *
 * Return Billto_Score                                                              *
 * Return Shipto_Score                                                              *
 ************************************************************************************/

import easi, ut, address, riskwise, business_risk, risk_indicators;

export CDN810_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
									dataset(RiskWise.Layout_CD2I) indata,
									boolean IBICID,
									boolean isBusiness, 
									dataset(business_risk.layout_biid_btst_output) biid,
									grouped dataset(Risk_Indicators.Layout_CIID_BtSt_Output) iid_results,
									unsigned1 reasonCodeVersion = 2) := 


FUNCTION

 /************************************************************************************
 * Build Easi census data                                                            *
 ************************************************************************************/
 
//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	used_census_fields := record
		string12 geolink;
		string6 hhsize;			// AverageHouseholdSize
		string6 highinc;		// PercentHouseholdIncome$125,000+(HH00)
		string6 low_ed;			// PercentofAdultswithoutCollegeDegree(POPOVER25)
		string6 ownocp;		  // PercentOwnerOccupiedHousingUnits(HousingUnits)
		string6 span_lang;	// VerySpanish
		string6 unemp;			// PercentUnemployed(POP16+)
		string6 lar_fam;		// Percent Large Family
		string6 med_hhinc;	// Median Household Income
	end;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		used_census_fields easi;
		used_census_fields easi2;
	END;
	
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi census;
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.census.easi := ri;	
		self.census.cd2i.county := le.bill_to_out.shell_input.county;
		self.census.cd2i.state := le.bill_to_out.shell_input.st;
		self.census.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.census.easi2 := ri;
		self.census.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.census.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.census.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self := le;
	END;

	clam_with_easi_tmp := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));

	clam_with_easi := join(indata, clam_with_easi_tmp,
		(left.seq*2) = right.bs.bill_to_out.seq,
		transform(layout_model_in, 
			self.census.cd2i.seq := left.seq,
			self.census.cd2i.avscode    := left.avscode ,
			self.census.cd2i.ordertype  := left.ordertype,
			self.census.cd2i.pymtmethod := left.pymtmethod,
			self.census.cd2i.cidcode    := left.cidcode ,
			self.census.cd2i.orderdate  := left.orderdate,
			self.census.cd2i.channel2  := left.channel2,
			self.census.cd2i.orderamt   := left.orderamt,
			self.census.cd2i.prodcode   := left.prodcode,
			self.census.cd2i.shipmode   := left.shipmode,
			self := right), right outer);
	
	Layout_ModelOut doModel( clam_with_easi le ) := TRANSFORM
		

	 /************************************************************************************
	 * Order Attribute Fields                                                           *
	 ************************************************************************************/
		
		AVS								    := le.census.cd2i.avscode;     		  // Address Verification System
		bcflag							  := le.census.cd2i.ordertype;				// Business/Consumer Flag
		ccresp							  := le.census.cd2i.cidcode;					// CID match variable
		Customer_Create_date	:= le.census.cd2i.orderdate;				// Date first seen at Dell
		local_channel					:= le.census.cd2i.channel2;				 	// Business Channel
		orderamt							:= trim(le.census.cd2i.orderamt);   // Amount of Order
		pmttype						  	:= le.census.cd2i.pymtmethod;			 	// Method of Payment
		risk_level_new				:= le.census.cd2i.prodcode;					// *NEW LEVELS* Product Category expanded to 8 levels from 2.
		shipmode							:= le.census.cd2i.shipmode;					// Shipping mode

	 /************************************************************************************
	 * IP Fields                                                                        *
	 ************************************************************************************/

		IP_continent					:= le.bs.ip2o.continent;	        // IP continent code
		IP_countrycode        := le.bs.ip2o.countrycode;	      // IP country code
		IP_domain_1           := le.bs.ip2o.domain; 						// IP domain name
		IP_secondleveldomain  := le.bs.ip2o.secondleveldomain;	// IP second level domain name
		ip_state              := le.bs.ip2o.state;           	  // IP state code
		IP_topleveldomain     := le.bs.ip2o.topleveldomain;     // IP top level domain name
		ipaddr                := le.bs.ip2o.ipaddr;						  // IP address

			 
	 /************************************************************************************
	 * Name/Address/Email Score Fields                                                  *
	 ************************************************************************************/
			 
		IST_addrscore					:= (INTEGER)le.bs.eddo.addrscore;	 	// Address score
		IST_efirstscore       := (INTEGER)le.bs.eddo.efirstscore; // email first name score
		IST_elastscore        := (INTEGER)le.bs.eddo.elastscore;	// email last name score
		

	 /************************************************************************************
	 * Billto Boca Shell 2.0 Fields                                                         *
	 ************************************************************************************/

		did 					              := le.bs.Bill_To_Out.did;	    																										// Field #3 	 	DID
		truedid 	 			            := le.bs.Bill_To_Out.truedid;																											// Field #4 	 	DID Archive Indicator
		in_state 	 			            := le.bs.Bill_To_Out.shell_input.in_state; 																				// Field #8 	 	Input State
		in_email_address 	 	        := le.bs.Bill_To_Out.shell_input.email_address;																		// Field #30 	Input Email Address
		nas_summary 	 		          := le.bs.Bill_To_Out.iid.nas_summary;																							// Field #34 	Name-Address-SSN verification from InstantID
		nap_summary 	 		          := le.bs.Bill_To_Out.iid.nap_summary;																							// Field #35 	Name-Address-Phone verification from InstantID
		rc_hphonevalflag 	 	        := le.bs.Bill_To_Out.iid.hphonevalflag;																						// Field #49 	Input Phone Validation Indicator (PW)
		rc_phonezipflag 	 	        := le.bs.Bill_To_Out.iid.phonezipflag;																						// Field #51 	Input Phone to Zip Code Match Indicator (PI)
		rc_phoneaddr_addrcount 	    := le.bs.Bill_To_Out.iid.phoneaddr_addrcount;																			// Field #80 	Number of Phone Sources confirming Address (Address Search)
		age 	 				              := le.bs.Bill_To_Out.name_verification.age;																				// Field #173 	Age calculated from ADL DOB
		add1_isbestmatch 	 	        := le.bs.Bill_To_Out.address_verification.input_address_information.isbestmatch;	// Field #176 	Input Address matches Best Address (1 := yes)
		add1_naprop 	 		          := le.bs.Bill_To_Out.address_verification.input_address_information.naprop;	      // Field #203 	Name-Address-Property ownership results:
		add1_census_income 	 	      := le.bs.Bill_To_Out.address_verification.input_address_information.census_income;// Field #218 	Census Tract Median Income
		property_owned_total 	      := le.bs.Bill_To_Out.address_verification.owned.property_total;										// Field #222 	Number of owned properties
		add2_isbestmatch 	 	        := le.bs.Bill_To_Out.address_verification.address_history_1.isbestmatch;					// Field #242 	Address matches Best Address (1 := yes)
		telcordia_type 	 	          := le.bs.Bill_To_Out.phone_verification.telcordia_type;														// Field #329 	*  00 := Regular (Plain Old Telephone Service (POTS))
		adls_per_addr_c6 	 	        := le.bs.Bill_To_Out.velocity_counters.adls_per_addr_created_6months;							// Field #357 	Current # of Unique ADLs Found with Input Address in Past 6 Months
		ssns_per_addr_c6 	 	        := le.bs.Bill_To_Out.velocity_counters.ssns_per_addr_created_6months;							// Field #358 	Current # of Unique SSNs Found with Input Address in Past 6 Months
		rel_within25miles_count 	  := le.bs.Bill_To_Out.relatives.relative_within25miles_count;											// Field #397 	Number of Relatives 0 - 25 miles
		watercraft_count 	 	        := le.bs.Bill_To_Out.watercraft.watercraft_count;																	// Field #427 	Number of Watercraft Currently Owned
		inferred_dob 	 		          := le.bs.Bill_To_Out.reported_dob;																								// Field #454 	Pre-Calcd Inferred DOB (YYYYMMDD)
		archive_date           := if(le.bs.bill_to_out.historydate=999999, 
																	(integer)(ut.GetDate), 
																	(integer)risk_indicators.iid_constants.full_history_date(le.bs.bill_to_out.historydate) ); 
																	// corrected the selection of the archive date
																	// in realtime transactions, most people were getting high scores because everyone appeared older than they are,
																	// and had longer customer_tenure than they actually do
																	



	 /************************************************************************************
	 * Shipto Boca Shell Fields                                                         *
	 ************************************************************************************/

		did_s	 			                := le.bs.Ship_To_Out.did;																																// Field #3 	 	DID
		truedid_s	 			            := le.bs.Ship_To_Out.truedid;																														// Field #4 	 	DID Archive Indicator
		in_state_s	 		            := le.bs.Ship_To_Out.shell_input.in_state;																							// Field #8 	 	Input State
		nas_summary_s	 		          := le.bs.Ship_To_Out.iid.nas_summary;																										// Field #34 	Name-Address-SSN verification from InstantID
		nap_summary_s	 		          := le.bs.Ship_To_Out.iid.nap_summary;																										// Field #35 	Name-Address-Phone verification from InstantID
		rc_hphonevalflag_s	 	      := le.bs.Ship_To_Out.iid.hphonevalflag; 																								// Field #49 	Input Phone Validation Indicator (PW)
		rc_phonezipflag_s	 	        := le.bs.Ship_To_Out.iid.phonezipflag;																									// Field #51 	rc_phonezipflag 
		rc_sources_s	 		          := le.bs.Ship_To_Out.iid.sources;																												// Field #69	 	Header Sources
		age_s				                := le.bs.Ship_To_Out.name_verification.age;																							// Field #173 	Age calculated from ADL DOB
		add1_naprop_s	 		          := le.bs.Ship_To_Out.address_verification.input_address_information.naprop;							// Field #203 	Name-Address-Property ownership results:
		add1_census_income_s	      := le.bs.Ship_To_Out.address_verification.input_address_information.census_income;			// Field #218 	Census Tract Median Income
		add1_census_education_s	    := le.bs.Ship_To_Out.address_verification.input_address_information.census_education;		// Field #220	Census Tract Median Education
		telcordia_type_s	 	        := le.bs.Ship_To_Out.phone_verification.telcordia_type;																	// Field #329 	*  00 := Regular (Plain Old Telephone Service (POTS))
		phones_per_adl_c6_s	 	      := le.bs.Ship_To_Out.velocity_counters.phones_per_adl_created_6months;									// Field #354	Current # of Unique Phones per ADL in the Past 6 Months
		adls_per_addr_c6_s	 	      := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;										// Field #357 	Current # of Unique ADLs Found with Input Address in Past 6 Months
		wealth_index_s	 		        := le.bs.Ship_To_Out.wealth_indicator;																									// Field #453	Pre-Calculated Wealth Index
		inferred_dob_s	 		        := le.bs.Ship_To_Out.reported_dob;																											// Field #454	Pre-Calculated Inferred DOB
																
	 /************************************************************************************
	 * Billto EASI Census Fields                                                        *
	 ************************************************************************************/

		c_hhsize 		 					:= le.census.easi.hhsize;			// AverageHouseholdSize
		c_highinc 		 				:= le.census.easi.highinc;		// PercentHouseholdIncome$125,000+(HH00)
		c_low_ed 		 					:= le.census.easi.low_ed;			// PercentofAdultswithoutCollegeDegree(POPOVER25)
		c_ownocc_p 		 				:= le.census.easi.ownocp;		  // PercentOwnerOccupiedHousingUnits(HousingUnits)
		c_span_lang 		 			:= le.census.easi.span_lang;	// VerySpanish
		c_unemp 		 					:= le.census.easi.unemp;			// PercentUnemployed(POP16+)


	 /************************************************************************************
	 * Shipto EASI Census Fields                                                        *
	 ************************************************************************************/

		c_hhsize_s		 				:= le.census.easi2.hhsize;	  // AverageHouseholdSize
		c_lar_fam_s		 				:= le.census.easi2.lar_fam;		// Percent Large Family
		c_low_ed_s		 				:= le.census.easi2.low_ed;		// PercentofAdultswithoutCollegeDegree(POPOVER25)
		c_med_hhinc_s		 			:= le.census.easi2.med_hhinc;	// Median Household Income
		c_unemp_s		 					:= le.census.easi2.unemp;			// PercentUnemployed(POP16+)


	 /************************************************************************************
	 * CODE STARTS HERE                                                                 *
	 ************************************************************************************/

	/*** OFFSETS ***/

		//*MAIN MODEL;
		
		bt_offset   := ln(((1-.00508)*.02488)/(.00508*(1-.02488)));
		st_offset   := ln(((1-.06392)*.25452)/(.06392*(1-.25452)));
		bubt_offset := ln(((1-.00221)*.01097)/(.00221*(1-.01097)));
		bust_offset := ln(((1-.01827)*.08512)/(.01827*(1-.08512)));
		
		//*SUBMODELS;
		
		bt_bt_c_offset := ln(((1-.00508)*.02488)/(.00508*(1-.02488)));
		bt_bt_b_offset := ln(((1-.00221)*.01097)/(.00221*(1-.01097)));
		st_st_c_offset := ln(((1-.06392)*.25452)/(.06392*(1-.25452)));
		st_st_b_offset := ln(((1-.01827)*.08512)/(.01827*(1-.08512)));
		bt_st_c_offset := ln(((1-.06392)*.25452)/(.06392*(1-.25452)));
		bt_st_b_offset := ln(((1-.01827)*.08512)/(.01827*(1-.08512)));


	/*** AVS ***/

		//*SHARED VARS;
			
			new_avs := Map( avs in ['**',' ']    =>  'NO RESPONSE',
											avs in ['0','S','5'] =>  'NOT SUPPORTED',
											avs in ['O','X','Y'] =>  'FULL MATCH', 
											avs in ['A','F','Z','E'] =>  'ADD/ZIP',
											avs in ['K','L']	   =>  'NAME/ZIP',
											avs in ['R','U']	   =>  'SYS UNAVAIL',
											avs in ['N','W']      =>  'NO MATCH',
											avs in ['D','M']	   =>  'INT MATCH',
											avs in ['G']	       =>  'NO MATCH - INT',
											'CATCHALL');
		
		//*BILLTO;	
			
			bt_avsX := Map( new_avs = 'FULL MATCH' and pmttype in ['A','M','V','O','Q','R']																   => 1,
											new_avs = 'INT MATCH' and pmttype = 'A'		            															 => 2,
											(new_avs = 'FULL MATCH' and pmttype != 'P') or (new_avs = 'ADD/ZIP' and pmttype='V') => 3,
											new_avs = 'ADD/ZIP' and pmttype != 'P'																							 => 4,
											new_avs = 'NAME/ZIP' and pmttype = 'A'																							 => 6,
											new_avs = 'NO MATCH' and pmttype not in ['A','P']																     => 7,
											new_avs = 'NOT SUPPORTED' or pmttype = 'P' 																					 => 8,
											new_avs in ['NO MATCH - INT','NO MATCH'] or (new_avs='SYS UNAVAIL' and pmttype='A')	 => 9,
																																																				      5);
		
		//*SHIPTO;
			
			st_avsX := Map(pmttype in ['M','V','O','Q','R'] and new_avs in 
												['ADD/ZIP','FULL MATCH','INT MATCH','NAME/ZIP','NO MATCH','NO RESPONSE'] => 1,
											pmttype='A' and new_avs='INT MATCH'																				 => 2,
											pmttype='A' and new_avs='FULL MATCH'																			 => 3,
											pmttype='A' and new_avs in ['ADD/ZIP','NAME/ZIP','NO MATCH']							 => 4,
											pmttype in ['M','V','O','Q','R']																										   => 5,
											pmttype in ['C','D','P']																									 => 6,
																																																		7);
		
		//*BUSINESS BILLTO;
		
			bubt_avsXchan := Map( local_channel in ['45','05','13']																							=> 0,
														local_channel='08' and new_avs='FULL MATCH'																=> 0,
														local_channel in ['04','08'] and new_avs in ['ADD/ZIP','FULL MATCH']			=> 1,
														new_avs in ['NO MATCH - INT','NO RESPONSE','NOT SUPPORTED','SYS UNAVAIL'] => 4,
														new_avs='NO MATCH'																												=> 3,
														new_avs='NAME/ZIP' and local_channel in ['12','28']												=> 3,
																																																				 2);
			

	/*** VERIFICATION ***/

		//*BILLTO;
		
			bt_nap := Map(nap_summary >= 11	  			=> 4,
										nap_summary >= 8					=> 3,
										nap_summary >= 5					=> 2,
																		             1); 
																								
			bt_nap1 := if(rc_phoneaddr_addrcount=0, bt_nap - 1, bt_nap);
																								
			bt_nas := Map(nas_summary >= 8 => 3,
										nas_summary >= 2 => 2,
																				1);
																								
			bt_verx := Map( bt_nap1 = 0 and bt_nas = 1			=> 0,
											bt_nap1 = 0 and bt_nas = 2			=> 1,
											bt_nap1 = 1 and bt_nas = 1			=> 2,
											bt_nap1 = 0											=> 4,
											(bt_nap1 < 3 and bt_nas = 3) or 	
												(bt_nap1 = 3 and bt_nas = 2) or 	
												(bt_nap1 = 4 and bt_nas = 1)	=> 5,
											bt_nap1 = 3 and bt_nas = 3			=> 6,
											bt_nap1 = 4											=> 7,
																												 3);
			
		//*SHIPTO;
		 INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		
				 _source_tot_AK_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'AK,') > 0);
				 _source_tot_AM_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'AM,') > 0);
				 _source_tot_AR_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'AR,') > 0);
				 _source_tot_BA_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'BA,') > 0);
				 _source_tot_CG_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'CG,') > 0);
				 _source_tot_CO_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'CO,') > 0);
				 _source_tot_DA_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'DA,') > 0);
				 _source_tot_D_s  := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'D ,') > 0);
				 _source_tot_DS_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'DS,') > 0);
				 _source_tot_EB_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'EB,') > 0);
				 _source_tot_EM_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'EM,') > 0);
				 _source_tot_EQ_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'EQ,') > 0);
				 _source_tot_FF_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'FF,') > 0);
				 _source_tot_FR_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'FR,') > 0);
				 _source_tot_L2_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'L2,') > 0);
				 _source_tot_LI_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'LI,') > 0);
				 _source_tot_MW_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'MW,') > 0);
				 _source_tot_P_s  := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'P ,') > 0);
				 _source_tot_PL_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'PL,') > 0);
				 _source_tot_TU_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'TU,') > 0);
				 _source_tot_V_s  := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'V ,') > 0);
				 _source_tot_W_s  := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'W ,') > 0);
				 _source_tot_WP_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'WP,') > 0);
				 _source_tot_VO_s := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources_s), 'VO,') > 0);
     	
				 _source_tot_EM_VO_s   := if(_source_tot_EM_s=1 or _source_tot_VO_s=1, 1, 0);			/* Combine EM and VO sources */
			
					num_pos_sources_tot_s :=  _source_tot_AM_s + 
																		_source_tot_AR_s + 
																		_source_tot_CG_s + 
																		_source_tot_D_s + 
																		_source_tot_EB_s + 
																		_source_tot_EM_VO_s + 
																		_source_tot_EQ_s + 
																		_source_tot_MW_s + 
																		_source_tot_P_s + 
																		_source_tot_PL_s + 
																		_source_tot_TU_s + 
																		_source_tot_V_s + 
																		_source_tot_W_s + 
																		_source_tot_WP_s;
																	
															 
		/*** END SHARED VAR ***/
															 
			st_num_pos_sources_tot_s :=	Map(num_pos_sources_tot_s =  0		=> 0,
																			num_pos_sources_tot_s <= 2		=> 2,
																																		   3);
			
		//*** ShipTo ***;
			
			st_nap_s := Map(nap_summary_s = 12					=> 3,
											nap_summary_s in [9,10,11]	=> 2,
											nap_summary_s in [5,6,7,8]	=> 1,
																									   0);
			
			st_nas_s := if(nas_summary_s != 0, 1, 0);
			st_verx_s := if(st_nas_s =1, st_nap_s + 1, st_nap_s);
			
		//*** BillTo ***;
			
			st_nap :=	if(nap_summary in [8,9,10,11,12], 1, 0);
			st_nas := if(nas_summary != 0, 1, 0);
																				
			st_verx := Map(st_nap =1 and st_nas =1 => 2,
										 st_nap =1 or st_nas =1  => 1,
																						    0);
			
		//*** VERX ***;
			
			st_verX1 := Map(st_verx_s = 4																			 => 7,
											st_verx_s = 3																			 => 6,
											st_verx_s = 2 and st_verx != 0										 => 5,
											(st_verx_s = 1 and st_verx != 0) or st_verx_s = 2	 => 4,
											st_verx_s = 1																			 => 3,
											st_verx = 2																				 => 2,
											st_verx = 1																				 => 1,
																																						0);
			
			
			
			st_verX2 := Map(st_verX1 = 7 and st_num_pos_sources_tot_s = 3	=> 8,
											st_verX1 >= 6																	=> 7,
											st_verX1 = 5																	=> 6,
											st_verX1 = 4 and st_num_pos_sources_tot_s = 3	=> 5,
																																	st_verX);
		
		//*BUSINESS BILLTO;
			
			bubt_verX := Map( nap_summary = 1 and rc_hphonevalflag = '1'					    => 0,
												nap_summary in [1,6] and rc_hphonevalflag in ['1','5']	=> 1,
												nap_summary = 0 and rc_hphonevalflag = '0'  						=> 5,
												nap_summary > 0 and rc_hphonevalflag = '5'	  					=> 3,
												nap_summary <=8 and rc_hphonevalflag !='1'		  				=> 4,
												nap_summary = 0																	    		=> 4,
																																						    	 2);
		
		//*BUSINESS SHIPTO;
		
			high_nap_s_ver := (nap_summary_s in [6,10,11,12]);
			med_nap_s_ver  := (nap_summary_s in [1,2,3,4,5,7,8,9]);
			low_nap_s_ver  := (nap_summary_s = 0);
			
			bust_nap_s :=	Map(rc_hphonevalflag_s = '1' and high_nap_s_ver => 9,
												rc_hphonevalflag_s = '5' and high_nap_s_ver => 8,
												rc_hphonevalflag_s = '1' and med_nap_s_ver  => 7,
												rc_hphonevalflag_s = '1' and low_nap_s_ver  => 6,
												rc_hphonevalflag_s = '2' and high_nap_s_ver => 5,
												rc_hphonevalflag_s = '5' and med_nap_s_ver  => 4,
												rc_hphonevalflag_s = '2' and med_nap_s_ver  => 3,
												rc_hphonevalflag_s = '5' and low_nap_s_ver  => 1,
												rc_hphonevalflag_s = '2' and low_nap_s_ver	=> 0,
																																	   2);
			
			bust_nas_s := (nas_summary_s != 0);


	/*** IP VARIABLES ***/
		
		//*SHARED VARS;
		
			na_flag := (IP_continent = '5');
			us_flag := (StringLib.StringToUpperCase(trim(IP_countrycode)) = 'US'); 
			state_match_flag := (StringLib.StringToUpperCase(trim(ip_state)) = StringLib.StringToUpperCase(trim(in_state)));
			
			ip_state_match := (na_flag and us_flag and state_match_flag);
			
			ip_mil_gov := (StringLib.StringToUpperCase(trim(IP_topleveldomain)) in ['MIL','GOV']);
			aol_domain := (StringLib.StringToUpperCase(trim(IP_secondleveldomain)) = 'AOL');		
			
			state_match_s := (StringLib.StringToUpperCase(trim(ip_state)) = StringLib.StringToUpperCase(trim(in_state_s)));
			state_match_st := (StringLib.StringToUpperCase(trim(in_state)) = StringLib.StringToUpperCase(trim(in_state_s)));
			
			dot_mil := (StringLib.StringToUpperCase(trim(IP_topleveldomain)) = 'MIL');
			dot_gov := (StringLib.StringToUpperCase(trim(IP_topleveldomain)) = 'GOV');
		
			ip_domain_dot := (contains_i(ip_toplevelDomain, '.') > 0);
			
			// get the domain suffix
			IP_domain_1_rev := Stringlib.StringReverse(IP_domain_1);
			dot_position := Stringlib.StringFind(IP_domain_1_rev, '.', 1);
			suffix_rev := IP_domain_1_rev[1..dot_position-1];
			ip_suffix := Stringlib.StringReverse(suffix_rev);		
			
			
			IP_domain := if( StringLib.StringToUpperCase(ip_suffix) not in ['COM','NET','GOV','MIL','EDU',' '], 
												'OTHER', StringLib.StringToUpperCase(ip_suffix));
		
		//*BILLTO;
			
			bt_ip_geoLocation := Map( length(trim(ipaddr))>0 and ip_state_match	=> 2,
																length(trim(ipaddr))>0 and aol_domain			=> 2,
																length(trim(ipaddr))>0 and us_flag				=> 1,
																length(trim(ipaddr))>0 										=> 0,
																																						-1);

			
			bt_ip_geoLocationX := Map(ip_mil_gov						=> 3,
																bt_ip_geoLocation=2		=> 2,
																bt_ip_geoLocation=1		=> 1,
																bt_ip_geoLocation=0		=> 0,
																											  -1);	
		
		//*SHIPTO;
			
			st_ip_geoLocation := Map(length(trim(ipaddr)) > 0 and ip_state_match => 3,
																length(trim(ipaddr)) > 0 and aol_domain		 => 2,
																length(trim(ipaddr)) > 0 and us_flag			 => 1,
																length(trim(ipaddr)) > 0 						    	 => 0,
																																						 -1);

			
			st_ip_geoLocationX := Map(ip_mil_gov																		=>  5,
																st_ip_geolocation >= 2 and state_match_st			=>  5,
																st_ip_geolocation =  1 and state_match_st			=>  4,
																st_ip_geolocation =  0 and state_match_st			=>  3,
																st_ip_geolocation = -1 and state_match_st			=> -1,
																st_ip_geolocation =  3 and not state_match_st	=>  2,
																st_ip_geolocation >= 1 and not state_match_st	=>  1,
																st_ip_geolocation =  0 and not state_match_st	=>  0,
																st_ip_geolocation = -1 and not state_match_st	=> -1,
																																								 -2);
		
			
			st_ip_domain := Map(length(trim(ipaddr)) > 0 and ip_domain_dot					            => 0,
													length(trim(ipaddr)) > 0 and ip_domain = ' '   									=> 1,
													length(trim(ipaddr)) > 0 and ip_domain in ['OTHER','COM','NET']	=> 2,
													length(trim(ipaddr)) > 0 and ip_domain in ['EDU']								=> 3,
													length(trim(ipaddr)) > 0 and ip_domain in ['GOV','MIL']					=> 4,
																																													  -1);
		
		//*BUSINESS BILLTO;
			
			bubt_ip_geoLocation := Map( length(trim(ipaddr)) > 0 and ip_state_match			=> 2,
																 	length(trim(ipaddr)) > 0 and aol_domain	 				=> 2,
																	length(trim(ipaddr)) > 0 and us_flag						=> 1,
																	length(trim(ipaddr)) > 0 									  		=> 0,
																																										-1);
			
			bubt_ip_geoLocationX := Map(ip_mil_gov							=> 3,
																	bubt_ip_geoLocation=2		=> 2,
																	bubt_ip_geoLocation=1		=> 1,
																	bubt_ip_geoLocation=0		=> 0,
																														-1);
		
		//*BUSINESS SHIPTO;
			
			bust_ip_geoLocation := Map( length(trim(ipaddr)) > 0 and ip_mil_gov			=> 3,
																	length(trim(ipaddr)) > 0 and ip_state_match	=> 2,
																	length(trim(ipaddr)) > 0 and aol_domain			=> 2,
																	length(trim(ipaddr)) > 0 and us_flag				=> 1,
																	length(trim(ipaddr)) > 0 										=> 0,
																																								-1);
																		
																	
			bust_ip_geoLocationX := Map(bust_ip_geoLocation =3										=> 5,
																	bust_ip_geoLocation =2 and state_match_st	=> 4,
																	bust_ip_geoLocation =1 and state_match_st	=> 3,
																	bust_ip_geoLocation =0 and state_match_st	=> 2,
																	bust_ip_geoLocation =2										=> 2,
																	bust_ip_geoLocation =1										=> 1,
																	bust_ip_geoLocation =0										=> 0,
																																							-1);

	/*** EMAIL VARS ***/

		//*SHARED VARS;
		
			email_has_dot := (contains_i(in_email_address, '.') > 0);
			prov_start := StringLib.StringFind(in_email_address, '@', 1)+1;
			prov_end   := length(trim(in_email_address)); 
		
			email_provider := if( email_has_dot, StringLib.StringToUpperCase(in_email_address[prov_start..prov_end]), '');
			
			// get email_provider_without_suffix
			email_dot_position := Stringlib.StringFind(email_provider, '.', 1);
			email_provider_without_suffix := email_provider[1..email_dot_position-1];
			
			email_provider2 := Map(length(trim(in_email_address)) > 0 and 
																email_provider_without_suffix not in 
																['HOTMAIL','GMAIL','AOL','YAHOO','VERIZON','SBCGLOBAL','MSN','COMAST'] 	=> 'OTHER',
														 length(trim(in_email_address)) > 0 => email_provider_without_suffix,
														 'NO EMAIL');

		
		
		//*BILLTO;
		
			bt_email_score := Map(IST_efirstscore=3 or IST_elastscore=3		=> 3,
														IST_efirstscore=2 or IST_elastscore=2		=> 2,
														IST_efirstscore=1 or IST_elastscore=1		=> 1,
														IST_efirstscore=0 or IST_elastscore=0		=> 0,
																																			-1);
		
		
		//*SHIPTO;
		
			st_email_score := Map(IST_efirstscore = 3 and IST_elastscore = 1	=> 5,
														IST_efirstscore = 3 and IST_elastscore >=2	=> 4,
														IST_efirstscore = 1 and IST_elastscore = 0	=> 2,
														IST_efirstscore = 1 and IST_elastscore = 1	=> 1,
														IST_efirstscore =-1 and IST_elastscore =-1	=>-1,
														IST_efirstscore < 1 and IST_elastscore < 1	=> 0,
																																					 3);
		
		//*BUSINESS SHIPTO;
		
			bust_email_score := Map(IST_efirstscore = 3 and IST_elastscore = 1	=> 4,
															IST_efirstscore = 3 and IST_elastscore >=2	=> 3,
															IST_efirstscore = 1 and IST_elastscore = 0	=> 2,
															IST_efirstscore =-1 and IST_elastscore =-1	=>-1,
															IST_efirstscore < 1 and IST_elastscore < 1	=> 0,
																																						 1);
		

	/*** PROPERTY ***/
		
		//*BILLTO;
		
			bt_add1_proptree := Map(add1_naprop = 4 and property_owned_total > 0	=> 4,
															add1_naprop = 4																=> 3,
															add1_naprop = 3																=> 2,
															property_owned_total > 0											=> 1,
																																						   0);
		
		//*SHIPTO;
		
			st_best_match_level := Map(add1_isbestmatch 	=> 2,
																 add2_isbestmatch 	=> 1,
																                  	   0);
			
		
			st_add1_naprop := if( (add1_naprop = 3), 2, add1_naprop);
			st_add1_naprop_s := if( (add1_naprop_s = 3), 2, add1_naprop_s);
				
			st_add1_proptree := Map(st_add1_naprop   = 0 and st_add1_naprop_s = 4	=> 9,
															st_add1_naprop   = 4 and st_add1_naprop_s = 4	=> 8,
															st_add1_naprop_s = 4 													=> 7,
															st_add1_naprop   = 0 and st_add1_naprop_s = 2	=> 6,
															st_add1_naprop_s = 2													=> 4,
															st_add1_naprop   = 0 and st_add1_naprop_s = 1	=> 4,
															st_add1_naprop   = 0 and st_add1_naprop_s = 0	=> 5,
															st_add1_naprop   = 4 and st_add1_naprop_s = 1	=> 3,
															st_add1_naprop_s = 1													=> 2,
															st_add1_naprop >= 2														=> 1,
															st_add1_naprop   = 1													=> 0,
																																						  -1);
			
			st_proptree := Map( st_add1_proptree = 9 and st_best_match_level = 2	=> 11,
													st_add1_proptree = 9															=> 10,
													st_add1_proptree = 8															=> 9,
													st_add1_proptree = 7 and st_best_match_level != 0	=> 9,
													st_add1_proptree = 7															=> 8,
													st_add1_proptree = 6 and st_best_match_level != 0	=> 8,
													st_add1_proptree = 6															=> 7,
													st_add1_proptree = 5 and st_best_match_level = 2	=> 7,
													st_add1_proptree = 4 and st_best_match_level = 2	=> 6,
													st_add1_proptree >=3 and st_best_match_level = 1	=> 5,
													st_add1_proptree >=2 and st_best_match_level = 2	=> 5,
													st_add1_proptree >=3 and st_best_match_level = 0	=> 4,
													st_add1_proptree = 2 and st_best_match_level = 1	=> 4,
													st_add1_proptree = 1 and st_best_match_level >=1	=> 3,
													st_add1_proptree = 0 and st_best_match_level = 2	=> 3,
													st_add1_proptree = 0 and st_best_match_level = 1	=> 2,
													st_add1_proptree >= 1															=> 1,
													st_add1_proptree = 0 and st_best_match_level = 0	=> 0,
																																						  -1);
		
	//*BUSINESS SHIPTO;
		
			bust_add1_naprop   := add1_naprop;  
			bust_add1_naprop_s := add1_naprop_s;
		
			bust_add1_proptree := Map(bust_add1_naprop = 0 and bust_add1_naprop_s = 4	=> 5,
																bust_add1_naprop = 0 or  bust_add1_naprop_s = 4	=> 4,
																bust_add1_naprop = 1 and bust_add1_naprop_s = 2	=> 3,
																bust_add1_naprop = 1 and bust_add1_naprop_s = 1	=> 2,
																bust_add1_naprop = 2 and bust_add1_naprop_s = 2	=> 2,
																bust_add1_naprop = 4 and bust_add1_naprop_s = 0	=> 0,
																																								   1);	
		
	/*** PHONE ***/
		
	//*BILLTO;
		
			bt_phnprob := Map(rc_phonezipflag = '1'															=> 2,
												telcordia_type not in ['00','50','51','52','54']	=> 1,
																																					   0);
		
	//*SHIPTO;
		
			st_phnprob_s := Map(rc_phonezipflag_s = '1'					  									=> 2,
													telcordia_type_s not in ['00','50','51','52','54']	=> 1,
																																							   0);
		
	//*BUSINESS BILLTO;
			
			bubt_phnprob := Map(rc_phonezipflag = '1'															=> 2,
													telcordia_type not in ['00','50','51','52','54']	=> 1,
																																					     0);
		
	//*BUSINESS SHIPTO;
		
			bust_phnprob_s := Map(rc_hphonevalflag_s = '0'				  									=> 3,
														rc_phonezipflag_s = '1'													  	=> 2,
														telcordia_type_s not in ['00','50','51','52','54']	=> 1,
																																									 0);
		
	/*** PRODUCT TYPE ***/
		
		/*** EXPECT NEW PRODUCT CODE VARIABLE IN PRODUCTION ***/
																														
			prod_code_new := if( length(trim(risk_level_new)) > 0, (integer)risk_level_new, -9999);																																							
			
			orderamt_n := (Real)orderamt;
		
	//*BILLTO;
			
			bt_prodXamt := Map( prod_code_new = 1															=> 0,
													prod_code_new = 0 and orderamt_n <1000				=> 0,
													prod_code_new = 0															=> 1,
													prod_code_new in [2,3] and orderamt_n < 1000	=> 1,
													prod_code_new in [2,3]												=> 2,
													orderamt_n < 500															=> 3,
																																					 4);
																																					 		
	//*SHIPTO;
			
			st_prodXamt := Map( prod_code_new = 1															=> 0,
													prod_code_new = 0 and orderamt_n <1000				=> 0,
													prod_code_new = 0															=> 1,
													prod_code_new in [2,3] and orderamt_n < 1000	=> 1,
													prod_code_new in [2,3]												=> 2,
													orderamt_n < 500															=> 3,
																																				   4);
		
	//*BUSINESS BILLTO;
			
			bubt_prodXamt := Map( prod_code_new in [0,1,2]									=> 0,
														prod_code_new in [3,4]										=> 1,
														prod_code_new = 5													=> 2,
														prod_code_new = 6 and orderamt_n < 500		=> 2,
																																				 3);
		
	//*BUSINESS SHIPTO;
			
			bust_prodXamt := Map( prod_code_new = 1													=> 0,
														prod_code_new = 0 and orderamt_n <1000		=> 0,
														prod_code_new = 0													=> 1,
														prod_code_new = 2 and orderamt_n < 750		=> 1,
														prod_code_new in [3,4]										=> 2,
														prod_code_new = 2													=> 3,
														prod_code_new =5 or orderamt_n < 500			=> 4,
																																		     5);

	/*** SHIPPING MODE ***/

	//*SHARED VARS;
		
			/* SHIPMODE2 IS PRODUCTION SHIPPING VARIABLE */
			
			bracket1 := ')';
			bracket2 := '[';
  		shipmode_new := Map(shipmode in [bracket1,'L','U','X']		  		=> 'GROUND',
													shipmode in ['7','B','R','W']		  		=> '2ND DAY',
													shipmode in ['2','^','N','Y','1','!']	=> 'NEXT DAY',
													shipmode in [bracket2]							 			  => 'HOME DELIVERY',
																																		 'OTHER');
		
	//*BILLTO;
			
			bt_shipmode := Map( shipmode_new='NEXT DAY'			=> 0,
													shipmode_new='2ND DAY'			=> 1,
																												 2);
		
	//*SHIPTO;
			
			st_shipmode := Map( shipmode_new='NEXT DAY'			=> 0,
													shipmode_new='2ND DAY'			=> 1,
																												 2);
		
	//*BUSINESS BILLTO;
			
			bubt_shipmode := Map(shipmode_new='NEXT DAY'		=> 0,
													 shipmode_new='2ND DAY'			=> 1,
													 								               2);
		
	//*BUSINESS SHIPTO;
			
			bust_shipmode := Map(shipmode_new='NEXT DAY'			=> 0,
												shipmode_new='2ND DAY'			=> 1,
																											 2);
		
	/*** CUSTOMER TENURE ***/

	//*SHARED VARS;
			
			systemdate := archive_date;
		
			INTEGER mdy( integer month, integer day, integer year ) := ut.DaysSince1900( (string4)year, (string2)month, '01' ) + (day - 1);			
			
			system_date_days := mdy((integer)systemdate[5..6], (integer)systemdate[7..8], (integer)systemdate[1..4]);			

			create_date_days := mdy((integer)Customer_Create_date[5..6], (integer)Customer_Create_date[7..8], (integer)Customer_Create_date[1..4]);
			
			days_since_first := system_date_days - if(create_date_days<0, system_date_days, 
																									if(create_date_days > system_date_days, system_date_days, create_date_days)); //*CUST VAR;
			
		
	//*BILLTO;
			
			bt_existing_cust := (days_since_first > 120);
		
	//*SHIPTO;
			
			st_existing_cust := (days_since_first > 60);
		
	//*BUSINESS BILLTO;
												
			bubt_cust_tenure_lg := ln(max(days_since_first,.01));
		
	//*BUSINESS SHIPTO;
												
			bust_cust_tenure_lg := ln(max(days_since_first,.01));
			
		
	/*** CID MATCH ***/

	//*BILLTO;
		
			bt_cid_match := (ccresp in ['M','Y']);
		
	//*SHIPTO;
		
			st_cid_match := (ccresp in ['M','Y']);
		
	//*BUSINESS BILLTO;
		
			bubt_cid_match := Map(ccresp in ['M','**','Y']	=>  1,
														ccresp = 'N'					=> -1,
																						          0);
		
		
	/*** VELOCITY ***/
		
	//*BILLTO;
		
			bt_adls_ssns_per_addr_c6 :=	Map( (adls_per_addr_c6 <= 0 and ssns_per_addr_c6 <= 0)	=> 0,
																			 (adls_per_addr_c6 <= 1 and ssns_per_addr_c6 <= 1)	=> 1,
																			 (adls_per_addr_c6 <= 2 and ssns_per_addr_c6 <= 2)	=> 2,
																			 (adls_per_addr_c6 <= 3 and ssns_per_addr_c6 <= 3)	=> 3,
																																														 4);
		
	//*SHIPTO;
		
			st_adls_per_addr_c6_s_5 := min(max(adls_per_addr_c6_s,0),5);
		
	//*BUSINESS SHIPTO;
		
			bust_adls_per_addr_c6_s_2  := min(max(adls_per_addr_c6_s,0),2);	
			bust_phones_per_adl_c6_s_2 := min(max(phones_per_adl_c6_s,0),2);


	/*** CENSUS ***/
		
	//*BILLTO;
		
			bt_c_hhsize_lg := ln(min(max((real)c_hhsize,1),5));
			bt_c_low_ed 	 := min(max((real)c_low_ed,1),100);
			bt_c_unemp_lg  := ln(min(max((real)c_unemp,.01),15));
		
	//*SHIPTO;
		
  		st_add1_census_education2_s := Map( (integer)add1_census_education_s = 0			=> 14,
																					length(trim(add1_census_education_s))>0 	=> min(max((integer)add1_census_education_s, 9), 16),
																																											 14);
		
			st_c_hhsize_s 	  := min(max((real)c_hhsize_s,1),5);
		
	//*BUSINESS BILLTO;
		
			bubt_c_highinc    := min(max((real)c_highinc,.01),100);
		
		  bubt_c_low_ed 		:= if( length(trim(c_low_ed))>0, min(max((real)c_low_ed,.01),100), 60);
		
		
	//*BUSINESS SHIPTO;
		
		
			bust_c_hhsize_s 	:= min(max((real)c_hhsize_s,1),5);
		
			bust_c_med_hhinc_s := if( length(trim(c_med_hhinc_s))=0, 100000, min(max((real)c_med_hhinc_s,1),200000));


	/*** AGE *** SHIPTO VAR ONLY ***/
		
			inferred_dob_date_days_billto := mdy((integer)inferred_dob[5..6], (integer)inferred_dob[7..8], (integer)inferred_dob[1..4]);
			days_since_dob_billto := system_date_days - inferred_dob_date_days_billto; 
			
			inferred_dob_date_days_shipto := mdy((integer)inferred_dob_s[5..6], (integer)inferred_dob_s[7..8], (integer)inferred_dob_s[1..4]);
			days_since_dob_shipto := system_date_days - inferred_dob_date_days_shipto; 
																			
			
		/*** BILLTO ***/
			
			combo_age_pre_cap := Map(age > 0 					=> age,
															inferred_dob != 0 => (integer)(days_since_dob_billto/365.25),
																									-1);
		
			combo_age := if(combo_age_pre_cap <=0, -1, combo_age_pre_cap);
			

			
			age_status :=	map(not truedid and combo_age <= 0 	=> 'No Record',
												truedid and combo_age <= 0 			=> 'Record - No Age',
																													 'Normal Record');
			
		/*** SHIPTO ***/

			combo_age_pre_cap_s := Map(age_s > 0 					=> age_s,
															inferred_dob_s != 0 => (integer)(days_since_dob_shipto/365.25),
																									-1);
		
			combo_age_s := if(combo_age_pre_cap_s <=0, -1, combo_age_pre_cap_s);			
			
			
			age_status_s :=	map(not truedid_s and combo_age_s <= 0 	=> 'No Record',
													truedid_s and combo_age_s <= 0 			=> 'Record - No Age',
																																 'Normal Record');			
			
			
			combo_age_rnd_tmp   := min(roundup(combo_age/10),8);
			combo_age_s_rnd_tmp := min(roundup(combo_age_s/10),8);
			
						
			combo_age_rnd := Map( age_status = 'No Record'				=> -10,
														age_status = 'Record - No Age' 	=> -5,
														combo_age_rnd_tmp);
			
			combo_age_s_rnd := Map( age_status_s = 'No Record'	=> -10,
															age_status_s = 'Record - No Age' => -5,
															combo_age_s_rnd_tmp);
			
			did_match := (did=did_s);
			
			
			st_combo_ageX := map( age_status='No Record' and age_status_s='No Record' => -20,
													  age_status_s = 'No Record' and combo_age_rnd = 8		=> 21,
														age_status_s = 'No Record' and combo_age_rnd = 7		=> 20,
														age_status_s = 'No Record' and combo_age_rnd = 6		=> 19,
														age_status_s = 'No Record' and combo_age_rnd = 5		=> 18,
														age_status_s = 'No Record' and combo_age_rnd = 4		=> 17,
														age_status_s = 'No Record'													=> 16,
														age_status_s != 'No Record' and (combo_age_rnd = combo_age_s_rnd) and did_match	=> 0,
														age_status_s != 'No Record' and combo_age_rnd = combo_age_s_rnd									=> 1,
														age_status_s != 'No Record' and combo_age_rnd = -5															=> 1,
														age_status_s != 'No Record' and combo_age_s_rnd = -5														=> 2,
														age_status_s != 'No Record' and combo_age_rnd = -10															=> 4,
														age_status_s != 'No Record' and combo_age_s_rnd > combo_age_rnd									=> 3,
														age_status_s != 'No Record' and combo_age_s_rnd < combo_age_rnd 								=> 5,
														age_status_s != 'No Record' 																										=> -50,
														-9999);	

		
		
	/*** MISC ***/

			st_wealth_index_s := wealth_index_s;
			

	/*** MEAN SUBSTIUTIONS ***/

//*BILLTO;

			 bt_avsX_m := Map( bt_avsX = 1 => 0.0058555048 ,
												 bt_avsX = 2 => 0.0091198303 ,
												 bt_avsX = 3 => 0.0175587309 ,
												 bt_avsX = 4 => 0.0241593209 ,
												 bt_avsX = 5 => 0.0396039604 ,
												 bt_avsX = 6 => 0.0710696339 ,
												 bt_avsX = 7 => 0.1324851569 ,
												 bt_avsX = 8 => 0.1623449831 ,
												 bt_avsX = 9 => 0.2055427252 ,
												 -9999);
			 
			 bt_verx_m := Map( bt_verx = 0 => 0.2001008065 ,
												 bt_verx = 1 => 0.0955240175 ,
												 bt_verx = 2 => 0.0565338276 ,
												 bt_verx = 3 => 0.0340684956 ,
												 bt_verx = 4 => 0.0178805774 ,
												 bt_verx = 5 => 0.0106117975 ,
												 bt_verx = 6 => 0.0059860102 ,
												 bt_verx = 7 => 0.0039467914 ,
												 -9999);
			 
			 bt_add1_proptree_m := Map(bt_add1_proptree = 0 => 0.0648476103 ,
																 bt_add1_proptree = 1 => 0.0234884732 ,
																 bt_add1_proptree = 2 => 0.0098239869 ,
																 bt_add1_proptree = 3 => 0.0055975007 ,
																 bt_add1_proptree = 4 => 0.0040875443 ,
																 -9999);
			 
			 bt_email_score_m := Map(bt_email_score = -1 => 0.0204442201 ,
															 bt_email_score = 0  => 0.0518131286 ,
															 bt_email_score = 1  => 0.0225823592 ,
															 bt_email_score = 2  => 0.0120547945 ,
															 bt_email_score = 3  => 0.0072839107 ,
															 -9999);
			 
			 bt_phnprob_m := Map(bt_phnprob = 0 => 0.0079872204 ,
													 bt_phnprob = 1 => 0.0213206591 ,
													 bt_phnprob = 2 => 0.0596495921 ,
													 -9999);
			 
			 bt_email_provider2_m := Map(email_provider2 = 'AOL' 	  		=> 0.0170690076 ,
																	 email_provider2 = 'GMAIL' 	  	=> 0.0699852144 ,
																	 email_provider2 = 'HOTMAIL'  	=> 0.0289824854 ,
																	 email_provider2 = 'MSN' 	  		=> 0.0073051948 ,
																	 email_provider2 = 'NO EMAIL' 	=> 0.0204449573 ,
																	 email_provider2 = 'OTHER' 	 		=> 0.0141116925 ,
																	 email_provider2 = 'SBCGLOBAL'	=> 0.0040257649 ,
																	 email_provider2 = 'VERIZON' 		=> 0.0027100271 ,
																	 email_provider2 = 'YAHOO' 			=> 0.0582042594 ,
																	 -9999);
																	 
			 bt_adls_ssns_per_addr_c6_m := Map(bt_adls_ssns_per_addr_c6 = 0 => 0.0204866196 ,
																				 bt_adls_ssns_per_addr_c6 = 1 => 0.0300219906 ,
																				 bt_adls_ssns_per_addr_c6 = 2 => 0.0392976589 ,
																				 bt_adls_ssns_per_addr_c6 = 3 => 0.0724637681 ,
																				 bt_adls_ssns_per_addr_c6 = 4 => 0.1756032172 ,
																				 -9999);
			 
			 bt_shipmode_m := Map( bt_shipmode = 0 => 0.0789110526 ,
														 bt_shipmode = 1 => 0.0237383347 ,
														 bt_shipmode = 2 => 0.0175231795 ,
														 -9999);
			 
			 bt_prodXamt_m := Map( bt_prodXamt = 0 => 0.0073991861 ,
														 bt_prodXamt = 1 => 0.0194785554 ,
														 bt_prodXamt = 2 => 0.0360451067 ,
														 bt_prodXamt = 3 => 0.0747368421 ,
														 bt_prodXamt = 4 => 0.2313253012 ,
														 -9999);
			 
			 bt_ip_geoLocationX_m := Map(bt_ip_geoLocationX = -1 => 0.0204103711 ,																	 
																	 bt_ip_geoLocationX = 0	 => 0.2294871795 ,
																	 bt_ip_geoLocationX = 1  => 0.0562666329 ,
																	 bt_ip_geoLocationX = 2  => 0.0135406611 ,
																	 bt_ip_geoLocationX = 3  => 0 ,
																	 -9999);
			 
//*SHIPTO;

			 st_avsX_m := Map( st_avsX = 1 => 0.2255799373 ,
												 st_avsX = 2 => 0.2370045808 ,
												 st_avsX = 3 => 0.2720994475 ,
												 st_avsX = 4 => 0.3067375887 ,
												 st_avsX = 5 => 0.3263403263 ,
												 st_avsX = 6 => 0.458712259 ,
												 st_avsX = 7 => 0.590778098 ,
												 -9999);
			 
			 st_verX2_m := Map(st_verX2 = 0 => 0.4817843866 ,
												 st_verX2 = 1 => 0.4658645775 ,
												 st_verX2 = 2 => 0.4367647059 ,
												 st_verX2 = 3 => 0.3432835821 ,
												 st_verX2 = 4 => 0.2392047884 ,
												 st_verX2 = 5 => 0.1969448095 ,
												 st_verX2 = 6 => 0.1724924012 ,
												 st_verX2 = 7 => 0.046713518 ,
												 st_verX2 = 8 => 0.0181686047 ,
												 -9999);
			 
			 st_proptree_m := Map( st_proptree = 0  => 0.5149606299 ,
														 st_proptree = 1  => 0.436416185 ,
														 st_proptree = 2  => 0.3760162602 ,
														 st_proptree = 3  => 0.3231165486 ,
														 st_proptree = 4  => 0.305378627 ,
														 st_proptree = 5  => 0.2708719852 ,
														 st_proptree = 6  => 0.2314647378 ,
														 st_proptree = 7  => 0.1754111198 ,
														 st_proptree = 8  => 0.1561371841 ,
														 st_proptree = 9  => 0.0934175532 ,
														 st_proptree = 10 => 0.0588235294 ,
														 st_proptree = 11 => 0.0484581498 ,
														 -9999);
			 
			 st_phnprob_s_m := Map(st_phnprob_s = 0 => 0.0772833724 ,
														 st_phnprob_s = 1 => 0.2075980211 ,
														 st_phnprob_s = 2 => 0.4522760646 ,
														 -9999);
			 
			 st_ip_geoLocationX_m := Map(st_ip_geoLocationX = -1 => 0.0501698754 ,
																	 st_ip_geoLocationX = 0  => 0.7675319644 ,
																	 st_ip_geoLocationX = 1  => 0.6820116664 ,
																	 st_ip_geoLocationX = 2  => 0.3626373626 ,
																	 st_ip_geoLocationX = 3  => 0.3282275711 ,
																	 st_ip_geoLocationX = 4  => 0.1033676333 ,
																	 st_ip_geoLocationX = 5  => 0.0426360182 ,
																	 -9999);
			 
			 st_email_score_m := Map(st_email_score = -1 => 0.0501358081 ,
															 st_email_score = 0  => 0.4715447154 ,
															 st_email_score = 1  => 0.3435700576 ,
															 st_email_score = 2  => 0.2417582418 ,
															 st_email_score = 3  => 0.1993736952 ,
															 st_email_score = 4  => 0.105046344 ,
															 st_email_score = 5  => 0.0587038652 ,
															 -9999);
			 
			 st_combo_ageX_m := Map( st_combo_ageX = -20 => 0.4164572864 ,
															 st_combo_ageX = 0   => 0.028150296 ,
															 st_combo_ageX = 1   => 0.2286536617 ,
															 st_combo_ageX = 2   => 0.2457446809 ,
															 st_combo_ageX = 3   => 0.2596327903 ,
															 st_combo_ageX = 4   => 0.2789799073 ,
															 st_combo_ageX = 5   => 0.3101946721 ,
															 st_combo_ageX = 16  => 0.3173129437 ,
															 st_combo_ageX = 17  => 0.3561827957 ,
															 st_combo_ageX = 18  => 0.3943161634 ,
															 st_combo_ageX = 19  => 0.4378619154 ,
															 st_combo_ageX = 20  => 0.4808510638 ,
															 st_combo_ageX = 21  => 0.5203761755 ,
															 -9999);
			 
			 st_adls_per_addr_c6_s_5_m := Map( st_adls_per_addr_c6_s_5 = 0 => 0.2186014148 ,
																				 st_adls_per_addr_c6_s_5 = 1 => 0.3287217459 ,
																				 st_adls_per_addr_c6_s_5 = 2 => 0.3742751713 ,
																				 st_adls_per_addr_c6_s_5 = 3 => 0.4193548387 ,
																				 st_adls_per_addr_c6_s_5 = 4 => 0.4871794872 ,
																				 st_adls_per_addr_c6_s_5 = 5 => 0.539964476 ,
																				 -9999);
			 
			 st_wealth_index_s_m := Map( (integer)st_wealth_index_s = 1 => 0.4060324826 ,
																	 (integer)st_wealth_index_s = 2 => 0.3565044687 ,
																	 (integer)st_wealth_index_s = 3 => 0.3259860789 ,
																	 (integer)st_wealth_index_s = 4 => 0.1819764911 ,
																	 (integer)st_wealth_index_s = 5 => 0.0793969849 ,
																	 (integer)st_wealth_index_s = 6 => 0.047182776 ,
																	 -9999);
			 
			 st_shipmode_m := Map( st_shipmode = 0 => 0.6086773821 ,
														 st_shipmode = 1 => 0.2396664249 ,
														 st_shipmode = 2 => 0.0839900456 ,
														 -9999);
			 
			 st_prodXamt_m := Map( st_prodXamt = 0 => 0.0279782251 ,
														 st_prodXamt = 1 => 0.1523586745 ,
														 st_prodXamt = 2 => 0.2923332907 ,
														 st_prodXamt = 3 => 0.571932299 ,
														 st_prodXamt = 4 => 0.7934981685 ,
														 -9999);
			 
//*BUSINESS BILLTO,

			 bubt_cid_match_m := Map(bubt_cid_match = -1 => 0.0597014925 ,
															 bubt_cid_match = 0  => 0.0401384083 ,
															 bubt_cid_match = 1  => 0.0094498188 ,
															 -9999);
			 
			 bubt_verX_m := Map( bubt_verX = 0 => 0.0005861665 ,
													 bubt_verX = 1 => 0.0018404585 ,
													 bubt_verX = 2 => 0.0035760728 ,
													 bubt_verX = 3 => 0.0071322837 ,
													 bubt_verX = 4 => 0.0218215875 ,
													 bubt_verX = 5 => 0.2611940299 ,
													 -9999);
			 
			 bubt_avsXchan_m := Map( bubt_avsXchan = 0 => 0.0001690903 ,
															 bubt_avsXchan = 1 => 0.0021084337 ,
															 bubt_avsXchan = 2 => 0.0037326094 ,
															 bubt_avsXchan = 3 => 0.040656677 ,
															 bubt_avsXchan = 4 => 0.0807272727 ,
															 -9999);
			 
			 bubt_ip_geoLocationX_m := Map(bubt_ip_geoLocationX = -1 => 0.0083881731 ,
																		 bubt_ip_geoLocationX = 0  => 0.1994301994 ,
																		 bubt_ip_geoLocationX = 1  => 0.0270804507 ,
																		 bubt_ip_geoLocationX = 2  => 0.0054418884 ,
																		 bubt_ip_geoLocationX = 3  => 0 ,
																		 -9999);
			 
			 bubt_phnprob_m := Map(bubt_phnprob = 0 => 0.0041178414 ,
														 bubt_phnprob = 1 => 0.022166913 ,
														 bubt_phnprob = 2 => 0.0458715596 ,
														 -9999);
			 
			 bubt_shipmode_m := Map( bubt_shipmode = 0 => 0.0439851616 ,
															 bubt_shipmode = 1 => 0.0198150594 ,
															 bubt_shipmode = 2 => 0.006643963 ,
															 -9999);
			 
			 bubt_prodXamt_m := Map( bubt_prodXamt = 0 => 0.0053733556 ,
															 bubt_prodXamt = 1 => 0.0122869955 ,
															 bubt_prodXamt = 2 => 0.0557768924 ,
															 bubt_prodXamt = 3 => 0.3388888889 ,
															 -9999);
			 
//*BUSINESS SHIPTO,

			 bust_nap_s_m := Map(bust_nap_s = 0 => 0.3316708229 ,
													 bust_nap_s = 1 => 0.1319407721 ,
													 bust_nap_s = 2 => 0.1302902725 ,
													 bust_nap_s = 3 => 0.1280148423 ,
													 bust_nap_s = 4 => 0.1225601453 ,
													 bust_nap_s = 5 => 0.0514018692 ,
													 bust_nap_s = 6 => 0.0423976608 ,
													 bust_nap_s = 7 => 0.0188223938 ,
													 bust_nap_s = 8 => 0.0070733864 ,
													 bust_nap_s = 9 => 0.0038779731 ,
													 -9999);
			 
			 bust_add1_proptree_m := Map(bust_add1_proptree = 0	=> 0.1664762993 ,
																	 bust_add1_proptree = 1 => 0.1156849768 ,
																	 bust_add1_proptree = 2 => 0.084073107 ,
																	 bust_add1_proptree = 3 => 0.0561797753 ,
																	 bust_add1_proptree = 4 => 0.0531111476 ,
																	 bust_add1_proptree = 5 => 0.0190528035 ,
																	 -9999);
			 
			 bust_ip_geoLocationX_m := Map(bust_ip_geoLocationX = -1 => 0.0063316502 ,
																		 bust_ip_geoLocationX = 0  => 0.7490566038 ,
																		 bust_ip_geoLocationX = 1  => 0.5413907285 ,
																		 bust_ip_geoLocationX = 2  => 0.1794380587 ,
																		 bust_ip_geoLocationX = 3  => 0.0602782071 ,
																		 bust_ip_geoLocationX = 4  => 0.0185079401 ,
																		 bust_ip_geoLocationX = 5  => 0 ,
																		 -9999);
			 
			 bust_email_score_m := Map(bust_email_score = -1 => 0.0065610498 ,
																 bust_email_score = 0  => 0.2247860636 ,
																 bust_email_score = 1  => 0.1510903427 ,
																 bust_email_score = 2  => 0.0977284733 ,
																 bust_email_score = 3  => 0.0436590437 ,
																 bust_email_score = 4  => 0.0248573757 ,
																 -9999);
			 
			 bust_email_provider2_m := Map(email_provider2 = 'AOL' 			  => 0.0561594203 ,
																		 email_provider2 = 'GMAIL' 			=> 0.354763749 ,
																		 email_provider2 = 'HOTMAIL' 		=> 0.0521628499 ,
																		 email_provider2 = 'MSN' 				=> 0.0531400966 ,
																		 email_provider2 = 'NO EMAIL' 	=> 0.0065615748 ,
																		 email_provider2 = 'OTHER' 			=> 0.0985811876 ,
																		 email_provider2 = 'SBCGLOBAL' 	=> 0.1034482759 ,
																		 email_provider2 = 'VERIZON' 		=> 0.0243902439 ,
																		 email_provider2 = 'YAHOO' 			=> 0.3736434109 ,
																		 -9999);
			 
			 bust_adls_per_addr_c6_s_2_m := Map( bust_adls_per_addr_c6_s_2 = 0 => 0.0712970634 ,
																					 bust_adls_per_addr_c6_s_2 = 1 => 0.1101694915 ,
																					 bust_adls_per_addr_c6_s_2 = 2 => 0.2017640573 ,
																					 -9999);
			 
			 bust_phones_per_adl_c6_s_2_m := Map(bust_phones_per_adl_c6_s_2 = 0 => 0.0998288361 ,
																					 bust_phones_per_adl_c6_s_2 = 1 => 0.046581876 ,
																					 bust_phones_per_adl_c6_s_2 = 2 => 0.0313174946 ,
																					 -9999);
			 
			 bust_phnprob_s_m := Map(bust_phnprob_s = 0 => 0.006 ,
															 bust_phnprob_s = 1 => 0.0628053974 ,
															 bust_phnprob_s = 2 => 0.2108588813 ,
															 bust_phnprob_s = 3 => 0.75537 ,
															 -9999);
			 
			 
			 bust_shipmode_m := Map( bust_shipmode = 0 => 0.3712354026 ,
															 bust_shipmode = 1 => 0.1395017794 ,
															 bust_shipmode = 2 => 0.0142829662 ,
															 -9999);
			 
			 bust_prodXamt_m := Map( bust_prodXamt = 0 => 0.0068176284 ,
															 bust_prodXamt = 1 => 0.0214001834 ,
															 bust_prodXamt = 2 => 0.0686460307 ,
															 bust_prodXamt = 3 => 0.1343115124 ,
															 bust_prodXamt = 4 => 0.5635005336 ,
															 bust_prodXamt = 5 => 0.8075772682 ,
															 -9999);
		
	/*** FINAL MODELS ***/

//*SHARED VARS;

			 base  := 720;
			 point := -20;
			 odds  := .0476;

//*BILLTO;

			bt_log := -10.22430738
										+ (integer)bt_cid_match  * -0.164933367				
										+ bt_avsX_m  * 10.807884109				
										+ bt_verx_m  * 7.3328009908               	
										+ bt_add1_proptree_m  * 13.488677832      	
										+ bt_email_score_m  * 14.638353791        	
										+ bt_phnprob_m  * 18.592990205            	
										+ bt_ip_geoLocationX_m  * 3.4387307716    	
										+ bt_email_provider2_m  * 14.637920466    	
										+ bt_adls_ssns_per_addr_c6_m  * 6.0206785136 	
										+ bt_shipmode_m  * 14.31480187           		
										+ bt_prodXamt_m  * 11.440776784          		
										+ (integer)bt_existing_cust  * -1.314893226       		
										+ bt_c_hhsize_lg  * 0.5664809791         		
										+ bt_c_low_ed  * 0.0132421127            		
										+ bt_c_unemp_lg  * 0.1277294452          		
										+ bt_offset  * 1                         		
			 ;
			 
			 bt_phat := (exp(bt_log )) / (1+exp(bt_log));
			 
			 BT_DELL_SCORE_pre_cap := round(point*(ln(bt_phat/(1-bt_phat)) - ln(odds))/ln(2) + base);
			 BT_DELL_SCORE := max(250,min(999,BT_DELL_SCORE_pre_cap));

//*SHIPTO;

			st_log := -9.246492992
										+ (integer)st_cid_match  * -0.087753755			
										+ st_avsX_m  * 3.486026884				
										+ st_verX2_m  * 1.2348654482			
										+ st_proptree_m  * 2.4633171923			
										+ st_phnprob_s_m  * 3.2465334738		
										+ st_ip_geoLocationX_m  * 3.3823363563	
										+ st_email_score_m  * 2.0180862957		
										+ st_combo_ageX_m  * 2.6370414045		
										+ st_adls_per_addr_c6_s_5_m  * 2.005696457
										+ st_wealth_index_s_m  * 1.8959393201	
										+ st_shipmode_m  * 2.3688735464			
										+ st_prodXamt_m  * 2.9148269916			
										+ (integer)st_existing_cust  * -0.936957483		
										+ st_c_hhsize_s  * 0.3776994597			
										+ st_add1_census_education2_s  * -0.164991071
										+ st_offset  * 1
			 ;
			 
			 st_phat := (exp(st_log )) / (1+exp(st_log));

			 ST_DELL_SCORE_pre_cap := round(point*(ln(st_phat/(1-st_phat)) - ln(odds))/ln(2) + base);
			 ST_DELL_SCORE := max(250,min(999,ST_DELL_SCORE_pre_cap));

//*BUSINESS BILLTO;

			bubt_log := -8.198487892
										+ bubt_cid_match_m  * 1.1753871082			
										+ bubt_verX_m  * 8.086106234                   
										+ bubt_avsXchan_m  * 33.659696218              
										+ bubt_ip_geoLocationX_m  * 8.2949725297       
										+ bubt_phnprob_m  * 45.649030041               
										+ bubt_shipmode_m  * 35.036100316              
										+ bubt_prodXamt_m  * 9.8293861394              
										+ bubt_cust_tenure_lg  * -0.340581629          
										+ bubt_c_highinc  * -0.010884231               
										+ bubt_c_low_ed  * 0.0198574747                
										+ bubt_offset  * 1
			 ;
			 
			 bubt_phat := (exp(bubt_log )) / (1+exp(bubt_log));

			 BUBT_DELL_SCORE_pre_cap := round(point*(ln(bubt_phat/(1-bubt_phat)) - ln(odds))/ln(2) + base);
			 BUBT_DELL_SCORE := max(250,min(999,BUBT_DELL_SCORE_pre_cap));

//*BUSINESS SHIPTO;

			bust_log := -8.24536829
										+ bust_nap_s_m  * 7.8934556912					
										+ (integer)bust_nas_s  * -0.326822067                        
										+ bust_add1_proptree_m  * 3.8909705712              
										+ bust_ip_geoLocationX_m  * 3.4900199908            
										+ bust_email_score_m  * 4.3880012056                
										+ bust_email_provider2_m  * 1.7165588767            
										+ bust_adls_per_addr_c6_s_2_m  * 2.5722080654       
										+ bust_phones_per_adl_c6_s_2_m  * 6.7092971139      
										+ bust_phnprob_s_m  * 2.7745551644                  
										+ bust_shipmode_m  * 5.2256302454                   
										+ bust_prodXamt_m  * 3.146703208                    
										+ bust_cust_tenure_lg  * -0.417829545               
										+ bust_c_hhsize_s  * 0.4970163308                   
										+ bust_c_med_hhinc_s  * -0.000010208                
										+ bust_offset  * 1
			 ;
			 
			 bust_phat := (exp(bust_log )) / (1+exp(bust_log));

			 BUST_DELL_SCORE_pre_cap := round(point*(ln(bust_phat/(1-bust_phat)) - ln(odds))/ln(2) + base);
			 BUST_DELL_SCORE := max(250,min(999,BUST_DELL_SCORE_pre_cap));     
			 
	/* LOGIC FOR CHOOSING APPROPRIATE SCORE GOES HERE */

		consumer := if(bcflag = '1', 1, 0);
		shipto_order := if(IST_addrscore < 80, 1, 0);
		
		CDN810_1_0_pre_cap :=	Map(consumer=1 and shipto_order=1			=> ST_DELL_SCORE,
															consumer=1 and shipto_order=0 		=> BT_DELL_SCORE,
															consumer=0 and shipto_order=1			=> BUST_DELL_SCORE,
															consumer=0 and shipto_order=0			=> BUBT_DELL_SCORE,
															0);
		
		
	/***** SEPARATE BILLTO AND SHIPTO SCORES GO HERE - SIX SUBMODELS *****/

//*BILLTO MODEL FOR CONSUMERS - ALL ORDERS;
		
		bt_bt_c_add1_census_inc := if( (integer)add1_census_income = 0, 37500, 
																	  min(max((integer)add1_census_income, 20000), 150000));
			
			bt_bt_c_add1_census_inc_log := ln(bt_bt_c_add1_census_inc + 1);
			bt_bt_c_own_watercraft 			:= (watercraft_count>0);
			bt_bt_c_hhsize_lg 					:= bt_c_hhsize_lg;	
			bt_bt_c_low_ed 							:= bt_c_low_ed;
			bt_bt_c_unemp 							:= min(max((real)c_unemp,0),15);
			bt_bt_c_span_lang 					:= abs(20-min(max((real)c_span_lang,0),200));     
			bt_bt_c_rel_dist_flag 			:= (rel_within25miles_count  > 0);	
		
			bt_bt_c_verx_m := Map( bt_verx = 0 => 0.2001008065 ,
														 bt_verx = 1 => 0.0955240175 ,
														 bt_verx = 2 => 0.0565338276 ,
														 bt_verx = 3 => 0.0340684956 ,
														 bt_verx = 4 => 0.0178805774 ,
														 bt_verx = 5 => 0.0106117975 ,
														 bt_verx = 6 => 0.0059860102 ,
														 bt_verx = 7 => 0.0039467914 ,
														 -9999);
			 
			 bt_bt_c_add1_proptree_m :=	Map( bt_add1_proptree = 0 => 0.0648476103 ,
																			 bt_add1_proptree = 1 => 0.0234884732 ,
																			 bt_add1_proptree = 2 => 0.0098239869 ,
																			 bt_add1_proptree = 3 => 0.0055975007 ,
																			 bt_add1_proptree = 4 => 0.0040875443 ,
																			 -9999);

			 bt_bt_c_phnprob_m := Map( bt_phnprob = 0 => 0.0079872204 ,
																 bt_phnprob = 1 => 0.0213206591 ,
																 bt_phnprob = 2 => 0.0596495921 ,
																 -9999);
			 
			 bt_bt_c_adls_ssns_per_addr_c6_m := Map( bt_adls_ssns_per_addr_c6 = 0 => 0.0204866196 ,
																							 bt_adls_ssns_per_addr_c6 = 1 => 0.0300219906 ,
																							 bt_adls_ssns_per_addr_c6 = 2 => 0.0392976589 ,
																							 bt_adls_ssns_per_addr_c6 = 3 => 0.0724637681 ,
																							 bt_adls_ssns_per_addr_c6 = 4 => 0.1756032172 ,
																							 -9999);

		 bt_bt_c_log := -3.689785109
										+ bt_bt_c_verx_m  * 11.358363485					
										+ bt_bt_c_add1_proptree_m  * 17.461309035     			
										+ bt_bt_c_phnprob_m  * 24.708254553                 	
										+ bt_bt_c_adls_ssns_per_addr_c6_m  * 8.6079894466      	
										+ bt_bt_c_add1_census_inc_log  * -0.488214632   		
										+ (integer)bt_bt_c_own_watercraft  * -0.403683117               	
										+ bt_bt_c_hhsize_lg  * 1.0414617084               		
										+ bt_bt_c_low_ed  * 0.0054986003                  		
										+ bt_bt_c_unemp  * 0.036868965                    		
										+ bt_bt_c_span_lang  * 0.0026367299               		
										+ (integer)bt_bt_c_rel_dist_flag  * -0.332014111             	
										+ bt_bt_c_offset  * 1                        			
			 ;
			 
			 
//*BILLTO MODEL FOR BUSINESS - ALL ORDERS;
		
			bt_bt_b_highinc := bubt_c_highinc;
			bt_bt_b_low_ed  := bubt_c_low_ed;

			bt_bt_b_verX_m := Map( bubt_verX = 0 => 0.0005861665 ,
														 bubt_verX = 1 => 0.0018404585 ,
														 bubt_verX = 2 => 0.0035760728 ,
														 bubt_verX = 3 => 0.0071322837 ,
														 bubt_verX = 4 => 0.0218215875 ,
														 bubt_verX = 5 => 0.2611940299 ,
														 -9999);
			 
			 bt_bt_b_phnprob_m := Map( bubt_phnprob = 0 => 0.0041178414 ,
																 bubt_phnprob = 1 => 0.022166913 ,
																 bubt_phnprob = 2 => 0.0458715596 ,
																 -9999);

			 bt_bt_b_log := -8.127078843
										+ bt_bt_b_verX_m  * 14.09155175			
										+ bt_bt_b_phnprob_m  * 58.59964189        
										+ bt_bt_b_highinc  * -0.017481537         
										+ bubt_c_low_ed  * 0.0244048762           
										+ bt_bt_b_offset  * 1                   	
			 ;
			 
			 
//*SHIPTO MODEL FOR CONSUMERS - SHIPTO ORDERS;

			st_st_c_hhsize_s := st_c_hhsize_s;
		
			st_st_c_low_ed_s := Map( length(trim(c_low_ed_s))=0 => 50,
																(real)c_low_ed_s = 100 => .01,	
															min(max((real)c_low_ed_s,.01),90) );
		
			st_st_c_low_ed_s_lg := ln(st_st_c_low_ed_s);
		
			st_st_c_lar_fam_s := if(length(trim(c_lar_fam_s))=0, 50, min(max((real)c_lar_fam_s,.01),200));
		
			st_st_c_lar_fam_s_lg := ln(st_st_c_lar_fam_s);
		
			st_st_c_add1_census_inc_s := if( (integer)add1_census_income_s = 0, 70000, min(max((integer)add1_census_income_s, 20000), 200000));

			st_st_c_verX2_m := Map( st_verX2 = 0 => 0.4817843866 ,
															st_verX2 = 1 => 0.4658645775 ,
															st_verX2 = 2 => 0.4367647059 ,
															st_verX2 = 3 => 0.3432835821 ,
															st_verX2 = 4 => 0.2392047884 ,
															st_verX2 = 5 => 0.1969448095 ,
															st_verX2 = 6 => 0.1724924012 ,
															st_verX2 = 7 => 0.046713518 ,
															st_verX2 = 8 => 0.0181686047 ,
															-9999);
															 
			 st_st_c_proptree_m := Map(st_proptree = 0  => 0.5149606299 ,
																 st_proptree = 1  => 0.436416185 ,
																 st_proptree = 2  => 0.3760162602 ,
																 st_proptree = 3  => 0.3231165486 ,
																 st_proptree = 4  => 0.305378627 ,
																 st_proptree = 5  => 0.2708719852 ,
																 st_proptree = 6  => 0.2314647378 ,
																 st_proptree = 7  => 0.1754111198 ,
																 st_proptree = 8  => 0.1561371841 ,
																 st_proptree = 9  => 0.0934175532 ,
																 st_proptree = 10 => 0.0588235294 ,
																 st_proptree = 11 => 0.0484581498 ,
																 -9999);
			 
			 st_st_c_phnprob_s_m := Map( st_phnprob_s = 0 => 0.0772833724 ,
																	 st_phnprob_s = 1 => 0.2075980211 ,
																	 st_phnprob_s = 2 => 0.4522760646 ,
																	 -9999);
																	 
			 st_st_c_combo_ageX_m := Map(st_combo_ageX = -20 => 0.4164572864 ,
																	 st_combo_ageX = 0   => 0.028150296 ,
																	 st_combo_ageX = 1   => 0.2286536617 ,
																	 st_combo_ageX = 2   => 0.2457446809 ,
																	 st_combo_ageX = 3   => 0.2596327903 ,
																	 st_combo_ageX = 4   => 0.2789799073 ,
																	 st_combo_ageX = 5   => 0.3101946721 ,
																	 st_combo_ageX = 16  => 0.3173129437 ,
																	 st_combo_ageX = 17  => 0.3561827957 ,
																	 st_combo_ageX = 18  => 0.3943161634 ,
																	 st_combo_ageX = 19  => 0.4378619154 ,
																	 st_combo_ageX = 20  => 0.4808510638 ,
																	 st_combo_ageX = 21  => 0.5203761755 ,
																	 -9999);
			 
			 st_st_c_adls_per_addr_c6_s_5_m := Map(st_adls_per_addr_c6_s_5 = 0 => 0.2186014148 ,
																						 st_adls_per_addr_c6_s_5 = 1 => 0.3287217459 ,
																						 st_adls_per_addr_c6_s_5 = 2 => 0.3742751713 ,
																						 st_adls_per_addr_c6_s_5 = 3 => 0.4193548387 ,
																						 st_adls_per_addr_c6_s_5 = 4 => 0.4871794872 ,
																						 st_adls_per_addr_c6_s_5 = 5 => 0.539964476 ,
																						 -9999);
			 
			 st_st_c_wealth_index_s_m := Map((integer)st_wealth_index_s = 1 => 0.4060324826 ,
																			 (integer)st_wealth_index_s = 2 => 0.3565044687 ,
																			 (integer)st_wealth_index_s = 3 => 0.3259860789 ,
																			 (integer)st_wealth_index_s = 4 => 0.1819764911 ,
																			 (integer)st_wealth_index_s = 5 => 0.0793969849 ,
																			 (integer)st_wealth_index_s = 6 => 0.047182776 ,
																			 -9999);
			 


				st_st_c_log := -10.6341936
										+ st_st_c_verX2_m  * 1.4563460969				
										+ st_st_c_proptree_m  * 2.6889374212           	
										+ st_st_c_phnprob_s_m  * 4.3819852569          	
										+ st_st_c_combo_ageX_m  * 4.3679538529         	
										+ st_st_c_adls_per_addr_c6_s_5_m  * 4.1665898122    
										+ st_st_c_wealth_index_s_m  * 3.5537665105          
										+ st_st_c_hhsize_s  * 0.5039511914                	
										+ st_st_c_low_ed_s_lg  * 0.2907867413             	
										+ st_st_c_lar_fam_s_lg  * 0.0039301886             	
										+ st_st_c_add1_census_inc_s  * -8.151519E-6     	
										+ st_st_c_offset  * 1                        		
			 ;
			 
			 
			 
//*SHIPTO MODEL FOR BUSINESS - SHIPTO ORDERS ONLY;

			st_st_b_nas_s    		:= bust_nas_s;
			st_st_b_hhsize_s 		:= bust_c_hhsize_s;
			st_st_b_med_hhinc_s := bust_c_med_hhinc_s;
			st_st_b_unemp_s_lg  := ln(min(max((real)c_unemp_s,.01),5));

			st_st_b_nap_s_m := Map( bust_nap_s = 0 => 0.3316708229 ,
			  											 bust_nap_s = 1 => 0.1319407721 ,
															 bust_nap_s = 2 => 0.1302902725 ,
															 bust_nap_s = 3 => 0.1280148423 ,
															 bust_nap_s = 4 => 0.1225601453 ,
															 bust_nap_s = 5 => 0.0514018692 ,
															 bust_nap_s = 6 => 0.0423976608 ,
															 bust_nap_s = 7 => 0.0188223938 ,
															 bust_nap_s = 8 => 0.0070733864 ,
															 bust_nap_s = 9 => 0.0038779731 ,
															 -9999);
			 
			 st_st_b_add1_proptree_m := Map( bust_add1_proptree = 0 => 0.1664762993 ,
																			 bust_add1_proptree = 1 => 0.1156849768 ,
																			 bust_add1_proptree = 2 => 0.084073107 ,
																			 bust_add1_proptree = 3 => 0.0561797753 ,
																			 bust_add1_proptree = 4 => 0.0531111476 ,
																			 bust_add1_proptree = 5 => 0.0190528035 ,
																			 -9999);
			 
			 st_st_b_adls_per_addr_c6_s_2_m := Map(bust_adls_per_addr_c6_s_2 = 0 => 0.0712970634 ,
																						 bust_adls_per_addr_c6_s_2 = 1 => 0.1101694915 ,
																						 bust_adls_per_addr_c6_s_2 = 2 => 0.2017640573 ,
																						 -9999);
																						 
			 st_st_b_phones_per_adl_c6_s_2_m := Map( bust_phones_per_adl_c6_s_2 = 0 => 0.0998288361 ,
																							 bust_phones_per_adl_c6_s_2 = 1 => 0.046581876 ,
																							 bust_phones_per_adl_c6_s_2 = 2 => 0.0313174946 ,
																							 -9999);
																							 
			 st_st_b_phnprob_s_m := Map( bust_phnprob_s = 0 => 0.006 ,
																	 bust_phnprob_s = 1 => 0.0628053974 ,
																	 bust_phnprob_s = 2 => 0.2108588813 ,
																	 bust_phnprob_s = 3 => 0.75537,
																	 -9999);
			 
			 
			 st_st_b_log := -9.516710549
										+ st_st_b_nap_s_m  * 10.145185043				
										+ (integer)st_st_b_nas_s  * -0.151179522                     
										+ st_st_b_add1_proptree_m  * 11.406105211           
										+ st_st_b_adls_per_addr_c6_s_2_m  * 8.2770456833    
										+ st_st_b_phones_per_adl_c6_s_2_m  * 11.066695142   
										+ st_st_b_phnprob_s_m  * 5.8037599416               
										+ st_st_b_hhsize_s  * 0.6432806867                  
										+ st_st_b_med_hhinc_s  * -0.00001261                
										+ st_st_b_unemp_s_lg  * 0.1110516843                
										+ st_st_b_offset  * 1                               
			 ;
			 
//*BILLTO MODEL FOR CONSUMERS - SHIPTO ORDERS;

			combo_age_pre_cap_bs := Map(age > 0 					=> age,
															inferred_dob != 0 => (integer)(days_since_dob_billto/365.25),
																									-1);
		
			combo_age_bs := if(combo_age_pre_cap_bs <=0, -1, combo_age_pre_cap_bs);		

			combo_age2 := roundup(combo_age_bs/10);
			
			
			age_status_bs := Map(not truedid and combo_age_bs <= 0 	=> 'No Record',
														truedid and combo_age_bs <= 0 		=> 'Record - No Age',
																														 'Normal Record');
			
			bt_st_c_combo_age3 := Map(age_status_bs = 'No Record'				=> -10,
																age_status_bs = 'Record - No Age'	=> -5,
																							min(max(combo_age2,3),8) );
																																 
			bt_st_c_nap := if(nap_summary in [8,9,10,11,12], 1, 0);
			
			bt_st_c_nas := if(nas_summary != 0, 1, 0);
																				
			bt_st_c_verx := Map(bt_st_c_nap=1 and bt_st_c_nas=1	=> 2,
													bt_st_c_nap=1 or  bt_st_c_nas=1	=> 1,
																														0);
			
			bt_st_c_ownocc_p := min(max((real)c_ownocc_p,1),100);
			bt_st_c_unemp_lg := bt_c_unemp_lg;
			
			 bt_st_c_combo_age3_m := Map(bt_st_c_combo_age3 = -10 => 0.3709090909 ,
																	 bt_st_c_combo_age3 = -5  => 0.2106463878 ,
																	 bt_st_c_combo_age3 = 3   => 0.2059721751 ,
																	 bt_st_c_combo_age3 = 4   => 0.2306235201 ,
																	 bt_st_c_combo_age3 = 5   => 0.2393506652 ,
																	 bt_st_c_combo_age3 = 6   => 0.2641312453 ,
																	 bt_st_c_combo_age3 = 7   => 0.2720825274 ,
																	 bt_st_c_combo_age3 = 8   => 0.2826282628 ,
																	 -9999);
			 
			 bt_st_c_verx_m := Map(bt_st_c_verx = 0 => 0.3746360401 ,
														 bt_st_c_verx = 1 => 0.2555949992 ,
														 bt_st_c_verx = 2 => 0.2334464266 ,
														 -9999);
			 
			 bt_st_c_phnprob_m := Map( bt_phnprob = 0 => 0.2425447316 ,
																 bt_phnprob = 1 => 0.2500891139 ,
																 bt_phnprob = 2 => 0.2771418661 ,
																 -9999);
		
		

			 bt_st_c_log := -5.373138417
										+ bt_st_c_combo_age3_m  * 3.433331045 	
										+ bt_st_c_verx_m  * 2.1058617459          
										+ bt_st_c_phnprob_m  * 3.7916592958       
										+ bt_st_c_ownocc_p  * 0.0048962623        
										+ bt_st_c_unemp_lg  * -0.022670968        
										+ bt_st_c_offset  * 1                   	
			 ;
			 

//*BILLTO MODEL FOR BUSINESS - SHIPTO ORDERS;

			bt_st_b_verX := Map(rc_hphonevalflag = '1' and nap_summary in [1,6] 	 => 4,
													nap_summary in [1,6]															 => 3,
													rc_hphonevalflag = '1' and nap_summary in [11,12]	 => 1,
													nap_summary in [11,12]														 => 0,
																																							2);
		
			bt_st_b_phnprob := Map( rc_hphonevalflag = '0'	=> 2,
															rc_phonezipflag = '1'		=> 1,
																											 0);
		
			bt_st_b_ownocc_p := min(max((real)c_ownocc_p,1),100);
			bt_st_b_low_ed   := min(max((real)c_low_ed,1),100);
			bt_st_b_unemp_lg := ln(min(max((real)c_unemp,.01),15));
		
			bt_st_b_verX_m := Map( bt_st_b_verX = 0 => 0.1619399918 ,
														 bt_st_b_verX = 1 => 0.1175257732 ,
														 bt_st_b_verX = 2 => 0.099958792 ,
														 bt_st_b_verX = 3 => 0.0309720944,
														 bt_st_b_verX = 4 => 0.0140521206,
														 -9999);
			 
			bt_st_b_phnprob_m := Map(bt_st_b_phnprob = 0 => 0.0758568096 ,
															 bt_st_b_phnprob = 1 => 0.0845006778 ,
															 bt_st_b_phnprob = 2 => 0.6629834254 ,
															 -9999);


			bt_st_b_log := -6.47900027
										+ bt_st_b_verX_m  * 14.503222805		
										+ bt_st_b_phnprob_m  * 5.2889837874       
										+ bt_st_b_ownocc_p  * 0.0062190575        
										+ bt_st_b_low_ed  * 0.0054909574          
										+ bt_st_b_unemp_lg  * 0.0372825366        
										+ bt_st_b_offset  * 1                   	
			 ;
			 
	/*** LOGIC FOR CHOOSING CORRECT SUBMODEL SCORE ***/

		sub_bt_bt_con_score  := (exp(bt_bt_c_log )) / (1+exp(bt_bt_c_log ));
		sub_bt_bt_con_score1 := (integer)(point*(ln(sub_bt_bt_con_score/(1-sub_bt_bt_con_score)) - ln(odds))/ln(2) + base);
		
		sub_bt_bt_bus_score  := (exp(bt_bt_b_log )) / (1+exp(bt_bt_b_log ));
		sub_bt_bt_bus_score1 := (integer)(point*(ln(sub_bt_bt_bus_score/(1-sub_bt_bt_bus_score)) - ln(odds))/ln(2) + base);
		
		sub_bt_st_con_score  := (exp(bt_st_c_log )) / (1+exp(bt_st_c_log ));
		sub_bt_st_con_score1 := (integer)(point*(ln(sub_bt_st_con_score/(1-sub_bt_st_con_score)) - ln(odds))/ln(2) + base);
		
		sub_bt_st_bus_score  := (exp(bt_st_b_log )) / (1+exp(bt_st_b_log ));
		sub_bt_st_bus_score1 := (integer)(point*(ln(sub_bt_st_bus_score/(1-sub_bt_st_bus_score)) - ln(odds))/ln(2) + base);
		
		sub_st_st_con_score  := (exp(st_st_c_log )) / (1+exp(st_st_c_log ));
		sub_st_st_con_score1 := (integer)(point*(ln(sub_st_st_con_score/(1-sub_st_st_con_score)) - ln(odds))/ln(2) + base);
		
		sub_st_st_bus_score  := (exp(st_st_b_log )) / (1+exp(st_st_b_log ));
		sub_st_st_bus_score1 := (integer)(point*(ln(sub_st_st_bus_score/(1-sub_st_st_bus_score)) - ln(odds))/ln(2) + base);
		
		

		BILLTO_SCORE_pre_cap := Map(shipto_order=0 and consumer=1 => sub_bt_bt_con_score1,
																shipto_order=0 and consumer=0 => sub_bt_bt_bus_score1,
																shipto_order=1 and consumer=1 => sub_bt_st_con_score1,
																shipto_order=1 and consumer=0 => sub_bt_st_bus_score1,
																0);
									
		SHIPTO_SCORE_pre_cap := Map(shipto_order=0 and consumer=1 => sub_bt_bt_con_score1,
																shipto_order=0 and consumer=0 => sub_bt_bt_bus_score1,
																shipto_order=1 and consumer=1 => sub_st_st_con_score1,
																shipto_order=1 and consumer=0 => sub_st_st_bus_score1,
																0);
												
		
		CDN810_1_0 			:= min(max(CDN810_1_0_pre_cap			 ,250),999);
		Billto_Score    := min(max(BILLTO_SCORE_pre_cap    ,250),999);
		Shipto_Score    := min(max(SHIPTO_SCORE_pre_cap    ,250),999);

		model_score 		:= (string)CDN810_1_0+(string)Billto_Score+(string)Shipto_Score;
		 			 
		self.seq := le.bs.bill_to_out.seq;
		self.score := model_score;
		self.ri := [];

		SELF := [];
		
	end;

	model := project(clam_with_easi, doModel(LEFT));
	


//need to project billto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam_with_easi le, iid_results rt) := TRANSFORM
	self.seq := le.bs.Bill_To_Out.seq;
	self.socllowissue := (string)le.bs.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.bs.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.bs.Bill_To_Out.iid.NAS_summary;
	self.nxx_type := le.bs.Bill_To_Out.phone_verification.telcordia_type;
	SELF.ssns_per_adl_seen_18months := le.bs.Bill_To_Out.Velocity_Counters.ssns_per_adl_seen_18months;
	SELF.zipscore := rt.Bill_To_Output.zipscore;
	SELF.combo_zipscore := rt.Bill_To_Output.combo_zipscore;
	
	self := le.bs.Bill_To_Out.iid;
	self := le.bs.Bill_To_Out.shell_input;
	self := le.bs.Bill_To_out;
END;
iidBT := JOIN(clam_with_easi, iid_results, 
					LEFT.bs.Bill_To_Out.seq = RIGHT.Bill_To_Output.seq, 
					into_layout_output(LEFT, RIGHT), LEFT OUTER, KEEP(1));


temp_layout := RECORD
	RiskWise.Layout_IP2O ip;
	Risk_Indicators.Layout_EDDO eddo;
	business_risk.layout_biid_btst_output biid;
END;


temp_layout fill_ip(clam_with_easi le, biid rt ) := TRANSFORM
	self.eddo := le.bs.eddo;
	self.ip.countrycode := le.bs.ip2o.countrycode[1..2];
	self.ip := le.bs.ip2o;
	self.biid := rt;
END;
ipInfo := JOIN(clam_with_easi, biid, 
left.bs.bill_to_out.seq = right.bill_to_output.seq, fill_ip(left, right), left outer);


Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
	self.seq := le.seq;
	self.ri := if( isBusiness,
			MAP(reasonCodeVersion = 2 => RiskWise.cdReasonCodesBus2(le, 6, rt, true, IBICID, rt.biid.Bill_to_output),
																	 RiskWise.cdReasonCodesBus(le, 6, rt, true, IBICID, rt.biid.Bill_to_output)
				 ),
			MAP(reasonCodeVersion = 2 => RiskWise.cdReasonCodesCon2(le, 6, rt, true, IBICID),
																	 RiskWise.cdReasonCodesCon(le, 6, rt, true, IBICID)
				 )
	);
	self := [];
END;
BTReasons := join(iidBT, ipInfo, left.seq = right.ip.seq, addBTReasons(left, right), left outer);

Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
	self.ri := rt.ri;
	self := le;
END;
BTrecord := JOIN(model, BTReasons, left.seq = right.seq, fillReasons(left,right), left outer);


//need to project the shipto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output2(clam_with_easi le, iid_results rt) := TRANSFORM
	self.seq := le.bs.Ship_To_Out.seq;
	self.socllowissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.bs.Ship_To_Out.iid.NAS_summary;
	self.nxx_type := le.bs.Ship_To_Out.phone_verification.telcordia_type;
	SELF.ssns_per_adl_seen_18months := le.bs.Ship_To_Out.Velocity_Counters.ssns_per_adl_seen_18months;
	SELF.zipscore := rt.Ship_To_Output.zipscore;
	SELF.combo_zipscore := rt.Ship_To_Output.combo_zipscore;	
	
	self := le.bs.Ship_To_Out.iid;
	self := le.bs.Ship_To_Out.shell_input;
	self := le.bs.Ship_To_Out;
END;
iidST := JOIN(clam_with_easi, iid_results, 
					LEFT.bs.Ship_To_Out.seq = RIGHT.Ship_To_Output.seq, 
					into_layout_output2(LEFT, RIGHT), LEFT OUTER, KEEP(1));


Layout_ModelOut addSTReasons(iidST le, ipInfo rt ) := TRANSFORM
	self.seq := le.seq;
	self.ri := if( isBusiness,
			MAP(reasonCodeVersion = 2 => RiskWise.cdReasonCodesBus2(le, 6, rt, false, IBICID, rt.biid.Ship_to_output),
																	 RiskWise.cdReasonCodesBus(le, 6, rt, false, IBICID, rt.biid.Ship_to_output)
				 ),
			MAP(reasonCodeVersion = 2 => RiskWise.cdReasonCodesCon2(le, 6, rt, false, IBICID),
																	 RiskWise.cdReasonCodesCon(le, 6, rt, false, IBICID)
				 )
	);
	self := [];
END;

STReasons := join(iidST, ipInfo, left.seq=((right.ip.seq*2)-1), addSTReasons(left, right), left outer);


Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
	self.ri := le.ri + rt.ri;
	self := le;
END;
STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(left,right), left outer);


RETURN (STRecord);


end;
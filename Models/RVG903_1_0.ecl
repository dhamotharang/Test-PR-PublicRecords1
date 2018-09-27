/************************************************************************************/
/* RVG903_1_0                       Version 01                                BY PK */
/*                               Project ID:  1197                        4/02/2009 */
/************************************************************************************/

/************************************************************************************/
/* Returns the following score - RVG903                                             */
/************************************************************************************/

import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVG903_1_0(dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	
	Layout_ModelOut doModel( clam le ) := TRANSFORM

		/************************************************************************************/
		/* Fields from Modeling Shell                                                       */
		/************************************************************************************/
     in_dob                          := le.shell_input.dob;  // 30     Input Date of Birth (YYYYMMDD)

     nas_summary                     := le.iid.nas_summary; //35     Name-Address-SSN verification from InstantID
     nap_summary                     := le.iid.nap_summary; //36     Name-Address-Phone verification from InstantID

     rc_wphonetypeflag               := (integer)le.iid.wphonetypeflag; //48     Input Work Phone Type (PW)
     rc_wphonevalflag                := (integer)le.iid.wphonevalflag;  //51     Input Work Phone Validation Indicator
     rc_wphonedissflag               := (integer)le.iid.wphonedissflag; //54     Input Work Phone Disconnect Flag

     rc_decsflag                     := (integer)le.iid.decsflag; 			//56     SSN Deceased Indicator
     rc_ssndobflag                   := (integer)le.iid.socsdobflag; 	//57     SSN Prior Indicator (PI)
     rc_pwssndobflag                 := (integer)le.iid.pwsocsdobflag; //58     SSN Prior Indicator (PW)
     rc_ssnvalflag                   := (integer)le.iid.socsvalflag; 	//59     SSN Validation Indicator (PI)
     rc_pwssnvalflag                 := (integer)le.iid.pwsocsvalflag; //60     SSN Validation Indicator (PW)
                                  
     rc_dwelltype                    := le.iid.dwelltype; //68     Type of Dwelling

     rc_sources                      := le.iid.sources; //70     Header Sources Key

     rc_fnamecount                   := le.iid.firstcount; 		 //71     Number of Non-Phone Sources Confirming First Name
     rc_lnamecount                   := le.iid.lastcount; 		 //72     Number of Non-Phone Sources Confirming Last Name
     rc_phonelnamecount              := le.iid.phonelastcount; //77     Number of Phone Sources Confirming Last Name (Phone Search)

     combo_ssnscore                  := le.iid.combo_ssnscore; //109     SSN Name Match Score (255 = Could not calculate)
     combo_dobscore                  := le.iid.combo_dobscore; //110     DOB Name Match Score (255 = Could not calculate)

     EQ_count                        := le.source_verification.eq_count;   //120     Number of EQ Source Records
     PR_count                        := le.source_verification.pr_count;   //123     Number of PR Source Records
     EM_count                        := le.source_verification.em_count;   //125     Number of EM Source Records
     W_count                         := le.source_verification.w_count;    //126     Number of W Source Records

     ssnlength                       := le.input_validation.ssn_length;    //150     Length of Input SSN

     wphnpop                         := (integer)le.input_validation.workphone;     //155     Work Phone # Populated Indicator

     add1_address_score              := le.address_verification.input_address_information.address_score;          //175     Address Match Score (255 = Could not calculate)
     add1_isbestmatch                := (integer)le.address_verification.input_address_information.isbestmatch;            //177     Input Address matches 'Best' Address (1 = yes)
     add1_avm_med_fips               := le.AVM.Input_Address_Information.avm_median_fips_level;  //190     AVM: Median AVM for County
     add1_avm_med_geo11              := le.AVM.Input_Address_Information.avm_median_geo11_level; //191     AVM: Median AVM for Census Tract
     add1_avm_med_geo12              := le.AVM.Input_Address_Information.avm_median_geo12_level; //192     AVM: Median AVM for Census Block
                                 
     add1_naprop                     := le.address_verification.input_address_information.naprop; //204     Name-Address-Property ownership results for Address 1
     add2_naprop                     := le.address_verification.address_history_1.naprop;         //270     Name-Address-Property ownership results for Address 2
     add3_naprop                     := le.address_verification.address_history_2.naprop; 			  //305     Name-Address-Property ownership results for Address 3

     phones_per_addr_c6              := le.velocity_counters.phones_per_addr_created_6months; 		//360     # of Unique Phones Found with Input Address Created in the Last 6 Months

     inferred_dob                    := le.reported_dob; //473     Pre-Calc'd Inferred DOB (YYYYMMDD)

		 archive_date										 := if(999999=le.historydate, (unsigned4)((STRING)Std.Date.Today())[1..8], le.historydate);


 /************************************************************************************/
/* Code Starts Here                                                                 */
/************************************************************************************/


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		INTEGER mdy( integer month, integer day, integer year ) := ut.DaysSince1900( (string4)year, (string2)month, '01' ) + (day - 1);			
		
  /* Dates */

			 sysdate := mdy((integer)((STRING)archive_date)[5..6], if(le.historydate=999999, (integer)((STRING)archive_date)[7..8], 1), (integer)((STRING)archive_date)[1..4]);
			 sysyear := (integer)archive_date[1..4];


			 inferred_dob_8 := mdy(min(12,max(1,(integer)((STRING)inferred_dob)[5..6])),1,(integer)((STRING)inferred_dob)[1..4]) +
                              min(31,max(1,(integer)((STRING)inferred_dob)[7..8])) - 1;
															
			 inferred_dob_6 := mdy(min(12,max(1,(integer)((STRING)inferred_dob)[5..6])),1,(integer)((STRING)inferred_dob)[1..4]);

			 inferred_dob2 := Map(length(trim((string)inferred_dob)) = 8 => inferred_dob_8,
														length(trim((string)inferred_dob)) = 6 => inferred_dob_6,
														-9999);

			 yrsince_inferred_dob := if(inferred_dob2 = -9999, 0, (integer)((sysdate-inferred_dob2)/365.25));		

  
	
	/*  Verification */

       source_tot_DS := contains_i(StringLib.StringToUpperCase(rc_sources), 'DS,');


  /* Verification - Counts by Source */

       EQ_count_c := Map(EQ_count <=  5 => 0,
												 EQ_count <= 11 => 1,
												                   2);

       PR_count_c := Map(PR_count <=  0 => 0,
												 PR_count <=  1 => 1,
												                   2);

       PR_count_notbest_flag := if(PR_count <=  0, 0, 1);


       EM_count_c := Map(EM_count <=  1 => 0,
												 EM_count <=  5 => 1,
												                   2);


       W_count_flag := if(W_count  <=  0, 0, 1);


      EQ_count_c_m_best  := Map(EQ_count_c = 0 => 0.0398116438,
					       EQ_count_c = 1 => 0.0610122024,
					       EQ_count_c = 2 => 0.067311828,
					       -9999);


      PR_count_c_m_best := Map(PR_count_c = 0 => 0.0570642833,
				          PR_count_c = 1 => 0.0620577028,
				          PR_count_c = 2 => 0.0777988615,
				          -9999);

									 
			EM_count_c_m_best := Map(EM_count_c = 0 => 0.0565051277,
													EM_count_c = 1 => 0.0666327569,
													EM_count_c = 2 => 0.0872313527,
													-9999);

			vermod_counts_by_source_best2_tmp := -5.025487587
									 + EQ_count_c_m_best  * 15.777732157
									 + PR_count_c_m_best  * 10.569300513
									 + EM_count_c_m_best  * 10.526742594
									 + W_count_flag  * 0.4184272347
			;									 
							 
									 
      vermod_counts_by_source_best2 := 100 * (exp(vermod_counts_by_source_best2_tmp )) / (1+exp(vermod_counts_by_source_best2_tmp ));



			EM_count_c_m_notbest := Map(EM_count_c = 0 => 0.037111334,
																	EM_count_c = 1 => 0.0524158126,
																	EM_count_c = 2 => 0.0790513834,
																	-9999);


			vermod_counts_by_source_notbest2_tmp := -4.19206809
									 + EQ_count_c  * 0.2950176602
									 + PR_count_notbest_flag  * 0.4943407138
									 + EM_count_c_m_notbest  * 13.057790581
			;
			vermod_counts_by_source_notbest2 := 100 * (exp(vermod_counts_by_source_notbest2_tmp )) / (1+exp(vermod_counts_by_source_notbest2_tmp ));


			vermod_counts_by_source2 := if(add1_isbestmatch = 1, vermod_counts_by_source_best2, vermod_counts_by_source_notbest2);



  /* Verification - Input Elements */

       rc_fnamecount_c := Map(rc_fnamecount <= 1 => 0,
						      rc_fnamecount <= 2 => 1,
						      rc_fnamecount <= 3 => 2,
						      rc_fnamecount <= 4 => 3,
						      rc_fnamecount <= 5 => 4,
						      rc_fnamecount <= 6 => 5,
						      6);


       rc_lnamecount_best_c := Map(rc_lnamecount <= 1 => 0,
							       rc_lnamecount <= 4 => 3,
							       rc_lnamecount <= 7 => 6,
							       7);


       add1_address_score_100 := if( add1_address_score = 100, 1, 0);


       combo_ssnscore_100 := if( combo_ssnscore = 100, 1, 0);


       combo_dobscore_100 := Map(combo_dobscore = 100 => 2,
							     combo_dobscore >= 60 and combo_dobscore < 100 => 1,
							     0);


       inf_dob_match := if( trim(in_dob) = trim((string)inferred_dob), 1, 0);



  /* Code to Means */


      rc_lnamecount_best_c_m := Map(rc_lnamecount_best_c = 0 => 0.042688465,
								    rc_lnamecount_best_c = 3 => 0.054696341,
								    rc_lnamecount_best_c = 6 => 0.0739910314,
								    rc_lnamecount_best_c = 7 => 0.0967741935,
								    -9999);


      combo_dobscore_100_m := Map(combo_dobscore_100 = 0 => 0.0396184886,
							      combo_dobscore_100 = 1 => 0.0639780931,
							      combo_dobscore_100 = 2 => 0.0666194905,
							      -9999);


      vermod_elements_best_tmp := -5.975160332
                   + combo_ssnscore_100  * 1.7743674476
                   + rc_lnamecount_best_c_m  * 13.178656581
                   + combo_dobscore_100_m  * 11.244475382
      ;
      vermod_elements_best := 100 * (exp(vermod_elements_best_tmp )) / (1+exp(vermod_elements_best_tmp ));


      vermod_elements_notbest_tmp := -4.810336659
                     + rc_fnamecount_c  * 0.1244033115
                     + rc_phonelnamecount  * 0.2723057105
                     + add1_address_score_100  * 0.4483870638
                     + combo_ssnscore_100  * 1.1063508779
                     + inf_dob_match  * 0.2308322313
        ;
      vermod_elements_notbest := 100 * (exp(vermod_elements_notbest_tmp )) / (1+exp(vermod_elements_notbest_tmp ));

			vermod_elements := if( add1_isbestmatch = 1, vermod_elements_best, vermod_elements_notbest);


  /* Vermod */

			vermod_best2_tmp := -4.002493682
									 + vermod_elements  * 0.1985398982
			;
			vermod_best2 := 100 * (exp(vermod_best2_tmp )) / (1+exp(vermod_best2_tmp ));

			
			vermod_notbest2_tmp := -4.341843074
									 + vermod_counts_by_source2  * 0.1052732207
									 + vermod_elements  * 0.1590958536
			;
			vermod_notbest2 := 100 * (exp(vermod_notbest2_tmp )) / (1+exp(vermod_notbest2_tmp ));			
			

      vermod2 := if( add1_isbestmatch = 1, vermod_best2, vermod_notbest2);


  /*  Fraud Point */

		 aptflag := if( rc_dwelltype = 'A', 1, 0);


		 deceased := if( rc_decsflag = 1, 1, 0);


		 deceased_flag := if( (( source_tot_ds > 0 ) or ( deceased > 0 )), 1, 0);


		 ssnprior := if( rc_pwssndobflag=1 or rc_ssndobflag=1, 1, 0);


		 ssninval_pi := if( rc_ssnvalflag = 1, 1, 0);

		 ssninval_pw := if( rc_pwssnvalflag in [1,2,3], 1, 0);

		 ssinval_flag := if(ssninval_pi = 1 or ssninval_pw = 1, 1, 0);

		 ssnprob     := max( deceased_flag   ,
												ssnprior        ,
												ssinval_flag
											 );


      wphn_cell_mobile_pager := if( trim((string)rc_wphonetypeflag) in ['1', '2', '3'], 1, 0);


      wphn_valid_res_phone := if(rc_wphonevalflag = 2, 1, 0);
      wphn_valid_NotPots   := if(rc_wphonevalflag = 4, 1, 0);
      wphn_valid_unk_phone := if(rc_wphonevalflag = 5, 1, 0);


      wphn_disconnected := if(rc_wphonedissflag = 1, 1, 0);

          

      wphnprob_neg_pop_tmp := sum(
                          wphn_cell_mobile_pager    ,
                          wphn_valid_res_phone      ,
                          wphn_valid_NotPots        ,
                          wphn_valid_unk_phone      ,
                          wphn_disconnected
                         );
      
      // cap at 2
      wphnprob_neg_pop := if(wphnprob_neg_pop_tmp > 2, 2, wphnprob_neg_pop_tmp);

			wphnprob_neg := if( wphnpop = 1, wphnprob_neg_pop, -1);


      wphnprob_neg_m := Map(wphnprob_neg = -1 => 0.0433170153,
						    wphnprob_neg = 0 => 0.0649796938 ,
						    wphnprob_neg = 1 => 0.0592506535 ,
						    wphnprob_neg = 2 => 0.0405507356 ,
						    -9999);



  /*  Velocity */
  
      phones_per_addr_c6_c_flag_tmp := if( phones_per_addr_c6 <= 0, 0, 1);
      phones_per_addr_c6_c_flag := if( aptflag = 1, -1, phones_per_addr_c6_c_flag_tmp);


  /*  Age    */

       inferred_dob_age := Map(yrsince_inferred_dob <= 21 => 21,
						       yrsince_inferred_dob >= 60 => 60,
						       yrsince_inferred_dob);



  /*  Property */

       avm_geo_tmp := Map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							     add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
							     add1_avm_med_fips  > 0 => add1_avm_med_fips,
							     100000);

	   // cap
       avm_geo := if( avm_geo_tmp > 100000, 100000, avm_geo_tmp);


			 NaProp1_count := (integer)( add1_naprop = 1 ) + (integer)( add2_naprop = 1 ) + (integer)( add3_naprop = 1 );



  /* Model */

       base  := 703;                          /* RiskView Parameters */
       odds  := 1 / 21;
       point := 40;

       ov_ssndead      := (integer)( ((integer)ssnlength > 0 ) and ( rc_decsflag = 1 ) );
       ov_ssnprior     :=  (integer)( (rc_ssndobflag = 1 ) or ( rc_pwssndobflag = 1 ) );

       mod7 := -5.692379996
                    + vermod2  * 0.1209649302
                    + phones_per_addr_c6_c_flag  * -0.075485101
                    + inferred_dob_age  * 0.0221626951
                    + ssnprob  * -0.987644564
                    + wphnprob_neg_m  * 19.05433042
                    + NaProp1_count  * -0.066288452
                    + avm_geo  * 3.777961E-6
       ;
       phat := (exp(mod7 )) / (1+exp(mod7 ));
       mod7_scr_tmp1 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

       mod7_scr_tmp2 := min(900,max(501,mod7_scr_tmp1));


       mod7_scr := if(( mod7_scr_tmp2 > 680 ) and ( ov_ssndead = 1 or ov_ssnprior = 1 ), 680, mod7_scr_tmp2);

       RVG903 := if( riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, mod7_scr);


			self.seq := le.seq;
			
			// WE DO NOT WANT TO RETURN REASON CODES FROM THIS MODEL. SCORES ONLY. 
			// However, we need to check correction reason codes and inCalif for proper score overrides.
			
			riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
			inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
									(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
									(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;		
									
			riTemp2 := RiskWise.rvReasonCodes(le, 4, inCalif, true);  // Run this so that inCalif can return RC 35 if necessary
			
			self.score := map
			(
				riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
				riTemp2[1].hri='35' => '000',
				intformat( RVG903, 3, 1 )
			);	
			
			SELF.ri := [];  // No reason codes returned for this model. 
			
	end;

	model := project( clam, doModel(left) );
	return model;
end;


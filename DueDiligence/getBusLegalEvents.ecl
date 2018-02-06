IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp;

EXPORT getBusLegalEvents(DATASET(DueDiligence.layouts.Busn_Internal) BusnData,
																Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											          BIPV2.mod_sources.iParams linkingOptions,
												 boolean ReportIsRequested, 
		  											      boolean DebugMode = FALSE,
												 boolean isFCRA = false) := FUNCTION

	// ------                                                                                    ------
	// ------ The Business Executives have been added to the Busn_Internal                       ------
	// ------ in the form of a child dataset                                                     ------
	// ------ Call the common.getexecs extract all of the business executives                    ------
 // ------ into a simple DATASET so it can go through the get LegalEvents                     ------
	// ------ The results will come back this layout:                                            ------
	// ------  DueDiligence.LayoutsInternal.RelatedParty                                         ------
	// ------                                                                                    ------
	SimpleBusinessExecutives   := DueDiligence.CommonBusiness.getexecs(BusnData);   
	 
	// ------   Start by getting all of the liens and judgment data                              ------
	// ------ The results will come back this layout:                                            ------
	// ------  DueDiligence.LayoutsInternal.RelatedParty                                         ------  
	// ------  
  UpdateBusinessExecutivesCriminalOffense  := DueDiligence.getIndCriminal(SimpleBusinessExecutives, ReportIsRequested, Debugmode, isFCRA);
	
	// ------  Collect all of the Criminal offenses data                                         ------
	getBEOLegalEventType := DueDiligence.getIndLegalEventType(UpdateBusinessExecutivesCriminalOffense);
	// ------ The results will come back this layout:                                            ------
	// ------  DueDiligence.LayoutsInternal.RelatedParty                                         ------
	// ------  
  UpdateBusinessExecutivesCriminalOffense  := DueDiligence.getIndCriminal(SimpleBusinessExecutives, ReportIsRequested, Debugmode, isFCRA);
  // ------ with the derogatory events found in the previous function                          ------
	// ------ The results will come back this layout:                                            ------
	// ------ DueDiligence.layouts.Busn_Internal                                                 ------

  UpdateBusnExecsWithDerog   := DueDiligence.CommonBusiness.ReplaceExecs(BusnData, getBEOLegalEventType);
	 		

	//**********************roll the BEO legal info up to inquired business  		
	rolledExecutiveCriminalOffense := ROLLUP(SORT(getBEOLegalEventType, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), 
										LEFT.seq = RIGHT.seq AND
										LEFT.ultID = RIGHT.ultID AND
										LEFT.orgID = RIGHT.orgID AND
										LEFT.seleID = RIGHT.seleID,
										TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
										          /*  If the DID on the left is currently incarcerated or currently on parole (per the VOO Function) 
                                  - keep that flag, else pick up the flag from the RIGHT.  */  
										     SELF.party.EverIncarcer                       := IF (LEFT.party.EverIncarcer, LEFT.party.EverIncarcer, RIGHT.party.EverIncarcer);
															SELF.party.CurrIncarcer                       := IF (LEFT.party.CurrIncarcer, LEFT.party.CurrIncarcer, RIGHT.party.CurrIncarcer);
															SELF.party.CurrParole                         := IF (LEFT.party.CurrParole,   LEFT.party.CurrParole,   RIGHT.party.CurrParole);
															
															/* We are looking for the Business Executive Officers that has the most of each of the following offenses...         */
															/* rather than summing up all of the offenses for all of the BEO's                                                   */
															/* Based on this language used in the attribute...                                                                   */
               /* LEVEL 8:                                                                                                          */
															/* Business or at least one BEO is reported with evidence of 5-9 liens, judgements, or evictions in the last 3 years */
															/* Example if there are 3 BEO's and each BEO has 5 liens/judgments/eviction - attribute level is 8 not level 9 (10   */
															/* or greater).                                                                                                      */  
															SELF.party.ConvictedFelonyCount4F_OVNYR       := IF(LEFT.party.ConvictedFelonyCount4F_OVNYR > RIGHT.party.ConvictedFelonyCount4F_OVNYR,
															                                                    LEFT.party.ConvictedFelonyCount4F_OVNYR,
																																									                         RIGHT.party.ConvictedFelonyCount4F_OVNYR);  
															
               SELF.party.ConvictedFelonyCount4F_NYR         := IF(LEFT.party.ConvictedFelonyCount4F_NYR > RIGHT.party.ConvictedFelonyCount4F_NYR,
							                                                            LEFT.party.ConvictedFelonyCount4F_NYR,
																																					                             RIGHT.party.ConvictedFelonyCount4F_NYR);
															
															SELF.party.ConvictedFelonyCount4F_Ever        := IF(LEFT.party.ConvictedFelonyCount4F_Ever > RIGHT.party.ConvictedFelonyCount4F_Ever,
															                                                    LEFT.party.ConvictedFelonyCount4F_Ever,
																																									                         RIGHT.party.ConvictedFelonyCount4F_Ever);
															
															SELF.party.ConvictedUnknownCount4U_OVNYR      := IF(LEFT.party.ConvictedUnknownCount4U_OVNYR > RIGHT.party.ConvictedUnknownCount4U_OVNYR,
															                                                    LEFT.party.ConvictedUnknownCount4U_OVNYR,
																																									                         RIGHT.party.ConvictedUnknownCount4U_OVNYR);
															
															SELF.party.ConvictedUnknownCount4U_NYR        := IF(LEFT.party.ConvictedUnknownCount4U_NYR > RIGHT.party.ConvictedUnknownCount4U_NYR,
															                                                    LEFT.party.ConvictedUnknownCount4U_NYR,
																																									                         RIGHT.party.ConvictedUnknownCount4U_NYR);
															
															SELF.party.ConvictedUnknownCount4U_Ever       := IF(LEFT.party.ConvictedUnknownCount4U_Ever > RIGHT.party.ConvictedUnknownCount4U_Ever,
															                                                    LEFT.party.ConvictedUnknownCount4U_Ever,
																																									                         RIGHT.party.ConvictedUnknownCount4U_Ever);
															
															SELF.party.ConvictedMisdemeanorCount4M_OVNYR  := IF(LEFT.party.ConvictedMisdemeanorCount4M_OVNYR > RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR,
															                                                    LEFT.party.ConvictedMisdemeanorCount4M_OVNYR,
																																									                         RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR);
															
															SELF.party.ConvictedMisdemeanorCount4M_NYR    := IF(LEFT.party.ConvictedMisdemeanorCount4M_NYR > RIGHT.party.ConvictedMisdemeanorCount4M_NYR,
															                                                    LEFT.party.ConvictedMisdemeanorCount4M_NYR,
																																									                         RIGHT.party.ConvictedMisdemeanorCount4M_NYR);
															
															SELF.party.ConvictedMisdemeanorCount4M_Ever   := IF(LEFT.party.ConvictedMisdemeanorCount4M_Ever > RIGHT.party.ConvictedMisdemeanorCount4M_Ever,
															                                                    LEFT.party.ConvictedMisdemeanorCount4M_Ever,
																																									                         RIGHT.party.ConvictedMisdemeanorCount4M_Ever);
															
															SELF.party.ConvictedTraffic2T_OVNYR           := IF(LEFT.party.ConvictedTraffic2T_OVNYR  > RIGHT.party.ConvictedTraffic2T_OVNYR,
															                                                    LEFT.party.ConvictedTraffic2T_OVNYR,
																																									                         RIGHT.party.ConvictedTraffic2T_OVNYR);
															
															SELF.party.ConvictedTraffic2T_NYR             := IF(LEFT.party.ConvictedTraffic2T_NYR  > RIGHT.party.ConvictedTraffic2T_NYR,
															                                                    LEFT.party.ConvictedTraffic2T_NYR,
																																									                         RIGHT.party.ConvictedTraffic2T_NYR);
															
															SELF.party.ConvictedTraffic2T_Ever            := IF(LEFT.party.ConvictedTraffic2T_Ever > RIGHT.party.ConvictedTraffic2T_Ever,
															                                                    LEFT.party.ConvictedTraffic2T_Ever,
																																									                         RIGHT.party.ConvictedTraffic2T_Ever);
															
														 SELF.party.ConvictedInfractions2I_OVNYR       := IF(LEFT.party.ConvictedInfractions2I_OVNYR > RIGHT.party.ConvictedInfractions2I_OVNYR,
														                                                     LEFT.party.ConvictedInfractions2I_OVNYR,
																																								                          RIGHT.party.ConvictedInfractions2I_OVNYR);
														 
		             SELF.party.ConvictedInfractions2I_NYR         := IF(LEFT.party.ConvictedInfractions2I_NYR > RIGHT.party.ConvictedInfractions2I_NYR,
								                                                           LEFT.party.ConvictedInfractions2I_NYR,
																																					                             RIGHT.party.ConvictedInfractions2I_NYR);
								                        
		             SELF.party.ConvictedInfractions2I_Ever        := IF(LEFT.party.ConvictedInfractions2I_Ever > RIGHT.party.ConvictedInfractions2I_Ever,
								                                                           LEFT.party.ConvictedInfractions2I_Ever,
																																					                             RIGHT.party.ConvictedInfractions2I_Ever);  
															
															SELF.party.category9 := LEFT.party.category9 OR RIGHT.party.category9;
															SELF.party.category8 := LEFT.party.category8 OR RIGHT.party.category8;
															SELF.party.category7 := LEFT.party.category7 OR RIGHT.party.category7;
															SELF.party.category6 := LEFT.party.category6 OR RIGHT.party.category6;
															SELF.party.category5 := LEFT.party.category5 OR RIGHT.party.category5;
															SELF.party.category4 := LEFT.party.category4 OR RIGHT.party.category4;
															SELF.party.category3 := LEFT.party.category3 OR RIGHT.party.category3;
															SELF.party.category2 := LEFT.party.category2 OR RIGHT.party.category2;
															
								 
															// SELF.party.evictionsCntOVNYR                  := IF(LEFT.party.evictionsCntOVNYR     > RIGHT.party.evictionsCntOVNYR,
															                                                    // LEFT.party.evictionsCntOVNYR,
																																									                         // RIGHT.party.evictionsCntOVNYR);
															
															// SELF.party.evictionsCntInThePastNYR           := IF(LEFT.party.evictionsCntInThePastNYR     > RIGHT.party.evictionsCntInThePastNYR,
															                                                    // LEFT.party.evictionsCntInThePastNYR,
																																									                         // RIGHT.party.evictionsCntInThePastNYR);
															 
		             // SELF.party.evictionsCnt                       := IF(LEFT.party.evictionsCnt                 > RIGHT.party.evictionsCnt,
								                                                           // LEFT.party.evictionsCnt,
																																					                             // RIGHT.party.evictionsCnt);
								 
															SELF.party.category9 := LEFT.party.category9 OR RIGHT.party.category9;
															SELF.party.category8 := LEFT.party.category8 OR RIGHT.party.category8;
															SELF.party.category7 := LEFT.party.category7 OR RIGHT.party.category7;
															SELF.party.category6 := LEFT.party.category6 OR RIGHT.party.category6;
															SELF.party.category5 := LEFT.party.category5 OR RIGHT.party.category5;
															SELF.party.category4 := LEFT.party.category4 OR RIGHT.party.category4;
															SELF.party.category3 := LEFT.party.category3 OR RIGHT.party.category3;
															SELF.party.category2 := LEFT.party.category2 OR RIGHT.party.category2;
															
								 
															SELF := LEFT;));
	
	UpdateBusnWithEvidenceOfCrim := JOIN(UpdateBusnExecsWithDerog, rolledExecutiveCriminalOffense,
											LEFT.seq = RIGHT.seq AND
											LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
											LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
											LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
											TRANSFORM(DueDiligence.Layouts.Busn_Internal,
											     //***************************************************************************************************
											          /* These are all of the evidence flags used in the CRIMINAL ATTRIBUTE  */ 
																//***************************************************************************************************
											     SELF.BEOevidenceOfPreviousIncarceration             := IF(RIGHT.party.EverIncarcer,        TRUE, FALSE),  
											     SELF.BEOevidenceOfCurrentIncarceration              := IF(RIGHT.party.CurrIncarcer,        TRUE, FALSE),  
																SELF.BEOevidenceOfCurrentParole                     := IF(RIGHT.party.CurrParole,          TRUE, FALSE),
																    /*   This will be used in Level 8 of busLegalCriminal attribute  */  
																SELF.BEOevidenceOfFelonyConvictionInLastNYR         := IF(RIGHT.party.ConvictedFelonyCount4F_NYR > 0, TRUE, FALSE), 
																    /*   This will be used in Level 7 of busLegalCriminal attribute  */
																SELF.BEOevidenceOfFelonyConvictionOlderNYR          := IF(RIGHT.party.ConvictedFelonyCount4F_OVNYR > 0, TRUE, FALSE), 
																    /*   This will be used in Level 5 of busLegalCriminal attribute  */  
																SELF.BEOevidenceOfUncatagorizedConvictionInLastNYR  := IF(RIGHT.party.ConvictedUnknownCount4U_NYR > 0, TRUE, FALSE), 
															    	/*   This will be used in Level 4 of busLegalCriminal attribute  */ 
																SELF.BEOevidenceOfMisdeameanorConvictionInLastNYR   := IF(RIGHT.party.ConvictedMisdemeanorCount4M_NYR > 0, TRUE, FALSE),
																    /*   This will be used in Level 3 of busLegalCriminal attribute */ 
																SELF.BEOevidenceOfUncatagorizedConvictionOlderNYR   := IF(RIGHT.party.ConvictedUnknownCount4U_OVNYR > 0, TRUE, FALSE),
																SELF.BEOevidenceOfMisdeameanorConvictionOlderNYR    := IF(RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR > 0, TRUE, FALSE),  
																//***************************************************************************************************
																      /* These are all of the evidence flags used in the CIVIL ATTRIBUTE  */ 
																			   /*   CIVIL ATTRIBUTE includes liens, judgements (held in the liens  */
																				  /*   unreleased count) plus evictions                               */
																     // /*  This will be used in Level 4 of BusLegalCivil attribute  */
																// SELF.BEOevidenceOf5To9CivilOlderNYR                  := IF(tempCivilOlderNYR IN DueDiligence.Constants.CIVIL_RANGE_A , TRUE,  FALSE),
																	    // /*  This will be used in Level 3 of BusLegalCivil attribute  */
																// SELF.BEOevidenceOf3To4CivilOlderNYR                  := IF(tempCivilOlderNYR IN DueDiligence.Constants.CIVIL_RANGE_B , TRUE, FALSE),
																     // /*  This will be used in Level 2 of BusLegalCivil attribute  */
																// SELF.BEOevidenceOf1To2CivilOlderNYR                  := IF(tempCivilOlderNYR IN DueDiligence.Constants.CIVIL_RANGE_C, TRUE,  FALSE),
																//***************************************************************************************************
																      /* These are all of the evidence flags used in the TRAFFIC and INFRACTIONS ATTRIBUTE  */ 
																//***************************************************************************************************
																     /*  This will be used in Level 9 of busTrafficInfractions attribute  */   
											     SELF.BEOevidenceOf3TrafficNYR                       := IF(RIGHT.party.ConvictedTraffic2T_NYR >= 3, TRUE, FALSE), 
													        /*  This will be used in Level 8 of busTrafficInfractions attribute  */
											     SELF.BEOevidenceOf2TrafficNYR                       := IF(RIGHT.party.ConvictedTraffic2T_NYR IN [1, 2], TRUE, FALSE),
													        /*  This will be used in Level 7 of busTrafficInfractions attribute  */
																SELF.BEOevidenceOf3InfractionsNYR                   := IF(RIGHT.party.ConvictedInfractions2I_NYR >= 3,  TRUE, FALSE),
											          /*  This will be used in Level 6 of busTrafficInfractions attribute  */     
															 SELF.BEOevidenceOf2InfractionsNYR                    := IF(RIGHT.party.ConvictedInfractions2I_NYR IN [1, 2], TRUE, FALSE),
															      /*  This will be used in Level 5 of busTrafficInfractions attribute  */  
																SELF.BEOevidenceOf3TrafficOlderNYR                   := IF(RIGHT.party.ConvictedTraffic2T_OVNYR >= 3, TRUE, FALSE),   
																     /*  This will be used in Level 4 of busTrafficInfractions attribute  */
																SELF.BEOevidenceOf2TrafficOlderNYR                   := IF(RIGHT.party.ConvictedTraffic2T_OVNYR IN [1, 2], TRUE,  FALSE),
																	    /*  This will be used in Level 3 of busTrafficInfractions attribute  */
																SELF.BEOevidenceOf3InfractionsOlderNYR               := IF(RIGHT.party.ConvictedInfractions2I_OVNYR >= 3, TRUE, FALSE),
																     /*  This will be used in Level 2 of busTrafficInfractions attribute  */
																SELF.BEOevidenceOf2InfractionsOlderNYR               := IF(RIGHT.party.ConvictedInfractions2I_OVNYR IN [1, 2], TRUE,  FALSE),
																
															//legal event type
															SELF.atleastOneBEOInCategory9 := RIGHT.party.category9;
															SELF.atleastOneBEOInCategory8 := RIGHT.party.category8;
															SELF.atleastOneBEOInCategory7 := RIGHT.party.category7;
															SELF.atleastOneBEOInCategory6 := RIGHT.party.category6;
															SELF.atleastOneBEOInCategory5 := RIGHT.party.category5;
															SELF.atleastOneBEOInCategory4 := RIGHT.party.category4;
															SELF.atleastOneBEOInCategory3 := RIGHT.party.category3;
															SELF.atleastOneBEOInCategory2 := RIGHT.party.category2;
															SELF.BEOsHaveNoConvictionsOrCategoryHits := RIGHT.party.category9 = FALSE AND RIGHT.party.category8 = FALSE AND
																																					RIGHT.party.category7 = FALSE AND RIGHT.party.category6 = FALSE AND
																																					RIGHT.party.category5 = FALSE AND RIGHT.party.category4 = FALSE AND
																																					RIGHT.party.category3 = FALSE AND RIGHT.party.category2 = FALSE;
															
															SELF := LEFT;),
											LEFT OUTER);
		
		
	 // -----                                                                                     ----- 
	 // ----- If the report is requested by the XML Service (not allowed by Batch)                -----
	 // ----- THEN add the BEO Criminal data to that section of the report.                       -----
	 // ----- ELSE just leave the reporting sections empty                                        -----
	 // -----   The AddCriminalOffenses is in Business Internal layout                            -----
	 // -----   The OffensesToListButLimited is a subset of all the offenses when there are       -----
	 // -----   more than 20 offenses.  
	 // -----                                                                                     -----
	UpdateBusnExecCriminalWithReport  := IF(ReportIsRequested, 
	                                     DueDiligence.reportBusExecCriminal(UpdateBusnWithEvidenceOfCrim, UpdateBusinessExecutivesCriminalOffense, DebugMode),
	      																		             /* ELSE */ 
																			                   UpdateBusnWithEvidenceOfCrim); 
	
	
	// -----                                                                                     ------
	// ----- Finish finding DEROG information for the Business                                   ------                             
	// ------ The results will come back this layout:                                            ------
	// ------      DueDiligence.layouts.Busn_Internal                                            ------
	// ------                                                                                    ------  
	UpdateInquiredBusinessWithDerog   := DueDiligence.getBusLien(UpdateBusnExecCriminalWithReport, options, linkingOptions, ReportIsRequested, DebugMode); 
	   
	// ********************
	//   DEBUGGING OUTPUTS
	// ********************
	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(BusnData, 50),                              NAMED('BusnData')));    	   	    	   	   	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(SimpleBusinessExecutives, 50),              NAMED('SimpleBusinessExecutives')));    	   	    	   	   	   	 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusinessExecutivesCriminalOffense, 50),   NAMED('UpdateBusinessExecutivesCriminalOffense'))); 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusnExecsWithDerog, 50),              NAMED('UpdateBusnExecsWithDerog')));
	 IF(DebugMode,     OUTPUT(CHOOSEN(rolledExecutiveCriminalOffense, 50),        NAMED('rolledExecutiveCriminalOffense'))); 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateBusnWithEvidenceOfCrim, 50),          NAMED('UpdateBusnWithEvidenceOfCrim'))); 
	 IF(DebugMode,     OUTPUT(CHOOSEN(UpdateInquiredBusinessWithDerog , 50),      NAMED('UpdateInquiredBusinessWithDerog')));
	  
		
		
	

	// OUTPUT(rolledExecutiveCriminalOffense, NAMED('rolledExecutiveCriminalOffense'));
	// OUTPUT(UpdateBusnWithEvidenceOfCrim, NAMED('UpdateBusnWithEvidenceOfCrim'));
	// OUTPUT(UpdateInquiredBusinessWithDerog, NAMED('UpdateInquiredBusinessWithDerog'));
	// OUTPUT(getBEOLegalEventType, NAMED('getBEOLegalEventType'));
	
 
	RETURN UpdateInquiredBusinessWithDerog;
END; 
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

	// ------ Collect all of the Criminal offenses data                                         ------
	// ------ The results will come back this layout:                                           ------
	// ------ DueDiligence.LayoutsInternal.RelatedParty                                         ------
	// ------  
  UpdateBusinessExecutivesCriminalOffense  := DueDiligence.getIndCriminal(SimpleBusinessExecutives, ReportIsRequested, Debugmode, isFCRA);
	
	//retrieve related party event types for a given offense charge
	getBEOLegalEventType := DueDiligence.getIndLegalEventType(UpdateBusinessExecutivesCriminalOffense);

  // ------                                                                                    ------
	// ------ Call the Common.ReplaceExecs routine to  update   executive information            ------ 
  // ------ with the derogatory events found in the previous function                          ------
	// ------ The results will come back this layout:                                            ------
	// ------ DueDiligence.layouts.Busn_Internal                                                 ------
  UpdateBusnExecsWithDerog   := DueDiligence.CommonBusiness.ReplaceExecs(BusnData, getBEOLegalEventType);
	 		

	//**********************roll the BEO legal info up to inquired business  		
	rolledExecutiveCriminalOffense := ROLLUP(SORT(getBEOLegalEventType, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), 
																						#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
																						TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																											//rollup to the business for the state criminal data of the BEOs
																											SELF.party.EverIncarcer                       := LEFT.party.EverIncarcer OR RIGHT.party.EverIncarcer;
																											SELF.party.CurrIncarcer                       := LEFT.party.CurrIncarcer OR RIGHT.party.CurrIncarcer;
																											SELF.party.CurrParole                         := LEFT.party.CurrParole OR RIGHT.party.CurrParole;
                                                                                                      
																											SELF.party.ConvictedFelonyCount4F_OVNYR       := MAX(LEFT.party.ConvictedFelonyCount4F_OVNYR,
																																																					 RIGHT.party.ConvictedFelonyCount4F_OVNYR);  
																											
																											SELF.party.ConvictedFelonyCount4F_NYR         := MAX(LEFT.party.ConvictedFelonyCount4F_NYR,
                                                                                                           RIGHT.party.ConvictedFelonyCount4F_NYR);
																											
																											SELF.party.ConvictedUnknownCount4U_OVNYR      := MAX(LEFT.party.ConvictedUnknownCount4U_OVNYR,
																																																					 RIGHT.party.ConvictedUnknownCount4U_OVNYR);
																											
																											SELF.party.ConvictedUnknownCount4U_NYR        := MAX(LEFT.party.ConvictedUnknownCount4U_NYR,
																																																					 RIGHT.party.ConvictedUnknownCount4U_NYR);
																											
																											SELF.party.ConvictedMisdemeanorCount4M_OVNYR  := MAX(LEFT.party.ConvictedMisdemeanorCount4M_OVNYR,
																																																					 RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR);
																											
																											SELF.party.ConvictedMisdemeanorCount4M_NYR    := MAX(LEFT.party.ConvictedMisdemeanorCount4M_NYR,
																																																					 RIGHT.party.ConvictedMisdemeanorCount4M_NYR);
                                                                                                           
                                                      SELF.party.noEvidenceOfConvictedStateCrim     := LEFT.party.noevidenceofconvictedstatecrim OR RIGHT.party.noevidenceofconvictedstatecrim;
																											
                                                      
                                                      //rollup to the business for the traffic and infractions of the BEOs
																											SELF.party.ConvictedTraffic2T_OVNYR           := MAX(LEFT.party.ConvictedTraffic2T_OVNYR,
																																																					 RIGHT.party.ConvictedTraffic2T_OVNYR);
																											
																											SELF.party.ConvictedTraffic2T_NYR             := MAX(LEFT.party.ConvictedTraffic2T_NYR,
																																																					 RIGHT.party.ConvictedTraffic2T_NYR);
																											
																											SELF.party.ConvictedInfractions2I_OVNYR       := MAX(LEFT.party.ConvictedInfractions2I_OVNYR,
																																																					 RIGHT.party.ConvictedInfractions2I_OVNYR);
																										 
																											SELF.party.ConvictedInfractions2I_NYR         := MAX(LEFT.party.ConvictedInfractions2I_NYR,
																																																					 RIGHT.party.ConvictedInfractions2I_NYR); 
                                                                                                           
                                                      
                                                      SELF.party.noEvidenceOfTrafficOrInfraction     := LEFT.party.noEvidenceOfTrafficOrInfraction OR RIGHT.party.noEvidenceOfTrafficOrInfraction;
                                                      
                                                      
                                                      //rollup to the business the counts of state crimial and trafic ever of the BEOs
                                                      SELF.party.ConvictedTraffic2T_Ever := LEFT.party.ConvictedTraffic2T_Ever + RIGHT.party.ConvictedTraffic2T_Ever;
                                                      SELF.party.ConvictedInfractions2I_Ever := LEFT.party.ConvictedInfractions2I_Ever + RIGHT.party.ConvictedInfractions2I_Ever;
                                                      
                                                      SELF.party.NonConvictedTraffic1T_Ever := LEFT.party.NonConvictedTraffic1T_Ever + RIGHT.party.NonConvictedTraffic1T_Ever;
                                                      SELF.party.NonConvictedInfraction1I_Ever := LEFT.party.NonConvictedInfraction1I_Ever + RIGHT.party.NonConvictedInfraction1I_Ever;

                                                      SELF.party.ConvictedFelonyCount4F_Ever := LEFT.party.ConvictedFelonyCount4F_Ever + RIGHT.party.ConvictedFelonyCount4F_Ever;
                                                      SELF.party.ConvictedUnknownCount4U_Ever := LEFT.party.ConvictedUnknownCount4U_Ever + RIGHT.party.ConvictedUnknownCount4U_Ever;
                                                      SELF.party.ConvictedMisdemeanorCount4M_Ever := LEFT.party.ConvictedMisdemeanorCount4M_Ever + RIGHT.party.ConvictedMisdemeanorCount4M_Ever;

                                                      SELF.party.NonConvictedFelonyCount3F_EVER := LEFT.party.NonConvictedFelonyCount3F_EVER + RIGHT.party.NonConvictedFelonyCount3F_EVER;
                                                      SELF.party.NonConvictedUnknownCount3U_EVER := LEFT.party.NonConvictedUnknownCount3U_EVER + RIGHT.party.NonConvictedUnknownCount3U_EVER;
                                                      SELF.party.NonConvictedMisdemeanorCount3M_EVER := LEFT.party.NonConvictedMisdemeanorCount3M_EVER + RIGHT.party.NonConvictedMisdemeanorCount3M_EVER;
                                                      
                                                      //rollup to the business for the traffic and infractions of the BEOs
                                                      SELF.party.trafficInfractionFlags := DueDiligence.Common.RollFlags(party.trafficInfractionFlags);
                                                      SELF.party.trafficInfractionScore := MAX(LEFT.party.trafficInfractionScore, RIGHT.party.trafficInfractionScore);

                                                      //rollup to the business for the legal event types of the BEOs
																											SELF.party.legalEventTypeFlags := DueDiligence.Common.RollFlags(party.legalEventTypeFlags);
                                                      SELF.party.legalEventTypeScore := MAX(LEFT.party.legalEventTypeScore, RIGHT.party.legalEventTypeScore);   
																																															 
																											SELF := LEFT;));
	
	UpdateBusnWithEvidenceOfCrim := JOIN(UpdateBusnExecsWithDerog, rolledExecutiveCriminalOffense,
																				#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
																				TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																								  //***************************************************************************************************
																									/* These are all of the evidence flags used in the CRIMINAL ATTRIBUTE  */ 
																									//***************************************************************************************************
																									SELF.BEOevidenceOfPreviousIncarceration             := IF(RIGHT.party.EverIncarcer,        TRUE, FALSE),  
																									SELF.BEOevidenceOfCurrentIncarceration              := IF(RIGHT.party.CurrIncarcer,        TRUE, FALSE),  
																									SELF.BEOevidenceOfCurrentParole                     := IF(RIGHT.party.CurrParole,          TRUE, FALSE),
																									/*   This will be used in Level 8 of BusLegalStateCriminal attribute  */  
																									SELF.BEOevidenceOfFelonyConvictionInLastNYR         := IF(RIGHT.party.ConvictedFelonyCount4F_NYR > 0, TRUE, FALSE), 
																									/*   This will be used in Level 7 of BusLegalStateCriminal attribute  */
																									SELF.BEOevidenceOfFelonyConvictionOlderNYR          := IF(RIGHT.party.ConvictedFelonyCount4F_OVNYR > 0, TRUE, FALSE), 
																									/*   This will be used in Level 5 of BusLegalStateCriminal attribute  */  
																									SELF.BEOevidenceOfUncatagorizedConvictionInLastNYR  := IF(RIGHT.party.ConvictedUnknownCount4U_NYR > 0, TRUE, FALSE), 
																									/*   This will be used in Level 4 of BusLegalStateCriminal attribute  */ 
																									SELF.BEOevidenceOfMisdeameanorConvictionInLastNYR   := IF(RIGHT.party.ConvictedMisdemeanorCount4M_NYR > 0, TRUE, FALSE),
																									/*   This will be used in Level 3 of BusLegalStateCriminal attribute */ 
																									SELF.BEOevidenceOfUncatagorizedConvictionOlderNYR   := IF(RIGHT.party.ConvictedUnknownCount4U_OVNYR > 0, TRUE, FALSE),
																									SELF.BEOevidenceOfMisdeameanorConvictionOlderNYR    := IF(RIGHT.party.ConvictedMisdemeanorCount4M_OVNYR > 0, TRUE, FALSE),  
																									SELF.BEONoEvidenceOfStateCriminal                   := RIGHT.party.noEvidenceOfConvictedStateCrim,  
																									
                                                  //***************************************************************************************************
																									/* These are all of the evidence flags used in the TRAFFIC and INFRACTIONS ATTRIBUTE  */ 
																									//***************************************************************************************************
																									SELF.BEOevidenceOf3TrafficNYR                       := RIGHT.party.trafficInfractionFlags[1] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf2TrafficNYR                       := RIGHT.party.trafficInfractionFlags[2] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf3InfractionsNYR                   := RIGHT.party.trafficInfractionFlags[3] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf2InfractionsNYR                   := RIGHT.party.trafficInfractionFlags[4] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf3TrafficOlderNYR                  := RIGHT.party.trafficInfractionFlags[5] = DueDiligence.Constants.T_INDICATOR;   
																									SELF.BEOevidenceOf2TrafficOlderNYR                  := RIGHT.party.trafficInfractionFlags[6] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf3InfractionsOlderNYR              := RIGHT.party.trafficInfractionFlags[7] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEOevidenceOf2InfractionsOlderNYR              := RIGHT.party.trafficInfractionFlags[8] = DueDiligence.Constants.T_INDICATOR; 
																									SELF.BEONoEvidenceOfTrafficOrInfraction             := RIGHT.party.trafficInfractionFlags[9] = DueDiligence.Constants.T_INDICATOR; 
                                                  
                                                  //count if a BEO has ever had
                                                  SELF.BusFelonyConviction_4F := RIGHT.party.ConvictedFelonyCount4F_Ever;
                                                  SELF.BusFelonyNonConviction_3F := RIGHT.party.NonConvictedFelonyCount3F_EVER;
                                                  SELF.BusMisdemeanorConviction_4M := RIGHT.party.ConvictedMisdemeanorCount4M_Ever;
                                                  SELF.BusMisdemeanorNonConviction_3M := RIGHT.party.NonConvictedMisdemeanorCount3M_EVER;
                                                  SELF.BusUnknownConviction_4U := RIGHT.party.ConvictedUnknownCount4U_Ever;
                                                  SELF.BusUnknownNonConviction_3U := RIGHT.party.NonConvictedUnknownCount3U_EVER;
                                                  SELF.BusTrafficConviction_2T := RIGHT.party.ConvictedTraffic2T_Ever;
                                                  SELF.BusTrafficNonConviction_1T := RIGHT.party.NonConvictedTraffic1T_Ever; 
                                                  SELF.BusInfractionConviction_2I := RIGHT.party.ConvictedInfractions2I_Ever;
                                                  SELF.BusInfractionNonConviction_1I := RIGHT.party.NonConvictedInfraction1I_Ever;
																										
																									//legal event type
                                                  SELF.atleastOneBEOInCategory9 := RIGHT.party.legalEventTypeFlags[1] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory8 := RIGHT.party.legalEventTypeFlags[2] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory7 := RIGHT.party.legalEventTypeFlags[3] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory6 := RIGHT.party.legalEventTypeFlags[4] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory5 := RIGHT.party.legalEventTypeFlags[5] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory4 := RIGHT.party.legalEventTypeFlags[6] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory3 := RIGHT.party.legalEventTypeFlags[7] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.atleastOneBEOInCategory2 := RIGHT.party.legalEventTypeFlags[8] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOsHaveNoConvictionsOrCategoryHits := RIGHT.party.legalEventTypeFlags[9] = DueDiligence.Constants.T_INDICATOR;
																									
																									SELF := LEFT;),
																				LEFT OUTER);
		
		
	

	// -----                                                                                     ------
	// ----- Finish finding DEROG information for the Business                                   ------                             
	// ------ The results will come back this layout:                                            ------
	// ------      DueDiligence.layouts.Busn_Internal                                            ------
	// ------                                                                                    ------  
	UpdateInquiredBusinessWithDerog   := DueDiligence.getBusLien(UpdateBusnWithEvidenceOfCrim, options, linkingOptions, ReportIsRequested, DebugMode); 
	   
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
	  
		
		

	// OUTPUT(UpdateBusinessExecutivesCriminalOffense, NAMED('UpdateBusinessExecutivesCriminalOffense'));
  // OUTPUT(getBEOLegalEventType, NAMED('getBEOLegalEventType'));
	// OUTPUT(rolledExecutiveCriminalOffense, NAMED('rolledExecutiveCriminalOffense'));
	// OUTPUT(UpdateBusnWithEvidenceOfCrim, NAMED('UpdateBusnWithEvidenceOfCrim'));
	// OUTPUT(UpdateInquiredBusinessWithDerog, NAMED('UpdateInquiredBusinessWithDerog'));
	
	
 
	RETURN UpdateInquiredBusinessWithDerog;
END; 
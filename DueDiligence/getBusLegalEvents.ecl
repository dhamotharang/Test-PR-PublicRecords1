IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp;

EXPORT getBusLegalEvents(DATASET(DueDiligence.layouts.Busn_Internal) BusnData,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											   BIPV2.mod_sources.iParams linkingOptions,
												 boolean ReportIsRequested) := FUNCTION

	// ------                                                                                    ------
	// ------ The Business Executives have been added to the Busn_Internal                       ------
	// ------ in the form of a child dataset                                                     ------
	// ------ Call the common.getexecs extract all of the business executives                    ------
  // ------ into a simple DATASET so it can go through the get LegalEvents                     ------
	// ------ The results will come back this layout:                                            ------
	// ------  DueDiligence.LayoutsInternal.RelatedParty                                         ------
	// ------                                                                                    ------
	execsAsRelatedParties   := DueDiligence.CommonBusiness.getexecs(BusnData);   
  
  addExecsDID := PROJECT(execsAsRelatedParties, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
                                                          SELF.did := LEFT.party.did;
                                                          SELF := LEFT;));

	// ------ Collect all of the Criminal offenses data
  getExecutiveCriminalOffenses  := DueDiligence.getIndCriminal(addExecsDID);

  // ------                                                                                    ------
	// ------ Call the Common.ReplaceExecs routine to  update   executive information            ------ 
  // ------ with the derogatory events found in the previous function                          ------
	// ------ The results will come back this layout:                                            ------
	// ------ DueDiligence.layouts.Busn_Internal                                                 ------
  replaceExecs := DueDiligence.CommonBusiness.ReplaceExecs(BusnData, getExecutiveCriminalOffenses);
	 		

	//**********************roll the BEO legal info up to inquired business  		
	rolledExecutiveCriminalOffense := ROLLUP(SORT(getExecutiveCriminalOffenses, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), 
																						#EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
																						TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																											// rollup to the business for the state criminal data of the BEOs
                                                      SELF.party.stateCriminalLegalEventsFlags := DueDiligence.Common.RollFlags(party.stateCriminalLegalEventsFlags);
                                                      SELF.party.stateCriminalLegalEventsScore := MAX(LEFT.party.stateCriminalLegalEventsScore, RIGHT.party.stateCriminalLegalEventsScore);
                                                      
                                                      // rollup to the business for the legal event types of the BEOs
																											SELF.party.legalEventTypeFlags := DueDiligence.Common.RollFlags(party.legalEventTypeFlags);
                                                      SELF.party.legalEventTypeScore := MAX(LEFT.party.legalEventTypeScore, RIGHT.party.legalEventTypeScore); 
																											  
																																															 
																											SELF := LEFT;));
	
	updateBusnWithEvidenceOfCrim := JOIN(replaceExecs, rolledExecutiveCriminalOffense,
																				#EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
																				TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																								   //state criminal data
                                                  SELF.BEOevidenceOfCurrentIncarcerationOrParole := RIGHT.party.stateCriminalLegalEventsFlags[1] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfFelonyConvictionInLastNYR := RIGHT.party.stateCriminalLegalEventsFlags[2] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfFelonyConvictionOlderNYR := RIGHT.party.stateCriminalLegalEventsFlags[3] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfPreviousIncarceration := RIGHT.party.stateCriminalLegalEventsFlags[4] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfUncatagorizedConvictionInLastNYR := RIGHT.party.stateCriminalLegalEventsFlags[5] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfMisdeameanorConvictionInLastNYR := RIGHT.party.stateCriminalLegalEventsFlags[6] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfUncatagorizedConvictionOlderNYR := RIGHT.party.stateCriminalLegalEventsFlags[7] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEOevidenceOfMisdeameanorConvictionOlderNYR := RIGHT.party.stateCriminalLegalEventsFlags[8] = DueDiligence.Constants.T_INDICATOR;
                                                  SELF.BEONoEvidenceOfStateCriminal := RIGHT.party.stateCriminalLegalEventsFlags[9] = DueDiligence.Constants.T_INDICATOR;
																										
																									// legal event type
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
	UpdateInquiredBusinessWithDerog   := DueDiligence.getBusLien(updateBusnWithEvidenceOfCrim, options, linkingOptions, ReportIsRequested); 
	
  
  
  
  
  
	// ********************
	//   DEBUGGING OUTPUTS
	// ********************
	// OUTPUT(BusnData, NAMED('BusnData'));
	// OUTPUT(execsAsRelatedParties, NAMED('execsAsRelatedParties'));
	// OUTPUT(addExecsDID, NAMED('addExecsDID'));
  // OUTPUT(getExecutiveCriminalOffenses, NAMED('getExecutiveCriminalOffenses'));
	// OUTPUT(replaceExecs, NAMED('replaceExecs'));
	// OUTPUT(rolledExecutiveCriminalOffense, NAMED('rolledExecutiveCriminalOffense'));
	// OUTPUT(updateBusnWithEvidenceOfCrim, NAMED('updateBusnWithEvidenceOfCrim'));
	// OUTPUT(UpdateInquiredBusinessWithDerog, NAMED('UpdateInquiredBusinessWithDerog'));
	
	
 
	RETURN UpdateInquiredBusinessWithDerog;
END; 
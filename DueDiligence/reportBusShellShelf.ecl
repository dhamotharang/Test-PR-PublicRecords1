IMPORT Census_Data, codes, DueDiligence, iesp;

EXPORT reportBusShellShelf(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION

  
		   projectBusShelfInfo := PROJECT(inData, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencebusinessreport.T_DDRBusinessShellShelfCharacteristics, STRING bestFipsCode, STRING bestCounty, STRING2 bestState},
																										SELF.seq := LEFT.seq;
																										SELF.ultID := LEFT.busn_info.BIP_IDs.UltID.LinkID;
																										SELF.orgID := LEFT.busn_info.BIP_IDs.OrgID.LinkID;
																										SELF.seleID := LEFT.busn_info.BIP_IDS.SeleID.LinkID;
																	                  /* populate the shell shelf Charactistics section using information already on the business internal */   
																										SELF.IncorporatedInStateWithLooseIncorpLaws := LEFT.incorpWithLooseLaws;
																										SELF.IncorporationState                      := LEFT.CompanyIncorpState;
                                                    SELF.TINReported                            := IF(LEFT.FEINSourcesCnt > 0, true, false);   
                                                    /* Set these boolean flags for the report */  
                                                    SELF.BetterBusinessBureau                     := IF(LEFT.BetterBusCnt > 0, true, false);   
                                                    SELF.YellowPages                              := IF(LEFT.YellowPageCnt > 0, true, false);   
                                                    SELF.GovernmentSources                        := IF(LEFT.GongGovernmentCnt > 0, true, false);
                                                    SELF.UtilitySources                           := IF((LEFT.UtilityCnt + LEFT.GongBusinessCnt) > 0, true, false); 
                                                    SELF.BureauReporting                          := IF(LEFT.creditSrcCnt > 0, true, false);
                                                    SELF.AgentExists                              := IF(LEFT.numOfRegAgents > 0, true, false);   
                                                    SELF.NumberOfBusinessesFoundAtAddress         := LEFT.numOfBusFoundAtAddr;
                                                    SELF.NumberOfIncorporatedInStateWithLooseIncorpLaws := LEFT.numOfBusIncInStateLooseLaws;
                                                    SELF.NumberOfBusinessWithNoFEIN               := LEFT.numOfBusNoReportedFein;
                                                    SELF.AddressPrivatePost                       := LEFT.privatePostExists;
                                                    SELF.AddressMailDrop                          := LEFT.mailDropExists;
                                                    SELF.AddressRemailer                          := LEFT.remailerExists;
                                                    SELF.AddressStorageFacility                   := LEFT.storageFacilityExists;
                                                    SELF.AddressUndeliverableSecondaryRange       := LEFT.undeliverableSecRangeExists;
                                                    SELF.SOSIncorporationDate                     := iesp.ECL2ESP.toDate(LEFT.sosIncorporationDate);
                                                    SELF.DateFirstSeen                            := iesp.ECL2ESP.toDate(LEFT.busnHdrDtFirstSeenNonCredit);
                                                    //***notice the days apart routine can handle the dates in either order (oldest vs most recent) ***//
                                                    dayzApart := IF(LEFT.busnHdrDtFirstSeenNonCredit > 0 AND LEFT.sosIncorporationDate > 0,
                                                                    DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)LEFT.busnHdrDtFirstSeenNonCredit, (STRING)LEFT.sosIncorporationDate),
                                                                    DueDiligence.Constants.NUMERIC_ZERO);
                                                    
                                                    years := dayzApart DIV 365;
                                                    daysAfterYears := dayzApart % 365;
                                                    months := TRUNCATE(daysAfterYears/30.44);
                                                    days := TRUNCATE((daysAfterYears - (months*30.44)));
                                                    
                                                    SELF.NumberOfYears := years;
                                                    SELF.NumberOfMonths := months;
                                                    SELF.NumberOfDays := days;
                                                    
                                                    SELF.TimeBetweenSOSIncorporationDateDateFirstSeen   := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)LEFT.busnHdrDtFirstSeenNonCredit, (STRING)LEFT.sosIncorporationDate),
																										SELF := [];));																																														
  
   
        /*  perform the JOIN by Link ID  to add this section to the business internal                              */ 
        /*  This is the result set that should be returned by this FUNCTION - it contains the newly updated Business Internal */  
	     UpdateBusShellShelfChar := JOIN(inData, projectBusShelfInfo,
               #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()), 
               TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                    /* Pickup all of the fields from the RIGHT that match  */
                    SELF.BusinessReport.BusinessAttributeDetails.Operating.ShellShelfCharacteristics :=  RIGHT;                      
                    SELF := LEFT;),
               LEFT OUTER);  
                                                
                                           
                          

		//OUTPUT(projectBusShelfInfo, NAMED('projectBusShelfInfo'));
		// OUTPUT(bestWithCounty, NAMED('bestWithCounty'));
		// OUTPUT(addBusInfo, NAMED('addBusInfo'));
    

		RETURN UpdateBusShellShelfChar;
END;
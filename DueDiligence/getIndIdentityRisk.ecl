IMPORT DueDiligence, Risk_Indicators;

EXPORT getIndIdentityRisk(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                          STRING dataRestrictionMask,
                          UNSIGNED1 dppa,
                          UNSIGNED1 glba,
                          INTEGER bsVersion,
                          UNSIGNED8 bsOptions) := FUNCTION

                                              
                                              
    //get the best SSN flags details for the individual
    //create a temp DueDiligence.Layouts.Indv_Internal to handle the call
    ssnBestIndvInternal := PROJECT(inData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.historyDate := LEFT.historyDate;
                                                      SELF.individual.ssn := LEFT.bestSSN;
                                                      SELF.individual.did := LEFT.inquiredDID;
                                                      SELF.individual.dob := LEFT.bestDOB;
                                                      SELF := [];));
      
      
    bestSSNWithFlags := DueDiligence.CommonIndividual.GetIIDSSNFlags(ssnBestIndvInternal, dataRestrictionMask, dppa, glba, bsVersion, bsOptions);
    
    identityData := JOIN(inData, bestSSNWithFlags,
                          LEFT.seq = (UNSIGNED)RIGHT.account AND
                          LEFT.individual.did = RiGHT.did,
                          TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                          
                                    //dd values
                                    ddBestSSNIssuedPriorDOB := (LEFT.bestDOB > 0 AND (RIGHT.pwsocsdobflag = '1' OR RIGHT.socsdobflag = '1'));
                                    ddBestSSNRandomIssuedInvalid := Risk_Indicators.rcSet.isCodeIS(RIGHT.ssn, RIGHT.socsvalflag, RIGHT.socllowissue, RIGHT.socsRCISflag);
                                    ddBestSSNInvalid := RIGHT.socsvalflag = '1' OR RIGHT.pwsocsvalflag IN ['1', '2', '3'];
                                    
                                    SELF.dd_bestSSNReportedDeceased := RIGHT.decsflag;
                                    SELF.dd_bestSSNInvalid := ddBestSSNInvalid;
                                    SELF.dd_bestSSNIssuedPriorDOB := ddBestSSNIssuedPriorDOB;
                                    SELF.dd_bestSSNRandomIssuedInvalid := ddBestSSNRandomIssuedInvalid;
                                                    
                                    SELF.lastSeenBySource := (UNSIGNED4)DueDiligence.Common.checkInvalidDate((STRING)LEFT.cit_lastReportedByAnySource);
                                    SELF.lexIDReportedDeceased := LEFT.cit_lexIDReportedDeceased = 1 OR LEFT.bs_lexIDDeceased;
                                    SELF.ssnReportedDeceased := LEFT.cit_inputSSNReportedDeceased = 1 OR 
                                                                Risk_Indicators.rcSet.isCode02(LEFT.bs_bestSSNDecsFlag) OR
                                                                Risk_Indicators.rcSet.isCode02(RIGHT.decsflag);
                                                                
                                    SELF.redFlagSSNInvalid := LEFT.cit_lexIDBestSSNInvalid = 1 OR 
                                                              LEFT.cit_inputSSNInvalid = 1 OR
                                                              LEFT.bs_bestSSNValid = '1' OR
                                                              ddBestSSNInvalid;
                                                              
                                    SELF.redFlagSSNIssuedPriorDOB := LEFT.cit_inputSSNIssuePriorToDOB = 1 OR ddBestSSNIssuedPriorDOB;
                                    SELF.redFlagSSNRandomIssuedInvalid := LEFT.cit_inputSSNRandomIssuedInvalid = 1 OR ddBestSSNRandomIssuedInvalid;                                                                          
                                                                          
                                    SELF.redFlagLexIDContainsMultiSSNs := LEFT.cit_lexIDMultipleSSNs > 0;
                                    SELF.redFlagInputSSNAssocAtleast3LexIDs := LEFT.bs_adlsPerSSN >= 3;
                                    SELF.redFlagInputSSNIsITIN := LEFT.cit_inputSSNITIN;
                                    SELF.bestDOBExists := LEFT.bestDOB > 0;
                                    SELF.bestAddressExists := LEFT.bestAddress.streetAddress1 <> DueDiligence.Constants.EMPTY AND
                                                              LEFT.bestAddress.city <> DueDiligence.Constants.EMPTY AND
                                                              LEFT.bestAddress.state <> DueDiligence.Constants.EMPTY AND
                                                              LEFT.bestAddress.zip5 <> DueDiligence.Constants.EMPTY;
                                    
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
    
    
    
    // OUTPUT(ssnBestIndvInternal, NAMED('ssnBestIndvInternal'));
    // OUTPUT(bestSSNWithFlags, NAMED('bestSSNWithFlags'));
    
    

    RETURN identityData;
END;
IMPORT DueDiligence, STD, ut;

EXPORT getIndKRIBusAssoc(DueDiligence.LayoutsInternal.IndBusAssociations indiv) := FUNCTION

		//PERSON BUSINESSS ASSOCIATIONS 
    isInquired := indiv.did = indiv.busAssociation.beos[1].did;
    isBEO := indiv.busAssociation.beos[1].isBEO;
    isOwnershipProng := indiv.busAssociation.beos[1].isOwnershipProng;
    isControlProng := indiv.busAssociation.beos[1].isControlProng;
    isMSBcibNBFIcag := indiv.busAssociation.sicNaicRisk.msbExists OR
                      indiv.busAssociation.sicNaicRisk.cibRetailExists OR
                      indiv.busAssociation.sicNaicRisk.cibNonRetailExists OR
                      indiv.busAssociation.sicNaicRisk.nbfiExists OR
                      indiv.busAssociation.sicNaicRisk.cagExists;
    isLATFTa := indiv.busAssociation.sicNaicRisk.legAcctTeleFlightTravExists OR indiv.busAssociation.sicNaicRisk.autoExists;
    isHighRisk := indiv.busAssociation.sicNaicRisk.otherHighRiskIndustExists;
    reportedSICorNAICS := indiv.busAssociation.sicNaicRisk.sicCodes <> DueDiligence.Constants.EMPTY OR indiv.busAssociation.sicNaicRisk.naicCodes <> DueDiligence.Constants.EMPTY;
    businessAssociation := indiv.busAssociation.seleID > 0;
    
		busAssocFlag9 := IF(isInquired AND isBEO AND isOwnershipProng AND isMSBcibNBFIcag, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                            		 
		busAssocFlag8 := IF(isInquired AND isBEO AND isControlProng AND isMSBcibNBFIcag, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                		 
		busAssocFlag7 := IF(isInquired AND isBEO AND isOwnershipProng AND isLATFTa, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		busAssocFlag6 := IF(isInquired AND isBEO AND isControlProng AND isLATFTa, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		busAssocFlag5 := IF(isInquired AND isBEO AND isOwnershipProng AND isHighRisk, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		busAssocFlag4 := IF(isInquired AND isBEO AND isControlProng AND isHighRisk, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		busAssocFlag3 := IF((isInquired AND isBEO AND (isOwnershipProng OR isControlProng)) AND reportedSICorNAICS = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		busAssocFlag2 := IF((isInquired AND isBEO AND (isOwnershipProng OR isControlProng)) AND 
                        reportedSICorNAICS = TRUE AND 
                        isMSBcibNBFIcag = FALSE AND 
                        isLATFTa = FALSE AND 
                        isHighRisk = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		busAssocFlag1 := IF(businessAssociation = FALSE OR (businessAssociation AND 
                                                        busAssocFlag9 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag8 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag7 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag6 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag5 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag4 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag3 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssocFlag2 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                               	 
		
		busAssocConcat_Final := DueDiligence.Common.calcFinalFlagField(busAssocFlag9,
                                                                    busAssocFlag8,
                                                                    busAssocFlag7,
                                                                    busAssocFlag6,
                                                                    busAssocFlag5,
                                                                    busAssocFlag4,
                                                                    busAssocFlag3,
                                                                    busAssocFlag2,
                                                                    busAssocFlag1); 

		perBusAssoc_Flag := busAssocConcat_Final;
		perBusAssoc := (STRING)(10-STD.Str.Find(busAssocConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
    
    

    // OUTPUT(isMSBcibNBFIcag, NAMED('isMSBcibNBFIcag'));
    // OUTPUT(isLATFTa, NAMED('isLATFTa'));
    // OUTPUT(isHighRisk, NAMED('isHighRisk'));
    // OUTPUT(reportedSICorNAICS, NAMED('reportedSICorNAICS'));


		RETURN DueDiligence.Common.createNVPair(perBusAssoc, perBusAssoc_Flag);
END;
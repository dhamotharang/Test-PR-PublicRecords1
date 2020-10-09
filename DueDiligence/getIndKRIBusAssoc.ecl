IMPORT DueDiligence, STD;


EXPORT getIndKRIBusAssoc(DueDiligence.LayoutsInternal.IndBusAssociations indiv) := FUNCTION

    //PERSON BUSINESSS ASSOCIATIONS
    //Inquired information
    inquiredData := indiv.busAssociation.beos(did = indiv.did);

    isInquired := COUNT(inquiredData) > 0;
    isBEO := inquiredData[1].isBEO;
    isOwnershipProng := inquiredData[1].isOwnershipProng;
    isControlProng := inquiredData[1].isControlProng;

    inquiredBEOOwnControl := isInquired AND isBEO AND (isOwnershipProng OR isControlProng);

    businessAssociation := indiv.busAssociation.seleID > 0;


    //Industry code information
    allIndustryCodes := indiv.busAssociation.sicNaicSources;

    bestSicCode := allIndustryCodes(sicCode <> DueDiligence.Constants.EMPTY AND isprimary)[1].riskiestLevel;
    bestNaicsCode := allIndustryCodes(naicCode <> DueDiligence.Constants.EMPTY AND isprimary)[1].riskiestLevel;


    cibCategory := DueDiligence.ConstantsIndustry.CIB_GROUPING;
    financialCateogry := DueDiligence.ConstantsIndustry.FINANCIAL_GROUPING;
    miscCategory := DueDiligence.ConstantsIndustry.MISC_CATEGORY_GROUPING;
    medLowRisk := DueDiligence.ConstantsIndustry.MED_LOW_RISK_GROUPING;                                         





    busAssoc9 := IF(inquiredBEOOwnControl AND (bestSicCode IN cibCategory OR bestNaicsCode IN cibCategory), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc8 := IF(inquiredBEOOwnControl AND (bestSicCode IN financialCateogry OR bestNaicsCode IN financialCateogry), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc7 := IF(inquiredBEOOwnControl AND (bestSicCode IN miscCategory OR bestNaicsCode IN miscCategory), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc6 := IF(inquiredBEOOwnControl AND (bestSicCode = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH OR bestNaicsCode = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 

    busAssoc5 := IF(inquiredBEOOwnControl AND COUNT(allIndustryCodes(riskiestLevel IN cibCategory)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc4 := IF(inquiredBEOOwnControl AND COUNT(allIndustryCodes(riskiestLevel IN financialCateogry)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc3 := IF(inquiredBEOOwnControl AND COUNT(allIndustryCodes(riskiestLevel IN miscCategory)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    busAssoc2 := IF(inquiredBEOOwnControl AND COUNT(allIndustryCodes(riskiestLevel = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 

    busAssoc1 := IF(businessAssociation = FALSE OR (businessAssociation AND 
                                                        busAssoc9 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc8 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc7 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc6 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc5 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc4 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc3 = DueDiligence.Constants.F_INDICATOR AND
                                                        busAssoc2 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        
                                                        
    busAssoc0 := DueDiligence.Constants.EMPTY;

    busAssocFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(busAssoc9, busAssoc8, busAssoc7,
                                                                           busAssoc6, busAssoc5, busAssoc4,
                                                                           busAssoc3, busAssoc2, busAssoc1, busAssoc0);
                                                                           
    busAssocScore := (STRING2)(10-STD.Str.Find(busAssocFlags, DueDiligence.Constants.T_INDICATOR, 1)); 





    perBusAssoc_Flag := busAssocFlags;
    perBusAssoc := busAssocScore; 



    // OUTPUT(inquiredData, NAMED('inquiredData'));
    // OUTPUT(inquiredBEOOwnControl, NAMED('inquiredBEOOwnControl'));

    // OUTPUT(allIndustryCodes, NAMED('allIndustryCodes'));
    // OUTPUT(bestSicCode, NAMED('bestSicCode'));
    // OUTPUT(bestNaicsCode, NAMED('bestNaicsCode'));


    RETURN DueDiligence.Common.createNVPair(perBusAssoc, perBusAssoc_Flag);
END;
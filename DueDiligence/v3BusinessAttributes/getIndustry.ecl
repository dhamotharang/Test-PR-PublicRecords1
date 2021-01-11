IMPORT DueDiligence, STD;

EXPORT getIndustry(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                   DATASET(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim) rawIndustry) := FUNCTION

    //for each lexID determine which levels were hit
    industry := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                            
                                            SELF.seq := LEFT.seq;
                                            SELF.ultID := LEFT.inquiredBusiness.ultID;
                                            SELF.orgID := LEFT.inquiredBusiness.orgID;
                                            SELF.seleID := LEFT.inquiredBusiness.seleID;
                                            
                                            allCodes := rawIndustry(seq = LEFT.seq AND 
                                                                     ultID = LEFT.inquiredBusiness.ultID AND
                                                                     orgID = LEFT.inquiredBusiness.orgID AND
                                                                     seleID = LEFT.inquiredBusiness.seleID);
                                                                                                                           
                                                                     
                                            bestSICData := allCodes(sicCode = LEFT.bestData.sicCode)[1].riskiestOverallLevel;
                                            bestNAICSData := allCodes(naicsCode = LEFT.bestData.naicsCode)[1].riskiestOverallLevel;
                                                                                                


                                            cibCategory := DueDiligence.ConstantsIndustry.CIB_GROUPING;
                                            financialCateogry := DueDiligence.ConstantsIndustry.FINANCIAL_GROUPING;
                                            miscCategory := DueDiligence.ConstantsIndustry.MISC_CATEGORY_GROUPING;
                                            medLowRisk := DueDiligence.ConstantsIndustry.MED_LOW_RISK_GROUPING;
                                            
                                            
                                            
                                            industry9 := IF(bestSICData IN cibCategory OR 
                                                            bestNAICSData IN cibCategory, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry8 := IF(bestSICData IN financialCateogry OR 
                                                            bestNAICSData IN financialCateogry, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry7 := IF(bestSICData IN miscCategory OR 
                                                            bestNAICSData IN miscCategory, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry6 := IF(bestSICData = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH OR 
                                                            bestNAICSData = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry5 := IF(COUNT(allCodes(riskiestOverallLevel IN cibCategory)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry4 := IF(COUNT(allCodes(riskiestOverallLevel IN financialCateogry)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry3 := IF(COUNT(allCodes(riskiestOverallLevel IN miscCategory)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry2 := IF(COUNT(allCodes(riskiestOverallLevel = DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry1 := IF(COUNT(allCodes(riskiestOverallLevel IN medLowRisk)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            
                                            industry0 := DueDiligence.Constants.EMPTY;
                                            
                                            industryFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(industry9, industry8, industry7,
                                                                                                                   industry6, industry5, industry4,
                                                                                                                   industry3, industry2, industry1, industry0);
                                            
                                            industryScore := (STRING2)(10-STD.Str.Find(industryFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                            
                                            SELF.busIndustry := industryScore;
                                            SELF.busIndustry_Flag := industryFlags;
                                            
                                            SELF := [];));



    // OUTPUT(industry, NAMED('industry'));

    RETURN industry;
END;
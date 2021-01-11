IMPORT DueDiligence, iesp;

EXPORT getIndustry(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                   DATASET(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim) rawIndustry) := FUNCTION


    convertIndustryRisk := PROJECT(rawIndustry, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustryReport,
                                                          SELF.seq := LEFT.seq;
                                                          SELF.ultID := LEFT.ultID;
                                                          SELF.orgID := LEFT.orgID;
                                                          SELF.seleID := LEFT.seleID;
                                                          
                                                          useSICData := LEFT.sicCode <> DueDiligence.Constants.EMPTY;
                                                          
                                                          SELF.sicNaicsData := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRSICNAIC,
                                                                                                  SELF.sicCode := LEFT.sicCode;
                                                                                                  SELF.naicsCode := LEFT.naicsCode;
                                                                                                  SELF.description := IF(useSICData, LEFT.sicDesc, LEFT.naicsDesc);
                                                                                                  SELF.firstReported := iesp.ECL2ESP.toDate(LEFT.dateFirstSeen);
                                                                                                  SELF.lastReported := iesp.ECL2ESP.toDate(LEFT.dateLastSeen);
                                                                                                  
                                                                                                  SELF.industryRisk := IF(useSICData, LEFT.sicRiskLevel, LEFT.naicsRiskLevel);
                                                                                                  SELF.cashIntensiveRetail := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_RETAIL OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_RETAIL;
                                                                                                  SELF.cashIntensiveNonRetail := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_NON_RETAIL OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_NON_RETAIL;
                                                                                                  SELF.moneyServiceBusiness := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.MONEY_SERVICE_BUSINESS OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.MONEY_SERVICE_BUSINESS;
                                                                                                  SELF.nonBankFinancialInstitution := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.NON_BANK_FINANCIAL_INSTITUTIONS OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.NON_BANK_FINANCIAL_INSTITUTIONS;
                                                                                                  SELF.casinoOrGamblingRelated := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.CASINO_AND_GAMING OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.CASINO_AND_GAMING;
                                                                                                  SELF.legalAccountantTelemarketerFlightOrTravel := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL;
                                                                                                  SELF.automotive := LEFT.sicIndustry = DueDiligence.ConstantsIndustry.AUTOMOTIVE OR LEFT.naicsIndustry = DueDiligence.ConstantsIndustry.AUTOMOTIVE;)]);
                                                          
                                                          SELF := [];));



    //roll all the sic/naics to the business
    rollIndustries := ROLLUP(SORT(convertIndustryRisk, seq, ultID, orgID, seleID),
                             LEFT.seq = RIGHT.seq AND
                             LEFT.ultID = RIGHT.ultID AND
                             LEFT.orgID = RIGHT.orgID AND
                             LEFT.seleID = RIGHT.seleID,
                             TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustryReport,
                                        SELF.sicNaicsData := LEFT.sicNaicsData + RIGHT.sicNaicsData;
                                        SELF := LEFT;));



    addIndustryRpt := JOIN(inData, rollIndustries,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                            LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                            LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessReport,
                                      SELF.seq := LEFT.seq;
                                      SELF.ultID := LEFT.inquiredBusiness.ultID;
                                      SELF.orgID := LEFT.inquiredBusiness.orgID;
                                      SELF.seleID := LEFT.inquiredBusiness.seleID;
                                      
                                      SELF.businessReport.businessAttributeDetails.operating.businessInformation.SICNAICs := RIGHT.sicNaicsData;
                                                                            
                                      SELF := LEFT;
                                      SELF := [];),
                            LEFT OUTER,
                            ATMOST(1));





    // OUTPUT(convertIndustryRisk, NAMED('convertIndustryRisk'));
    // OUTPUT(rollIndustries, NAMED('rollIndustries'));
    // OUTPUT(addIndustryRpt, NAMED('addIndustryRpt'));


    RETURN addIndustryRpt;
END;
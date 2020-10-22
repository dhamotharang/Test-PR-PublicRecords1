IMPORT Business_Risk_BIP, Codes, DueDiligence, iesp, MDR, STD, TopBusiness_BIPV2;

EXPORT getIndustry(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                    DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION


    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);

    industryRaw := TopBusiness_BIPV2.Key_Industry_Linkids.KeyFetch(DueDiligence.v3Common.DDBusiness.GetKfetchLinkIDs(inData),
                                                                    Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                                    0,,
                                                                    DueDiligence.Constants.MAX_10000);                  
    
    //mimic filtering like SmartLinx
    filtIndustry := industryRaw((sicCode != DueDiligence.Constants.EMPTY OR naics != DueDiligence.Constants.EMPTY)AND  
																((source = MDR.sourceTools.src_EBR AND record_type = 'C') OR
																source != MDR.sourceTools.src_EBR));
                                
                                
    //add our sequence number to the Raw  records found for this Business
    industryWithSeq := DueDiligence.v3Common.DDBusiness.AppendSeq(filtIndustry, inData, FALSE);
    
    //slim the data to the fields we care about
    slimIndust := PROJECT(industryWithSeq, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.ultID := LEFT.ultID;
                                                      SELF.orgID := LEFT.orgID;
                                                      SELF.seleID := LEFT.seleID;
                                                      
                                                      SELF.historyDate := LEFT.historyDate;
                                                      SELF.dateFirstSeen := IF(LEFT.dt_first_seen = 0, LEFT.dt_first_seen, LEFT.dt_first_seen);
                                                      SELF.dateLastSeen := IF(LEFT.dt_last_seen = 0, LEFT.dt_last_seen, LEFT.dt_last_seen);
                                                      
                                                      SELF.sicCode := LEFT.sicCode;
                                                      SELF.naicsCode := LEFT.naics;       
                                                      
                                                      SELF := [];));
    
    cleanDates := DueDiligence.Common.CleanDatasetDateFields(slimIndust, 'dateFirstSeen, dateLastSeen');
    
    filterData := DueDiligence.CommonDate.FilterRecordsSingleDate(cleanDates, dateFirstSeen);
    
    transFiltData := PROJECT(filterData, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim, SELF := LEFT));



    addBestCodes := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                              SELF.seq := LEFT.seq;
                                              SELF.ultID := LEFT.inquiredBusiness.ultID;
                                              SELF.orgID := LEFT.inquiredBusiness.orgID;
                                              SELF.seleID := LEFT.inquiredBusiness.seleID;
                                              
                                              SELF.historyDate := LEFT.historyDate;
                                              SELF.sicCode := LEFT.bestData.sicCode;
                                              SELF.naicsCode := LEFT.bestData.naicsCode; 
                                              SELF.isBest := TRUE;
                                              
                                              SELF := [];));
    
    workingIndustry := addBestCodes + transFiltData;
    
    
    uniqueSICData := DueDiligence.v3Common.DDBusiness.GetUniqueIndustries(workingIndustry(sicCode <> DueDiligence.Constants.EMPTY), TRUE);
    uniqueNAICSData := DueDiligence.v3Common.DDBusiness.GetUniqueIndustries(workingIndustry(naicsCode <> DueDiligence.Constants.EMPTY), FALSE);
    
    
    //add descriptions
    addSICDesc := JOIN(uniqueSICData, Codes.Key_SIC4,
                       LEFT.sicCode = RIGHT.sic4_code,
                       TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                 SELF.sicDesc := STD.Str.ToTitleCase(RIGHT.sic4_description);
                                 SELF := LEFT;),
                       LEFT OUTER,
                       ATMOST(1));
                       
    addNAICSDesc := JOIN(uniqueNAICSData, Codes.Key_NAICS,
                         LEFT.naicsCode = RIGHT.naics_code,
                         TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                   SELF.naicsDesc := RIGHT.naics_description;
                                   SELF := LEFT;),
                         LEFT OUTER,
                         ATMOST(1));
    
    allCodes := addSICDesc + addNAICSDesc;
    
    
    industryRiskInfo := DueDiligence.v3Common.DDBusiness.GetIndustryRisk(allCodes);
    
    //sort by best, riskiest, most recent to limit the number of codes
    sortGrpData := GROUP(SORT(industryRiskInfo, seq, ultID, orgID, seleID, -isBest, -riskiestOverallLevel, -dateLastSeen, -dateFirstSeen), seq, ultID, orgID, seleID);
    limitedIndustries := DueDiligence.v3Common.General.GetMaxNumberOfRecords(sortGrpData, iesp.constants.DDRAttributesConst.MaxSICNAICs);




    // OUTPUT(CHOOSEN(industryRaw, 500), NAMED('industryRaw'));
    // OUTPUT(CHOOSEN(filtIndustry, 500), NAMED('filtIndustry'));
    // OUTPUT(CHOOSEN(industryWithSeq, 500), NAMED('industryWithSeq'));
    // OUTPUT(CHOOSEN(slimIndust, 500), NAMED('slimIndust'));
    // OUTPUT(CHOOSEN(cleanDates, 500), NAMED('cleanDates'));
    // OUTPUT(CHOOSEN(filterData, 500), NAMED('filterData'));
    // OUTPUT(CHOOSEN(workingIndustry, 500), NAMED('workingIndustry'));
    // OUTPUT(CHOOSEN(allCodes, 500), NAMED('allCodes'));
    // OUTPUT(CHOOSEN(industryRiskInfo, 500), NAMED('industryRiskInfo'));
    // OUTPUT(CHOOSEN(sortGrpData, 500), NAMED('sortGrpData'));
    // OUTPUT(CHOOSEN(limitedIndustries, 500), NAMED('limitedIndustries'));


    RETURN limitedIndustries;
END;
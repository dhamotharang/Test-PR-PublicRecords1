IMPORT DueDiligence;

EXPORT getBusinessOperating(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                            DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                            DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                            DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION


    /////////////////////////////
    //get necessary raw data
    /////////////////////////////
    rawIndustryResults := DueDiligence.v3BusinessData.getIndustry(inData, regulatoryAccess);
    
    
    
    /////////////////////////////
    //based on the operating data
    //  populate requested attributes
    /////////////////////////////
    noAttributeResults := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes);
    
    industryAttributeResults := DueDiligence.v3BusinessAttributes.getIndustry(inData, rawIndustryResults);
    
    
    
    /////////////////////////////
    //populate attributes if requested
    /////////////////////////////
    industry := IF(attributesRequested.includeAll OR attributesRequested.includeIndustry, industryAttributeResults, noAttributeResults);
    // geographic := IF(attributesRequested.includeAll OR attributesRequested.includeGeographic, xyz, noAttributeResults);
    // validity := IF(attributesRequested.includeAll OR attributesRequested.includeValidity, xya, noAttributeResults);
    // stability := IF(attributesRequested.includeAll OR attributesRequested.includeStability, xyz, noAttributeResults);
    // structureType := IF(attributesRequested.includeAll OR attributesRequested.includeStructureType, xyz, noAttributeResults);
    // sosAgeRange := IF(attributesRequested.includeAll OR attributesRequested.includeSOSAgeRange, xyz, noAttributeResults);
    // publicRecordsAgeRange := IF(attributesRequested.includeAll OR attributesRequested.includePublicRecordAgeRange, xyz, noAttributeResults);
    // shellShelf := IF(attributesRequested.includeAll OR attributesRequested.includeShellShelf, xyz, noAttributeResults);
    
   
    /////////////////////////////
    //rollup/combine all requested
    //    operating attributes
    /////////////////////////////
    operatingAttributes := ROLLUP(SORT(industry /*+ geographic + validity stability + structureType + sosAgeRange + publicRecordsAgeRange + shellShelf*/, seq, ultID, orgID, seleID),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID,
                              TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;

                                        SELF.busIndustry := DueDiligence.v3Common.General.FirstPopulatedString(busIndustry);
                                        SELF.busIndustry_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busIndustry_Flag);
                                        
                                        // SELF.busGeographic := DueDiligence.v3Common.General.FirstPopulatedString(busGeographic);
                                        // SELF.busGeographic_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busGeographic_Flag);
                                        
                                        // SELF.busValidity := DueDiligence.v3Common.General.FirstPopulatedString(busValidity);
                                        // SELF.busValidity_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busValidity_Flag);
                                        
                                        // SELF.busStability := DueDiligence.v3Common.General.FirstPopulatedString(busStability);
                                        // SELF.busStability_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStability_Flag);
                                        
                                        // SELF.busStructureType := DueDiligence.v3Common.General.FirstPopulatedString(busStructureType);
                                        // SELF.busStructureType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStructureType_Flag);
                                        
                                        // SELF.busSOSAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(busSOSAgeRange);
                                        // SELF.busSOSAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busSOSAgeRange_Flag);
                                        
                                        // SELF.busPublicRecordAgeRange := DueDiligence.v3Common.General.FirstPopulatedString(busPublicRecordAgeRange);
                                        // SELF.busPublicRecordAgeRange_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busPublicRecordAgeRange_Flag);
                                        
                                        // SELF.busShellShelf := DueDiligence.v3Common.General.FirstPopulatedString(busShellShelf);
                                        // SELF.busShellShelf_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busShellShelf_Flag);
                                        
                                        SELF := LEFT;));
                                        



    /////////////////////////////
    //based on the operating data 
    //  get report data/sections
    /////////////////////////////
    //based on request - populate the reports of the legal section
    noLegalReportData := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessReport);
    
    industryReportData := DueDiligence.v3BusinessReport.getIndustry(inData, rawIndustryResults);
    
    
    
    /////////////////////////////
    //determine if 'full' module
    //  was requested - if so
    //  return report data/sections
    /////////////////////////////
    includeReportData := ddOptions.includeReportData AND
                        (attributesRequested.includeAll OR 
                        (attributesRequested.includeIndustry)); // AND
                          // attributesRequested.includeGeographic AND
                          // attributesRequested.includeValidity AND
                          // attributesRequested.includeStability AND
                          // attributesRequested.includeStructureType AND
                          // attributesRequested.includeSOSAgeRange AND
                          // attributesRequested.includePublicRecordAgeRange AND
                          // attributesRequested.includeShellShelf));
                          
                          
                                                                                                           
                          
                          
                          
                          
                                            
    operatingReports := IF(includeReportData, industryReportData, noLegalReportData);
    

    //join the attributes and report data together
    finalOperating := JOIN(operatingAttributes, operatingReports,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.ultID = RIGHT.ultID AND
                            LEFT.orgID = RIGHT.orgID AND
                            LEFT.seleID = RIGHT.seleID,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                      SELF.seq := LEFT.seq;
                                      SELF.ultID := LEFT.ultID;
                                      SELF.orgID := LEFT.orgID;
                                      SELF.seleID := LEFT.seleID;
                                      
                                      SELF.busIndustry := LEFT.busIndustry;
                                      SELF.busIndustry_Flag := LEFT.busIndustry_Flag;
                                      // SELF.busGeographic := LEFT.busGeographic;
                                      // SELF.busGeographic_Flag := LEFT.busGeographic_Flag;
                                      // SELF.busValidity := LEFT.busValidity;
                                      // SELF.busValidity_Flag := LEFT.busValidity_Flag;
                                      // SELF.busStability := LEFT.busStability;
                                      // SELF.busStability_Flag := LEFT.busStability_Flag;
                                      // SELF.busStructureType := LEFT.busStructureType;
                                      // SELF.busStructureType_Flag := LEFT.busStructureType_Flag;
                                      // SELF.busSOSAgeRange := LEFT.busSOSAgeRange;
                                      // SELF.busSOSAgeRange_Flag := LEFT.busSOSAgeRange_Flag;
                                      // SELF.busPublicRecordAgeRange := LEFT.busPublicRecordAgeRange;
                                      // SELF.busPublicRecordAgeRange_Flag := LEFT.busPublicRecordAgeRange_Flag;
                                      // SELF.busShellShelf := LEFT.busShellShelf;
                                      // SELF.busShellShelf_Flag := LEFT.busShellShelf_Flag;
                                      
                                      codes := rawIndustryResults(isbest AND seq = LEFT.seq AND 
                                                                  ultID = LEFT.ultID AND
                                                                  orgID = LEFT.orgID AND
                                                                  seleID = LEFT.seleID);
                                                            
                                      bestNAICS := codes(naicsCode <> DueDiligence.Constants.EMPTY)[1];
                                      bestSIC := codes(sicCode <> DueDiligence.Constants.EMPTY)[1];
                                      
                                      SELF.report.businessReport.businessInformation.NaicsCode := IF(ddOptions.includeReportData, bestNAICS.naicsCode, DueDiligence.Constants.EMPTY);
                                      SELF.report.businessReport.businessInformation.NaicsDescription := IF(ddOptions.includeReportData, bestNAICS.naicsDesc, DueDiligence.Constants.EMPTY);
                                      SELF.report.businessReport.businessInformation.SicCode := IF(ddOptions.includeReportData, bestSIC.sicCode, DueDiligence.Constants.EMPTY);
                                      SELF.report.businessReport.businessInformation.SicDescription := IF(ddOptions.includeReportData, bestSIC.sicDesc, DueDiligence.Constants.EMPTY);

                                      SELF.operatingReportIncluded := includeReportData; //only included if the flag is set and module attributes selected
                                      SELF.report.businessReport := RIGHT.businessReport;
                                      
                                      SELF := [];),
                            LEFT OUTER,
                            ATMOST(1));




    // OUTPUT(rawIndustryResults, NAMED('rawIndustryResults'));
    // OUTPUT(industryAttributeResults, NAMED('industryAttributeResults'));
    // OUTPUT(industry, NAMED('industry'));
    
    // OUTPUT(operatingAttributes, NAMED('operatingAttributes'));
    
    // OUTPUT(industryReportData, NAMED('industryReportData'));
    
    // OUTPUT(operatingReports, NAMED('operatingReports'));
    // OUTPUT(finalOperating, NAMED('finalOperating'));
    


    RETURN finalOperating;
END;
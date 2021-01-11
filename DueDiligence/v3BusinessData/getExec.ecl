IMPORT DueDiligence;


EXPORT getExec(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
               DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
               DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
               DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION
                
   
 
 
    //get limited exec with best data
    beoAndTitles := DueDiligence.v3BusinessData.getExecBestLimitedData(inData, regulatoryAccess);
    

    notRequested := DATASET([], DueDiligence.v3Layouts.Internal.BusinessTemp);
    
    //criminal should be called for all attributes, state legal event, offense type or network attributes when the report is being requested
    execCrimRequested := attributesRequested.includeAll OR 
                         attributesRequested.includeOffenseType OR attributesRequested.includeStateLegalEvent OR
                         (ddOptions.includeReportData AND
                         (attributesRequested.includeAll OR
                         (attributesRequested.includeBEOProfLicense AND attributesRequested.includeBEOUSResidency AND attributesRequested.includeBEOAccessToFundsProperty)));
                         //attributesRequested.includeLinkedBusinesses)); //UNCOMMENT ONCE CODED
                         
    execAccesstoFundsProp := attributesRequested.includeAll OR attributesRequested.includeBEOAccessToFundsProperty;



    execCrim := IF(execCrimRequested, 
                    DueDiligence.v3BusinessData.getExecCriminal(beoAndTitles, attributesRequested, ddOptions), 
                    notRequested);
    
    

    execAssets := IF(execAccesstoFundsProp,
                      DueDiligence.v3BusinessData.getExecAssets(beoAndTitles, regulatoryAccess),
                      notRequested);
                      
        
    
    
        
    allBEOs := DueDiligence.v3Common.DDBusiness.GetBEOExecDetails(beoAndTitles);
    crimBEOs := DueDiligence.v3Common.DDBusiness.GetBEOExecDetails(execCrim);
    assetBEOs := DueDiligence.v3Common.DDBusiness.GetBEOExecDetails(execAssets);
                                                            

    addCrim := JOIN(allBEOs, crimBEOs,
                    LEFT.seq = RIGHT.seq AND
                    LEFT.ultID = RIGHT.ultID AND
                    LEFT.orgID = RIGHT.orgID AND
                    LEFT.seleID = RIGHT.seleID AND
                    LEFT.lexID = RIGHT.lexID AND
                    LEFT.lastName = RIGHT.lastName AND
                    LEFT.firstName = RIGHT.firstName AND
                    LEFT.suffix = RIGHT.suffix,
                    TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                              SELF.stateLegalEvents := RIGHT.stateLegalEvents;
                              SELF.stateLegalEventsFlag := RIGHT.stateLegalEventsFlag;
                              SELF.offenseType := RIGHT.offenseType;
                              SELF.offenseTypeFlag := RIGHT.offenseTypeFlag;
                              SELF := LEFT;),
                    LEFT OUTER,
                    ATMOST(1));
                              
    addAssets := JOIN(addCrim, assetBEOs,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.ultID = RIGHT.ultID AND
                      LEFT.orgID = RIGHT.orgID AND
                      LEFT.seleID = RIGHT.seleID AND
                      LEFT.lexID = RIGHT.lexID AND
                      LEFT.lastName = RIGHT.lastName AND
                      LEFT.firstName = RIGHT.firstName AND
                      LEFT.suffix = RIGHT.suffix,
                      TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                SELF.numProperties := RIGHT.numProperties;
                                SELF.totalTaxAssessedVal := RIGHT.totalTaxAssessedVal;
                                SELF.numWatercraft := RIGHT.numWatercraft;
                                SELF.maxWatercraftLengthRaw := RIGHT.maxWatercraftLengthRaw;
                                SELF.numVehicles := RIGHT.numVehicles;
                                SELF.maxBaseVehicleVal := RIGHT.maxBaseVehicleVal;
                                SELF.numAircraft := RIGHT.numAircraft;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));



    transAllBEOData := PROJECT(addAssets, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.ultID := LEFT.ultID;
                                                    SELF.orgID := LEFT.orgID;
                                                    SELF.seleID := LEFT.seleID;
                                                    SELF.execs := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimExec, SELF := LEFT; SELF := [];)]);
                                                    SELF := [];));
                                

    rollAllBEOData := ROLLUP(SORT(transAllBEOData, seq, ultID, orgID, seleID),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID,
                              TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                        SELF.execs := LEFT.execs + RIGHT.execs;
                                        SELF := LEFT;));
          
   

    updateBEOs := JOIN(inData, rollAllBEOData,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                      LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                      LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                      TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                SELF.beos := RIGHT.execs;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));


    //add criminal data
    finalBEOs := JOIN(updateBEOs, execCrim,
                      LEFT.seq = RIGHT.seq AND
                      LEFT.inquiredBusiness.ultID = RIGHT.inquiredBusiness.ultID AND
                      LEFT.inquiredBusiness.orgID = RIGHT.inquiredBusiness.orgID AND
                      LEFT.inquiredBusiness.seleID = RIGHT.inquiredBusiness.seleID,
                      TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                SELF.beoCrimReport := RIGHT.beoCrimReport;
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));
                      

      
    
    // OUTPUT(beoAndTitles, NAMED('beoAndTitles'));
   
    // OUTPUT(execCrim, NAMED('execCrim'));
    // OUTPUT(execAssets, NAMED('execAssets'));
    
    // OUTPUT(allBEOs, NAMED('allBEOs'));
    // OUTPUT(crimBEOs, NAMED('crimBEOs'));
    // OUTPUT(assetBEOs, NAMED('assetBEOs'));
    
    // OUTPUT(addCrim, NAMED('addCrim'));
    // OUTPUT(addAssets, NAMED('addAssets'));
    
    // OUTPUT(transAllBEOData, NAMED('transAllBEOData'));
    // OUTPUT(rollAllBEOData, NAMED('rollAllBEOData'));
    // OUTPUT(updateBEOs, NAMED('updateBEOs'));
    // OUTPUT(finalBEOs, NAMED('finalBEOs'));


    RETURN finalBEOs;
END;
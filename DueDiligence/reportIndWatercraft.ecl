IMPORT DueDiligence, iesp;

EXPORT reportIndWatercraft(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION

    transIndWater := PROJECT(inData, TRANSFORM(DueDiligence.LayoutsInternal.SharedWatercraftSlim,
                                                SELF.seq := LEFT.seq;
                                                SELF.did := LEFT.inquiredDID;
                                                
                                                SELF.allWatercraft := LEFT.perWatercraft;
                                                SELF := [];));
                                                

    sharedReportWaterData := DueDiligence.reportSharedWatercraft(transIndWater);
    
    reportWater := PROJECT(sharedReportWaterData, TRANSFORM({UNSIGNED6 seq, UNSIGNED6 did, iesp.duediligencepersonreport.t_DDRPersonWatercraftOwnership},
                                                            SELF.watercrafts := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonWatercraft,
                                                                                                    SELF.OwnershipType.SubjectOwned := LEFT.inquiredOwned;
                                                                                                    SELF.OwnershipType.SpouseOwned := LEFT.spouseOwned;
                                                                                                    SELF.OwnershipType.Owners := PROJECT(LEFT.owners, TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                                                                                                                                                SELF.lexID := (STRING)LEFT.did;
                                                                                                                                                                SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY))); 
                                                                                                    SELF := LEFT;)]);
                                                            SELF := LEFT;));
                                                                                                    
                                                                                                    
    rollReportWater := ROLLUP(SORT(reportWater, seq, did),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.watercrafts := LEFT.watercrafts + RIGHT.watercrafts;
                                        SELF := LEFT;));
    
    // add formatted report data to the report
    addWatercraftToReport := JOIN(inData, rollReportWater,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.inquiredDID = RIGHT.did,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            SELF.PersonReport.PersonAttributeDetails.Economic.Watercraft.Watercrafts := RIGHT.watercrafts;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));

    
    
    // OUTPUT(transIndWater, NAMED('transIndWater'));
    // OUTPUT(sharedReportWaterData, NAMED('sharedReportWaterData'));
    // OUTPUT(reportWater, NAMED('reportWater'));
    // OUTPUT(rollReportWater, NAMED('rollReportWater'));
    // OUTPUT(addWatercraftToReport, NAMED('addWatercraftToReport'));
    
    RETURN addWatercraftToReport;
END; 
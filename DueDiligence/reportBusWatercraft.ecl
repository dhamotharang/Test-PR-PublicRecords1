IMPORT DueDiligence, iesp;

EXPORT reportBusWatercraft(DATASET(DueDiligence.Layouts.Busn_Internal) inData) := FUNCTION


	 transBusWater := PROJECT(inData, TRANSFORM(DueDiligence.LayoutsInternal.SharedWatercraftSlim,
                                              SELF.seq := LEFT.seq;
                                              SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                              SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                              SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                              
                                              SELF.allWatercraft := LEFT.busWatercraft;
                                              SELF := [];));
                                                

    sharedReportWaterData := DueDiligence.reportSharedWatercraft(transBusWater);

    reportWater := PROJECT(sharedReportWaterData, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencebusinessreport.t_DDRBusinessWatercraftOwnership},
                                                            SELF.seq := LEFT.seq;
                                                            SELF.ultID := LEFT.ultID;
                                                            SELF.orgID := LEFT.orgID;
                                                            SELF.seleID := LEFT.seleID;
                                                            SELF.watercrafts := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRWatercraft, SELF := LEFT;)]);
                                                            SELF := [];));
                                                                                                    
    rollReportWater := ROLLUP(SORT(reportWater, seq, ultID, orgID, seleID),
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.watercrafts := LEFT.watercrafts + RIGHT.watercrafts;
                                        SELF := LEFT;));
    
    // add formatted report data to the report
    addWatercraftToReport := JOIN(inData, rollReportWater,
                                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                  TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                            SELF.BusinessReport.BusinessAttributeDetails.Economic.Watercraft.Watercrafts := RIGHT.watercrafts;
                                            SELF.BusinessReport.BusinessAttributeDetails.Economic.Watercraft.WatercraftCount := LEFT.watercraftCount;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));
                                  


    // OUTPUT(transBusWater, NAMED('transBusWater'));
    // OUTPUT(sharedReportWaterData, NAMED('sharedReportWaterData'));
    // OUTPUT(reportWater, NAMED('reportWater'));
    // OUTPUT(rollReportWater, NAMED('rollReportWater'));
    // OUTPUT(addWatercraftToReport, NAMED('addWatercraftToReport'));
    
    
    RETURN addWatercraftToReport;

END;   
	
	
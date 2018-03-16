IMPORT BIPv2, DueDiligence,  iesp;

EXPORT reportBusSOSFilings(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											     DATASET(DueDiligence.LayoutsInternalReport.BusCorpFilingsSlimLayout) BusSOSFilingsSlim) := FUNCTION
		

  sortFilings := SORT(BusSOSFilingsSlim, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -LastSeenDate);
  groupFilings := GROUP(sortFilings, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

	// ------                                                                        ------
  // ------ populate the ChildDataset  with the list of Reporting Bureaus         ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
  // ------                                                                       ------
	DueDiligence.LayoutsInternalReport.ReportingOfSOSFilingsChildLayout  FormatTheListOfSOSFilings(BusSOSFilingsSlim le, Integer FilingCount) := TRANSFORM, 
                                                                                      SKIP(FilingCount > iesp.constants.DDRAttributesConst.MaxSOSFilingStatuses)
            
    SELF.BusSOSFilingsChild := PROJECT(le, TRANSFORM(iesp.duediligencebusinessreport.t_DDRSOSFiling,
                                                      SELF.BusinessName                     := le.BusinessName;                      
                                                      SELF.FilingType                       := le.FilingType;
                                                      SELF.SOSFilingStatus                  := le.FilingStatus;
                                                      SELF.FilingNumber                     := le.FilingNumber;
                                                      SELF.SOSIncorporationState            := le.IncorporationState; 
                                                      SELF.FilingDate.Year                  := (unsigned4)le.FilingDate[1..4];     //** YYYY
                                                      SELF.FilingDate.Month                 := (unsigned2)le.FilingDate[5..6];     //** MM
                                                      SELF.FilingDate.Day                   := (unsigned2)le.FilingDate[7..8];     //** DD
                                                      SELF.SOSLastUpdated.Year              := (unsigned4)le.LastSeenDate[1..4];   //** YYYY
                                                      SELF.SOSLastUpdated.Month             := (unsigned2)le.LastSeenDate[5..6];   //** MM
                                                      SELF.SOSLastUpdated.Day               := (unsigned2)le.LastSeenDate[7..8];   //** DD 
                                                      SELF                                  := [];));
    SELF := le;
    SELF := [];
	END;  
	 

	BusSOSFilingDataset := PROJECT(groupFilings, FormatTheListOfSOSFilings(LEFT, COUNTER));
  
  rollFilings := ROLLUP(BusSOSFilingDataset,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.BusSOSFilingsChild := LEFT.BusSOSFilingsChild + RIGHT.BusSOSFilingsChild;
                                  SELF := LEFT;));
                                  
  addFilteredSOSFilings := JOIN(BusnData, rollFilings,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                          SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSFilingStatuses := LEFT.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSFilingStatuses  + RIGHT.BusSOSFilingsChild;  
                                          SELF := LEFT),
                                LEFT OUTER);
  
  countFilingStatus := PROJECT(BusSOSFilingsSlim, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED4 activeStatusFilingCount, UNSIGNED4 otherStatusFilingCount},
                                                            SELF.activeStatusFilingCount := (INTEGER)LEFT.isActive;
                                                            SELF.otherStatusFilingCount := IF(LEFT.isActive, 0, 1);
                                                            SELF := LEFT;
                                                            SELF := [];));
				       
	rollCounts := ROLLUP(countFilingStatus,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.activeStatusFilingCount := LEFT.activeStatusFilingCount + RIGHT.activeStatusFilingCount;
                                  SELF.otherStatusFilingCount := LEFT.otherStatusFilingCount + RIGHT.otherStatusFilingCount;
                                  SELF := LEFT;
                                  SELF := [];));
                                  
															 															
	addSOSCounts := JOIN(addFilteredSOSFilings, rollCounts,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                        TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                  SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSActiveCount := LEFT.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSActiveCount  + RIGHT.activeStatusFilingCount;  
                                  SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSOtherCount := LEFT.BusinessReport.BusinessAttributeDetails.Operating.BusinessInformation.SOSOtherCount  + RIGHT.otherStatusFilingCount;  
                                  SELF := LEFT),
                        LEFT OUTER);

		
	// OUTPUT(sortFilings,   NAMED('sortFilings'));
	// OUTPUT(BusSOSFilingsSlim,   NAMED('BusSOSFilingsSlim'));
	// OUTPUT(BusSOSFilingDataset, NAMED('BusSOSFilingDataset'));
  // OUTPUT(rollFilings, NAMED('rollFilings'));
	// OUTPUT(countFilingStatus, NAMED('countFilingStatus'));
	// OUTPUT(rollCounts, NAMED('rollCounts'));
	// OUTPUT(addSOSCounts, NAMED('addSOSCounts'));
																
		
  RETURN addSOSCounts;
		
END;   
	
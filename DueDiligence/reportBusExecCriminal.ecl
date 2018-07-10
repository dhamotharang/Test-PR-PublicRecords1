IMPORT DueDiligence, iesp;

EXPORT reportBusExecCriminal(DATASET(DueDiligence.layouts.Busn_Internal) InputBusnCriminal, 
                             STRING6 DD_SSNMask) := FUNCTION


    
    //get a list of offenses for each exec
    listOfExec := NORMALIZE(InputBusnCriminal, LEFT.execs, TRANSFORM({DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout, DATASET(DueDiligence.Layouts.CriminalOffenses) execOffenses, DATASET(DueDiligence.Layouts.Positions) titles},																												
                                                                      SELF.seq := LEFT.seq;  
                                                                      SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                      SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                      SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                      SELF.did := RIGHT.did; 
                                                                      SELF.execOffenses := RIGHT.indOffenses;
                                                                      SELF.titles := RIGHT.positions;
                                                                      SELF := RIGHT; 
                                                                      SELF := [];)); 
  
    
    //get a list of offenses for execs which have criminal data
    listOfExecOffenses := NORMALIZE(listOfExec, LEFT.execOffenses, TRANSFORM(DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout,
                                                                              SELF.crimData := RIGHT;
                                                                              SELF := LEFT;));
                                                                              
    //get a list of titles for each exec
    listOfExecPositions := NORMALIZE(listOfExec, LEFT.titles, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 lastSeen, STRING title},
                                                                        SELF.lastSeen := RIGHT.lastSeen;
                                                                        SELF.title := RIGHT.title;
                                                                        SELF := LEFT;));
                                                                        
    //get most recent title per exec
    sortExecPositions := SORT(listOfExecPositions, seq, ultID, orgID, seleID, did, -lastSeen);
    recentPosition := DEDUP(sortExecPositions, seq, ultID, orgID, seleID, did);
    
    //add the most recent title to exec with offenses
    listOfExecOffensesWithTitle := JOIN(listOfExecOffenses, recentPosition,
                                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                        LEFT.did = RIGHT.did,
                                        TRANSFORM(DueDiligence.LayoutsInternalReport.FlatListOfIndividualsWithCriminalLayout,
                                                  SELF.mostRecentTitle := RIGHT.title;
                                                  SELF := LEFT;),
                                        LEFT OUTER);
 

		populateChildCrimDataset := DueDiligence.reportSharedLegal.getDDRLegalEventCriminalWithMasking(listOfExecOffensesWithTitle, DD_SSNMask);
  
    formatExecCriminal := PROJECT(populateChildCrimDataset, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) crimEvents},
                                                                      SELF.seq := LEFT.seq;
                                                                      SELF.ultID := LEFT.ultID;
                                                                      SELF.orgID := LEFT.orgID;
                                                                      SELF.seleID := LEFT.seleID;
                                                                      SELF.did := LEFT.did;
                                                                      SELF.crimEvents := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents,
                                                                                                            SELF.ExecTitle := LEFT.execTitle;
                                                                                                            SELF.ExecutiveOfficer := LEFT;
                                                                                                            SELF.Criminals := LEFT.criminalChildDS;
                                                                                                            SELF := [];)]);
                                                                      SELF := [];));
                                                                      
    
    //roll formatted exec criminal layout up to the business level
    sortFormatExecCrim := SORT(formatExecCriminal, seq, ultID, orgID, seleID, did);
    rollFormatExecCrim := ROLLUP(sortFormatExecCrim,
                                 #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                                 TRANSFORM(RECORDOF(LEFT),
                                            SELF.crimEvents := LEFT.crimEvents + RIGHT.crimEvents;
                                            SELF := LEFT;));


    //add crim data back to the inquired business report
    addExecCrimReportData := JOIN(InputBusnCriminal, rollFormatExecCrim,
                                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                  TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                            SELF.BusinessReport.BusinessAttributeDetails.Legal.PossibleLegalEvents := RIGHT.crimEvents;
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));


		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
  // OUTPUT(listOfExec, NAMED('listOfExec'));
  // OUTPUT(listOfExecOffenses, NAMED('listOfExecOffenses'));
  // OUTPUT(listOfExecPositions, NAMED('listOfExecPositions'));
  // OUTPUT(recentPosition, NAMED('recentPosition'));
  // OUTPUT(listOfExecOffensesWithTitle, NAMED('listOfExecOffensesWithTitle'));
  // OUTPUT(populateChildCrimDataset, NAMED('populateChildCrimDataset'));
  // OUTPUT(formatExecCriminal, NAMED('formatExecCriminal'));
  // OUTPUT(rollFormatExecCrim, NAMED('rollFormatExecCrim'));
  // OUTPUT(addExecCrimReportData, NAMED('addExecCrimReportData'));


   
		RETURN addExecCrimReportData;		
	END;   
	
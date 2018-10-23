IMPORT BIPv2, BizLinkFull, Business_Risk_BIP, Doxie, DueDiligence, iesp, MDR, Risk_Indicators, STD;

/*
	No Keys are being accessed in this function.  This logic is working with the 
  Inquired Business and the list of BEO's with no DIDS.
	Notice in this logic we are using the first and last name as unique identifiers		 
*/

EXPORT reportBusDIDLessExecs(DATASET(DueDiligence.layouts.Busn_Internal) inData)
                                                                         := FUNCTION
  
  //retrieve execs off the inquired business
  workingDIDLessExecs := DueDiligence.CommonBusiness.getDIDLessExecs(inData);
  
   //start populating the report with the exec info already present in the Business Internal
   //which in the case of DIDLess Executive - it is only the first and last name 
  popExecReport := PROJECT(workingDIDLessExecs, TRANSFORM({DueDiligence.LayoutsInternalReport.BusExecs, UNSIGNED4 historyDate, STRING SSN},
                                                    SELF.Name := iesp.ECL2ESP.SetName(LEFT.party.firstName, LEFT.party.middleName, LEFT.party.lastName, LEFT.party.suffix, DueDiligence.Constants.EMPTY, LEFT.party.fullName);                                   
                                                    SELF := LEFT;
                                                    SELF := [];));
  
   
   
   //grab titles/positions from the internal record
  positions := NORMALIZE(workingDIDLessExecs, LEFT.party.positions, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 mostRecentDate, UNSIGNED4 secondRecentDate, STRING firstName, STRING lastName, DATASET(iesp.duediligenceshared.t_DDRPositionTitles) titles},
                                                                        SELF.titles := PROJECT(LEFT, TRANSFORM(iesp.duediligenceshared.t_DDRPositionTitles,
                                                                                                                SELF.Title := RIGHT.title;
                                                                                                                SELF.FirstReported := iesp.ECL2ESP.toDate(RIGHT.firstSeen);
                                                                                                                SELF.LastReported := iesp.ECL2ESP.toDate(RIGHT.lastSeen);
                                                                                                                SELF := [];));
                                                                        SELF.mostRecentDate := RIGHT.lastSeen;
                                                                        SELF.secondRecentDate := RIGHT.firstSeen;
                                                                        SELF.firstName := LEFT.party.firstName;
                                                                        SELF.lastName := LEFT.party.lastName;
                                                                        SELF := LEFT;
                                                                        SELF := [];));
                                                                        
                                                                        
  cleanPosDate := DueDiligence.Common.CleanDatasetDateFields(positions, 'mostRecentDate, secondRecentDate');  
  
  limitedPos := GROUP(SORT(cleanPosDate, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), firstName, lastName, -mostRecentDate, -secondRecentDate), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), firstName, lastName);
  workingPos := DueDiligence.Common.GetMaxRecords(limitedPos, iesp.constants.DDRAttributesConst.MaxTitles); 
  
  rollIndPos := ROLLUP(SORT(workingPos, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did),
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.firstName = RIGHT.firstName AND
                        LEFT.lastName  = RIGHT.lastName,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.titles := LEFT.titles + RIGHT.titles;
                                  SELF := LEFT));
  
  addPos := JOIN(popExecReport, rollIndPos,
                 #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                 LEFT.Name.first = RIGHT.firstName AND
                 LEFT.Name.last  = RIGHT.lastName,
                 TRANSFORM(RECORDOF(LEFT),
                            SELF.Titles := RIGHT.titles;
                            SELF := LEFT;),
                 LEFT OUTER,
                 ATMOST(1));
                 
  //if all sections for the BEO are populated then
  //roll up all BEOs to the business level to add to the report
  transformData := PROJECT(addPos, TRANSFORM(DueDiligence.LayoutsInternalReport.InquiredBusExecs,
                                                              SELF.execs := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessExecutives,
                                                                                                SELF := LEFT;
                                                                                                SELF := [];)]);
                                                              SELF := LEFT;
                                                              SELF := [];));
                                              
  rollExecs := ROLLUP(SORT(transformData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.execs := LEFT.execs + RIGHT.execs;
                                SELF := LEFT;));
                                  
  //add to report
  addBEOToReport := JOIN(inData, rollExecs,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.BusinessReport.BusinessAttributeDetails.NetworkDetails.BusinessExecutives := LEFT.BusinessReport.BusinessAttributeDetails.NetworkDetails.BusinessExecutives + RIGHT.execs;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
  
  
 //***DEBUG Statements - comment out before deploying***//
  
  // OUTPUT(InData,              NAMED('InData')); 
  // OUTPUT(workingDIDLessExecs, NAMED('workingDIDLessExecs')); 
  // OUTPUT(popExecReport,       NAMED('popExecReport')); 
  // OUTPUT(positions,           NAMED('positions')); 
  // OUTPUT(cleanPosDate,        NAMED('cleanPosDate')); 
  // OUTPUT(limitedPos,          NAMED('limitedPos')); 
  // OUTPUT(workingPos,          NAMED('workingPos')); 
  // OUTPUT(addPos,              NAMED('addPos')); 
  // OUTPUT(transformData,       NAMED('transformData')); 
  // OUTPUT(rollExecs,           NAMED('rollExecs')); 
  // OUTPUT(addBEOToReport,      NAMED('addBEOToReport')); 
  
  
  
	RETURN addBEOToReport;
END;

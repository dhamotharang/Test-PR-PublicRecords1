IMPORT BIPv2, BizLinkFull, Doxie, DueDiligence, iesp, STD;


EXPORT reportBusExecs(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION
                                  
  //retrieve execs off the inquired business
  allExecs := DueDiligence.CommonBusiness.getExecs(inData);
  
  //sort and group execs to limit those we will display
  //NEED MORE TO SORT ON???
  limitedExecs := GROUP(SORT(allExecs, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

  workingExecs := DueDiligence.Common.GetMaxRecords(limitedExecs, iesp.constants.DDRAttributesConst.MaxBusinessExecs);
  
  //start populating the report with the exec info before dealing with the child datasets
  popExecReport := PROJECT(workingExecs, TRANSFORM(DueDiligence.LayoutsInternalReport.BusExecs,
                                                    SELF.Name := iesp.ECL2ESP.SetName(LEFT.party.firstName, LEFT.party.middleName, LEFT.party.lastName, LEFT.party.suffix, DueDiligence.Constants.EMPTY, LEFT.party.fullName);
                                                    SELF.LexID := (STRING)LEFT.party.did;
                                                    SELF.DOB := iesp.ECL2ESP.toDate(LEFT.party.dob);
                                                    SELF.USResidency := LEFT.party.usResidencyScore;
                                                    SELF.CriminalLegalEvents := (INTEGER)LEFT.party.criminalLegalEventsScore;
                                                    SELF.CivilLegalEvents := (INTEGER)LEFT.party.civilLegalEventsScore;
                                                    SELF.LegalTypes := (INTEGER)LEFT.party.legalEventTypeScore;
                                                                                          
                                                    SELF.did := LEFT.party.did;
                                                    SELF := LEFT;
                                                    SELF := [];));
  

  //grab the licenses 
  profLicenses := NORMALIZE(workingExecs, LEFT.party.licenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED6 did, UNSIGNED4 mostRecentDate, UNSIGNED4 secondRecentDate, STRING lastName, DATASET(iesp.duediligenceshared.t_DDRProfessionalLicenses) lics},
                                                                          SELF.lics := PROJECT(LEFT, TRANSFORM(iesp.duediligenceshared.t_DDRProfessionalLicenses,
                                                                                                                SELF.IssuingAgency := RIGHT.licenseCategory;
                                                                                                                SELF.License := RIGHT.licenseType;
                                                                                                                SELF.IssueDate := iesp.ECL2ESP.toDate(RIGHT.issueDate);
                                                                                                                SELF.ExpirationDate := iesp.ECL2ESP.toDate(RIGHT.expirationDate);
                                                                                                                SELF.Status := IF(RIGHT.isactive, 'ACTIVE', 'INACTIVE');
                                                                                                                SELF.LawAccounting := RIGHT.lawacct;
                                                                                                                SELF.FinanceRealEstate := RIGHT.realEstate;
                                                                                                                SELF.MedicalDoctor := RIGHT.medical;
                                                                                                                SELF.PilotMarinePilotHarborPilotExplosives := RIGHT.blastPilot;
                                                                                                                SELF := [];));
                                                                          SELF.mostRecentDate := RIGHT.expirationDate;
                                                                          SELF.secondRecentDate := RIGHT.issueDate;
                                                                          SELF.lastName := LEFT.party.lastName;
                                                                          SELF.did := LEFT.party.did;
                                                                          SELF := LEFT;
                                                                          SELF := [];));
 
	cleanProfLicDate := DueDiligence.Common.CleanDatasetDateFields(profLicenses, 'mostRecentDate, secondRecentDate');                                                                        
                                                                          
  limitedLics := GROUP(SORT(cleanProfLicDate, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -mostRecentDate -secondRecentDate, lastName), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
  workingLics := DueDiligence.Common.GetMaxRecords(limitedLics, iesp.constants.DDRAttributesConst.MaxLicenses);   
  
  rollIndLics := ROLLUP(SORT(workingLics, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did),
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.lics := LEFT.lics + RIGHT.lics;
                                  SELF := LEFT));
  
  addLics := JOIN(popExecReport, rollIndLics,
                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                  LEFT.did = RIGHT.did,
                  TRANSFORM(RECORDOF(LEFT),
                            SELF.ProfessionalLicenses := RIGHT.lics;
                            SELF := LEFT;),
                  LEFT OUTER,
                  ATMOST(1));
  
  
  //grab titles/positions child datasets
  positions := NORMALIZE(workingExecs, LEFT.party.positions, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED6 did, UNSIGNED4 mostRecentDate, UNSIGNED4 secondRecentDate, STRING lastName, DATASET(iesp.duediligenceshared.t_DDRPositionTitles) titles},
                                                                        SELF.titles := PROJECT(LEFT, TRANSFORM(iesp.duediligenceshared.t_DDRPositionTitles,
                                                                                                                SELF.Title := RIGHT.title;
                                                                                                                SELF.FirstReported := iesp.ECL2ESP.toDate(RIGHT.firstSeen);
                                                                                                                SELF.LastReported := iesp.ECL2ESP.toDate(RIGHT.lastSeen);
                                                                                                                SELF := [];));
                                                                        SELF.mostRecentDate := RIGHT.lastSeen;
                                                                        SELF.secondRecentDate := RIGHT.firstSeen;
                                                                        SELF.lastName := LEFT.party.lastName;
                                                                        SELF.did := LEFT.party.did;
                                                                        SELF := LEFT;
                                                                        SELF := [];));

	cleanPosDate := DueDiligence.Common.CleanDatasetDateFields(positions, 'mostRecentDate, secondRecentDate');  
  
  limitedPos := GROUP(SORT(cleanPosDate, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -mostRecentDate, -secondRecentDate, lastName), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
  workingPos := DueDiligence.Common.GetMaxRecords(limitedPos, iesp.constants.DDRAttributesConst.MaxTitles); 
  
  rollIndPos := ROLLUP(SORT(workingPos, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did),
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.titles := LEFT.titles + RIGHT.titles;
                                  SELF := LEFT));
  
  addPos := JOIN(addLics, rollIndPos,
                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                  LEFT.did = RIGHT.did,
                  TRANSFORM(RECORDOF(LEFT),
                            SELF.Titles := RIGHT.titles;
                            SELF := LEFT;),
                  LEFT OUTER,
                  ATMOST(1));
    
    
  //this section will be used to make calls to grab additional information pertaining to the BEOs
  //first get all the unique dids (no need to call the keys multiple time for the same key
  uniqueDIDs := DEDUP(SORT(addPos, did), did);
  
  //check to see if the individual is tied to another business - need to add some history date for archiving here..... 11.2 changes
  busAssociations := JOIN(uniqueDIDs, BizLinkFull.Key_BizHead_L_CONTACT_DID.key,
                          KEYED(LEFT.did = RIGHT.contact_did) AND
                          LEFT.seleid <> RIGHT.seleid,
                          TRANSFORM({BOOLEAN assocOtherBus, RECORDOF(LEFT)},
                                    SELF.assocOtherBus := RIGHT.contact_did <> 0;
                                    SELF := LEFT;),
                          LIMIT(0), KEEP(1));                 
                  
  addAssociation := JOIN(addPos, busAssociations,
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.AssociatedWithOtherCompanies := RIGHT.assocOtherBus;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
  
  //check to see if the individual is deceased
  // deceasedDIDs := JOIN(uniqueDIDs, Doxie.key_Death_masterV2_ssa_DID,
                      // (UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND									
                      // KEYED(LEFT.DID = RIGHT.l_did),
                      // TRANSFORM({RECORDOF(LEFT) le, RECORDOF(RIGHT) ri},
                                // SELF.le := LEFT;
                                // SELF.ri := RIGHT;), 
                      // KEEP(200), ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
  
  
  
 
 
 
 
 
 
 
  //roll up all BEOs to the business level to add to the report
  transformData := PROJECT(addAssociation, TRANSFORM(DueDiligence.LayoutsInternalReport.InquiredBusExecs,
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
                                    SELF.BusinessReport.BusinessAttributeDetails.NetworkDetails.BusinessExecutives := RIGHT.execs;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
  
  
  
  
  // OUTPUT(allExecs, NAMED('allExecs'));
  // OUTPUT(limitedExecs, NAMED('limitedExecs'));
  // OUTPUT(workingExecs, NAMED('workingExecs'));
  // OUTPUT(popExecReport, NAMED('popExecReport'));
  
  // OUTPUT(profLicenses, NAMED('profLicenses'));
  // OUTPUT(limitedLics, NAMED('limitedLics'));
  // OUTPUT(workingLics, NAMED('workingLics'));
  // OUTPUT(rollIndLics, NAMED('rollIndLics'));
  // OUTPUT(addLics, NAMED('addLics'));
  
  // OUTPUT(positions, NAMED('positions'));
  // OUTPUT(limitedPos, NAMED('limitedPos'));
  // OUTPUT(workingPos, NAMED('workingPos'));
  // OUTPUT(rollIndPos, NAMED('rollIndPos'));
  // OUTPUT(addPos, NAMED('addPos'));  
  
  // OUTPUT(uniqueDIDs, NAMED('uniqueDIDs'));  
      
  // OUTPUT(busAssociations, NAMED('busAssociations'));
  // OUTPUT(addAssociation, NAMED('addAssociation'));
  
  // OUTPUT(deceasedDIDs, NAMED('deceasedDIDs'));
  
  // OUTPUT(transformData, NAMED('transformData'));
  // OUTPUT(rollExecs, NAMED('rollExecs'));
  // OUTPUT(addBEOToReport, NAMED('addBEOToReport'));

   
  RETURN addBEOToReport;                                  
END;                                  
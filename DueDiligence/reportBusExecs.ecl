IMPORT BIPv2, BizLinkFull, Business_Risk_BIP, Doxie, DueDiligence, iesp, MDR, Risk_Indicators, STD;


EXPORT reportBusExecs(DATASET(DueDiligence.layouts.Busn_Internal) inData,
                      Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                      BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
                                  
  //retrieve execs off the inquired business
  allExecs := DueDiligence.CommonBusiness.getExecs(inData);
  
  //sort and group execs to limit those we will display
  //NEED MORE TO SORT ON???
  limitedExecs := GROUP(SORT(allExecs, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

  workingExecs := DueDiligence.Common.GetMaxRecords(limitedExecs, iesp.constants.DDRAttributesConst.MaxBusinessExecs);
  
  //start populating the report with the exec info before dealing with the child datasets
  popExecReport := PROJECT(workingExecs, TRANSFORM({DueDiligence.LayoutsInternalReport.BusExecs, UNSIGNED4 historyDate, STRING SSN},
                                                    SELF.Name := iesp.ECL2ESP.SetName(LEFT.party.firstName, LEFT.party.middleName, LEFT.party.lastName, LEFT.party.suffix, DueDiligence.Constants.EMPTY, LEFT.party.fullName);
                                                    SELF.LexID := (STRING)LEFT.party.did;
                                                    SELF.DOB := iesp.ECL2ESP.toDate(LEFT.party.dob);
                                                    SELF.USResidency := LEFT.party.usResidencyScore;
                                                    SELF.CriminalLegalEvents := (INTEGER)LEFT.party.stateCriminalLegalEventsScore;  //To be removed at later date replaced with CriminalStateLegalEvents
                                                    SELF.CriminalStateLegalEvents := (INTEGER)LEFT.party.stateCriminalLegalEventsScore;
                                                    SELF.LegalTypes := (INTEGER)LEFT.party.legalEventTypeScore;
                                                                                          
                                                    SELF.did := LEFT.party.did;
                                                    SELF.SSN := LEFT.party.ssn;
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
  
  //check to see if the individual is tied to another business - no history date since there no date field in key. No way to tell when they were associated
  //with other business unless we were to do another key cal - this is just a boolean check for the report
  busAssociations := JOIN(uniqueDIDs, BizLinkFull.Key_BizHead_L_CONTACT_DID.key,
                          KEYED(LEFT.did = RIGHT.contact_did) AND
                          LEFT.seleid <> RIGHT.seleid,
                          TRANSFORM({RECORDOF(LEFT)},
                                    SELF := LEFT;),
                          LIMIT(0), KEEP(1));                 
                  
  addAssociation := JOIN(addPos, busAssociations,
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.AssociatedWithOtherCompanies := RIGHT.did <> 0; 
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
                     
  
  //check to see if the individual is deceased
  deceasedDIDs := JOIN(uniqueDIDs, Doxie.key_Death_masterV2_ssa_DID,
                      (UNSIGNED)(RIGHT.dod8) < LEFT.historydate AND									
                      KEYED(LEFT.DID = RIGHT.l_did) AND
                      NOT((Risk_Indicators.iid_constants.deathSSA_ok(options.DataRestrictionMask) = FALSE AND RIGHT.src = MDR.sourceTools.src_Death_Restricted) 
                          OR (linkingOptions.AllowGLB = FALSE AND RIGHT.glb_flag = DueDiligence.Constants.YES)),
                      TRANSFORM({RECORDOF(RIGHT)},
                                SELF := RIGHT;), 
                      KEEP(1), ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
  
  uniqueDeceasedDIDs := DEDUP(SORT(deceasedDIDs, l_did), l_did);
  
  addDeceased := JOIN(addAssociation, uniqueDeceasedDIDs,
                      LEFT.did = RIGHT.l_did,
                      TRANSFORM(RECORDOF(LEFT),
                                SELF.Deceased := RIGHT.l_did <> 0; 
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));
                      
                      
  //check to see if more than 2 individuals are associated with the ssn                    
  indsAssocWithSSN := JOIN(uniqueDIDs, doxie.Key_Header_SSN,
                            (INTEGER)LEFT.SSN > 0 AND LENGTH(TRIM(LEFT.SSN)) = 9 AND
                            KEYED(LEFT.SSN[1] = RIGHT.S1 AND 
                                  LEFT.SSN[2] = RIGHT.S2 AND 
                                  LEFT.SSN[3] = RIGHT.S3 AND 
                                  LEFT.SSN[4] = RIGHT.S4 AND 
                                  LEFT.SSN[5] = RIGHT.S5 AND 
                                  LEFT.SSN[6] = RIGHT.S6 AND 
                                  LEFT.SSN[7] = RIGHT.S7 AND 
                                  LEFT.SSN[8] = RIGHT.S8 AND 
                                  LEFT.SSN[9] = RIGHT.S9),
                            TRANSFORM({UNSIGNED6 didSearching, STRING9 SSN, RECORDOF(RIGHT), UNSIGNED3 didsAssoc},
                                      SELF.didSearching := LEFT.did;
                                      SELF.SSN := LEFT.SSN;
                                      SELF.didsAssoc := 1;
                                      SELF := RIGHT;),
                            ATMOST(Business_Risk_BIP.Constants.Limit_Default));      
  
  uniqueIndAssocs := DEDUP(SORT(indsAssocWithSSN, didSearching, SSN, did), didSearching, SSN, did);
  
  countIndAssocs := ROLLUP(SORT(uniqueIndAssocs, didSearching),
                          LEFT.didSearching = RIGHT.didSearching,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.didsAssoc := LEFT.didsAssoc + RIGHT.didsAssoc;
                                    SELF := LEFT;));
                                    
  addMoreTwoAssocsWithSSN := JOIN(addDeceased, countIndAssocs,
                                  LEFT.did = RIGHT.didSearching,
                                  TRANSFORM(RECORDOF(LEFT),
                                            SELF.MoreThanTwoIndvsAssociatedWithSSN := RIGHT.didsAssoc > 2; 
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));                                 
 
 
 
 
 
 
  //roll up all BEOs to the business level to add to the report
  transformData := PROJECT(addMoreTwoAssocsWithSSN, TRANSFORM(DueDiligence.LayoutsInternalReport.InquiredBusExecs,
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
  
  
  
  
  // OUTPUT(inData, NAMED('inData'));
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
  // OUTPUT(uniqueDeceasedDIDs, NAMED('uniqueDeceasedDIDs'));
  // OUTPUT(addDeceased, NAMED('addDeceased'));
  
  // OUTPUT(indsAssocWithSSN, NAMED('indsAssocWithSSN'));
  // OUTPUT(uniqueIndAssocs, NAMED('uniqueIndAssocs'));
  // OUTPUT(countIndAssocs, NAMED('countIndAssocs'));
  // OUTPUT(addMoreTwoAssocsWithSSN, NAMED('addMoreTwoAssocsWithSSN'));
  
  // OUTPUT(transformData, NAMED('transformData'));
  // OUTPUT(rollExecs, NAMED('rollExecs'));
  // OUTPUT(addBEOToReport, NAMED('addBEOToReport'));

   
  RETURN addBEOToReport;                                  
END;                                  
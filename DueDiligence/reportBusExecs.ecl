IMPORT BIPv2, BizLinkFull, Business_Risk_BIP, Doxie, DueDiligence, iesp, MDR, Risk_Indicators, STD;


EXPORT reportBusExecs(DATASET(DueDiligence.layouts.Busn_Internal) inData,
                      Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                      BIPV2.mod_sources.iParams linkingOptions) := FUNCTION
 

  //retrieve execs off the inquired business
  allExecs := DueDiligence.CommonBusiness.getExecs(inData);
  
  //sort and group execs to limit those we will display
  limitedExecs := GROUP(SORT(allExecs, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

  workingExecs := DueDiligence.Common.GetMaxRecords(limitedExecs, iesp.constants.DDRAttributesConst.MaxBusinessExecs);
  
  //start populating the report with the exec info already present in the Business Internal
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
  profLicenses := NORMALIZE(workingExecs, LEFT.party.licenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 mostRecentDate, UNSIGNED4 secondRecentDate, STRING lastName, DATASET(iesp.duediligenceshared.t_DDRProfessionalLicenses) lics},
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
  
  
  //grab titles/positions from the internal record
  positions := NORMALIZE(workingExecs, LEFT.party.positions, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 mostRecentDate, UNSIGNED4 secondRecentDate, STRING lastName, DATASET(iesp.duediligenceshared.t_DDRPositionTitles) titles},
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
    
    
  //this section will be used to make calls to the keys to grab additional information pertaining to the BEOs
  //first get all the unique dids  
  uniqueDIDs := DEDUP(SORT(addPos, did), did);
  
  //----                                                                                                                 ----
  //---- check to see if the individual is tied to another business - no history date since there no date field in key.  ---- 
  //----     No way to tell 'WHEN' they were associated to the another business                                          ----
  //----     Pick up the LINK ID of the another business and get the name of the business.                               ----
  //----                                                                                                                 ----
  busAssociations := JOIN(uniqueDIDs, BizLinkFull.Key_BizHead_L_CONTACT_DID.key,
                          KEYED(LEFT.did = RIGHT.contact_did) AND
                          LEFT.seleid <> RIGHT.seleid,
                          TRANSFORM(DueDiligence.LayoutsInternalReport.Associated_Businesses,     
                                    /*  save the unique identifier of the associated business */  
                                    SELF.Busn_Info.BIP_IDs.seq           := LEFT.did;                          //***use the DID as the seq # of this process                             
                                    SELF.Busn_info.BIP_IDs.UltID.LinkID  := RIGHT.ultid;
                                    SELF.Busn_info.BIP_IDs.OrgID.LinkID  := RIGHT.orgID;
                                    SELF.Busn_info.BIP_IDs.SeleID.LinkID := RIGHT.seleid;
                                    /*  save the BEO DID from the Inquired Business   */                                        
                                    SELF.InquiredBus.did                 := LEFT.did;
                                    /*  retain the unique identifier of the Inquire business */   
                                    SELF.InquiredBus.seq                 := LEFT.seq;                          //***retain the seq # of the "inquired business"
                                    SELF.InquiredBus.ultid               := LEFT.ultid;
                                    SELF.InquiredBus.seleid              := LEFT.seleid;
                                    /* no need to populate the other fields in this result set */  
                                    SELF                                 := [];),
                          //*** this is an INNER JOIN - so it will KEEP only matches  ***//                          
                          //*** at this time we are going to LIMIT the number matches ***//
                          //*** and KEEP the same number in the report                ***//
                          LIMIT(100), KEEP(100));  
                          
  //Now while processing the associated businesses - SORT and eliminate duplicate LINKIDs  
  dedupBusMatches := DEDUP(SORT(busAssociations, Busn_Info.BIP_IDs.seq, Busn_info.BIP_IDs.UltID.LinkID, Busn_info.BIP_IDs.OrgID.LinkID, Busn_info.BIP_IDs.SeleID.LinkID), 
                          Busn_info.BIP_IDs.UltID.LinkID, 
                          Busn_info.BIP_IDs.OrgID.LinkID, 
                          Busn_info.BIP_IDs.SeleID.LinkID); 
                             
  //Pass this list of associated business LINKID's and get the Business Names 
   busAssocBestInfo  := DueDiligence.getBusExecAssociatedBusNames(dedupBusMatches, Options, linkingOptions); 
  
 //Create the List of Business Names associated with this did where company_Name is a child DATASET of busAssocBestInfo 
   ListOfAssociatedCompanyNames := NORMALIZE(busAssocBestInfo, LEFT.company_Name, TRANSFORM(DueDiligence.LayoutsInternalReport.ReportingOfBEOAssociatedBus,                                                
                                   SELF.seq                     := LEFT.seq;          //***this is actually a did of the BEO we are working on
																	 SELF.ultID                   := LEFT.UltID;        //***this is the Associated Business of the DID
																	 SELF.orgID                   := LEFT.OrgID;
																	 SELF.seleID                  := LEFT.SeleID;
                                   SELF.did                     := LEFT.seq;          //***lets put the did back where it belongs
                                   /* Notice in the layout the RptAssocBusNames is defined as a DATASET in this Layout                        */
                                   /* While working with child DATASETS this step needs to be done prior to the ROLLUP                        */
                                   /* The results will BE a DATASET with one Business in it for every row in the ListOfAssociatedCompanyNames */
                                   SELF.RptAssocBusNames        := PROJECT(LEFT, TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessNameWithLexID,
                                                                          SELF.BusinessName  := Right.Company_Name;
                                                                          SELF.LexID         := (STRING)LEFT.SeleID;
                                                                          SELF               := [];));
                                   SELF                         := LEFT;
                                   SELF                         := [];));
  
  //Now use the ROLLUP to Create the 1 to many relationship between the BEO and the Associated Business Names ***//   
   rollAssocBus := ROLLUP(SORT(ListOfAssociatedCompanyNames, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), seq),
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT), 
                                  SELF.RptAssocBusNames := LEFT.RptAssocBusNames + RIGHT.RptAssocBusNames;
                                  /* We don't care about the LINK ID's of the associated business any more.   */ 
                                  SELF.ultid            := 0;
                                  SELF.orgid            := 0; 
                                  SELF.seleid           := 0;
                                  SELF := LEFT));
  
  
  //JOIN the ListOfCompanyNames back to the record set that contains the DID of the BEO of the Inquired Business            
  addAssociation := JOIN(addPos, rollAssocBus,
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    /*  This results in a CHILD DATASET for each DID/BEO      */   
                                    SELF.AssociatedWithOtherBusinesses := RIGHT.RptAssocBusNames;
                                    /*  If there are associated business present in the DATASET - set the boolean flag to true */  
                                    SELF.AssociatedWithOtherCompanies  := IF(COUNT(RIGHT.RptAssocBusNames) > 0, true, false);  
                                    SELF := LEFT;),
                          /*  Not all DID's are associated with another Business so use a LEFT OUTER JOIN   */ 
                          /*  to keep records from the LEFT even if there is not a matching RIGHT           */  
                          LEFT OUTER,
                          ATMOST(1));
  //The Associated With Other Business is now populated in this results set and should get passed along and eventually land in the NetworkDetails of the Business Report                  
  
  
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
  
  //add the deceased flag to the result set that contains reporting information for the business executive  
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
 
 
 
 
 
  //if all sections for the BEO are populated then
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
  // OUTPUT(dedupBusMatches, NAMED('dedupBusMatches'));
  
 // OUTPUT(seqBusMatches, NAMED('seqBusMatches'));
 // OUTPUT(busAssocBestInfo, NAMED('busAssocBestInfo'));
 // OUTPUT(ListOfAssociatedCompanyNames, NAMED('ListOfAssociatedCompanyNames'));
 // OUTPUT(rollAssocBus, NAMED('rollAssocBus'));
  
  //OUTPUT(addAssociation, NAMED('addAssociation'));
  
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
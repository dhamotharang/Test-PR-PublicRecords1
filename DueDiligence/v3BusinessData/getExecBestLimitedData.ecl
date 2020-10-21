IMPORT BIPV2_Build, Business_Risk_BIP, DueDiligence, iesp, STD, ut;

/*
	Following Keys being used:
			BIPV2_Build.key_contact_linkids.kFetch
*/
EXPORT getExecBestLimitedData(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                              DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
    

    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);
    linkingOptions := DueDiligence.v3Common.DDBusiness.GetLinkingOptions(regulatoryAccess);
    modAccess := DueDiligence.v3Common.General.GetModAccess(regulatoryAccess);
    
    
    
    //get unique business - only need to get the data once per business, will be added back when we add the seq back
    uniqueBusiness := DEDUP(SORT(inData, inquiredBusiness.ultID, inquiredBusiness.orgID, inquiredBusiness.seleID, seq), inquiredBusiness.ultID, inquiredBusiness.orgID, inquiredBusiness.seleID);


    execsRaw := BIPV2_Build.key_contact_linkids.kFetch(DueDiligence.v3Common.DDBusiness.GetKfetchLinkIDs(uniqueBusiness),
                                                        Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                        0, // ScoreThreshold --> 0 = Give me everything
                                                        linkingOptions,
                                                        Business_Risk_BIP.Constants.Limit_Default,
                                                        Options.KeepLargeBusinesses, 
                                                        modAccess)(source NOT IN DueDiligence.Constants.EXCLUDE_SOURCES);
																										 
																										 
    
    //pull out the contact info and needed info
    pulledExecs :=  PROJECT(execsRaw, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails -[seq, historyDate],
                                                SELF.ultID := LEFT.ultID;
                                                SELF.orgID := LEFT.orgID;
                                                SELF.seleID := LEFT.seleID;
                                                
                                                SELF.lexID := LEFT.contact_did;
                                                
                                                SELF.firstName := LEFT.contact_name.fname;
                                                SELF.middleName := LEFT.contact_name.mname;
                                                SELF.lastName := LEFT.contact_name.lname;
                                                SELF.suffix := LEFT.contact_name.name_suffix;
                                                SELF.fullName := DueDiligence.v3Common.General.CombineNamePartsForFullName(LEFT.contact_name.fname, LEFT.contact_name.mname, LEFT.contact_name.lname, LEFT.contact_name.name_suffix);
                                                
                                                SELF.firstSeen := IF((UNSIGNED4)LEFT.dt_first_seen = DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED4)LEFT.dt_vendor_first_reported, (UNSIGNED4)LEFT.dt_first_seen);	
                                                
                                                lastSeen := IF((UNSIGNED4)LEFT.dt_last_seen = DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED4)LEFT.dt_vendor_last_reported, (UNSIGNED4)LEFT.dt_last_seen);	
                                                SELF.lastSeen := lastSeen;
                                                
                                                SELF.ssn := LEFT.contact_ssn;
                                                
                                                derived := STD.Str.ToUpperCase(TRIM(LEFT.contact_job_title_derived, LEFT, RIGHT));
                                                SELF.title := IF(derived IN DueDiligence.Constants.EXECUTIVE_TITLES, derived, DueDiligence.Constants.EMPTY);
                                                
                                                SELF := LEFT;
                                                SELF := [];));
                                                

    filterExecs := pulledExecs(title <> DueDiligence.Constants.EMPTY);
    
    uniqueExecs := DEDUP(filterExecs, ALL);
    
    //Add back our Seq numbers.
    execsRawSeq := DueDiligence.v3Common.DDBusiness.AppendSeq(uniqueExecs, indata, FALSE);
    
    //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
    execCleanDates := DueDiligence.Common.CleanDatasetDateFields(execsRawSeq, 'firstSeen, lastSeen');
    
    //Filter out records after our history date.
    execFilt := DueDiligence.CommonDate.FilterRecordsSingleDate(execCleanDates, firstSeen);
    
    transExec := PROJECT(execFilt, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails, 
                                              lastSeenDays := DueDiligence.CommonDate.DaysApartWithZeroEmptyDate((STRING)LEFT.lastSeen, (STRING)LEFT.historyDate);
                                              past3Years := ut.DaysInNYears(3);
                                              seenLast3Years := lastSeenDays <= past3Years;
                                              
                                              SELF.isOwnershipProng := LEFT.title IN DueDiligence.Constants.OWNERSHIP_PRONG_TITLES AND seenLast3Years;
                                              SELF.isControlProng := LEFT.title NOT IN DueDiligence.Constants.OWNERSHIP_PRONG_TITLES AND seenLast3Years;
                                              
                                              SELF := LEFT;));
    
    
    
    //limit the number of execs to max allowed per business
    didlessExecs := DEDUP(SORT(transExec(lexID = 0), seq, ultID, orgID, seleID, lastName, firstName, suffix), seq, ultID, seleID, lastName, firstName, suffix);
    execs := DEDUP(SORT(transExec(lexID > 0), seq, ultID, orgID, seleID, lexID), seq, ultID, seleID, lexID);
    
    //all unique BEOs
    allUniqueBEOs := GROUP(SORT(didlessExecs + execs, seq, ultID, orgID, seleID, -lexID, -lastSeen, lastName, firstName, suffix), seq, ultID, orgID, seleID);
    
    maxBEOs := DueDiligence.v3Common.General.GetMaxNumberOfRecords(allUniqueBEOs, iesp.Constants.DDRAttributesConst.MaxBusinessExecs);

   
    //grab the best data for those that have lexIDs
    bestBEOData := DueDiligence.v3PersonData.getBestData(regulatoryAccess);
    
    transBEOLexID := PROJECT(maxBEOs(lexID > 0), TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                                            SELF.lexID := LEFT.lexID;
                                                            SELF.historyDate := LEFT.historyDate;
                                                            SELF := [];));
                                                            
    uniqueBestBEOs := DEDUP(SORT(transBEOLexID, lexID), lexID);
    
    beoBest := bestBEOData.GetIndividualBestDataWithLexID(uniqueBestBEOs);
    
    mostRecentBEODataByLexID := DEDUP(SORT(transExec(lexID > 0), lexID, -lastSeen, lastName, -firstName, -middleName, -suffix), lexID);
    
    //only get the data from the limited BEOs and replace name of the lexID to be best so they are the same
    beoWithBestData := JOIN(transExec(lexID > 0), beoBest,
                            LEFT.lexID = RIGHT.lexID,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                       SELF.seq := LEFT.seq;
                                       SELF.ultID := LEFT.ultID;
                                       SELF.orgID := LEFT.orgID;
                                       SELF.seleID := LEFT.seleID;
                                       SELF.lexID := LEFT.lexID;
                                       
                                       useBestInfo := RIGHT.lexID > 0;
                                       recentBEOInfo := mostRecentBEODataByLexID(lexID = LEFT.lexID);
                                       
                                       SELF.firstName := IF(useBestInfo, RIGHT.firstName, recentBEOInfo[1].firstName);
                                       SELF.middleName := IF(useBestInfo, RIGHT.middleName, recentBEOInfo[1].middleName);
                                       SELF.lastName := IF(useBestInfo, RIGHT.lastName, recentBEOInfo[1].lastName);
                                       SELF.suffix := IF(useBestInfo, RIGHT.suffix, recentBEOInfo[1].suffix);
                                       SELF.fullName := IF(useBestInfo, RIGHT.fullName, recentBEOInfo[1].fullName);
                                       
                                       SELF.dob := RIGHT.dob;
                                       SELF.ssn := RIGHT.ssn;
                                       
                                       SELF.streetAddress1 := RIGHT.streetAddress1;
                                       SELF.streetAddress2 := RIGHT.streetAddress2;
                                       SELF.prim_range := RIGHT.prim_range;
                                       SELF.predir := RIGHT.predir;
                                       SELF.prim_name := RIGHT.prim_name;
                                       SELF.addr_suffix := RIGHT.addr_suffix;
                                       SELF.postdir := RIGHT.postdir;
                                       SELF.unit_desig := RIGHT.unit_desig;
                                       SELF.sec_range := RIGHT.sec_range;
                                       
                                       SELF.city := RIGHT.city;
                                       SELF.state := RIGHT.state;
                                       SELF.zip := RIGHT.zip;
                                       SELF.zip4 := RIGHT.zip4;
                                       SELF.geo_blk := RIGHT.geo_blk;
                                       SELF.county := RIGHT.county;
                                       
                                       SELF := LEFT;
                                       SELF := [];),
                            LEFT OUTER,
                            ATMOST(1));
                                       
    beoWithName := JOIN(transExec(lexID = 0), maxBEOs(lexID = 0),
                        LEFT.seq = RIGHT.seq AND
                        LEFT.ultID = RIGHT.ultID AND
                        LEFT.orgID = RIGHT.orgID AND
                        LEFT.seleID = RIGHT.seleID AND
                        LEFT.lastName = RIGHT.lastName AND
                        LEFT.firstName = RIGHT.firstName AND
                        LEFT.suffix = RIGHT.suffix,
                        TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                  SELF := LEFT;));
    
    
    allBEOsData := beoWithBestData + beoWithName;
    
    
    
    //get exec title information for everyone
    execTitles := DueDiligence.v3BusinessData.getExecTitles(inData, allBEOsData);

    
    
    
    // OUTPUT(uniqueBusiness, NAMED('uniqueBusiness'));
    // OUTPUT(execsRaw, NAMED('execsRaw'));
    // OUTPUT(pulledExecs, NAMED('pulledExecs'));
    // OUTPUT(filterExecs, NAMED('filterExecs'));
    // OUTPUT(uniqueExecs, NAMED('uniqueExecs'));
    
    // OUTPUT(execsRawSeq, NAMED('execsRawSeq'));
    // OUTPUT(execCleanDates, NAMED('execCleanDates'));
    // OUTPUT(execFilt, NAMED('execFilt'));
    // OUTPUT(transExec, NAMED('transExec'));
    
    // OUTPUT(didlessExecs, NAMED('didlessExecs'));
    // OUTPUT(execs, NAMED('execs'));
    // OUTPUT(allUniqueBEOs, NAMED('allUniqueBEOs'));
    // OUTPUT(maxBEOs, NAMED('maxBEOs'));
    
    // OUTPUT(beoBest, NAMED('beoBest'));
    // OUTPUT(mostRecentBEODataByLexID, NAMED('mostRecentBEODataByLexID'));
    // OUTPUT(beoWithBestData, NAMED('beoWithBestData'));
    // OUTPUT(beoWithName, NAMED('beoWithName'));
    // OUTPUT(allBEOsData, NAMED('allBEOsData'));
    
    // OUTPUT(execTitles, NAMED('execTitles'));
    

    RETURN execTitles;
END;
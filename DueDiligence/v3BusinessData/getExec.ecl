IMPORT BIPV2, BIPV2_Build, Business_Risk_BIP, Doxie, DueDiligence, iesp, STD, ut;

/*
	Following Keys being used:
			BIPV2_Build.key_contact_linkids.kFetch
*/
EXPORT getExec(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
               DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
               DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
               DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION
                
   
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
    
    
    //get limited exec best data
    limitedExecData := DueDiligence.v3BusinessData.getExecBestLimitedData(transExec, regulatoryAccess);
    

    //get exec title information for everyone
    execTitles := DueDiligence.v3BusinessData.getExecTitles(limitedExecData);


    //transform and then rollup to the business level
    transBEOs := PROJECT(execTitles, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                               SELF.seq := LEFT.seq;
                                               SELF.ultID := LEFT.ultID;
                                               SELF.orgID := LEFT.orgID;
                                               SELF.seleID := LEFT.seleID;
                                               
                                               SELF.execs := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimExec,
                                                                                SELF.lexID := LEFT.lexID;
                                                                                SELF.firstName := LEFT.firstName;
                                                                                SELF.middleName := LEFT.middleName;
                                                                                SELF.lastName := LEFT.lastName;
                                                                                SELF.suffix := LEFT.suffix;
                                                                                SELF.fullName := LEFT.fullName;
                                                                                
                                                                                SELF.titles := LEFT.titles;
                                                                                
                                                                                SELF.dob := LEFT.dob;
                                                                                SELF.ssn := LEFT.ssn;
                                                                               
                                                                                SELF.streetAddress1 := LEFT.streetAddress1;
                                                                                SELF.streetAddress2 := LEFT.streetAddress2;
                                                                                SELF.prim_range := LEFT.prim_range;
                                                                                SELF.predir := LEFT.predir;
                                                                                SELF.prim_name := LEFT.prim_name;
                                                                                SELF.addr_suffix := LEFT.addr_suffix;
                                                                                SELF.postdir := LEFT.postdir;
                                                                                SELF.unit_desig := LEFT.unit_desig;
                                                                                SELF.sec_range := LEFT.sec_range;
                                                                                
                                                                                SELF.city := LEFT.city;
                                                                                SELF.state := LEFT.state;
                                                                                SELF.zip := LEFT.zip;
                                                                                SELF.zip4 := LEFT.zip4;
                                                                                SELF.geo_blk := LEFT.geo_blk;
                                                                                SELF.county := LEFT.county;

                                                                                SELF.isOwnershipProng := LEFT.isOwnershipProng;
                                                                                SELF.isControlProng := LEFT.isControlProng;
                                                                                
                                                                                SELF := [];)]);
                                               
                                               SELF := [];));
                                             
    rollBEOs := ROLLUP(SORT(transBEOs, seq, ultID, orgID, seleID),
                       LEFT.seq = RIGHT.seq AND
                       LEFT.ultID = RIGHT.ultID AND
                       LEFT.orgID = RIGHT.orgID AND
                       LEFT.seleID = RIGHT.seleID,
                       TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                  SELF.execs := LEFT.execs + RIGHT.execs;
                                  SELF := LEFT;));
                                  
    addBEOsToInput := JOIN(inData, rollBEOs,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                            LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                            LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                            TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                      SELF.beos := RIGHT.execs;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));


    
    execCrim := DueDiligence.v3BusinessData.getExecCriminal(addBEOsToInput, attributesRequested, ddOptions);
   




    // OUTPUT(uniqueBusiness, NAMED('uniqueBusiness'));
    // OUTPUT(execsRaw, NAMED('execsRaw'));
    // OUTPUT(pulledExecs, NAMED('pulledExecs'));
    // OUTPUT(filterExecs, NAMED('filterExecs'));
    // OUTPUT(uniqueExecs, NAMED('uniqueExecs'));
    
    // OUTPUT(execsRawSeq, NAMED('execsRawSeq'));
    // OUTPUT(execCleanDates, NAMED('execCleanDates'));
    // OUTPUT(execFilt, NAMED('execFilt'));
    // OUTPUT(transExec, NAMED('transExec'));
    
    // OUTPUT(limitedExecData, NAMED('limitedExecData'));
    // OUTPUT(execTitles, NAMED('execTitles'));
    
    // OUTPUT(transBEOs, NAMED('transBEOs'));
    // OUTPUT(rollBEOs, NAMED('rollBEOs'));
    // OUTPUT(addBEOsToInput, NAMED('addBEOsToInput'));
    
    // OUTPUT(execCrim, NAMED('execCrim'));


    RETURN execCrim;
END;
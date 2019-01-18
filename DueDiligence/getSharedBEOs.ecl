IMPORT BIPV2, BIPV2_Build, Business_Risk_BIP, DueDiligence, STD, UT;

/*
	Following Keys being used:
			BIPV2_Build.key_contact_linkids.kFetch
*/
EXPORT getSharedBEOs(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions) := FUNCTION



    execsRaw := BIPV2_Build.key_contact_linkids.kFetch(DueDiligence.CommonBusiness.GetLinkIDsForKFetch(indata),
																										 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																										 0, // ScoreThreshold --> 0 = Give me everything
																										 linkingOptions,
																										 Business_Risk_BIP.Constants.Limit_Default,
																										 Options.KeepLargeBusinesses)(source NOT IN DueDiligence.Constants.EXCLUDE_SOURCES);
																										 
																										 
    //Add back our Seq numbers.
    execsRawSeq := DueDiligence.CommonBusiness.AppendSeq(execsRaw, indata, FALSE);
    
    //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
    execCleanDates := DueDiligence.Common.CleanDatasetDateFields(execsRawSeq, 'dt_first_seen, dt_vendor_first_reported, dt_last_seen, dt_vendor_last_reported');
    
    // Filter out records after our history date.
    execFilt := DueDiligence.Common.FilterRecords(execCleanDates, dt_first_seen, dt_vendor_first_reported);
    
    //pull out the contact info and needed info
    pulledExecs :=  PROJECT(execFilt, TRANSFORM(DueDiligence.LayoutsInternal.BEOLayout,
                                                SELF.relatedParty.firstName := LEFT.contact_name.fname;
                                                SELF.relatedParty.middleName := LEFT.contact_name.mname;
                                                SELF.relatedParty.lastName := LEFT.contact_name.lname;
                                                SELF.relatedParty.suffix := LEFT.contact_name.name_suffix;
                                                SELF.relatedParty.did := LEFT.contact_did;
                                                
                                                firstSeenDate := (UNSIGNED4)LEFT.dt_first_seen;
                                                firstSeenVendor := (UNSIGNED4)LEFT.dt_vendor_first_reported;
                                                firstSeen := IF(firstSeenDate = DueDiligence.Constants.NUMERIC_ZERO, firstSeenVendor, firstSeenDate);	
                                                
                                                SELF.partyFirstSeen := (UNSIGNED4)LEFT.dt_first_seen;
                                                
                                                lastSeenDate := (UNSIGNED4)LEFT.dt_last_seen;
                                                lastSeenVendor := (UNSIGNED4)LEFT.dt_vendor_last_reported;
                                                lastSeen := IF(lastSeenDate = DueDiligence.Constants.NUMERIC_ZERO, lastSeenVendor, lastSeenDate);	
                                                
                                                SELF.partyLastSeen := lastSeen;
                                                SELF.relatedParty.ssn := LEFT.contact_ssn;
                                                
                                                derived := STD.Str.ToUpperCase(TRIM(LEFT.contact_job_title_derived, LEFT, RIGHT));
                                                execTitle := IF(derived IN DueDiligence.Constants.EXECUTIVE_TITLES, derived, DueDiligence.Constants.EMPTY);
                                                
                                                lastSeenDays := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)lastSeen, (STRING)LEFT.historyDate);
                                                past3Years := ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK);
                                                seenLast3Years := lastSeenDays <= past3Years;
                                                
                                                SELF.title := execTitle;
                                                SELF.isExec := execTitle <> DueDiligence.Constants.EMPTY;
                                                
                                                SELF.isOwnershipProng := execTitle IN DueDiligence.Constants.OWNERSHIP_PRONG_TITLES AND seenLast3Years;
                                                SELF.isControlProng := execTitle NOT IN DueDiligence.Constants.OWNERSHIP_PRONG_TITLES AND seenLast3Years;
                                                
                                                SELF := LEFT;
                                                SELF := [];));
                                                

    filterExecs := pulledExecs(isExec);
    
    withDIDs := DueDiligence.getSharedBEOsWithDID(filterExecs(relatedParty.did > 0));          
    addExecs := JOIN(indata, withDIDs,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                      TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                SELF.execs := RIGHT.executives;
                                SELF.execCount := COUNT(RIGHT.executives);
                                SELF := LEFT;),
                      LEFT OUTER,
                      ATMOST(1));
                      
                      
                      
    withoutDIDs := DueDiligence.getSharedBEOsDIDless(filterExecs(relatedParty.did = 0));
    addDIDLessExecs := JOIN(addExecs, withoutDIDs,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),	
                            TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                      SELF.DIDlessExecs := RIGHT.executives;
                                      SELF.DIDlessBEOCount := COUNT(RIGHT.executives);
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));




    // OUTPUT(execsRawSeq, NAMED('execsRawSeq'));
    // OUTPUT(filterExecs, NAMED('filterExecs'));
    // OUTPUT(withDIDs, NAMED('withDIDs'));
    // OUTPUT(addExecs, NAMED('addExecs'));
    // OUTPUT(withoutDIDs, NAMED('withoutDIDs'));
    // OUTPUT(addDIDLessExecs, NAMED('addDIDLessExecs'));
    
    
    
    RETURN addDIDLessExecs;
END;
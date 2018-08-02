IMPORT BIPV2, BIPV2_Build, Business_Risk_BIP, STD, TopBusiness_Services, ut;

/*
	Following Keys being used:
			BIPV2_Build.key_contact_linkids.kFetch
*/

EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions,
										BOOLEAN includeReportData) := FUNCTION


	execsRaw := BIPV2_Build.key_contact_linkids.kFetch(DueDiligence.CommonBusiness.GetLinkIDsForKFetch(indata),
																										 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																										 0, // ScoreThreshold --> 0 = Give me everything
																										 linkingOptions,
																										 Business_Risk_BIP.Constants.Limit_Default,
																										 Options.KeepLargeBusinesses)(source NOT IN DueDiligence.Constants.EXCLUDE_SOURCES);
																										 
																										 
	// Add back our Seq numbers.
	execsRawSeq := DueDiligence.CommonBusiness.AppendSeq(execsRaw, indata, FALSE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	execCleanDates := DueDiligence.Common.CleanDatasetDateFields(execsRawSeq, 'dt_first_seen, dt_vendor_first_reported, dt_last_seen, dt_vendor_last_reported');
	
	// Filter out records after our history date.
	execFilt := DueDiligence.Common.FilterRecords(execCleanDates, dt_first_seen, dt_vendor_first_reported);
	
	//pull out the contact info and needed info
	pulledExecs :=  PROJECT(execFilt, TRANSFORM({DueDiligence.Layouts.RelatedParty relatedParty, STRING title, UNSIGNED4 partyFirstSeen, UNSIGNED4 partyLastSeen, BOOLEAN isExec, RECORDOF(LEFT)},
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
																							
																							SELF.title := execTitle;
																							SELF.isExec := execTitle <> DueDiligence.Constants.EMPTY;
																							SELF := LEFT;
																							SELF := [];));

    
 //Send the Executives that have DID's listed in the Contacts Key through the attribute logic.   The attribute logic relies on having a DID to do all the look ups against the keys 
	sortPulledExecs  := SORT(pulledExecs(isExec AND relatedParty.did > 0), seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, title, partyLastSeen, partyFirstSeen);
	dedupPulledExecs := DEDUP(sortPulledExecs, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, title, partyLastSeen, partyFirstSeen);
															
	rollPulledExecsWithDID := ROLLUP(dedupPulledExecs,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.did = RIGHT.relatedParty.did AND
																		LEFT.title = RIGHT.title,
																		TRANSFORM(RECORDOF(LEFT),
																							SELF.partyLastSeen := MAX(LEFT.partyLastSeen, RIGHT.partyLastSeen);
																							SELF.partyFirstSeen := IF(LEFT.partyFirstSeen = DueDiligence.Constants.NUMERIC_ZERO, MAX(LEFT.partyFirstSeen, RIGHT.partyFirstSeen), MIN(LEFT.partyFirstSeen, RIGHT.partyFirstSeen));
																							SELF := LEFT;));

																						
	transformExecsWithDID := PROJECT(rollPulledExecsWithDID, TRANSFORM({DueDiligence.Layouts.RelatedParty relatedParty, UNSIGNED4 partyFirstSeen, UNSIGNED4 partyLastSeen, DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout},
																																			SELF.relatedParty.numOfPositions := 1;
																																			SELF.relatedParty.positions := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Positions,
																																																															SELF.firstSeen := LEFT.partyFirstSeen;
																																																															SELF.lastSeen := LEFT.partyLastSeen;
																																																															SELF.title := LEFT.title;
																																																															SELF := [];));
																																			SELF := LEFT;
                                                                      SELF := [];));
																																			
	sortExecsWithDID := SORT(transformExecsWithDID, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, partyFirstSeen);
	
	//rollup all positions per given DID
	rollUniqueExecsWithDID := ROLLUP(sortExecsWithDID,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.did = RIGHT.relatedParty.did,
																		TRANSFORM(RECORDOF(LEFT),
																							SELF.relatedParty.positions := LEFT.relatedParty.positions + RIGHT.relatedParty.positions;
																							SELF.relatedParty.numOfPositions := LEFT.relatedParty.numOfPositions + RIGHT.relatedParty.numOfPositions;
																							SELF := LEFT;));
	

	sortRecentExecs := SORT(rollUniqueExecsWithDID, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), -partylastseen);

	groupExecs := GROUP(sortRecentExecs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
	
	
	DueDiligence.LayoutsInternal.RelatedPartyLayout getMaxExecs(groupExecs ge, INTEGER c) := TRANSFORM, SKIP(c > DueDiligence.Constants.MAX_EXECS)
			SELF.executives := PROJECT(ge.relatedParty, TRANSFORM(LEFT));
			SELF := ge;
			SELF := [];
		END;
		
	
	getMaxExecutives := PROJECT(groupExecs, getMaxExecs(LEFT, COUNTER));
	
	sortAllExecs := SORT(UNGROUP(getMaxExecutives), seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
		
	//rollup all execs by inquired business (seq, ultID, orgID, seleID)
	rollAllExecs := ROLLUP(sortAllExecs,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,	
													TRANSFORM(RECORDOF(LEFT),
																		SELF.executives := LEFT.executives + RIGHT.executives;
																		SELF := LEFT;));	
										
	addExecs := JOIN(indata, rollAllExecs,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																		LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																		LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
																		TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																							SELF.execs := RIGHT.executives;
																							SELF.numOfBusExecs := COUNT(RIGHT.executives);
																							SELF := LEFT;),
																		LEFT OUTER);
																		
	
	getExecResidency := DueDiligence.getBusExecResidency(addExecs, options);	
  
  //these DIDless BEO's cannot be sent them through the attribute logic - but will be added to the report
  DIDLessExecs          := PROJECT(pulledExecs(isExec and relatedParty.did = 0), TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.Layouts.RelatedParty relatedparty, 
                                                                                     STRING title, 
                                                                                     UNSIGNED4 partyFirstSeen, 
                                                                                     UNSIGNED4 partyLastSeen, 
                                                                                     BOOLEAN isExec},
                                                     SELF.did  := LEFT.relatedparty.did;         //***expecting this to be zero                                                     
                                                     SELF      := LEFT;));
                                                     
  //this routine will update the Business Internal with a new DATASET of DIDlessBEO's to bus internal and adding them to list of BEO's in the report 
  UpdateInData      := DueDiligence.getBusExecWithNoDID(getExecResidency, DIDLessExecs, sortExecsWithDID);  

	
	// OUTPUT(execsRawSeq, NAMED('execsRawSeq'));
	// OUTPUT(pulledExecs, NAMED('pulledExecs'));
	// OUTPUT(sortPulledExecs, NAMED('sortPulledExecs'));
	// OUTPUT(dedupPulledExecs, NAMED('dedupPulledExecs'));
	
	// OUTPUT(rollPulledExecsWithDID, NAMED('rollPulledExecsWithDID'));
	// OUTPUT(transformExecsWithDID, NAMED('transformExecsWithDID'));
	// OUTPUT(sortExecsWithDID, NAMED('sortExecsWithDID'));
	// OUTPUT(rollUniqueExecsWithDID, NAMED('rollUniqueExecsWithDID'));
	// OUTPUT(sortRecentExecs, NAMED('sortRecentExecs'));
	// OUTPUT(groupExecs, NAMED('groupExecs'));
	// OUTPUT(getMaxExecutives, NAMED('getMaxExecutives'));
	// OUTPUT(rollAllExecs, NAMED('rollAllExecs'));
	// OUTPUT(addExecs, NAMED('addExecs'));
	// OUTPUT(getExecResidency, NAMED('getExecResidency'));
  // OUTPUT(DIDLessExecs, NAMED('DIDLessExecs'));
	// OUTPUT(UpdateInData, NAMED('UpdateInData'));
	
	
	
	RETURN UpdateInData;

END;
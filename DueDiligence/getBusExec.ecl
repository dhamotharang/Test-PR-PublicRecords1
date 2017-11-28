Import BIPV2, BIPV2_Build, Business_Risk_BIP, STD, TopBusiness_Services, ut;

/*
	Following Keys being used:
			BIPV2_Build.key_contact_linkids.kFetch
*/

EXPORT getBusExec(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
										Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
										BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


	contactsRaw := BIPV2_Build.key_contact_linkids.kFetch(DueDiligence.Common.GetLinkIDsForKFetch(indata),
																												 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																												 0, // ScoreThreshold --> 0 = Give me everything
																												 linkingOptions,
																												 Business_Risk_BIP.Constants.Limit_Default,
																												 Options.KeepLargeBusinesses)(source NOT IN DueDiligence.Constants.EXCLUDE_SOURCES);
																										 
																										 
	// Add back to Corp Filings our Seq numbers.
	contactsRawSeq := DueDiligence.Common.AppendSeq(contactsRaw, indata, FALSE);
	
	// Filter out records after our history date.
	corpFilingsFiltRecs := DueDiligence.Common.FilterRecords(contactsRawSeq, dt_first_seen, dt_vendor_first_reported);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_conFirstSeen := DueDiligence.Common.CleanDateFields(corpFilingsFiltRecs, dt_first_seen_contact);
	clean_conLastSeen := DueDiligence.Common.CleanDateFields(clean_conFirstSeen, dt_last_seen_contact);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	corpFilingsFilt := clean_conLastSeen;
	
	//pull out the contact info and needed info
	pulledContacts :=  PROJECT(corpFilingsFilt, TRANSFORM({DueDiligence.Layouts.RelatedParty relatedParty, STRING title, UNSIGNED4 partyFirstSeen, UNSIGNED4 partyLastSeen, BOOLEAN isExec, RECORDOF(LEFT)},
																													SELF.relatedParty.firstName := LEFT.contact_name.fname;
																													SELF.relatedParty.middleName := LEFT.contact_name.mname;
																													SELF.relatedParty.lastName := LEFT.contact_name.lname;
																													SELF.relatedParty.suffix := LEFT.contact_name.name_suffix;
																													SELF.relatedParty.did := LEFT.contact_did;
																													SELF.partyFirstSeen := (UNSIGNED4)LEFT.dt_first_seen_contact;
																													SELF.partyLastSeen := (UNSIGNED4)LEFT.dt_last_seen_contact;
																													SELF.relatedParty.ssn := LEFT.contact_ssn;
																													
																													derived := STD.Str.ToUpperCase(TRIM(LEFT.contact_job_title_derived, LEFT, RIGHT));
																													execTitle := IF(derived IN DueDiligence.Constants.EXECUTIVE_TITLES, derived, DueDiligence.Constants.EMPTY);
																													
																													SELF.title := execTitle;
																													SELF.isExec := execTitle <> DueDiligence.Constants.EMPTY;
																													SELF := LEFT;
																													SELF := [];));




	sortPulledExecs := SORT(pulledContacts(isExec AND relatedParty.did > 0), seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, relatedParty.lastName, -relatedParty.firstName, title, partyLastSeen, partyFirstSeen);
	dedupPulledExecs := DEDUP(sortPulledExecs, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, relatedParty.lastName, relatedParty.firstName, title, partyLastSeen, partyFirstSeen);
																	
	//seperate those with dids																		
	rollPulledExecsWithDID := ROLLUP(dedupPulledExecs(relatedParty.did > 0),
																		LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.did = RIGHT.relatedParty.did AND
																		LEFT.title = RIGHT.title,
																		TRANSFORM(RECORDOF(LEFT),
																						SELF.partyLastSeen := MAX(LEFT.partyLastSeen, RIGHT.partyLastSeen);
																						SELF.partyFirstSeen := IF(LEFT.partyFirstSeen = 0, MAX(LEFT.partyFirstSeen, RIGHT.partyFirstSeen), MIN(LEFT.partyFirstSeen, RIGHT.partyFirstSeen));
																						SELF := LEFT;));
																						
	transformExecsWithDID := PROJECT(rollPulledExecsWithDID, TRANSFORM(RECORDOF(LEFT),
																																			SELF.relatedParty.numOfPositions := 1;
																																			SELF.relatedParty.positions := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Positions,
																																																														SELF.firstSeen := LEFT.partyFirstSeen;
																																																														SELF.lastSeen := LEFT.partyLastSeen;
																																																														SELF.title := LEFT.title;
																																																														SELF := [];));
																																			SELF := LEFT;));
																																			
	sortExecsWithDID := SORT(transformExecsWithDID, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
	
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
																						
	
	
	//combine all unique execs back together
	allExecs := PROJECT(rollUniqueExecsWithDID, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, DATASET(DueDiligence.Layouts.RelatedParty) executives},
																																										SELF.executives := LEFT.relatedParty;
																																										SELF := LEFT;
																																										SELF := [];));
	
	sortAllExecs := SORT(allExecs, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
	
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



	// OUTPUT(contactsRaw, NAMED('contactsRaw'));
	// OUTPUT(corpFilingsFiltRecs, NAMED('corpFilingsFiltRecs'));
	
	
	// OUTPUT(pulledContacts, NAMED('pulledContacts'));
	// OUTPUT(sortPulledExecs, NAMED('sortPulledExecs'));
	// OUTPUT(dedupPulledExecs, NAMED('dedupPulledExecs'));
	
	// OUTPUT(rollPulledExecsWithDID, NAMED('rollPulledExecsWithDID'));
	// OUTPUT(transformExecsWithDID, NAMED('transformExecsWithDID'));
	// OUTPUT(rollUniqueExecsWithDID, NAMED('rollUniqueExecsWithDID'));
	// OUTPUT(allExecs, NAMED('allExecs'));
	// OUTPUT(addExecs, NAMED('addExecs'));
	


	RETURN addExecs;

END;